//
//  UNdabotPBMMJTest.m
//  UNdabotPBMMJTest
//
//  Created by Mihaela Mihaljević Jakić on 9/6/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "UNdabotPBMMJTest.h"
#import "InstagramPhotoFetcher.h"

@implementation UNdabotPBMMJTest

- (void)setUp
{
    [super setUp];    
    self.photoFetcher = [[InstagramPhotoFetcher alloc] init];
}

- (void)tearDown
{
    self.photoFetcher = nil;    
    [super tearDown];
}

- (void)testExample
{
    [self doInstagramFetchFile];
    STAssertTrue([self.photoFetcher.photos count] > 0, @"Cannot get 0 photos");
    
    [self doInstagramFetchNet];
    STAssertTrue([self.photoFetcher.photos count] > 0, @"Cannot get 0 photos");
}

-(NSString *)getFileString:(NSString *)fileName withType:(NSString *)type
{
    NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:type];
	NSStringEncoding encoding = 0;
	NSString *fileString = [NSString stringWithContentsOfFile:file usedEncoding:&encoding error:nil];
    return fileString;
}

- (void)doInstagramFetchFile
{
    NSString *instaString  = [self getFileString:@"instagram" withType:@"txt"];
    [self.photoFetcher updatePhotosFromString:instaString];
}

- (void)doInstagramFetchNet
{
    NSString *instaString  = [self.photoFetcher fetchURLString];
    [self.photoFetcher updatePhotosFromString:instaString];
}

@end
