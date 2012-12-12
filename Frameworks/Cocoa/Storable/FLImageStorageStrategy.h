//
//  FLImageStorageStrategy.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
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
