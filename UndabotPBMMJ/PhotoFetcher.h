//
//  PhotoFetcher.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPBMMJTopImages.h"

@interface PhotoFetcher : NSObject

@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UPBMMJTopImages *images;

- (void)photoDictToImages :(NSDictionary *)jsonDict; //abstarct

- (NSString *)fetchURLString;

- (void)updatePhotosFromString:(NSString *)string;

- (NSString *)name;

// Image properties

- (NSString *)userForRow:(int)row;
- (NSString *)captionForRow:(int)row;
- (NSString *)fullImageURLForRow:(int)row;
- (NSString *)thumbImageURLForRow:(int)row;

- (UIImage *)fullImageForRow:(int)row;
- (UIImage *)thumbImageForRow:(int)row;

- (void)setThumbImage:(UIImage *)image forRow:(int)row;
- (void)setFullImage:(UIImage *)image forRow:(int)row;

@end
