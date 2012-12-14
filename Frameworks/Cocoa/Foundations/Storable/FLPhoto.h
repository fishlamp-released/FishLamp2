//
//  FLPhoto.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLStorable.h"

extern NSString* const FLPhotoType;

@interface FLPhoto : FLStorable {
@private
	UIImage* _previewImage;
	UIImage* _originalImage;
	UIImage* _thumbnailImage;
}

+ (FLPhoto*) photo;

@property (readwrite, strong) UIImage* originalImage;
@property (readwrite, strong) UIImage* thumbnailImage;
@property (readwrite, strong) UIImage* previewImage;

- (void) clearImages; // in memory 

// TODO: not sure what this is for??
- (BOOL) needsManualScaling;

@end
