//
//  FLDownloadImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDownloadImageOperation.h"
#import "FLCachedImage.h"
#import "FLImageProperties.h"

@implementation FLDownloadImageOperation

- (id) initWithImageURL:(NSURL*) url {
    return [super initWithHTTPRequestURL:url];
}

+ (id) downloadImageOperation {
    return FLAutorelease([[[self class] alloc] initWithImageURL:nil]);
}

+ (id) downloadImageOperationWithImageURL:(NSURL*) imageURL{
    return FLAutorelease([[[self class] alloc] initWithImageURL:imageURL]);
}

- (FLResult) runOperationWithInput:(id) input {

    FLMutableHttpRequest* request = [FLMutableHttpRequest httpRequestWithURL:self.httpRequestURL];

    FLHttpResponse* httpResponse = [self sendHttpRequest:request 
                                       withAuthenticator:self.requestAuthenticator];
    
    FLThrowError([httpResponse simpleHttpResponseErrorCheck]);
    
    FLStorableImage* image = [FLStorableImage imageWithData:httpResponse.responseData];
    image.imageProperties = [FLImageProperties imagePropertiesWithImageURL:self.httpRequestURL];
    return image;
}

//- (FLResult) runOperationWithInput:(id) input {
//    
//    
//    id result = [super runOperationWithInput:(id) input];
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
//    [super runOperationWithInput:(id) input];
////
////    FLThrowError([self.httpResponse simpleHttpResponseErrorCheck]);
////    if(!self.error) {
////    
////        FLCachedImage* photo = [FLCachedImage cachedImage];
////        photo.url = self.URL.absoluteString;
////        
////        NSData* data = self.httpResponse.responseData;
////        if(data && data.length > 0)
////        {
////            // note: folder and file name will be set by image cache.
////            UIImage* imageFile = [[UIImage alloc] init];
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

