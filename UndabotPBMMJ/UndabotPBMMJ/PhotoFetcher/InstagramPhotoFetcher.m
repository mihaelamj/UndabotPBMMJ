//
//  InstagramPhotoFetcher.m
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/5/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "InstagramPhotoFetcher.h"
#import "InstagramClient.h"

#define INSTAGRAM_DATA @"data"

#define INSTAGRAM_IMAGES @"images"
#define INSTAGRAM_IMAGES_URL @"url"
#define INSTAGRAM_IMAGE_THUMB @"thumbnail"
#define INSTAGRAM_IMAGE_STANDARD @"standard_resolution"

#define INSTAGRAM_CAPTION @"caption"
#define INSTAGRAM_CAPTION_TEXT @"text"

#define INSTAGRAM_USER @"user"
#define INSTAGRAM_USER_NAME @"username"


@implementation InstagramPhotoFetcher

#pragma mark - Initializer

- (id)init
{
    self = [super init];
    
    if (self) {
        //https://api.instagram.com/v1/media/popular?client_id=9d178a7d6b5543beb235442d4d35761a
        self.URL = [NSString stringWithFormat:INSTAGRAM_POPULAR_URL, INSTAGRAM_CLIENT_ID];
    }
    return self;
}

#pragma mark - Properties

- (NSString *)name
{
    return @"Top Instagram Photos";
}

#pragma mark - Overrides

- (void)photoDictToImages :(NSDictionary *)jsonDict //abstarct
{
    //parse photos dictionary into array of UPBMMJTopImages    
    NSArray *dataArray = [jsonDict valueForKeyPath:INSTAGRAM_DATA];
    for (NSDictionary *oneDataDict in dataArray) {
        
        NSString *thumbImage = nil;
        NSString *fullImage = nil;
        NSString *user = nil;
        NSString *caption = nil;
        
        NSDictionary *imageDict = [oneDataDict valueForKeyPath:INSTAGRAM_IMAGES];
        if (imageDict) {
            thumbImage = [[imageDict valueForKey:INSTAGRAM_IMAGE_THUMB] valueForKey:INSTAGRAM_IMAGES_URL];
            fullImage = [[imageDict valueForKey:INSTAGRAM_IMAGE_STANDARD] valueForKey:INSTAGRAM_IMAGES_URL];
        }
        
        NSDictionary *captionDict = [oneDataDict valueForKeyPath:INSTAGRAM_CAPTION];
        if (captionDict) caption = [captionDict valueForKey:INSTAGRAM_CAPTION_TEXT];
        
        NSDictionary *userDict = [oneDataDict valueForKeyPath:INSTAGRAM_USER];
        if (userDict) user = [userDict valueForKey:INSTAGRAM_USER_NAME];
        
        [self.images addImageURL:fullImage withThumb:thumbImage forUser:user andTitle:caption];
    }
}

@end
