//
//  FLAssetStorage.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLImage.h"
#import "FLPhoto.h"

@protocol FLPhotoStorage <NSObject, FLImageDelegate>

- (FLPhoto*) readPhoto:(id) storageKey;
- (void) writePhoto:(FLPhoto*) photo

- (FLImage*) readImageForStorageKey:(id) storageKey subType:(NSString*) subType;

- (FLImage*) readPreviewImageForStorageKey:(id) storageKey;
- (FLImage*) readOriginalImageForStorageKey:(id) storageKey;
- (FLImage*) readThumbnailImageForStorageKey:(id) storageKey;

- (void) writeImage:(FLImage*) image withCompression:(CGFloat) compression;
- (void) writeImage:(FLImage*) image

@end
