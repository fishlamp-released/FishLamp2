//
//	FLZfUploadablePhoto.h
//	MyZen
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfUploadablePhotoBase.h"
//#import "FLImageAsset.h"
//#import "FLZfPreferences.h"
//#import "FLJpegFileImageAsset.h"
//#import "FLZfCategoryManager.h"
//#import "FLWeakReference.h"

//#define FLZf_LARGE_PHOTO_SUFFIX	@"_ZFL.JPG"
//#define FLZf_MEDIUM_PHOTO_SUFFIX	@"_ZFM.JPG"

@interface FLZfUploadablePhoto : FLZfUploadablePhotoBase {
//	id<FLImageAsset> _photo;
//	unsigned long long _actualUploadSize;
//	FLDeclareWeakRefMember();
}

//- (id) initWithFLPhoto:(id<FLImageAsset>) photo 
//	isCameraImage:(BOOL) isCameraImage
//	prefs:(FLZfPreferences*) prefs;
//
//@property (readwrite, retain, nonatomic) id<FLImageAsset> photo;
//@property (readonly, assign, nonatomic) unsigned long long actualUploadSize;

//- (NSComparisonResult) onOldestFirstSort:(FLZfUploadablePhoto*) compareTo;
//- (NSComparisonResult) onNewestFirstSort:(FLZfUploadablePhoto*) compareTo;
//- (NSComparisonResult) onSortArrayForUI:(FLZfUploadablePhoto*) compareTo;
//
//- (NSString*) displayName;
//- (void) setOptionsToDefault:(FLZfPreferences*) prefs;
//- (void) setNewFileName:(FLZfPreferences*) prefs;

//- (void) deleteFromDisk;
//- (void) saveToDisk;
//- (void) reloadDataFile;

//- (void) updateCategories:(FLZfCategoryManager*) categoryManager;

//+ (BOOL) loadFromDisk:(id<FLImageAsset>) photo 
//			 outPhoto:(FLZfUploadablePhoto**) outPhoto;

//- (BOOL) imageBytesUploaded;
//
//- (FLZfPhotoUpdater*) createUpdater;
//
//- (unsigned long long) dataFileSize;
//- (unsigned long long) originalFileSize;

@end

