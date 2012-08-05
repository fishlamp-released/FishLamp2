//
//	FLAssetsLibraryImageAsset.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLAssetsLibraryImageAsset.h"
#import "FLAssetsLibrary.h"
#import "FLPhotoExif.h"

@interface FLAssetsLibraryImageAsset ()
@property (readwrite, retain, nonatomic) id<FLStorableImage> original;
@property (readwrite, retain, nonatomic) id<FLStorableImage> thumbnail;
@property (readwrite, retain, nonatomic) id<FLStorableImage> fullScreen;
@end

@implementation FLAssetsLibraryImageAsset

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
		m_originalImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:url imageSize:FLAssetsLibraryImageSizeOriginal];
	}
	
	return self;
}

- (id) initWithImage:(UIImage*) image metaData:(NSDictionary*) metaData;
{
	if((self = [super init]))
	{
		m_originalImage = [[FLAssetsLibraryImage alloc] initWithOriginalImage:image exifData:metaData];
	}
	
	return self;
}

- (id) initWithALAsset:(ALAsset*) asset
{
	if((self = [super init]))
	{
		m_originalImage = [[FLAssetsLibraryImage alloc] initWithALAsset:asset imageSize:FLAssetsLibraryImageSizeOriginal];
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
	return ((FLAssetsLibraryImage*)self.original).asset;
}

- (void) dealloc
{
	FLRelease(m_thumnailImage);
	FLRelease(m_fullScreenImage);
	FLRelease(m_originalImage);
	FLSuperDealloc();
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

- (id<FLStorableImage>) fullScreen
{
	if(!m_fullScreenImage)
	{
		if(self.asset)
		{
			m_fullScreenImage = [[FLAssetsLibraryImage alloc] initWithALAsset:self.asset imageSize:FLAssetsLibraryImageSizeFullScreen];
		}
		else
		{
			m_fullScreenImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:FLAssetsLibraryImageSizeFullScreen];
		}
	
	}

	return m_fullScreenImage; 
}

- (id<FLStorableImage>) thumbnail
{
	if(!m_thumnailImage)
	{
		if(self.asset)
		{
			m_thumnailImage = [[FLAssetsLibraryImage alloc] initWithALAsset:self.asset imageSize:FLAssetsLibraryImageSizeThumbnail];
		}
		else
		{
			m_thumnailImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:FLAssetsLibraryImageSizeThumbnail];
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
	FLAssetsLibraryImageAsset* asset = [[FLAssetsLibraryImageAsset alloc] init];
	asset.original = FLReturnAutoreleased([self.original copyWithZone:nil]);
	asset.thumbnail = FLReturnAutoreleased([self.thumbnail copyWithZone:nil]);
	asset.fullScreen = FLReturnAutoreleased([self.fullScreen copyWithZone:nil]);
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

- (void) beginLoadingRepresentation:(FLErrorCallback) completionBlock
{
    [self.original beginLoadingRepresentation:completionBlock];
}

@end
