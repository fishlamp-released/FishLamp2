//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPreferences.h
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLDatabaseObject.h"

// --------------------------------------------------------------------
// ZFPreferences
// --------------------------------------------------------------------
@interface ZFPreferences : FLDatabaseObject<NSCopying, NSCoding>{ 
@private
	NSNumber* _saveImagesToPhoneGalleryOnUpload;
	NSNumber* _allowRefreshOnHomePage;
	NSNumber* _defaultUploadSize;
	NSValue* _landingPageScrollPosition;
	NSValue* _landingPageScrollPositionLandscape;
	NSNumber* _syncLargeImages;
	NSNumber* _openCameraOnLaunch;
	NSNumber* _autoZoomPhotos;
	NSNumber* _didUpgradeUploadQueue;
	NSNumber* _autoUploadPhotos;
	NSNumber* _autoAddNewPhotos;
	NSDate* _autoAddStartDate;
	NSNumber* _didCheckScrapbookPrivilege;
	NSNumber* _hasScrapbookPrivilege;
	NSNumber* _geoTagPhotosByDefault;
	NSNumber* _didUpgradeCache;
} 


@property (readwrite, retain, nonatomic) NSNumber* allowRefreshOnHomePage;

@property (readwrite, retain, nonatomic) NSNumber* autoAddNewPhotos;

@property (readwrite, retain, nonatomic) NSDate* autoAddStartDate;

@property (readwrite, retain, nonatomic) NSNumber* autoUploadPhotos;

@property (readwrite, retain, nonatomic) NSNumber* autoZoomPhotos;

@property (readwrite, retain, nonatomic) NSNumber* defaultUploadSize;

@property (readwrite, retain, nonatomic) NSNumber* didCheckScrapbookPrivilege;

@property (readwrite, retain, nonatomic) NSNumber* didUpgradeCache;

@property (readwrite, retain, nonatomic) NSNumber* didUpgradeUploadQueue;

@property (readwrite, retain, nonatomic) NSNumber* geoTagPhotosByDefault;

@property (readwrite, retain, nonatomic) NSNumber* hasScrapbookPrivilege;

@property (readwrite, retain, nonatomic) NSValue* landingPageScrollPosition;

@property (readwrite, retain, nonatomic) NSValue* landingPageScrollPositionLandscape;

@property (readwrite, retain, nonatomic) NSNumber* openCameraOnLaunch;

@property (readwrite, retain, nonatomic) NSNumber* saveImagesToPhoneGalleryOnUpload;

@property (readwrite, retain, nonatomic) NSNumber* syncLargeImages;

+ (NSString*) allowRefreshOnHomePageKey;

+ (NSString*) autoAddNewPhotosKey;

+ (NSString*) autoAddStartDateKey;

+ (NSString*) autoUploadPhotosKey;

+ (NSString*) autoZoomPhotosKey;

+ (NSString*) defaultUploadSizeKey;

+ (NSString*) didCheckScrapbookPrivilegeKey;

+ (NSString*) didUpgradeCacheKey;

+ (NSString*) didUpgradeUploadQueueKey;

+ (NSString*) geoTagPhotosByDefaultKey;

+ (NSString*) hasScrapbookPrivilegeKey;

+ (NSString*) landingPageScrollPositionKey;

+ (NSString*) landingPageScrollPositionLandscapeKey;

+ (NSString*) openCameraOnLaunchKey;

+ (NSString*) saveImagesToPhoneGalleryOnUploadKey;

+ (NSString*) syncLargeImagesKey;

+ (ZFPreferences*) preferences; 

@end

@interface ZFPreferences (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL saveImagesToPhoneGalleryOnUploadValue;

@property (readwrite, assign, nonatomic) BOOL allowRefreshOnHomePageValue;

@property (readwrite, assign, nonatomic) NSInteger defaultUploadSizeValue;

@property (readwrite, assign, nonatomic) CGPoint landingPageScrollPositionValue;

@property (readwrite, assign, nonatomic) CGPoint landingPageScrollPositionLandscapeValue;

@property (readwrite, assign, nonatomic) BOOL syncLargeImagesValue;

@property (readwrite, assign, nonatomic) BOOL openCameraOnLaunchValue;

@property (readwrite, assign, nonatomic) BOOL autoZoomPhotosValue;

@property (readwrite, assign, nonatomic) BOOL didUpgradeUploadQueueValue;

@property (readwrite, assign, nonatomic) BOOL autoUploadPhotosValue;

@property (readwrite, assign, nonatomic) BOOL autoAddNewPhotosValue;

@property (readwrite, assign, nonatomic) BOOL didCheckScrapbookPrivilegeValue;

@property (readwrite, assign, nonatomic) BOOL hasScrapbookPrivilegeValue;

@property (readwrite, assign, nonatomic) BOOL geoTagPhotosByDefaultValue;

@property (readwrite, assign, nonatomic) BOOL didUpgradeCacheValue;
@end

