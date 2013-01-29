//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLocalPreferences.h
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLUserPreferences.h"
@class ZFUploadGallery;
@class ZFAccessDescriptor;
@class FLSlideshowOptions;
@class ZFBrowserViewOptions;

// --------------------------------------------------------------------
// ZFLocalPreferences
// --------------------------------------------------------------------
@interface ZFLocalPreferences : FLUserPreferences<NSCopying, NSCoding>{ 
@private
	ZFUploadGallery* _defaultUploadGallery;
	NSNumber* _saveImagesToPhoneGalleryOnUpload;
	NSNumber* _slideShowLength;
	NSNumber* _autoRotateImagesInSlideshow;
	NSNumber* _allowRefreshOnHomePage;
	NSNumber* _showFeaturedGalleries;
	NSNumber* _showRecentGalleries;
	ZFAccessDescriptor* _defaultAccessDescriptor;
	NSNumber* _defaultUploadSize;
	NSNumber* _lastPhotoID;
	NSNumber* _disableHighPerformanceCache;
	NSNumber* _disableDiskCache;
	NSNumber* _uploadQueueSortType;
	NSValue* _landingPageScrollPosition;
	NSValue* _landingPageScrollPositionLandscape;
	NSNumber* _syncLargeImages;
	NSNumber* _openCameraOnLaunch;
	NSNumber* _experimentalCamera;
	NSNumber* _experimentalTabBar;
	NSNumber* _photoSetListMode;
	NSNumber* _groupListMode;
	NSNumber* _autoZoomPhotos;
	NSNumber* _autoAllowXXLImages;
	NSNumber* _didUpgradeUploadQueue;
	FLSlideshowOptions* _defaultSlideshowOptions;
	ZFBrowserViewOptions* _defaultBrowserViewOptions;
} 


@property (readwrite, retain, nonatomic) NSNumber* allowRefreshOnHomePage;

@property (readwrite, retain, nonatomic) NSNumber* autoAllowXXLImages;

@property (readwrite, retain, nonatomic) NSNumber* autoRotateImagesInSlideshow;

@property (readwrite, retain, nonatomic) NSNumber* autoZoomPhotos;

@property (readwrite, retain, nonatomic) ZFAccessDescriptor* defaultAccessDescriptor;

@property (readwrite, retain, nonatomic) ZFBrowserViewOptions* defaultBrowserViewOptions;

@property (readwrite, retain, nonatomic) FLSlideshowOptions* defaultSlideshowOptions;

@property (readwrite, retain, nonatomic) ZFUploadGallery* defaultUploadGallery;

@property (readwrite, retain, nonatomic) NSNumber* defaultUploadSize;

@property (readwrite, retain, nonatomic) NSNumber* didUpgradeUploadQueue;

@property (readwrite, retain, nonatomic) NSNumber* disableDiskCache;

@property (readwrite, retain, nonatomic) NSNumber* disableHighPerformanceCache;

@property (readwrite, retain, nonatomic) NSNumber* experimentalCamera;

@property (readwrite, retain, nonatomic) NSNumber* experimentalTabBar;

@property (readwrite, retain, nonatomic) NSNumber* groupListMode;

@property (readwrite, retain, nonatomic) NSValue* landingPageScrollPosition;

@property (readwrite, retain, nonatomic) NSValue* landingPageScrollPositionLandscape;

@property (readwrite, retain, nonatomic) NSNumber* lastPhotoID;

@property (readwrite, retain, nonatomic) NSNumber* openCameraOnLaunch;

@property (readwrite, retain, nonatomic) NSNumber* photoSetListMode;

@property (readwrite, retain, nonatomic) NSNumber* saveImagesToPhoneGalleryOnUpload;

@property (readwrite, retain, nonatomic) NSNumber* showFeaturedGalleries;

@property (readwrite, retain, nonatomic) NSNumber* showRecentGalleries;

@property (readwrite, retain, nonatomic) NSNumber* slideShowLength;

@property (readwrite, retain, nonatomic) NSNumber* syncLargeImages;

@property (readwrite, retain, nonatomic) NSNumber* uploadQueueSortType;

+ (NSString*) allowRefreshOnHomePageKey;

+ (NSString*) autoAllowXXLImagesKey;

+ (NSString*) autoRotateImagesInSlideshowKey;

+ (NSString*) autoZoomPhotosKey;

+ (NSString*) defaultAccessDescriptorKey;

+ (NSString*) defaultBrowserViewOptionsKey;

+ (NSString*) defaultSlideshowOptionsKey;

+ (NSString*) defaultUploadGalleryKey;

+ (NSString*) defaultUploadSizeKey;

+ (NSString*) didUpgradeUploadQueueKey;

+ (NSString*) disableDiskCacheKey;

+ (NSString*) disableHighPerformanceCacheKey;

+ (NSString*) experimentalCameraKey;

+ (NSString*) experimentalTabBarKey;

+ (NSString*) groupListModeKey;

+ (NSString*) landingPageScrollPositionKey;

+ (NSString*) landingPageScrollPositionLandscapeKey;

+ (NSString*) lastPhotoIDKey;

+ (NSString*) openCameraOnLaunchKey;

+ (NSString*) photoSetListModeKey;

+ (NSString*) saveImagesToPhoneGalleryOnUploadKey;

+ (NSString*) showFeaturedGalleriesKey;

+ (NSString*) showRecentGalleriesKey;

+ (NSString*) slideShowLengthKey;

+ (NSString*) syncLargeImagesKey;

+ (NSString*) uploadQueueSortTypeKey;

+ (ZFLocalPreferences*) localPreferences; 

@end

@interface ZFLocalPreferences (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL saveImagesToPhoneGalleryOnUploadValue;

@property (readwrite, assign, nonatomic) float slideShowLengthValue;

@property (readwrite, assign, nonatomic) BOOL autoRotateImagesInSlideshowValue;

@property (readwrite, assign, nonatomic) BOOL allowRefreshOnHomePageValue;

@property (readwrite, assign, nonatomic) BOOL showFeaturedGalleriesValue;

@property (readwrite, assign, nonatomic) BOOL showRecentGalleriesValue;

@property (readwrite, assign, nonatomic) NSInteger defaultUploadSizeValue;

@property (readwrite, assign, nonatomic) NSInteger lastPhotoIDValue;

@property (readwrite, assign, nonatomic) BOOL disableHighPerformanceCacheValue;

@property (readwrite, assign, nonatomic) BOOL disableDiskCacheValue;

@property (readwrite, assign, nonatomic) NSInteger uploadQueueSortTypeValue;

@property (readwrite, assign, nonatomic) CGPoint landingPageScrollPositionValue;

@property (readwrite, assign, nonatomic) CGPoint landingPageScrollPositionLandscapeValue;

@property (readwrite, assign, nonatomic) BOOL syncLargeImagesValue;

@property (readwrite, assign, nonatomic) BOOL openCameraOnLaunchValue;

@property (readwrite, assign, nonatomic) BOOL experimentalCameraValue;

@property (readwrite, assign, nonatomic) BOOL experimentalTabBarValue;

@property (readwrite, assign, nonatomic) BOOL photoSetListModeValue;

@property (readwrite, assign, nonatomic) BOOL groupListModeValue;

@property (readwrite, assign, nonatomic) BOOL autoZoomPhotosValue;

@property (readwrite, assign, nonatomic) BOOL autoAllowXXLImagesValue;

@property (readwrite, assign, nonatomic) BOOL didUpgradeUploadQueueValue;
@end

