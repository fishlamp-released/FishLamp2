//
//	FLZfUploadGallery.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfUploadGallery.h"

@interface FLZfUploadGallery (More)

- (BOOL) isValid;

- (id) initWithPhotoSet:(FLZfPhotoSet*) photoSet;

+ (FLZfUploadGallery*) uploadGallery:(FLZfPhotoSet*) photoSet;

@end
