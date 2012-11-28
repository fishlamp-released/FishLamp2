//
//  FLPhoto.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPhoto.h"

NSString* const FLPhotoType = @"com.fishlamp.photo";

@implementation FLPhoto

@synthesize originalImage = _originalImage;
@synthesize thumbnailImage = _thumbnailImage;
@synthesize previewImage = _previewImage;

- (id) init {
	if((self = [super init])) {
        self.storageKey = FLPhotoType;
	}
	return self;
}

+ (id) photo {
    return autorelease_([[[self class] alloc] init]);
}


#if FL_MRC
- (void) dealloc {
    [_previewImage release];
    [_originalImage release];
    [_thumbnailImage release];
    [super dealloc];
}
#endif


- (BOOL) needsManualScaling {
	return YES;
}

- (void) clearImages {
    self.thumbnailImage = nil;
    self.originalImage = nil;
    self.previewImage = nil;
}

- (void) copySelfTo:(FLPhoto*) photo {
    [super copySelfTo:photo];
    photo.originalImage = autorelease_([self.originalImage copy]);
    photo.thumbnailImage = autorelease_([self.thumbnailImage copy]);
    photo.previewImage = autorelease_([self.previewImage copy]);
}

@end

//#import "UIImageUtilities.h"
//#import "UIImage+Resize.h"
//#import "FLQueuedAsset.h"

//@interface FLPhoto ()
//@property (readwrite, retain, nonatomic) FLImage*  original;
//@property (readwrite, retain, nonatomic) FLImage*  thumbnail;
//@property (readwrite, retain, nonatomic) FLImage*  fullScreen;
//@end
//@dynamic assetUID;

//static float s_fullSize = 0.0;
//static float s_thumbnailSize = 0.0;
//
//+ (void) initialize {
//
//#if IOS
//	FLRect bounds = [UIScreen mainScreen].bounds;
//	s_fullSize = MAX(bounds.size.width, bounds.size.height);
//	s_thumbnailSize = DeviceIsPad() ? 120 : 80.0;
//    s_fullSize *= [UIScreen mainScreen].scale;
//    s_thumbnailSize *= [UIScreen mainScreen].scale;
//#endif
//}


//- (id) initWithFolder:(FLFolder*) folder assetUID:(NSString*) assetUID {
//	if((self = [super init])) {
//		self.assetUID = assetUID;
//		self.folder = folder;
//	}
//	
//	return self;
//}

//- (id) initWithJpegData:(NSData*) jpeg
//	folder:(FLFolder*) folder
//	assetUID:(NSString*) assetUID {
//	
//    if((self = [super init])) {
//		self.assetUID = assetUID;
//		self.folder = folder;
//		
//		FLJpegFile* jpegFile = (FLJpegFile*) self.original;
//		jpegFile.jpegData = jpeg;
//	}
//	
//	return self;
//}
//
//- (NSURL*) assetURL {
//	return [NSURL fileURLWithPath:[_folder pathForFile:self.assetUID]];
//}
//- (void) createThumbnailVersion
//{
////	NSImage_* thumb = nil;
//	
//	NSImage_* startImage = self.original.image;
//	if(!startImage)
//	{
//		startImage = self.fullScreen.image;
//	}
//
//	FLAssertIsNotNil_v(startImage, nil);
//
//	[self.thumbnail setImage:[startImage thumbnailImage:s_thumbnailSize 
//			transparentBorder:0 
//			cornerRadius:0 
//			interpolationQuality:kCGInterpolationDefault
//			makeSquare:NO]
//		exifData:nil
//		];
//	
////	  FLAssert_v(startImage != nil, @"no image to create thumbnail with");
////	
////	[startImage shrinkImage:&thumb maxLongSide:s_thumbnailSize makeSquare:YES];
////	
////	self.thumbnail.image = thumb;
////	
////	FLReleaseWithNil_(thumb);
//}
//
//
//- (void) createFullScreenVersion
//{
//	if(!self.fullScreen.hasImage)
//	{
////		[original shrinkImage:&fullSized maxLongSide:s_fullSize makeSquare:NO];
//
//		FLAssert_v(self.original.hasImage, @"no image to create full screen version");
//
//		[self.fullScreen setImage:[self.original.image resizedImageWithContentMode:UIViewContentModeScaleAspectFit 
//			bounds:FLSizeMake(s_fullSize, s_fullSize) 
//			interpolationQuality:kCGInterpolationDefault]
//			exifData:nil];
//	}
//	
//}//- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
//	clearThumbnailWhenDone:(BOOL) clearThumbnail
//{
//
//// FIXME: asset stuff is a mess
//
////	if( ![self.fullScreen existsInStorage])
////	{
////		[self.original readFromStorage];
////		[self createFullScreenVersion];
////		[self.fullScreen writeToStorage];
////		[self.original releaseImage];
////	}
////
////	if( ![self.thumbnail existsInStorage])
////	{
////		[self.fullScreen readFromStorage];
////		[self createThumbnailVersion];
////		[self.thumbnail writeToStorage];
////	}
////	
////	if(clearFullScreen)
////	{
////		[self.fullScreen releaseImage];
////	}
////	if(clearThumbnail)
////	{
////		[self.thumbnail releaseImage];
////	}
//}

//- (void) deleteFromAssetStorage
//{
////	if(_dataFile && [_dataFile existsInStorage])
////	{
////		[_dataFile deleteFromStorage];
////	}
//	
//	if(_thumbnailImageFile && [_thumbnailImageFile existsInStorage])
//	{
//		[_thumbnailImageFile deleteFromStorage];
//	}
//	
//	if(_originalImageFile && [_originalImageFile existsInStorage])
//	{
//		[_originalImageFile deleteFromStorage];
//	}
//	
//	if(_fullScreenImageFile && [_fullScreenImageFile existsInStorage])
//	{
//		[_fullScreenImageFile deleteFromStorage];
//	}
//	
////	FLReleaseWithNil_(_dataFile);
//	FLReleaseWithNil_(_thumbnailImageFile);
//	FLReleaseWithNil_(_originalImageFile);
//	FLReleaseWithNil_(_fullScreenImageFile);
//}

//- (NSImage_*) thumbnailImage {
//
//// FIXME: asset stuff is a mess
//
////	if(!self.thumbnail.image) {
////		[self.thumbnail readFromStorage];
////	}
//
//	return self.thumbnail.image;
//}
//
//- (NSDate*) takenDate {
//FIXME("ios dependencecy");
//    return nil;
////	return [self.original.properties exifDateTimeOriginal];
//}
//
////- (void) loadRepresentation
////{
////}
//
//+ (NSString*) assetURLScheme {
//    return @"file";
//}
