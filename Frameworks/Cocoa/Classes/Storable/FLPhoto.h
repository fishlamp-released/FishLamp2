//
//  FLPhoto.h
//  Composer
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLStorable.h"

extern NSString* const FLPhotoType;

@interface FLPhoto : FLStorable {
@private
	SDKImage* _previewImage;
	SDKImage* _originalImage;
	SDKImage* _thumbnailImage;
}

+ (FLPhoto*) photo;

@property (readwrite, strong) SDKImage* originalImage;
@property (readwrite, strong) SDKImage* thumbnailImage;
@property (readwrite, strong) SDKImage* previewImage;

- (void) clearImages; // in memory 

// TODO: not sure what this is for??
- (BOOL) needsManualScaling;

@end
