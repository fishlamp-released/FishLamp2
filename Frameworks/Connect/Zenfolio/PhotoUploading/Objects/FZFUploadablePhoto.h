//
//	FLZenfolioUploadablePhoto.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioUploadablePhotoBase.h"
//#import "FLImageAsset.h"
//#import "FLZenfolioPreferences.h"
//#import "FLJpegFileImageAsset.h"
//#import "FLZenfolioCategoryManager.h"
//#import "FLWeakReference.h"

//#define FLZenfolio_LARGE_PHOTO_SUFFIX	@"_ZenfolioL.JPG"
//#define FLZenfolio_MEDIUM_PHOTO_SUFFIX	@"_ZenfolioM.JPG"

@interface FLZenfolioUploadablePhoto : FLZenfolioUploadablePhotoBase {
//	id<FLImageAsset> _photo;
//	unsigned long long _actualUploadSize;
//	FLDeclareWeakRefMember();
}

//- (id) initWithFLPhoto:(id<FLImageAsset>) photo 
//	isCameraImage:(BOOL) isCameraImage
//	prefs:(FLZenfolioPreferences*) prefs;
//
//@property (readwrite, retain, nonatomic) id<FLImageAsset> photo;
//@property (readonly, assign, nonatomic) unsigned long long actualUploadSize;

//- (NSComparisonResult) onOldestFirstSort:(FLZenfolioUploadablePhoto*) compareTo;
//- (NSComparisonResult) onNewestFirstSort:(FLZenfolioUploadablePhoto*) compareTo;
//- (NSComparisonResult) onSortArrayForUI:(FLZenfolioUploadablePhoto*) compareTo;
//
//- (NSString*) displayName;
//- (void) setOptionsToDefault:(FLZenfolioPreferences*) prefs;
//- (void) setNewFileName:(FLZenfolioPreferences*) prefs;

//- (void) deleteFromDisk;
//- (void) saveToDisk;
//- (void) reloadDataFile;

//- (void) updateCategories:(FLZenfolioCategoryManager*) categoryManager;

//+ (BOOL) loadFromDisk:(id<FLImageAsset>) photo 
//			 outPhoto:(FLZenfolioUploadablePhoto**) outPhoto;

//- (BOOL) imageBytesUploaded;
//
//- (FLZenfolioPhotoUpdater*) createUpdater;
//
//- (unsigned long long) dataFileSize;
//- (unsigned long long) originalFileSize;

@end

