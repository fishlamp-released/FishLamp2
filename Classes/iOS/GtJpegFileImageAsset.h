//
//	GtCameraImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtJpegFile.h"
#import "GtFolder.h"
#import "GtImageAsset.h"

#define GtPhotoOriginalResolutionFileSuffix @"_O.JPG"
#define GtPhotoFullScreenImageFileSuffix @"_F.JPG"
#define GtPhotoThumbnailImageFileSuffix @"_T.JPG"

@interface GtJpegFileImageAsset : GtAsset<GtImageAsset> {
@private
	GtJpegFile* m_fullScreenImageFile;
	GtJpegFile* m_originalImageFile;
	GtJpegFile* m_thumbnailImageFile;
	GtFolder* m_folder;
}

@property (readwrite, retain, nonatomic) GtFolder* folder;

- (id) init;

- (id) initWithFolder:(GtFolder*) folder assetUID:(NSString*) assetUID;

- (id) initWithJpegData:(NSData*) jpeg
	folder:(GtFolder*) folder
	assetUID:(NSString*) assetUID;
@end
//
//@interface GtCameraPhoto : GtJpegFileImageAsset
//@end
