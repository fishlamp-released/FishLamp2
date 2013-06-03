//
//  FLImageStorageStrategy.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStorageStrategy.h"

@class SDKImage;
@class FLDatabase;
@protocol FLImageStorage;
@class FLImageProperties;

@protocol FLImageStorageStrategy <FLStorageStrategy>

- (id<FLImageStorage>) storageForImage:(SDKImage*) image;
- (FLDatabase*) databaseForImage:(SDKImage*) image;

- (FLImageProperties*) imagePropertiesForImageURL:(NSURL*) url;

@end
