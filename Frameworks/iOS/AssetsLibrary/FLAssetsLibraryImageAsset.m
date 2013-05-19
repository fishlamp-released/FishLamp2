//
//	FLAssetsLibraryImageAsset.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibraryImageAsset.h"
#import "FLAssetsLibrary.h"
#import "FLPhotoExif.h"
#import "FLQueuedAsset.h"

@interface FLAssetsLibraryImageAsset ()
@property (readwrite, retain, nonatomic) id<FLStorableImage> original;
@property (readwrite, retain, nonatomic) id<FLStorableImage> thumbnail;
@property (readwrite, retain, nonatomic) id<FLStorableImage> fullScreen;
@end

@implementation FLAssetsLibraryImageAsset

@synthesize fullScreen = _fullScreenImage;
@synthesize original = _originalImage;
@synthesize thumbnail = _thumnailImage;

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
		_originalImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:url imageSize:FLAssetsLibraryImageSizeOriginal];
	}
	
	return self;
}

- (id) initWithImage:(UIImage*) image metaData:(NSDictionary*) metaData 
{
	if((self = [super init]))
	{
		_originalImage = [[FLAssetsLibraryImage alloc] initWithOriginalImage:image exifData:metaData];
	}
	
	return self;
}

- (id) initWithALAsset:(ALAsset*) asset
{
	if((self = [super init]))
	{
		_originalImage = [[FLAssetsLibraryImage alloc] initWithALAsset:asset imageSize:FLAssetsLibraryImageSizeOriginal];
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
	FLRelease(_thumnailImage);
	FLRelease(_fullScreenImage);
	FLRelease(_originalImage);
	FLSuperDealloc();
}

- (NSURL*) assetURL
{
	return _originalImage.assetURL;
}

- (void) releaseFiles
{
	[_thumnailImage releaseImage];
	[_fullScreenImage releaseImage];
	[_originalImage releaseImage];
}

- (id<FLStorableImage>) fullScreen
{
	if(!_fullScreenImage)
	{
		if(self.asset)
		{
			_fullScreenImage = [[FLAssetsLibraryImage alloc] initWithALAsset:self.asset imageSize:FLAssetsLibraryImageSizeFullScreen];
		}
		else
		{
			_fullScreenImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:FLAssetsLibraryImageSizeFullScreen];
		}
	
	}

	return _fullScreenImage; 
}

- (id<FLStorableImage>) thumbnail
{
	if(!_thumnailImage)
	{
		if(self.asset)
		{
			_thumnailImage = [[FLAssetsLibraryImage alloc] initWithALAsset:self.asset imageSize:FLAssetsLibraryImageSizeThumbnail];
		}
		else
		{
			_thumnailImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:FLAssetsLibraryImageSizeThumbnail];
		}
	}

	return _thumnailImage; 
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
	[_thumnailImage deleteFromStorage];
	[_fullScreenImage deleteFromStorage];
	[_originalImage deleteFromStorage];
}

- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
	clearThumbnailWhenDone:(BOOL) clearThumbnail
{
}

- (id)copyWithZone:(NSZone *)zone
{
	FLAssetsLibraryImageAsset* asset = [[FLAssetsLibraryImageAsset alloc] init];
	asset.original = FLAutorelease([self.original copyWithZone:nil]);
	asset.thumbnail = FLAutorelease([self.thumbnail copyWithZone:nil]);
	asset.fullScreen = FLAutorelease([self.fullScreen copyWithZone:nil]);
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


//    setFactoryBlockForURLScheme:@"assets-library" factory:^(NSURL* url) {
//    }];
//     
//    if([self.assetURL hasPrefix:@"file:"])
////		{
////			self.assetObject = ;
////		}
////		else if([self.assetURL hasPrefix:@"assets-library"])
////		{
////			self.assetObject = FLAutorelease([[FLAssetsLibraryImageAsset alloc] initWithAssetURL:[NSURL URLWithString:self.assetURL]]);
////		}
//
////#import "FLJpegFileImageAsset.h"
////		if([self.assetURL hasPrefix:@"file:"])
////		{
////			self.assetObject = FLAutorelease([[FLJpegFileImageAsset alloc] initWithFolder:[FLUserSession instance].photoFolder assetUID:self.assetUID]);
////		}
////		else if([self.assetURL hasPrefix:@"assets-library"])
////		{
////			self.assetObject = FLAutorelease();
////		}

- (id) initWithQueuedAsset:(FLQueuedAsset*) queuedAsset {
    return [self initWithAssetURL:[NSURL URLWithString:queuedAsset.assetURL]];
}

+ (NSString*) assetURLScheme {
    return @"assets-library";
}


@end
