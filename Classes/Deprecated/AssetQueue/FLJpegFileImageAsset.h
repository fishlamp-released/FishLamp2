//
//	FLCameraImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#if 0
#import "FLJpegFile.h"
#import "FLFolder.h"
#import "FLImageAsset.h"


@interface FLJpegFileImageAsset : FLAsset<FLImageAsset> {
@private
	FLJpegFile* _fullScreenImageFile;
	FLJpegFile* _originalImageFile;
	FLJpegFile* _thumbnailImageFile;
	FLFolder* _folder;
}

@property (readwrite, retain, nonatomic) FLFolder* folder;

- (id) init;

- (id) initWithQueuedAsset:(FLQueuedAsset*) asset inFolder:(FLFolder*) folder;

- (id) initWithFolder:(FLFolder*) folder assetUID:(NSString*) assetUID;

- (id) initWithJpegData:(NSData*) jpeg
	folder:(FLFolder*) folder
	assetUID:(NSString*) assetUID;
@end
//
//@interface FLCameraPhoto : FLJpegFileImageAsset
//@end
#endif