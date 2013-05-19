//
//	FLCameraImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import "FLJpegFileImageAsset.h"
#import "FLCocoaRequired.h"
#import "SDKImage+Resize.h"
#import "FLQueuedAsset.h"

#import "FLFileAssetStorage.h"
#define FLPhotoOriginalResolutionFileSuffix @"_O.JPG"
#define FLPhotoFullScreenImageFileSuffix @"_F.JPG"
#define FLPhotoThumbnailImageFileSuffix @"_T.JPG"

@interface FLJpegFileImageAsset ()
@property (readwrite, retain, nonatomic) id<FLStorableImage> original;
@property (readwrite, retain, nonatomic) id<FLStorableImage> thumbnail;
@property (readwrite, retain, nonatomic) id<FLStorableImage> fullScreen;
@end

@implementation FLJpegFileImageAsset

@synthesize folder = _folder;
@synthesize original = _originalImageFile;
@synthesize thumbnail = _thumbnailImageFile;
@synthesize fullScreen = _fullScreenImageFile;

@dynamic assetUID;

static float s_fullSize = 0.0;
static float s_thumbnailSize = 0.0;

+ (void) initialize {

#if IOS
	CGRect bounds = [UIScreen mainScreen].bounds;
	s_fullSize = MAX(bounds.size.width, bounds.size.height);
	s_thumbnailSize = DeviceIsPad() ? 120 : 80.0;
	
	
    s_fullSize *= [UIScreen mainScreen].scale;
    s_thumbnailSize *= [UIScreen mainScreen].scale;
#endif
}

- (id) init {
	if((self = [super init])) {
	}
	return self;
}

- (id) initWithFolder:(FLFolder*) folder assetUID:(NSString*) assetUID {
	if((self = [super init])) {
		self.assetUID = assetUID;
		self.folder = folder;
	}
	
	return self;
}

- (id) initWithQueuedAsset:(FLQueuedAsset*) asset {

    return nil;
}

- (id) initWithQueuedAsset:(FLQueuedAsset*) queuedAsset inFolder:(FLFolder*) folder {
    return [self initWithFolder:folder assetUID:queuedAsset.assetUID];
}

- (id) initWithJpegData:(NSData*) jpeg
	folder:(FLFolder*) folder
	assetUID:(NSString*) assetUID {
	
    if((self = [super init])) {
		self.assetUID = assetUID;
		self.folder = folder;
		
		FLJpegFile* jpegFile = (FLJpegFile*) self.original;
		jpegFile.jpegData = jpeg;
	}
	
	return self;
}

- (NSURL*) assetURL {
	return [NSURL fileURLWithPath:[_folder pathForFile:self.assetUID]];
}

- (void) dealloc {
	FLReleaseWithNil(_folder);
	FLReleaseWithNil(_fullScreenImageFile);
	FLReleaseWithNil(_originalImageFile);
	FLReleaseWithNil(_thumbnailImageFile);
	FLSuperDealloc();
}

- (id<FLStorableImage>) original
{
	if(!_originalImageFile)
	{
		_originalImageFile = [[FLJpegFile alloc] initWithJpegData:nil 
			folder:_folder
			fileName: [NSString stringWithFormat:@"%@%@", self.assetUID, FLPhotoOriginalResolutionFileSuffix]];
	}
	return _originalImageFile;
}

- (id<FLStorableImage>) thumbnail
{
	if(!_thumbnailImageFile)
	{
		_thumbnailImageFile = [[FLJpegFile alloc] initWithJpegData:nil 
			folder:_folder
			fileName:[NSString stringWithFormat:@"%@%@", self.assetUID, FLPhotoThumbnailImageFileSuffix]];
	
	}
	return _thumbnailImageFile;
}

- (id<FLStorableImage>) fullScreen
{
	if(!_fullScreenImageFile)
	{
		_fullScreenImageFile = [[FLJpegFile alloc] initWithJpegData:nil 
			folder:_folder
			fileName:[NSString stringWithFormat:@"%@%@", self.assetUID, FLPhotoFullScreenImageFileSuffix]];
	
	}
	return _fullScreenImageFile;
}

// FIXME: asset stuff is a mess

- (void) loadThumbnail
{
//	if(!self.thumbnail.hasImage)
//	{
//		[self.thumbnail readFromStorage];
//	}
}

- (void) loadOriginal
{
//	if(!self.original.hasImage)
//	{
//		[self.original readFromStorage];
//	}
}

