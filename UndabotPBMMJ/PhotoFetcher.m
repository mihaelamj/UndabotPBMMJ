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

#pragma mark - Overrides

- (NSMutableArray *)photoDictToArrayDict :(NSDictionary *)jsonDict //abstarct
{
    NSException *e = [NSException
                      exceptionWithName:@"PhotoFetcher-photoDictToArray"
                      reason:@"*** This method needs overriding!"
                      userInfo:nil];
    @throw e;
    return nil;
}

- (NSString *)getUserForRow:(int)row
{
    return nil;
}

- (NSString *)getCaptionForRow:(int)row
{
    return nil;
}

- (NSString *)userForRow:(int)row
{
    if (![self getUserForRow:row]) return @"none";
    return [self getUserForRow:row];
}

- (NSString *)captionForRow:(int)row
{
    if (![self getUserForRow:row]) return @"?";
    return [self getUserForRow:row];
}

- (NSString *)thumbURLForRow:(int)row
{
    return nil;
}

- (NSString *)imageURLForRow:(int)row
{
    return nil;
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
    } else if (resultDict) self.photos = [self photoDictToArrayDict:resultDict];
    NSLog(@"self.photos:\n %@", self.photos);
}


@end
