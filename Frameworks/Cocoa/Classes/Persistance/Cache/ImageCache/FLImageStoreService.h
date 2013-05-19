//
//  FLImageStoreService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLService.h"
#import "FLStorableImage.h"
#import "FLObjectStorage.h"
#import "FLImageFolder.h"
#import "FLStorageService.h"

@class FLImageFolder;

@protocol FLImageStoreDelegate;

@interface FLImageStoreService : FLStorageService {
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