//
//  FLZenfolioQueuedPhoto.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "__FLZenfolioQueuedPhoto.h"
#import "FLZenfolioPhotoUpdater.h"
#import "FLZenfolioUploadGallery.h"

@interface FLZenfolioQueuedPhoto (FishLamp)

@property (readwrite, assign, nonatomic) FLZenfolioUploadGallery* uploadGallery;

@property (readonly, assign, nonatomic) BOOL hasUploadGallery;

- (FLZenfolioPhotoUpdater*) createUpdater;

- (NSURL*) buildUploadURL:(BOOL) includeParameters;


@end
