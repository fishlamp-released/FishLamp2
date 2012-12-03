//
//  FLDownloadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLCachedImage.h"
#import "FLImage.h"

@interface FLDownloadImageOperation : FLHttpOperation {
}

- (id) initWithImageURL:(NSURL*) url;

+ (id) downloadImageOperation;
+ (id) downloadImageOperationWithImageURL:(NSURL*) imageURL;

@end