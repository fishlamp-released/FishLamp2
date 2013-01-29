//
//  FLZfQueuedPhoto.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "__ZfQueuedPhoto.h"
#import "FLZfPhotoUpdater.h"
#import "FLZfUploadGallery.h"

@interface FLZfQueuedPhoto (FishLamp)

@property (readwrite, assign, nonatomic) FLZfUploadGallery* uploadGallery;

@property (readonly, assign, nonatomic) BOOL hasUploadGallery;

- (FLZfPhotoUpdater*) createUpdater;

- (NSURL*) buildUploadURL:(BOOL) includeParameters;


@end
