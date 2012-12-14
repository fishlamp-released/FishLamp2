//
//  FLAssetStorage.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLStorableImage.h"
#import "FLPhoto.h"

@protocol FLImageStorage <NSObject>

- (FLPhoto*) readPhoto:(id) storageKey;
- (void) writePhoto:(FLPhoto*) photo;

- (FLStorableImage*) readImageForStorageKey:(id) storageKey subType:(NSString*) subType;

- (FLStorableImage*) readPreviewImageForStorageKey:(id) storageKey;
- (FLStorableImage*) readOriginalImageForStorageKey:(id) storageKey;
- (FLStorableImage*) readThumbnailImageForStorageKey:(id) storageKey;

- (void) writeImage:(FLStorableImage*) image withCompression:(CGFloat) compression;
- (void) writeImage:(FLStorableImage*) image;

- (void) deleteImage:(FLStorableImage*) image;

@end
