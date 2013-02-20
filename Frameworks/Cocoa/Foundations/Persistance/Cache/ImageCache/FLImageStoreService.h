//
//  FLImageStoreService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLStorableImage.h"
#import "FLObjectDataStore.h"
#import "FLImageFolder.h"
#import "FLDataStoreService.h"

@class FLImageFolder;

@interface FLImageStoreService : FLDataStoreService {
@private
    FLImageFolder* _imageFolder;
}
@property (readwrite, strong) FLImageFolder* imageFolder;

- (void) deleteImage:(FLStorableImage*) image;
- (void) updateImage:(FLStorableImage*) image;

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url;
@end

@protocol FLImageCacheOpener <NSObject>
@optional
- (void) imageStoreServiceOpen:(FLImageStoreService*) imageCache;
- (void) imageStoreServiceClose:(FLImageStoreService*) imageCache;
@end