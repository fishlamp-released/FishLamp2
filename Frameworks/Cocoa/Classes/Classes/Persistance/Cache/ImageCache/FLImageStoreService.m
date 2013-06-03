//
//  FLImageStoreService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageStoreService.h"
#import "FLDatabase.h"
#import "FLImageFolder.h"
#import "FLUserDataStorageService.h"


@interface FLImageStoreService ()
//@property (readwrite, strong) id<FLObjectStorage> objectStorage;
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

- (id) init {
    self = [super initWithRootNameForDelegateMethods:@"imageStoreService"];
    if(self) {
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_imageFolder release];
    [super dealloc];
}
#endif

- (void) updateImage:(FLStorableImage*) image {
    FLAssert(self.isServiceOpen);
    
    [self.objectStorage writeObject:image.imageProperties];
    [self.imageFolder writeImage:image];
}

- (void) deleteImage:(FLStorableImage*) image {
    FLAssert(self.isServiceOpen);
    [self.imageFolder deleteImage:image];
    [self.objectStorage deleteObject:image];
}

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url {
    FLAssert(self.isServiceOpen);

    FLImageProperties* props = [self.objectStorage readObject:[FLImageProperties imagePropertiesWithImageURL:url]];
    FLStorableImage* image = nil; 
    
    if(props) {
        image = [FLStorableImage imageWithImageProperties:props];
    }
    
    return image;
}

- (void) openService {
    [super openService];
    FLAssertNotNil(self.objectStorage);
    FLAssertNotNil(self.imageFolder);
    
    [self.delegate imageStoreServiceDidOpen:self];
}

- (void) closeService {

    [super closeService];
    self.imageFolder = nil;
    [self.delegate imageStoreServiceDidClose:self];
}




@end
