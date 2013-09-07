//
//  UPBMMJImageViewController.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoFetcher.h"

@interface UPBMMJImageViewController : UIViewController

@property (nonatomic, strong) NSURL *imageURL;
@property (weak, nonatomic) PhotoFetcher *photoFetcher;
@property (nonatomic, strong) NSIndexPath *photoIndexPath;
@end
