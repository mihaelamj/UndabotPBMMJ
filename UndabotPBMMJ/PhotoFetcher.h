//
//  PhotoFetcher.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoFetcher : NSObject

@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *photos;


- (NSMutableArray *)photoDictToArrayDict:(NSDictionary *)jsonDict; //abstarct

- (NSString *)fetchURLString;

- (void)updatePhotosFromString:(NSString *)string;

- (NSString *)name;

- (NSString *)userForRow:(int)row;
- (NSString *)captionForRow:(int)row;
- (NSString *)thumbURLForRow:(int)row;//abstarct
- (NSString *)imageURLForRow:(int)row;//abstarct

- (NSString *)getUserForRow:(int)row;
- (NSString *)getCaptionForRow:(int)row;


@end
