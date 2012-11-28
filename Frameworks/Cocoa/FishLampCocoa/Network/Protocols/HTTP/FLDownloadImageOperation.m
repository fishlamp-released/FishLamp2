//
//  FLDownloadImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDownloadImageOperation.h"
#import "FLCachedImage.h"

@interface FLDownloadImageOperation ()
@property (readwrite, strong) FLImage* image;
@property (readwrite, strong) id<FLImageStorageStrategy> storageStrategy;
@end

@implementation FLDownloadImageOperation

@synthesize image = _image;
@synthesize storageStrategy = _storageStrategy;


- (id) initWithImageURL:(NSURL*) imageURL 
    storageStrategy:(id<FLImageStorageStrategy>) storageStrategy {
    
    self = [super initWithURL:imageURL];
    if(self) {
        self.storageStrategy = storageStrategy;
    }
    
    return self;
}

- (id) initWithImageURL:(NSURL*) imageURL {
    self = [self initWithImageURL:imageURL storageStrategy:nil];
    if(self) {
    
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_storageStrategy release];
    [super dealloc];
}
#endif

- (FLResult) runSelf {
    
    
    id result = [super runSelf];
    if([result succeeded]) {
//        NSData* imageBytes = result;
        
//    FLImageProperties* imageInfo = nil;
//    if(_storageStrategy) {
//        imageInfo = [_storageStrategy imagePropertiesForImageURL:self.imageURL];
//    }
        
        
    }
    
        
    [super runSelf];
//
//    FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
//    if(!self.error) {
//    
//        FLCachedImage* photo = [FLCachedImage cachedImage];
//        photo.url = self.URL.absoluteString;
//        
//        NSData* data = self.httpResponse.responseData;
//        if(data && data.length > 0)
//        {
//            // note: folder and file name will be set by image cache.
//            FLImage* imageFile = [[FLImage alloc] init];
//            imageFile.imageBytes = data;
//            // uhoh, how do I tell what type it is???
//FIXME("ambiguous type")            
//            photo.imageFile = imageFile;
//            FLReleaseWithNil_(imageFile);
//            
//            self.output = photo;
//        }
//    }

    return result;
}

@end

@interface FLDownloadImageBytesOperation ()
@property (readwrite, strong) NSData* imageBytes;
@end

@implementation FLDownloadImageBytesOperation 

@synthesize imageBytes = _imageBytes;

- (FLResult) runSelf {
	id result = [super runSelf];
    if([result succeeded]) {
        FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
        self.imageBytes = self.httpResponse.responseData;
        return self.imageBytes;
    }

    return result;
}

@end