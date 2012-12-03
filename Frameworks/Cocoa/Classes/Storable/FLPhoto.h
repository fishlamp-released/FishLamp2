//
//  FLPhoto.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLImage.h"
#import "FLStorable.h"

extern NSString* const FLPhotoType;

@interface FLPhoto : FLStorable {
@private
	FLImage* _previewImage;
	FLImage* _originalImage;
	FLImage* _thumbnailImage;
}

+ (FLPhoto*) photo;

@property (readwrite, strong) FLImage* originalImage;
@property (readwrite, strong) FLImage* thumbnailImage;
@property (readwrite, strong) FLImage* previewImage;

- (void) clearImages; // in memory 

// TODO: not sure what this is for??
- (BOOL) needsManualScaling;

@end
