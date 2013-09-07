//
//  PhotoFetcher.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "PhotoFetcher.h"

@implementation PhotoFetcher


#pragma mark - Properties

- (NSString *)name
{
    return _name ? _name : @"Unknown Photos";
}

- (UPBMMJTopImages *)images
{
    if (!_images) _images = [[UPBMMJTopImages alloc] init];
    return _images;
}

#pragma mark - Overrides

- (void)photoDictToImages :(NSDictionary *)jsonDict //abstarct
{
    NSException *e = [NSException
                      exceptionWithName:@"PhotoFetcher-photoDictToImages"
                      reason:@"*** This method needs overriding!"
                      userInfo:nil];
    @throw e;
}


#pragma mark - Fetching

- (NSString *)fetchURLString
{
    NSError *error = nil;
    NSLog(@"Fetching URL: %@", self.URL);
    NSString *resultText = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.URL] encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"result:\n %@", resultText);
    if (resultText && !([resultText length] == 0)) return resultText;
    else NSLog(@"Error = %@ for URL:%@", [error localizedDescription], self.URL);
    return nil;
}

//fetching data from the web is separated from filling the photos array, so that it can be done in a different thread
- (void)updatePhotosFromString:(NSString *)string
{
    if (!string) return;
    NSError *error = nil;
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSDictionary *resultDict = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    
    if (error) {
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
        return;
    } else if (resultDict) {
        self.images = nil;
        [self photoDictToImages:resultDict];
    }
    NSLog(@"self.images:\n %@", self.images);
}


#pragma mark - Image properties

- (NSString *)userForRow:(int)row
{
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return @"unknown user";
    return imageItem.user;
}

- (NSString *)captionForRow:(int)row
{
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return @"no title";
    return imageItem.title;
}

- (NSString *)fullImageURLForRow:(int)row
{
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return nil;
    return imageItem.fullImageURL;
}

- (NSString *)thumbImageURLForRow:(int)row
{
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return nil;
    return imageItem.thumbImageURL;
}

- (UIImage *)fullImageForRow:(int)row
{
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return nil;
    return imageItem.fullImage;
}

- (UIImage *)thumbImageForRow:(int)row
{
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return nil;
    return imageItem.thumbImage;
}

- (void)setThumbImage:(UIImage *)image forRow:(int)row
{
    if (!image) return;
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return;
    imageItem.thumbImage = image;
}

- (void)setFullImage:(UIImage *)image forRow:(int)row
{
    if (!image) return;
    UPBMMJImage *imageItem = [self.images imageForRow:row];
    if (!imageItem) return;
    imageItem.thumbImage = image;
}


@end
