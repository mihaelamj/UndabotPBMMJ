//
//  UPBMMJImage.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/6/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPBMMJImage : NSObject

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *thumbImageURL;
@property (strong, nonatomic) NSString *fullImageURL;
@property (strong, nonatomic) UIImage *thumbImage;
@property (strong, nonatomic) UIImage *fullImage;

- (NSString *)description;

@end
