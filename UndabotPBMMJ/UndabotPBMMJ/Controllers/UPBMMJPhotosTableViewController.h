//
//  UPBMMJPhotosTableViewController.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoFetcher.h"

@interface UPBMMJPhotosTableViewController : UITableViewController

@property (strong, nonatomic) PhotoFetcher *photoFetcher;

#define SHOW_IMAGE_SEGUE @"ShowImage"
#define PHOTO_CELL_NAME @"PhotoCell"

@end
