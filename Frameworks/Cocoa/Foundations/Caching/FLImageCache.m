//
//  FLImageCache.m
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageCache.h"
#import "FLDatabase.h"
#import "FLImageFolder.h"
#import "FLServiceManager.h"
#import "FLServiceKeys.h"
#import "FLUserDataStorageService.h"


//@implementation FLServiceManager (FLImageCache)
//FLSynthesizeSessionService(imageCacheService, setImageCacheService, FLImageCache*);
//@end

@interface FLImageCache ()
//@property (readwrite, strong) id<FLObjectDataStore> dataStore;
//@property (readwrite, strong) FLImageFolder* imageFolder;
//
//- (void) deleteImage:(FLServiceRequest*) serviceRequest 
//            finisher:(FLFinisher*) finisher;
//
//- (void) readImage:(FLServiceRequest*) serviceRequest 
//          finisher:(FLFinisher*) finisher;
//
//- (void) saveImage:(FLServiceRequest*) serviceRequest 
//          finisher:(FLFinisher*) finisher;         
@end

@implementation FLImageCache

@synthesize imageFolder = _imageFolder;

#if FL_MRC
- (void) dealloc {
    [_imageFolder release];
    [super dealloc];
}
#endif

- (void) updateImage:(FLStorableImage*) image {
    FLAssert_(self.isServiceOpen);
    
    [self.dataStore writeObject:image.imageProperties];
    [self.imageFolder writeImage:image];
}

- (void) deleteImage:(FLStorableImage*) image {
    FLAssert_(self.isServiceOpen);
    [self.imageFolder deleteImage:image];
    [self.dataStore deleteObject:image];
}

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url {
    FLAssert_(self.isServiceOpen);

    FLImageProperties* props = [self.dataStore readObject:[FLImageProperties imagePropertiesWithImageURL:url]];
    FLStorableImage* image = nil; 
    
    if(props) {
        image = [FLStorableImage imageWithImageProperties:props];
    }
    
    return image;
}

- (void) openService:(id) opener {
    FLPerformSelector(opener, @selector(openImageCache:));
    [super openService:opener];
    FLAssertNotNil_(self.dataStore);
    FLAssertNotNil_(self.imageFolder);
}

- (void) closeService:(id) closer {
    FLPerformSelector(closer, @selector(closeImageCache:));
    [super closeService:closer];
    self.imageFolder = nil;
}


@end
