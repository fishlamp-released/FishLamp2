//
//	GtSaveScaledImagesWithOriginalImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"
#import "GtJpegFileImageAsset.h"

// NOTE this will always create full screen version if it doesn't exist

typedef enum {
	GtLoadFullScreen		= (1 << 1),
	GtLoadThumbnail			= (1 << 2),
	GtLoadOriginal			= (1 << 3)
} GtSaveScaledImagesWithOriginalImageOption;

@interface GtSaveScaledImagesWithOriginalImage : GtOperation {
@private
	GtFolder* m_folder;
	GtSaveScaledImagesWithOriginalImageOption m_options;
}

- (id) initWithPhotoInput:(id<GtImageAsset>) photo 
				   folder:(GtFolder*) folder
			  saveOptions:(GtSaveScaledImagesWithOriginalImageOption) options;


@end
