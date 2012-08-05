//
//	FLSaveCameraImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSaveImageAssetToStorageOperation.h"
#import "FLImageAsset.h"

@implementation FLSaveImageAssetToStorageOperation

- (id) initWithImageAsset:(id<FLImageAsset>) asset  wantsThumbnail:(BOOL) wantsThumbnail
{
	if((self = [super init]))
	{
		m_asset = FLReturnRetained(asset);
		m_wantsThumbnail = wantsThumbnail;
	}
	
	return self;
}

+ (FLSaveImageAssetToStorageOperation*) saveImageAssetToStorageOperation:(id<FLImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail
{
	return FLReturnAutoreleased([[FLSaveImageAssetToStorageOperation alloc] initWithImageAsset:asset wantsThumbnail:wantsThumbnail]);
}

- (void) dealloc
{
	FLRelease(m_asset);
	FLSuperDealloc();
}

- (void) performSelf
{
	[m_asset.original writeToStorage];
	if(m_wantsThumbnail)
	{
		[m_asset createThumbnailVersion];
		[m_asset.thumbnail writeToStorage];
	}
	self.output = m_asset;
}

- (id<FLImageAsset>) outputPhoto
{
	return (id<FLImageAsset>) self.output;
}

- (void) setOutputPhoto:(id<FLImageAsset>) photo
{
	self.output = photo;
}

@end