- (void) loadFullScreen
{
//	if(!self.fullScreen.hasImage)
//	{
//		[self.fullScreen readFromStorage];
//	}
}

- (void) createThumbnailVersion
{
//	SDKImage* thumb = nil;
	
	SDKImage* startImage = self.original.image;
	if(!startImage)
	{
		startImage = self.fullScreen.image;
	}

	FLAssertIsNotNilWithComment(startImage, nil);

	[self.thumbnail setImage:[startImage thumbnailImage:s_thumbnailSize 
			transparentBorder:0 
			cornerRadius:0 
			interpolationQuality:kCGInterpolationDefault
			makeSquare:NO]
		exifDictionary:nil
		];
	
//	  FLAssertWithComment(startImage != nil, @"no image to create thumbnail with");
//	
//	[startImage shrinkImage:&thumb maxLongSide:s_thumbnailSize makeSquare:YES];
//	
//	self.thumbnail.image = thumb;
//	
//	FLReleaseWithNil(thumb);
}


- (void) createFullScreenVersion
{
	if(!self.fullScreen.hasImage)
	{
//		[original shrinkImage:&fullSized maxLongSide:s_fullSize makeSquare:NO];

		FLAssertWithComment(self.original.hasImage, @"no image to create full screen version");

		[self.fullScreen setImage:[self.original.image resizedImageWithContentMode:UIViewContentModeScaleAspectFit 
			bounds:CGSizeMake(s_fullSize, s_fullSize) 
			interpolationQuality:kCGInterpolationDefault]
			exifDictionary:nil];
	}
	
}

- (BOOL) needsManualScaling
{
	return YES;
}

- (void) releaseFiles
{
	FLReleaseWithNil(_thumbnailImageFile);
	FLReleaseWithNil(_originalImageFile);
	FLReleaseWithNil(_fullScreenImageFile);
}


- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
	clearThumbnailWhenDone:(BOOL) clearThumbnail
{

// FIXME: asset stuff is a mess

//	if( ![self.fullScreen existsInStorage])
//	{
//		[self.original readFromStorage];
//		[self createFullScreenVersion];
//		[self.fullScreen writeToStorage];
//		[self.original releaseImage];
//	}
//
//	if( ![self.thumbnail existsInStorage])
//	{
//		[self.fullScreen readFromStorage];
//		[self createThumbnailVersion];
//		[self.thumbnail writeToStorage];
//	}
//	
//	if(clearFullScreen)
//	{
//		[self.fullScreen releaseImage];
//	}
//	if(clearThumbnail)
//	{
//		[self.thumbnail releaseImage];
//	}
}

- (id) copyWithZone:(NSZone *)zone
{
	FLJpegFileImageAsset* photo = [[FLJpegFileImageAsset alloc] init];
	photo.original = self.original;
	photo.thumbnail = self.thumbnail;
	photo.fullScreen = self.fullScreen;
	photo.assetUID = self.assetUID;
	photo.folder = self.folder;
	return photo;
}

- (void) deleteFromAssetStorage
{
//	if(_dataFile && [_dataFile existsInStorage])
//	{
//		[_dataFile deleteFromStorage];
//	}
	
	if(_thumbnailImageFile && [_thumbnailImageFile existsInStorage])
	{
		[_thumbnailImageFile deleteFromStorage];
	}
	
	if(_originalImageFile && [_originalImageFile existsInStorage])
	{
		[_originalImageFile deleteFromStorage];
	}
	
	if(_fullScreenImageFile && [_fullScreenImageFile existsInStorage])
	{
		[_fullScreenImageFile deleteFromStorage];
	}
	
//	FLReleaseWithNil(_dataFile);
	FLReleaseWithNil(_thumbnailImageFile);
	FLReleaseWithNil(_originalImageFile);
	FLReleaseWithNil(_fullScreenImageFile);
}

- (SDKImage*) thumbnailImage {

// FIXME: asset stuff is a mess

//	if(!self.thumbnail.image) {
//		[self.thumbnail readFromStorage];
//	}

	return self.thumbnail.image;
}

- (NSDate*) takenDate {
FIXME("ios dependencecy");
    return nil;
//	return [self.original.properties exifDateTimeOriginal];
}

//- (void) loadRepresentation
//{
//}

+ (NSString*) assetURLScheme {
    return @"file";
}

@end

//@implementation FLCameraPhoto
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
//- (id<FLImageAsset>) photo
//{
//	return self;
//}
//
//@end
#endif