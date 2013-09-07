//
//  UPBMMJImage.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/6/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "UPBMMJImage.h"

@implementation UPBMMJImage


#pragma mark - Properties

- (NSString *)user
{
    return _user ? _user : @"unknown user";
}

- (NSString *)title
{
    return _title ? _title : @"no title";
}

#pragma mark - Description

- (NSString *)description
{
    NSString *hasThumbImage = self.thumbImage ? @"YES" : @"NO";
    NSString *hasFullImage = self.fullImage ? @"YES" : @"NO";
    return [NSString stringWithFormat:@"user: %@\n, title: %@\n, thumb: %@\n, image: %@\n, hasThumb: %@\n, hasImage: %@\n", self.user, self.title, self.thumbImageURL, self.fullImageURL, hasThumbImage, hasFullImage];
}

@end
