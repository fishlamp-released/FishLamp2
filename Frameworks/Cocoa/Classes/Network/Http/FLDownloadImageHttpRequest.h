//
//  FLDownloadImageHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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