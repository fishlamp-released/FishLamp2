//
//  FLImageCache.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLStorableImage.h"
#import "FLObjectDataStore.h"
#import "FLImageFolder.h"

@class FLImageFolder;

@interface FLImageCache : FLDataStoreService {
@private
     FLImageFolder* _imageFolder;
}

@property (readwrite, strong) FLImageFolder* imageFolder;

- (void) deleteImage:(FLStorableImage*) image;
- (void) updateImage:(FLStorableImage*) image;

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url;

@end

@protocol FLImageCacheOpener <NSObject>
- (void) openImageCache:(FLImageCache*) imageCache;
- (void) closeImageCache:(FLImageCache*) imageCache;
@end