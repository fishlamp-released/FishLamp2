//
//	FLSaveCameraImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSaveImageAssetToStorageOperation.h"
#import "FLImageAsset.h"

@implementation FLSaveImageAssetToStorageOperation

- (id) initWithImageAsset:(id<FLImageAsset>) asset  wantsThumbnail:(BOOL) wantsThumbnail
{
	if((self = [super init]))
	{
		_asset = FLRetain(asset);
		_wantsThumbnail = wantsThumbnail;
	}
	
	return self;
}

+ (FLSaveImageAssetToStorageOperation*) saveImageAssetToStorageOperation:(id<FLImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail
{
	return FLAutorelease([[FLSaveImageAssetToStorageOperation alloc] initWithImageAsset:asset wantsThumbnail:wantsThumbnail]);
}

- (void) dealloc
{
	FLRelease(_asset);
	FLSuperDealloc();
}

- (void) performSynchronously
{
	[_asset.original writeToStorage];
	if(_wantsThumbnail)
	{
		[_asset createThumbnailVersion];
		[_asset.thumbnail writeToStorage];
	}
	self.output = _asset;

}

- (id<FLImageAsset>) outputPhoto {
	return (id<FLImageAsset>) self.output;
}

- (void) setOutputPhoto:(id<FLImageAsset>) photo {
	self.output = photo;
}

@end
