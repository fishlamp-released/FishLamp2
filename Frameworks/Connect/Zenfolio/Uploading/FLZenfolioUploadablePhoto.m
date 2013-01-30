//
//	FLZenfolioUploadablePhoto.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioUploadablePhoto.h"
//#import "FLZenfolioCategoryManager.h"
//#import "FLZenfolioUtils.h"
//#import "FLSavePhotoToUsersPhotoAlbumOperation.h"
//#import "FLZenfolioUploadPhotoOperation.h"
//
//#import "FLUserLoginService.h"
//#import "NSFileManager+FLExtras.h"
//#import "FLHtmlStringBuilder.h"
//
//#import "FLJpegFileImageAsset.h"

//#define FILENAME @"IMG_"

@implementation FLZenfolioUploadablePhoto

//@synthesize photo = _photo;
//FLSynthesizeWeakRefProperty();

//- (id) initWithFLPhoto:(id<FLImageAsset>) photo 
//	isCameraImage:(BOOL) isCameraImage 
//	prefs:(FLZenfolioPreferences*) prefs
//{
//	FLAssertIsNotNil_(photo);
//	FLAssertIsNotNil_(prefs);
//
//	if((self = [super init]))
//	{
//		[self setOptionsToDefault: prefs ];
//		self.isCameraImage = isCameraImage;
//		self.dimensions = photo.original.image.size; 
//		self.wasSavedToPhotoGallery = !isCameraImage;
//		self.takenDate = [NSDate date];
//		self.modifiedDate = self.takenDate;
//		self.uploadGallery = prefs.defaultUploadGallery ? prefs.defaultUploadGallery : nil;
//		self.accessDescriptor = prefs.defaultAccessDescriptor ? prefs.defaultAccessDescriptor : nil ;
//		[self setPhotoDataFileName:photo.rootFileName];
//		self.photo = photo;
//	}
//	return self;
//}

//- (void) dealloc
//{	
//	FLReleaseWeakRef();
//	
//	FLRelease(_photo);
//	FLSuperDealloc();
//}

//- (unsigned long long) dataFileSize
//{
//	unsigned long long size2 = 0;
//	[NSFileManager getFileSize:self.photo.dataFile.filePath outSize:&size2 outError:nil];
//	return size2;
//}

//- (unsigned long long) originalFileSize
//{
//	unsigned long long size = 0;
//	[NSFileManager getFileSize:self.photo.original.filePath outSize:&size outError:nil];
//	return size;
//}
//
//- (unsigned long long) actualUploadSize
//{
//	return self.originalFileSize;
//}
//
//- (NSComparisonResult) onOldestFirstSort:(FLZenfolioUploadablePhoto*) compareTo
//{
//	return [self.takenDate compare:compareTo.takenDate];
//}
//
//- (NSComparisonResult) onNewestFirstSort:(FLZenfolioUploadablePhoto*) compareTo
//{
//	return [compareTo.takenDate compare:self.takenDate];
//}
//
//- (NSComparisonResult) onSortArrayForUI:(FLZenfolioUploadablePhoto*) compareTo
//{
//	int lhs = self.sortId;
//	int rhs = compareTo.sortId;
//
//	if(lhs == rhs )
//	{
//		return NSOrderedSame;
//	}
//	
//	return lhs < rhs ? NSOrderedAscending : NSOrderedDescending;
//}
//
//- (NSString*) displayName
//{
//	return FLStringIsNotEmpty(self.Title) ? self.Title : self.FileName;
//}
//
//- (void) setNewFileName:(FLZenfolioPreferences*) prefs
//{
//	prefs.lastPhotoID = prefs.lastPhotoID + 1;
//	NSString* fileName = [[NSString alloc] initWithFormat:@"%@%04u.JPG", FILENAME, prefs.lastPhotoID];
//	self.FileName = fileName;
//	FLReleaseWithNil(fileName);
//}
//
//- (void) setOptionsToDefault:(FLZenfolioPreferences*) prefs
//{
//	[self setNewFileName:prefs];
//	self.loginName = [FLUserLoginService instance].userLogin.userName;
//	self.uploadSize = prefs.defaultUploadSize;
//
//	if(prefs.defaultUploadGallery)
//	{
//		self.uploadGallery= prefs.defaultUploadGallery;
//	}
//	
//	self.saveToPhoneGalleryOnUpload = prefs.saveImagesToPhoneGalleryOnUpload;
//	self.accessDescriptor = prefs.defaultAccessDescriptor;
//
//	self.sortId = prefs.uploadQueueSortType == FLZenfolioUploadQueueSortNewestFirst ? -prefs.lastPhotoID : prefs.lastPhotoID;
//	self.uploadFileId = prefs.lastPhotoID;
//}
//
//- (void) deleteFromDisk
//{
//	[self.photo deleteFiles];
//}
//
//- (void) saveToDisk
//{
//}
//
//- (void) reloadDataFile
//{
//	FLZenfolioUploadablePhoto* photo = nil;
//	
//	[FLZenfolioUploadablePhoto loadFromDisk:self.photo outPhoto:&photo];
//	
//	FLAssertIsNotNil_(photo);
//	if(photo)
//	{
//		[self copyContentsFromObject:photo];
//
//		self.photo = photo.photo;
//		FLReleaseWithNil(photo);
//	}
//}
//
//- (void) copyContentsFromObject:(id) srcObject
//{
//	[super copyContentsFromObject:srcObject];
//	self.photo = [srcObject photo];
//}
//
////+ (BOOL) loadFromDisk:(id<FLImageAsset>) photoFile outPhoto:(FLZenfolioUploadablePhoto**) outPhoto
////{
////	photoFile.dataFile.data = nil;
////	
////	if([photoFile.dataFile existsInStorage])
////	{
////		[photoFile.dataFile readFromStorage];
////	
////		FLZenfolioUploadablePhoto* loadedPhoto = nil;
////
////		if(photoFile.dataFile.hasData)
////		{
////			loadedPhoto = [NSKeyedUnarchiver unarchiveObjectWithData:photoFile.dataFile.data];
////			
////			if(loadedPhoto)
////			{
////				loadedPhoto.photo = photoFile;
////				*outPhoto = FLRetain(loadedPhoto);
////				return YES;
////			}
////		}
////	}
////	
////	return NO;
////	
////}
//
//- (BOOL) imageBytesUploaded
//{
//	return self.uploadedPhotoId && self.uploadedPhotoId != 0;
//}
//
//#define FLNonNullString(s) FLStringIsEmpty(s) ? @"" : s
//
//- (FLZenfolioPhotoUpdater*) createUpdater
//{
//	FLZenfolioPhotoUpdater* updater = FLAutorelease([[FLZenfolioPhotoUpdater alloc] init]);
//	updater.Title = FLNonNullString(self.Title);
//	updater.Caption = FLNonNullString([FLHtmlStringBuilder convertToSimpleHtml:self.Caption]);
//	updater.Keywords = self.Keywords;
//	updater.Categories = self.Categories;
//	updater.Copyright = FLNonNullString(self.Copyright);
//	updater.FileName = FLNonNullString(self.FileName);
//	return updater;
//}
//
//- (BOOL)isEqual:(id)object;
//{
//	return [object isKindOfClass:[self class]] && [[self photoDataFileName] isEqualToString:[object photoDataFileName]];
//}
//
//- (NSUInteger)hash
//{
//	return [self.photoDataFileName hash];
//}

@end
