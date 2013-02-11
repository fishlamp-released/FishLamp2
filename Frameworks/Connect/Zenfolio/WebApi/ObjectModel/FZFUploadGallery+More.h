//
//	FLZenfolioUploadGallery.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioUploadGallery.h"

@interface FLZenfolioUploadGallery (More)

- (BOOL) isValid;

- (id) initWithPhotoSet:(FLZenfolioPhotoSet*) photoSet;

+ (FLZenfolioUploadGallery*) uploadGallery:(FLZenfolioPhotoSet*) photoSet;

@end
