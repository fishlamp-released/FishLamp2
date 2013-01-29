//
//	ZFUploadablePhoto.h
//	MyZen
//
//	Created by Mike Fullerton on 10/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFUploadablePhotoBase.h"
//#import "FLImageAsset.h"
//#import "ZFPreferences.h"
//#import "FLJpegFileImageAsset.h"
//#import "ZFCategoryManager.h"
//#import "FLWeakReference.h"

//#define ZF_LARGE_PHOTO_SUFFIX	@"_ZFL.JPG"
//#define ZF_MEDIUM_PHOTO_SUFFIX	@"_ZFM.JPG"

@interface ZFUploadablePhoto : ZFUploadablePhotoBase {
//	id<FLImageAsset> _photo;
//	unsigned long long _actualUploadSize;
//	FLDeclareWeakRefMember();
}

//- (id) initWithFLPhoto:(id<FLImageAsset>) photo 
//	isCameraImage:(BOOL) isCameraImage
//	prefs:(ZFPreferences*) prefs;
//
//@property (readwrite, retain, nonatomic) id<FLImageAsset> photo;
//@property (readonly, assign, nonatomic) unsigned long long actualUploadSize;

//- (NSComparisonResult) onOldestFirstSort:(ZFUploadablePhoto*) compareTo;
//- (NSComparisonResult) onNewestFirstSort:(ZFUploadablePhoto*) compareTo;
//- (NSComparisonResult) onSortArrayForUI:(ZFUploadablePhoto*) compareTo;
//
//- (NSString*) displayName;
//- (void) setOptionsToDefault:(ZFPreferences*) prefs;
//- (void) setNewFileName:(ZFPreferences*) prefs;

//- (void) deleteFromDisk;
//- (void) saveToDisk;
//- (void) reloadDataFile;

//- (void) updateCategories:(ZFCategoryManager*) categoryManager;

//+ (BOOL) loadFromDisk:(id<FLImageAsset>) photo 
//			 outPhoto:(ZFUploadablePhoto**) outPhoto;

//- (BOOL) imageBytesUploaded;
//
//- (ZFPhotoUpdater*) createUpdater;
//
//- (unsigned long long) dataFileSize;
//- (unsigned long long) originalFileSize;

@end

