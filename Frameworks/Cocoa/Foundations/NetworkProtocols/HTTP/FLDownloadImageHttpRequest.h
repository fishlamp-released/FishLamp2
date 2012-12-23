//
//  FLDownloadImageHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLHttpRequest.h"
#import "FLStorableImage.h"

@interface FLDownloadImageHttpRequest : FLHttpRequest {
}

+ (id) downloadImageRequest;
+ (id) downloadImageRequestWithURL:(NSURL*) imageURL;

// result is a FLStorableImage

@end