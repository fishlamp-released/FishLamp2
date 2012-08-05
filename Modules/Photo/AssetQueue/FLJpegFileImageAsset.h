//
//	FLCameraImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLJpegFile.h"
#import "FLFolder.h"
#import "FLImageAsset.h"

#define FLPhotoOriginalResolutionFileSuffix @"_O.JPG"
#define FLPhotoFullScreenImageFileSuffix @"_F.JPG"
#define FLPhotoThumbnailImageFileSuffix @"_T.JPG"

@interface FLJpegFileImageAsset : FLAsset<FLImageAsset> {
@private
	FLJpegFile* m_fullScreenImageFile;
	FLJpegFile* m_originalImageFile;
	FLJpegFile* m_thumbnailImageFile;
	FLFolder* m_folder;
}

@property (readwrite, retain, nonatomic) FLFolder* folder;

- (id) init;

- (id) initWithFolder:(FLFolder*) folder assetUID:(NSString*) assetUID;

- (id) initWithJpegData:(NSData*) jpeg
	folder:(FLFolder*) folder
	assetUID:(NSString*) assetUID;
@end
//
//@interface FLCameraPhoto : FLJpegFileImageAsset
//@end
