//
//	GtCameraImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtJpegFileImageAsset.h"
#import "GtImageUtilities.h"
#import "UIImage+Resize.h"
#import "GtPhotoExif.h"

@interface GtJpegFileImageAsset ()
@property (readwrite, retain, nonatomic) id<GtStorableImage> original;
@property (readwrite, retain, nonatomic) id<GtStorableImage> thumbnail;
@property (readwrite, retain, nonatomic) id<GtStorableImage> fullScreen;
@end

@implementation GtJpegFileImageAsset

@synthesize folder = m_folder;
@synthesize original = m_originalImageFile;
@synthesize thumbnail = m_thumbnailImageFile;
@synthesize fullScreen = m_fullScreenImageFile;

@dynamic assetUID;

static float s_fullSize = 0.0;
static float s_thumbnailSize = 0.0;

+ (void) initialize
{
	CGRect bounds = [UIScreen mainScreen].bounds;
	s_fullSize = MAX(bounds.size.width, bounds.size.height);
	s_thumbnailSize = DeviceIsPad() ? 120 : 80.0;
	
	if(OSVersionIsAtLeast4_0())
	{
		s_fullSize *= [UIScreen mainScreen].scale;
		s_thumbnailSize *= [UIScreen mainScreen].scale;
	}
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithFolder:(GtFolder*) folder assetUID:(NSString*) assetUID
{
	if((self = [super init]))
	{
		self.assetUID = assetUID;
		self.folder = folder;
	}
	
	return self;
}

- (id) initWithJpegData:(NSData*) jpeg
	folder:(GtFolder*) folder
	assetUID:(NSString*) assetUID
{
	if((self = [super init]))
	{
		self.assetUID = assetUID;
		self.folder = folder;
		
		GtJpegFile* jpegFile = (GtJpegFile*) self.original;
		jpegFile.jpegData = jpeg;
	}
	
	return self;
}

- (NSURL*) assetURL
{
	return [NSURL fileURLWithPath:[m_folder pathForFile:self.assetUID]];
}

- (void) dealloc
{
	GtReleaseWithNil(m_folder);
	GtReleaseWithNil(m_fullScreenImageFile);
	GtReleaseWithNil(m_originalImageFile);
	GtReleaseWithNil(m_thumbnailImageFile);
	GtSuperDealloc();
}

- (id<GtStorableImage>) original
{
	if(!m_originalImageFile)
	{
		m_originalImageFile = [[GtJpegFile alloc] initWithJpegData:nil 
			folder:m_folder
			fileName: [NSString stringWithFormat:@"%@%@", self.assetUID, GtPhotoOriginalResolutionFileSuffix]];
	}
	return m_originalImageFile;
}

- (id<GtStorableImage>) thumbnail
{
	if(!m_thumbnailImageFile)
	{
		m_thumbnailImageFile = [[GtJpegFile alloc] initWithJpegData:nil 
			folder:m_folder
			fileName:[NSString stringWithFormat:@"%@%@", self.assetUID, GtPhotoThumbnailImageFileSuffix]];
	
	}
	return m_thumbnailImageFile;
}

- (id<GtStorableImage>) fullScreen
{
	if(!m_fullScreenImageFile)
	{
		m_fullScreenImageFile = [[GtJpegFile alloc] initWithJpegData:nil 
			folder:m_folder
			fileName:[NSString stringWithFormat:@"%@%@", self.assetUID, GtPhotoFullScreenImageFileSuffix]];
	
	}
	return m_fullScreenImageFile;
}

- (void) loadThumbnail
{
	if(!self.thumbnail.hasImage)
	{
		[self.thumbnail readFromStorage];
	}
}

- (void) loadOriginal
{
	if(!self.original.hasImage)
	{
		[self.original readFromStorage];
	}
}

- (void) loadFullScreen
{
	if(!self.fullScreen.hasImage)
	{
		[self.fullScreen readFromStorage];
	}
}

- (void) createThumbnailVersion
{
//	UIImage* thumb = nil;
	
	UIImage* startImage = self.original.image;
	if(!startImage)
	{
		startImage = self.fullScreen.image;
	}

	GtAssertNotNil(startImage);

	[self.thumbnail setImage:[startImage thumbnailImage:s_thumbnailSize 
			transparentBorder:0 
			cornerRadius:0 
			interpolationQuality:kCGInterpolationDefault
			makeSquare:NO]
		exifData:nil
		];
	
//	  GtAssert(startImage != nil, @"no image to create thumbnail with");
//	
//	[startImage shrinkImage:&thumb maxLongSide:s_thumbnailSize makeSquare:YES];
//	
//	self.thumbnail.image = thumb;
//	
//	GtReleaseWithNil(thumb);
}


- (void) createFullScreenVersion
{
	if(!self.fullScreen.hasImage)
	{
//		[original shrinkImage:&fullSized maxLongSide:s_fullSize makeSquare:NO];

		GtAssert(self.original.hasImage, @"no image to create full screen version");

		[self.fullScreen setImage:[self.original.image resizedImageWithContentMode:UIViewContentModeScaleAspectFit 
			bounds:CGSizeMake(s_fullSize, s_fullSize) 
			interpolationQuality:kCGInterpolationDefault]
			exifData:nil];
	}
	
}

- (BOOL) needsManualScaling
{
	return YES;
}

- (void) releaseFiles
{
	GtReleaseWithNil(m_thumbnailImageFile);
	GtReleaseWithNil(m_originalImageFile);
	GtReleaseWithNil(m_fullScreenImageFile);
}


- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
	clearThumbnailWhenDone:(BOOL) clearThumbnail
{
	if( ![self.fullScreen existsInStorage])
	{
		[self.original readFromStorage];
		[self createFullScreenVersion];
		[self.fullScreen writeToStorage];
		[self.original releaseImage];
	}

	if( ![self.thumbnail existsInStorage])
	{
		[self.fullScreen readFromStorage];
		[self createThumbnailVersion];
		[self.thumbnail writeToStorage];
	}
	
	if(clearFullScreen)
	{
		[self.fullScreen releaseImage];
	}
	if(clearThumbnail)
	{
		[self.thumbnail releaseImage];
	}
}

- (id) copyWithZone:(NSZone *)zone
{
	GtJpegFileImageAsset* photo = [[GtJpegFileImageAsset alloc] init];
	photo.original = self.original;
	photo.thumbnail = self.thumbnail;
	photo.fullScreen = self.fullScreen;
	photo.assetUID = self.assetUID;
	photo.folder = self.folder;
	return photo;
}

- (void) deleteFromAssetStorage
{
//	if(m_dataFile && [m_dataFile existsInStorage])
//	{
//		[m_dataFile deleteFromStorage];
//	}
	
	if(m_thumbnailImageFile && [m_thumbnailImageFile existsInStorage])
	{
		[m_thumbnailImageFile deleteFromStorage];
	}
	
	if(m_originalImageFile && [m_originalImageFile existsInStorage])
	{
		[m_originalImageFile deleteFromStorage];
	}
	
	if(m_fullScreenImageFile && [m_fullScreenImageFile existsInStorage])
	{
		[m_fullScreenImageFile deleteFromStorage];
	}
	
//	GtReleaseWithNil(m_dataFile);
	GtReleaseWithNil(m_thumbnailImageFile);
	GtReleaseWithNil(m_originalImageFile);
	GtReleaseWithNil(m_fullScreenImageFile);
}

- (UIImage*) thumbnailImage
{
	if(!self.thumbnail.image)
	{
		[self.thumbnail readFromStorage];
	}

	return self.thumbnail.image;
}

- (NSDate*) takenDate
{
	return [self.original.properties exifDateTimeOriginal];
}

//- (void) loadRepresentation
//{
//}

@end

//@implementation GtCameraPhoto
//
//- (BOOL) isEditable
//{
//	return YES;
//}
//
//- (BOOL) metaDataIsAvailable
//{
//	return NO;
//}
//
//- (id) photoId
//{
//	return self;
//}
//
//- (NSString*) title
//{
//	return @"Camera Photo"; 
//}
//
//- (NSString*) details
//{
//	
//	return @"";
//}
//
//- (BOOL)isEqual:(id)object
//{
//	return [super isEqual:object];
//}
//- (NSUInteger)hash
//{
//	return [super hash];
//}
//
//- (id<GtImageAsset>) photo
//{
//	return self;
//}
//
//@end
