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

@interface FLImageCacheService ()
@property (readwrite, strong) FLDatabase* cacheDatabase;
@property (readwrite, strong) FLImageFolder* imageCacheFolder;

- (void) deleteImage:(FLServiceRequest*) serviceRequest 
            finisher:(FLFinisher*) finisher;

- (void) readImage:(FLServiceRequest*) serviceRequest 
          finisher:(FLFinisher*) finisher;

- (void) saveImage:(FLServiceRequest*) serviceRequest 
          finisher:(FLFinisher*) finisher;         
@end

@implementation FLImageCacheService

@synthesize cacheDatabase = _cacheDatabase;
@synthesize imageCacheFolder = _imageCacheFolder;

- (id) init {
    self = [super init];
    
    if(self) {
        [self setRequestHandler:@selector(saveImage:finisher:)
          forServiceRequestType:FLServiceRequestTypeUpdate];

        [self setRequestHandler:@selector(deleteImage:finisher:)
          forServiceRequestType:FLServiceRequestTypeDelete];

        [self setRequestHandler:@selector(readImage:finisher:)
          forServiceRequestType:FLServiceRequestTypeRead];

    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_cacheDatabase release];
    [_imageCacheFolder release];
    [super dealloc];
}
#endif

- (void) saveImage:(FLServiceRequest*) serviceRequest 
          finisher:(FLFinisher*) finisher {
    
    FLStorableImage* image = [serviceRequest argumentForKey:NSStringFromClass([FLStorableImage class])];
    
    [self.cacheDatabase saveObject:image.imageProperties];
    [self.imageCacheFolder writeImage:image];
    
    [finisher setFinished];
}

- (void) deleteImage:(FLServiceRequest*) serviceRequest 
            finisher:(FLFinisher*) finisher {
            
    FLStorableImage* image = [serviceRequest argumentForKey:NSStringFromClass([FLStorableImage class])];

    [self.imageCacheFolder deleteImage:image];
    [self.cacheDatabase deleteObject:image];

    [finisher setFinished];
}

- (void) readImage:(FLServiceRequest*) serviceRequest 
          finisher:(FLFinisher*) finisher {
            
    NSURL* url = [serviceRequest argumentForKey:NSStringFromClass([NSURL class])];
                
    FLImageProperties* input = [FLImageProperties imagePropertiesWithImageURL:url];
    FLImageProperties* props = [self.cacheDatabase loadObject:input];
    FLStorableImage* image = nil; 
    
    if(props) {
        image = [FLStorableImage imageWithImageProperties:props];
        
// TODO: add storage strategy!!        
    }
    
    [finisher setFinishedWithResult:image];
}

- (void) openService:(id) sender {
    self.cacheDatabase = [self.services resourceForKey:FLUserDataCacheDatabase];
    self.imageCacheFolder = [self.services resourceForKey:FLUserDataImageCacheFolder];
}

- (void) closeService:(id) sender {
    self.cacheDatabase = nil;
    self.imageCacheFolder = nil;
}

@end
