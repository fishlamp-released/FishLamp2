//
//  FLImageStoreService.m
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageStoreService.h"
#import "FLDatabase.h"
#import "FLImageFolder.h"
#import "FLServiceKeys.h"
#import "FLUserDataStorageService.h"


@interface FLImageStoreService ()
//@property (readwrite, strong) id<FLObjectStorage> dataStore;
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

@implementation FLImageStoreService

@synthesize imageFolder = _imageFolder;

#if FL_MRC
- (void) dealloc {
    [_imageFolder release];
    [super dealloc];
}
#endif

- (void) updateImage:(FLStorableImage*) image {
    FLAssert(self.isServiceOpen);
    
    [self.dataStore writeObject:image.imageProperties];
    [self.imageFolder writeImage:image];
}

- (void) deleteImage:(FLStorableImage*) image {
    FLAssert(self.isServiceOpen);
    [self.imageFolder deleteImage:image];
    [self.dataStore deleteObject:image];
}

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url {
    FLAssert(self.isServiceOpen);

    FLImageProperties* props = [self.dataStore readObject:[FLImageProperties imagePropertiesWithImageURL:url]];
    FLStorableImage* image = nil; 
    
    if(props) {
        image = [FLStorableImage imageWithImageProperties:props];
    }
    
    return image;
}

- (void) openService:(id) opener {
    FLPerformSelector(opener, @selector(imageStoreServiceOpen:));
    [super openService:opener];
    FLAssertNotNil(self.dataStore);
    FLAssertNotNil(self.imageFolder);
}

- (void) closeService:(id) closer {
    FLPerformSelector(closer, @selector(imageStoreServiceClose:));
    [super closeService:closer];
    self.imageFolder = nil;
}

@end
