//
//	FLSaveScaledImagesWithOriginalImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLSynchronousOperation.h"
#import "FLJpegFileImageAsset.h"

// NOTE this will always create full screen version if it doesn't exist

typedef enum {
	FLLoadFullScreen		= (1 << 1),
	FLLoadThumbnail			= (1 << 2),
	FLLoadOriginal			= (1 << 3)
} FLSaveScaledImagesWithOriginalImageOption;

@interface FLSaveScaledImagesWithOriginalImage : FLSynchronousOperation {
@private
	FLFolder* _folder;
	FLSaveScaledImagesWithOriginalImageOption _options;
}

+ (FLSaveScaledImagesWithOriginalImage*) saveScaledImagesWithOriginalImage:(id<FLImageAsset>) photo 
				   folder:(FLFolder*) folder
			  saveOptions:(FLSaveScaledImagesWithOriginalImageOption) options;

- (id) initWithPhotoInput:(id<FLImageAsset>) photo 
				   folder:(FLFolder*) folder
			  saveOptions:(FLSaveScaledImagesWithOriginalImageOption) options;


@end
