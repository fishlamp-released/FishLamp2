//
//	FLSaveCameraImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLSynchronousOperation.h"
#import "FLImageAsset.h"
#import "FLFolder.h"

@interface FLSaveImageAssetToStorageOperation : FLSynchronousOperation {
@private
	id<FLImageAsset> _asset;
	BOOL _wantsThumbnail;
}

- (id) initWithImageAsset:(id<FLImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail;

+ (FLSaveImageAssetToStorageOperation*) saveImageAssetToStorageOperation:(id<FLImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail;

@property (readwrite, retain, nonatomic) id<FLImageAsset> outputPhoto;

@end
