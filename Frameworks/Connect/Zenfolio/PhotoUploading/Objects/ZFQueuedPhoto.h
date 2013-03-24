//
//  ZFQueuedPhoto.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "__ZFQueuedPhoto.h"
#import "ZFPhotoUpdater.h"
#import "ZFUploadGallery.h"

@interface ZFQueuedPhoto (FishLamp)

@property (readwrite, assign, nonatomic) ZFUploadGallery* uploadGallery;

@property (readonly, assign, nonatomic) BOOL hasUploadGallery;

- (ZFPhotoUpdater*) createUpdater;

- (NSURL*) buildUploadURL:(BOOL) includeParameters;


@end
