//
//  UPBMMJImageViewController.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "UPBMMJImageViewController.h"
#import "GlobalNetActivity.h"

@interface UPBMMJImageViewController  () <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *graySpinner;

@end

@implementation UPBMMJImageViewController

#pragma mark - Properties

- (void)setPhotoIndexPath:(NSIndexPath *)photoIndexPath
{
    _photoIndexPath = photoIndexPath;
    NSString *URLStritng = [self.photoFetcher fullImageURLForRow:self.photoIndexPath.row];
    self.imageURL = [NSURL URLWithString:URLStritng];
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (void)setTitle:(NSString *)title
{
    super.title = title;
}

#pragma mark - Loading

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage]; 
}

- (void)updateScrollViewWithImage:(UIImage *)image
{
    self.scrollView.zoomScale = 1.0;
    self.scrollView.contentSize = image.size;
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    NSLog(@"Updated ScrollView");
}

- (void)resetImage
{
    if (self.scrollView) {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        UIImage *fullImage = [self.photoFetcher fullImageForRow:self.photoIndexPath.row];
        NSURL *imageURL = self.imageURL;
        
        if (fullImage) {
            [self updateScrollViewWithImage:fullImage];
        } else {
            NSLog(@"No full image for : %d", self.photoIndexPath.row);
            [self.graySpinner startAnimating];
            dispatch_queue_t downloadQueue = dispatch_queue_create("One image fetcher", NULL);
            
            dispatch_async(downloadQueue, ^{ //1. get in another thread
                [GlobalNetActivity show];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
                [GlobalNetActivity hide];
                
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                [self.photoFetcher setFullImage:image forRow:self.photoIndexPath.row];
                
                NSLog(@"Created new full image: %d", self.photoIndexPath.row);
                
                //check if user clicked back
                if (self.imageURL == imageURL) {
                    dispatch_async(dispatch_get_main_queue(), ^{ // 2. do in main queue
                        if (image) {
                            [self updateScrollViewWithImage:image];
                        }
                        [self.graySpinner stopAnimating];
                    });
                }
                
            });
        }
    }
}

#pragma mark - UIScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
