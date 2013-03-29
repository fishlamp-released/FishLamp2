//
//  FLImageStoreService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLStorableImage.h"
#import "FLObjectStorage.h"
#import "FLImageFolder.h"
#import "FLObjectStorageService.h"

@class FLImageFolder;

@protocol FLImageStoreDelegate;

@interface FLImageStoreService : FLObjectStorageService {
@private
    FLImageFolder* _imageFolder;
}
@property (readwrite, strong) FLImageFolder* imageFolder;

- (void) deleteImage:(FLStorableImage*) image;
- (void) updateImage:(FLStorableImage*) image;

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url;
@end

@protocol FLImageStoreDelegate <NSObject>
- (void) imageStoreServiceDidOpen:(FLImageStoreService*) imageCache;
- (void) imageStoreServiceDidClose:(FLImageStoreService*) imageCache;
@end