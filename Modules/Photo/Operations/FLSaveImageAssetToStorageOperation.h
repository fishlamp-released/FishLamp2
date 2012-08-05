//
//	FLSaveCameraImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOperation.h"
#import "FLImageAsset.h"
#import "FLFolder.h"

@interface FLSaveImageAssetToStorageOperation : FLOperation {
@private
	id<FLImageAsset> m_asset;
	BOOL m_wantsThumbnail;
}

- (id) initWithImageAsset:(id<FLImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail;

+ (FLSaveImageAssetToStorageOperation*) saveImageAssetToStorageOperation:(id<FLImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail;

@property (readwrite, retain, nonatomic) id<FLImageAsset> outputPhoto;

@end
