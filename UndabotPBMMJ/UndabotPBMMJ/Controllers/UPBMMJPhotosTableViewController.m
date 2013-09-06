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
                    NSURL *url = [NSURL URLWithString:[self.photoFetcher imageURLForRow:indexPath.row]];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self.photoFetcher captionForRow:indexPath.row]];
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
    return [self.photoFetcher.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PHOTO_CELL_NAME forIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    NSLog(@"caption: %@", [self.photoFetcher captionForRow:indexPath.row]);
    NSLog(@"user: %@", [self.photoFetcher userForRow:indexPath.row]);
    NSLog(@"thumb: %@", [self.photoFetcher thumbURLForRow:indexPath.row]);
    NSLog(@"image: %@ \n", [self.photoFetcher imageURLForRow:indexPath.row]);
    
    cell.textLabel.text = [self.photoFetcher captionForRow:indexPath.row];
    cell.detailTextLabel.text = [self.photoFetcher userForRow:indexPath.row];
//    cell.imageView.image = [UIImage image]];

    return cell;
}

#pragma mark - Loading

- (void)loadTopPhotosFromWeb
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t loadSO= dispatch_queue_create("Photos data fetcher", NULL);
    dispatch_async(loadSO, ^{
//        [NSThread sleepForTimeInterval:2.0];//simulate long operation
        [GlobalNetActivity show];
        NSString *photoDataString = [self.photoFetcher fetchURLString];
        [GlobalNetActivity hide];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoFetcher updatePhotosFromString:photoDataString];
            
#pragma mark - Change to update each cell image in another thread
            //update table View
            //NSURL *url = [NSURL URLWithString:[self.photoFetcher thumbURLForRow:indexPath.row]];
            [self.tableView reloadData];
            //update table View
            
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
