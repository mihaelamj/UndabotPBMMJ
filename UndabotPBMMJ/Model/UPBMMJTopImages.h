//
//  UPBMMJTopImages.h
//  UndabotPBMMJ
//
//  Created by Mihaela Mihaljević Jakić on 9/6/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPBMMJImage.h"

@interface UPBMMJTopImages : NSObject
@property (strong, nonatomic) NSMutableArray *items; // of UPBMMJImage

- (void)addImageURL:(NSString *)URL withThumb:(NSString *)thumbURL forUser:(NSString *)user andTitle:(NSString *)title;

- (UPBMMJImage *)imageForRow:(int)row;

- (int)count;

- (NSString *)description;

@end
