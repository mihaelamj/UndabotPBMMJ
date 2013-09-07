//
//  InstagramPhotosTableViewController.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "InstagramPhotosTableViewController.h"
#import "InstagramPhotoFetcher.h"

@interface InstagramPhotosTableViewController ()

@end

@implementation InstagramPhotosTableViewController

@synthesize photoFetcher = _photoFetcher;

#pragma mark - Properties

- (PhotoFetcher *)photoFetcher
{
    if (!_photoFetcher) _photoFetcher = [[InstagramPhotoFetcher alloc] init];
    return _photoFetcher;
}

@end
