//
//	GtSaveCameraImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSaveImageAssetToStorageOperation.h"
#import "GtImageAsset.h"

@implementation GtSaveImageAssetToStorageOperation

- (id) initWithImageAsset:(id<GtImageAsset>) asset  wantsThumbnail:(BOOL) wantsThumbnail
{
	if((self = [super init]))
	{
		m_asset = GtRetain(asset);
		m_wantsThumbnail = wantsThumbnail;
	}
	
	return self;
}

+ (GtSaveImageAssetToStorageOperation*) saveImageAssetToStorageOperation:(id<GtImageAsset>) asset wantsThumbnail:(BOOL) wantsThumbnail
{
	return GtReturnAutoreleased([[GtSaveImageAssetToStorageOperation alloc] initWithImageAsset:asset wantsThumbnail:wantsThumbnail]);
}

- (void) dealloc
{
	GtRelease(m_asset);
	GtSuperDealloc();
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

- (id<GtImageAsset>) outputPhoto
{
	return (id<GtImageAsset>) self.output;
}

- (void) setOutputPhoto:(id<GtImageAsset>) photo
{
	self.output = photo;
}

@end
