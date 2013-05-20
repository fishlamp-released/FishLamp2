//
//	GtAssetsLibraryImageAsset.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryImageAsset.h"
#import "GtAssetsLibrary.h"
#import "GtPhotoExif.h"

@interface GtAssetsLibraryImageAsset ()
@property (readwrite, retain, nonatomic) id<GtStorableImage> original;
@property (readwrite, retain, nonatomic) id<GtStorableImage> thumbnail;
@property (readwrite, retain, nonatomic) id<GtStorableImage> fullScreen;
@end

@implementation GtAssetsLibraryImageAsset

@synthesize fullScreen = m_fullScreenImage;
@synthesize original = m_originalImage;
@synthesize thumbnail = m_thumnailImage;

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithAssetURL:(NSURL*) url
{
	if((self = [super init]))
	{
		m_originalImage = [[GtAssetsLibraryImage alloc] initWithAssetURL:url imageSize:GtAssetsLibraryImageSizeOriginal];
	}
	
	return self;
}

- (id) initWithImage:(UIImage*) image metaData:(NSDictionary*) metaData;
{
	if((self = [super init]))
	{
		m_originalImage = [[GtAssetsLibraryImage alloc] initWithOriginalImage:image exifData:metaData];
	}
	
	return self;
}

- (id) initWithALAsset:(ALAsset*) asset
{
	if((self = [super init]))
	{
		m_originalImage = [[GtAssetsLibraryImage alloc] initWithALAsset:asset imageSize:GtAssetsLibraryImageSizeOriginal];
	}
	
	return self;
}

- (NSString*) assetUID
{
	return [super assetUID];
}

- (void) setAssetUID:(NSString*) uid
{
	[super setAssetUID:uid];
}

- (ALAsset*) asset
{
	return ((GtAssetsLibraryImage*)self.original).asset;
}

- (void) dealloc
{
	GtRelease(m_thumnailImage);
	GtRelease(m_fullScreenImage);
	GtRelease(m_originalImage);
	GtSuperDealloc();
}

- (NSURL*) assetURL
{
	return m_originalImage.assetURL;
}

- (void) releaseFiles
{
	[m_thumnailImage releaseImage];
	[m_fullScreenImage releaseImage];
	[m_originalImage releaseImage];
}

- (id<GtStorableImage>) fullScreen
{
	if(!m_fullScreenImage)
	{
		if(self.asset)
		{
			m_fullScreenImage = [[GtAssetsLibraryImage alloc] initWithALAsset:self.asset imageSize:GtAssetsLibraryImageSizeFullScreen];
		}
		else
		{
			m_fullScreenImage = [[GtAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:GtAssetsLibraryImageSizeFullScreen];
		}
	
	}

	return m_fullScreenImage; 
}

- (id<GtStorableImage>) thumbnail
{
	if(!m_thumnailImage)
	{
		if(self.asset)
		{
			m_thumnailImage = [[GtAssetsLibraryImage alloc] initWithALAsset:self.asset imageSize:GtAssetsLibraryImageSizeThumbnail];
		}
		else
		{
			m_thumnailImage = [[GtAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:GtAssetsLibraryImageSizeThumbnail];
		}
	}

	return m_thumnailImage; 
}

- (UIImage*) thumbnailImage
{
	if(!self.thumbnail.image)
	{
		[self.thumbnail readFromStorage];
	}

	return self.thumbnail.image;
}

- (void) loadThumbnail
{
	if(!self.thumbnail.image )
	{
		[self.thumbnail readFromStorage];
	}
}

- (void) loadOriginal
{
	if(!self.original.image)
	{
		[self.original readFromStorage];
	}
}

- (void) loadFullScreen
{
	if(!self.fullScreen.image)
	{
		[self.fullScreen readFromStorage];
	}
}

- (void) createThumbnailVersion
{
}

- (void) createFullScreenVersion
{
}

- (void) deleteFromStorage
{
	[m_thumnailImage deleteFromStorage];
	[m_fullScreenImage deleteFromStorage];
	[m_originalImage deleteFromStorage];
}

- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
	clearThumbnailWhenDone:(BOOL) clearThumbnail
{
}

- (id)copyWithZone:(NSZone *)zone
{
	GtAssetsLibraryImageAsset* asset = [[GtAssetsLibraryImageAsset alloc] init];
	asset.original = GtReturnAutoreleased([self.original copyWithZone:nil]);
	asset.thumbnail = GtReturnAutoreleased([self.thumbnail copyWithZone:nil]);
	asset.fullScreen = GtReturnAutoreleased([self.fullScreen copyWithZone:nil]);
	asset.assetUID = self.assetUID;
	return asset;
}

- (BOOL) needsManualScaling
{
	return NO;
}

- (NSDate*) takenDate
{
	return [self.original.properties exifDateTimeOriginal];
}

- (void) beginLoadingRepresentation:(GtErrorCallback) completionBlock
{
    [self.original beginLoadingRepresentation:completionBlock];
}

@end
