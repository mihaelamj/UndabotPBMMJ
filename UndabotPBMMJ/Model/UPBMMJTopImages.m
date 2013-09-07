//
//  UPBMMJTopImages.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/6/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "UPBMMJTopImages.h"


@implementation UPBMMJTopImages

#pragma mark - Properties

- (NSMutableArray *)items
{
    if (!_items) _items = [[NSMutableArray alloc] init];
    return _items;
}

#pragma mark - Methods

- (NSString *)sanitizeDictString:(NSString *)string
{
    return [string isKindOfClass:[NSString class]] ? string : nil;
}

- (void)addImageURL:(NSString *)imageURL withThumb:(NSString *)thumbURL forUser:(NSString *)user andTitle:(NSString *)title
{
    UPBMMJImage *image = [[UPBMMJImage alloc] init];
    
    NSString *safeUser = [self sanitizeDictString:user];
    NSString *safeTitle = [self sanitizeDictString:title];
    
    image.user = safeUser ? safeUser : @"unknown user";
    image.title = safeTitle ? safeTitle : @"no title"; //NSNull
    image.thumbImageURL = [self sanitizeDictString:thumbURL];
    image.fullImageURL = [self sanitizeDictString:imageURL];
    
    [self.items addObject:image];
}

- (UPBMMJImage *)imageForRow:(int)row
{
    if (row < 0 || row > self.items.count) return nil;
    return (UPBMMJImage *)self.items[row];
}

- (int)count
{
    return [self.items count];
}

#pragma mark - Description

- (NSString *)description
{
    NSMutableString *desc = [[NSMutableString alloc] init];
    for (UPBMMJImage *image in self.items) {
        [desc appendFormat:@"%@\n", image.description];
    }
    return desc;
}

@end
