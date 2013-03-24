//
//  FLDownloadImageHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDownloadImageHttpRequest.h"
#import "FLCachedImage.h"
#import "FLImageProperties.h"

@implementation FLDownloadImageHttpRequest

+ (id) downloadImageRequest {
    return FLAutorelease([[[self class] alloc] initWithURL:nil]);
}

+ (id) downloadImageRequestWithURL:(NSURL*) imageURL {
    return FLAutorelease([[[self class] alloc] initWithURL:imageURL]);
}

- (FLResult) resultFromHttpResponse:(FLHttpResponse*) response {

    FLStorableImage* image = [FLStorableImage imageWithData:response.responseData];

// TODO: could be a redirected URL for image???   
    
    image.imageProperties = [FLImageProperties imagePropertiesWithImageURL:self.headers.requestURL];
    return image;
}


//- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
//    
//    
//    id result = [super runOperation];
//    if([result succeeded]) {
////        NSData* imageBytes = result;
//        
////    FLImageProperties* imageInfo = nil;
////    if(_storageStrategy) {
////        imageInfo = [_storageStrategy imagePropertiesForImageURL:self.imageURL];
////    }
//        
//        
//    }
//    
//        
//    [super runOperation];
////
////    FLThrowIfError([self.httpResponse simpleHttpResponseErrorCheck]);
////    if(!self.error) {
////    
////        FLCachedImage* photo = [FLCachedImage cachedImage];
////        photo.url = self.URL.absoluteString;
////        
////        NSData* data = self.httpResponse.responseData;
////        if(data && data.length > 0)
////        {
////            // note: folder and file name will be set by image cache.
////            SDKImage* imageFile = [[SDKImage alloc] init];
////            imageFile.imageBytes = data;
////            // uhoh, how do I tell what type it is???
////FIXME("ambiguous type")            
////            photo.imageFile = imageFile;
////            FLReleaseWithNil(imageFile);
////            
////            self.output = photo;
////        }
////    }
//
//    return result;
//}

@end

