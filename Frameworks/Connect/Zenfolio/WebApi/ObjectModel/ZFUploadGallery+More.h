//
//	ZFUploadGallery.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFUploadGallery.h"

@interface ZFUploadGallery (More)

- (BOOL) isValid;

- (id) initWithPhotoSet:(ZFPhotoSet*) photoSet;

+ (ZFUploadGallery*) uploadGallery:(ZFPhotoSet*) photoSet;

@end
