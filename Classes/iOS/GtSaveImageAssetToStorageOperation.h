//
//	GtSaveCameraImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"
#import "GtImageAsset.h"
#import "GtFolder.h"

@interface GtSaveImageAssetToStorageOperation : GtOperation {
@private
	id<GtImageAsset> m_asset;
	BOOL m_wantsThumbnail;
}

- (id) initWithImageAsset:(id<GtImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail;

+ (GtSaveImageAssetToStorageOperation*) saveImageAssetToStorageOperation:(id<GtImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail;

@property (readwrite, retain, nonatomic) id<GtImageAsset> outputPhoto;

@end
