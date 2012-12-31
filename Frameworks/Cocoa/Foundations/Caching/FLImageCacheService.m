//
//  FLImageCacheService.m
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageCacheService.h"
#import "FLDatabase.h"
#import "FLImageFolder.h"
#import "FLServiceManagingContext.h"
#import "FLServiceKeys.h"
#import "FLUserDataStorageService.h"


//@implementation FLServiceManagingContext (FLImageCacheService)
//FLSynthesizeSessionService(imageCacheService, setImageCacheService, FLImageCacheService*);
//@end

@interface FLImageCacheService ()
@property (readwrite, strong) FLDatabase* cacheDatabase;
@property (readwrite, strong) FLImageFolder* imageCacheFolder;
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

@implementation FLImageCacheService

@synthesize cacheDatabase = _cacheDatabase;
@synthesize imageCacheFolder = _imageCacheFolder;

#if FL_MRC
- (void) dealloc {
    [_cacheDatabase release];
    [_imageCacheFolder release];
    [super dealloc];
}
#endif

- (void) updateImage:(FLStorableImage*) image {
    [self.cacheDatabase saveObject:image.imageProperties];
    [self.imageCacheFolder writeImage:image];
}

- (void) deleteImage:(FLStorableImage*) image {
    [self.imageCacheFolder deleteImage:image];
    [self.cacheDatabase deleteObject:image];
}


- (FLStorableImage*) readImageWithURLKey:(NSURL*) url {
    FLImageProperties* input = [FLImageProperties imagePropertiesWithImageURL:url];
    FLImageProperties* props = [self.cacheDatabase loadObject:input];
    FLStorableImage* image = nil; 
    
    if(props) {
        image = [FLStorableImage imageWithImageProperties:props];
        
// TODO: add storage strategy!!        
    }
    
    return image;
}

- (void) openService:(FLServiceManagingContext*) context {
    self.cacheDatabase = [[self.context userStorageService] cacheDatabase];
    self.imageCacheFolder = [[self.context userStorageService] imageCacheFolder];
}

- (void) closeService:(FLServiceManagingContext*) context {
    self.cacheDatabase = nil;
    self.imageCacheFolder = nil;
}


@end
