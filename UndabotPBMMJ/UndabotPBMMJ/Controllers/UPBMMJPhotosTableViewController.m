//
//  UPBMMJPhotosTableViewController.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "UPBMMJPhotosTableViewController.h"
#import "GlobalNetActivity.h"

@interface UPBMMJPhotosTableViewController ()

@end

@implementation UPBMMJPhotosTableViewController

#pragma mark - Properties

- (PhotoFetcher *)photoFetcher
{
    return nil; // abstract
    //init specific PhotoFetcher descendand
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:SHOW_IMAGE_SEGUE]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                    NSString *urlString = [self.photoFetcher fullImageURLForRow:indexPath.row];
                    if (urlString) {
                        NSURL *url = [NSURL URLWithString:urlString];
                        if (url) {
                            [segue.destinationViewController performSelector:@selector(setPhotoFetcher:) withObject:self.photoFetcher];
                            [segue.destinationViewController performSelector:@selector(setPhotoIndexPath:) withObject:indexPath];
                            [segue.destinationViewController setTitle:[self.photoFetcher captionForRow:indexPath.row]];
                        }
                    }
                }
            }
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photoFetcher.images count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PHOTO_CELL_NAME forIndexPath:indexPath];
    
    cell.textLabel.text = [self.photoFetcher captionForRow:indexPath.row];
    cell.detailTextLabel.text = [self.photoFetcher userForRow:indexPath.row];
    
    NSString *thumbURL = [self.photoFetcher thumbImageURLForRow:indexPath.row];
    
    if (thumbURL) {
        UIImage *thumbImage = [self.photoFetcher thumbImageForRow:indexPath.row];
        
        if (!thumbImage) {
            
            NSLog(@"No thumb for cell : %d", indexPath.row);
            dispatch_queue_t q = dispatch_queue_create("Thumbnail Web Photo", 0);
            dispatch_async(q, ^{
                [GlobalNetActivity show];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:thumbURL]];
                [GlobalNetActivity hide];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UITableViewCell *cellToUpdate = [self.tableView cellForRowAtIndexPath:indexPath]; // create a copy of the cell to avoid keeping a strong pointer to "cell" since that one may have been reused by
                    UIImage *newThumb = [UIImage imageWithData:imageData];
                    
                    NSLog(@"Created new thumb: %@ for cell: %d", thumbURL, indexPath.row);
                    
                    [self.photoFetcher setThumbImage:newThumb forRow:indexPath.row];
                    cellToUpdate.imageView.image = newThumb;
                    
                    NSLog(@"Added thumb to cell : %d", indexPath.row);
                    
                    [cellToUpdate setNeedsLayout];
                });
            });
            
        } else {
            NSLog(@"Cell: %d reusing thumb: %@", indexPath.row, thumbURL);
            cell.imageView.image = thumbImage;
            [cell setNeedsLayout];
        }
    }
    
    return cell;
}

#pragma mark - Loading

- (void)loadTopPhotosFromWeb
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t loadSO= dispatch_queue_create("Photos data fetcher", NULL);
    dispatch_async(loadSO, ^{
        [GlobalNetActivity show];
        NSString *photoDataString = [self.photoFetcher fetchURLString];
        [GlobalNetActivity hide];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoFetcher updatePhotosFromString:photoDataString];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.photoFetcher.name];
    
    [self loadTopPhotosFromWeb];
	
	[self.refreshControl addTarget:self
                            action:@selector(loadTopPhotosFromWeb)
                  forControlEvents:(UIControlEventValueChanged)];
}

@end
