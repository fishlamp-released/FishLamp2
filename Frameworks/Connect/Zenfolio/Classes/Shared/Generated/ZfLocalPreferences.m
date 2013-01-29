//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLocalPreferences.m
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLocalPreferences.h"
#import "ZFUploadGallery.h"
#import "ZFAccessDescriptor.h"
#import "FLSlideshowOptions.h"
#import "ZFBrowserViewOptions.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFLocalPreferences


@synthesize allowRefreshOnHomePage = _allowRefreshOnHomePage;
@synthesize autoAllowXXLImages = _autoAllowXXLImages;
@synthesize autoRotateImagesInSlideshow = _autoRotateImagesInSlideshow;
@synthesize autoZoomPhotos = _autoZoomPhotos;
@synthesize defaultAccessDescriptor = _defaultAccessDescriptor;
@synthesize defaultBrowserViewOptions = _defaultBrowserViewOptions;
@synthesize defaultSlideshowOptions = _defaultSlideshowOptions;
@synthesize defaultUploadGallery = _defaultUploadGallery;
@synthesize defaultUploadSize = _defaultUploadSize;
@synthesize didUpgradeUploadQueue = _didUpgradeUploadQueue;
@synthesize disableDiskCache = _disableDiskCache;
@synthesize disableHighPerformanceCache = _disableHighPerformanceCache;
@synthesize experimentalCamera = _experimentalCamera;
@synthesize experimentalTabBar = _experimentalTabBar;
@synthesize groupListMode = _groupListMode;
@synthesize landingPageScrollPosition = _landingPageScrollPosition;
@synthesize landingPageScrollPositionLandscape = _landingPageScrollPositionLandscape;
@synthesize lastPhotoID = _lastPhotoID;
@synthesize openCameraOnLaunch = _openCameraOnLaunch;
@synthesize photoSetListMode = _photoSetListMode;
@synthesize saveImagesToPhoneGalleryOnUpload = _saveImagesToPhoneGalleryOnUpload;
@synthesize showFeaturedGalleries = _showFeaturedGalleries;
@synthesize showRecentGalleries = _showRecentGalleries;
@synthesize slideShowLength = _slideShowLength;
@synthesize syncLargeImages = _syncLargeImages;
@synthesize uploadQueueSortType = _uploadQueueSortType;

+ (NSString*) allowRefreshOnHomePageKey
{
	return @"allowRefreshOnHomePage";
}

+ (NSString*) autoAllowXXLImagesKey
{
	return @"autoAllowXXLImages";
}

+ (NSString*) autoRotateImagesInSlideshowKey
{
	return @"autoRotateImagesInSlideshow";
}

+ (NSString*) autoZoomPhotosKey
{
	return @"autoZoomPhotos";
}

+ (NSString*) defaultAccessDescriptorKey
{
	return @"defaultAccessDescriptor";
}

+ (NSString*) defaultBrowserViewOptionsKey
{
	return @"defaultBrowserViewOptions";
}

+ (NSString*) defaultSlideshowOptionsKey
{
	return @"defaultSlideshowOptions";
}

+ (NSString*) defaultUploadGalleryKey
{
	return @"defaultUploadGallery";
}

+ (NSString*) defaultUploadSizeKey
{
	return @"defaultUploadSize";
}

+ (NSString*) didUpgradeUploadQueueKey
{
	return @"didUpgradeUploadQueue";
}

+ (NSString*) disableDiskCacheKey
{
	return @"disableDiskCache";
}

+ (NSString*) disableHighPerformanceCacheKey
{
	return @"disableHighPerformanceCache";
}

+ (NSString*) experimentalCameraKey
{
	return @"experimentalCamera";
}

+ (NSString*) experimentalTabBarKey
{
	return @"experimentalTabBar";
}

+ (NSString*) groupListModeKey
{
	return @"groupListMode";
}

+ (NSString*) landingPageScrollPositionKey
{
	return @"landingPageScrollPosition";
}

+ (NSString*) landingPageScrollPositionLandscapeKey
{
	return @"landingPageScrollPositionLandscape";
}

+ (NSString*) lastPhotoIDKey
{
	return @"lastPhotoID";
}

+ (NSString*) openCameraOnLaunchKey
{
	return @"openCameraOnLaunch";
}

+ (NSString*) photoSetListModeKey
{
	return @"photoSetListMode";
}

+ (NSString*) saveImagesToPhoneGalleryOnUploadKey
{
	return @"saveImagesToPhoneGalleryOnUpload";
}

+ (NSString*) showFeaturedGalleriesKey
{
	return @"showFeaturedGalleries";
}

+ (NSString*) showRecentGalleriesKey
{
	return @"showRecentGalleries";
}

+ (NSString*) slideShowLengthKey
{
	return @"slideShowLength";
}

+ (NSString*) syncLargeImagesKey
{
	return @"syncLargeImages";
}

+ (NSString*) uploadQueueSortTypeKey
{
	return @"uploadQueueSortType";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLocalPreferences*)object).uploadQueueSortType = FLCopyOrRetainObject(_uploadQueueSortType);
	((ZFLocalPreferences*)object).syncLargeImages = FLCopyOrRetainObject(_syncLargeImages);
	((ZFLocalPreferences*)object).defaultAccessDescriptor = FLCopyOrRetainObject(_defaultAccessDescriptor);
	((ZFLocalPreferences*)object).allowRefreshOnHomePage = FLCopyOrRetainObject(_allowRefreshOnHomePage);
	((ZFLocalPreferences*)object).defaultBrowserViewOptions = FLCopyOrRetainObject(_defaultBrowserViewOptions);
	((ZFLocalPreferences*)object).photoSetListMode = FLCopyOrRetainObject(_photoSetListMode);
	((ZFLocalPreferences*)object).defaultSlideshowOptions = FLCopyOrRetainObject(_defaultSlideshowOptions);
	((ZFLocalPreferences*)object).experimentalCamera = FLCopyOrRetainObject(_experimentalCamera);
	((ZFLocalPreferences*)object).disableDiskCache = FLCopyOrRetainObject(_disableDiskCache);
	((ZFLocalPreferences*)object).slideShowLength = FLCopyOrRetainObject(_slideShowLength);
	((ZFLocalPreferences*)object).defaultUploadGallery = FLCopyOrRetainObject(_defaultUploadGallery);
	((ZFLocalPreferences*)object).autoZoomPhotos = FLCopyOrRetainObject(_autoZoomPhotos);
	((ZFLocalPreferences*)object).didUpgradeUploadQueue = FLCopyOrRetainObject(_didUpgradeUploadQueue);
	((ZFLocalPreferences*)object).experimentalTabBar = FLCopyOrRetainObject(_experimentalTabBar);
	((ZFLocalPreferences*)object).landingPageScrollPosition = FLCopyOrRetainObject(_landingPageScrollPosition);
	((ZFLocalPreferences*)object).lastPhotoID = FLCopyOrRetainObject(_lastPhotoID);
	((ZFLocalPreferences*)object).disableHighPerformanceCache = FLCopyOrRetainObject(_disableHighPerformanceCache);
	((ZFLocalPreferences*)object).saveImagesToPhoneGalleryOnUpload = FLCopyOrRetainObject(_saveImagesToPhoneGalleryOnUpload);
	((ZFLocalPreferences*)object).autoAllowXXLImages = FLCopyOrRetainObject(_autoAllowXXLImages);
	((ZFLocalPreferences*)object).autoRotateImagesInSlideshow = FLCopyOrRetainObject(_autoRotateImagesInSlideshow);
	((ZFLocalPreferences*)object).showFeaturedGalleries = FLCopyOrRetainObject(_showFeaturedGalleries);
	((ZFLocalPreferences*)object).showRecentGalleries = FLCopyOrRetainObject(_showRecentGalleries);
	((ZFLocalPreferences*)object).defaultUploadSize = FLCopyOrRetainObject(_defaultUploadSize);
	((ZFLocalPreferences*)object).landingPageScrollPositionLandscape = FLCopyOrRetainObject(_landingPageScrollPositionLandscape);
	((ZFLocalPreferences*)object).groupListMode = FLCopyOrRetainObject(_groupListMode);
	((ZFLocalPreferences*)object).openCameraOnLaunch = FLCopyOrRetainObject(_openCameraOnLaunch);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_defaultUploadGallery);
	FLRelease(_saveImagesToPhoneGalleryOnUpload);
	FLRelease(_slideShowLength);
	FLRelease(_autoRotateImagesInSlideshow);
	FLRelease(_allowRefreshOnHomePage);
	FLRelease(_showFeaturedGalleries);
	FLRelease(_showRecentGalleries);
	FLRelease(_defaultAccessDescriptor);
	FLRelease(_defaultUploadSize);
	FLRelease(_lastPhotoID);
	FLRelease(_disableHighPerformanceCache);
	FLRelease(_disableDiskCache);
	FLRelease(_uploadQueueSortType);
	FLRelease(_landingPageScrollPosition);
	FLRelease(_landingPageScrollPositionLandscape);
	FLRelease(_syncLargeImages);
	FLRelease(_openCameraOnLaunch);
	FLRelease(_experimentalCamera);
	FLRelease(_experimentalTabBar);
	FLRelease(_photoSetListMode);
	FLRelease(_groupListMode);
	FLRelease(_autoZoomPhotos);
	FLRelease(_autoAllowXXLImages);
	FLRelease(_didUpgradeUploadQueue);
	FLRelease(_defaultSlideshowOptions);
	FLRelease(_defaultBrowserViewOptions);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_defaultUploadGallery) [aCoder encodeObject:_defaultUploadGallery forKey:@"_defaultUploadGallery"];
	if(_saveImagesToPhoneGalleryOnUpload) [aCoder encodeObject:_saveImagesToPhoneGalleryOnUpload forKey:@"_saveImagesToPhoneGalleryOnUpload"];
	if(_slideShowLength) [aCoder encodeObject:_slideShowLength forKey:@"_slideShowLength"];
	if(_autoRotateImagesInSlideshow) [aCoder encodeObject:_autoRotateImagesInSlideshow forKey:@"_autoRotateImagesInSlideshow"];
	if(_allowRefreshOnHomePage) [aCoder encodeObject:_allowRefreshOnHomePage forKey:@"_allowRefreshOnHomePage"];
	if(_showFeaturedGalleries) [aCoder encodeObject:_showFeaturedGalleries forKey:@"_showFeaturedGalleries"];
	if(_showRecentGalleries) [aCoder encodeObject:_showRecentGalleries forKey:@"_showRecentGalleries"];
	if(_defaultAccessDescriptor) [aCoder encodeObject:_defaultAccessDescriptor forKey:@"_defaultAccessDescriptor"];
	if(_defaultUploadSize) [aCoder encodeObject:_defaultUploadSize forKey:@"_defaultUploadSize"];
	if(_lastPhotoID) [aCoder encodeObject:_lastPhotoID forKey:@"_lastPhotoID"];
	if(_disableHighPerformanceCache) [aCoder encodeObject:_disableHighPerformanceCache forKey:@"_disableHighPerformanceCache"];
	if(_disableDiskCache) [aCoder encodeObject:_disableDiskCache forKey:@"_disableDiskCache"];
	if(_uploadQueueSortType) [aCoder encodeObject:_uploadQueueSortType forKey:@"_uploadQueueSortType"];
	if(_landingPageScrollPosition) [aCoder encodeObject:_landingPageScrollPosition forKey:@"_landingPageScrollPosition"];
	if(_landingPageScrollPositionLandscape) [aCoder encodeObject:_landingPageScrollPositionLandscape forKey:@"_landingPageScrollPositionLandscape"];
	if(_syncLargeImages) [aCoder encodeObject:_syncLargeImages forKey:@"_syncLargeImages"];
	if(_openCameraOnLaunch) [aCoder encodeObject:_openCameraOnLaunch forKey:@"_openCameraOnLaunch"];
	if(_experimentalCamera) [aCoder encodeObject:_experimentalCamera forKey:@"_experimentalCamera"];
	if(_experimentalTabBar) [aCoder encodeObject:_experimentalTabBar forKey:@"_experimentalTabBar"];
	if(_photoSetListMode) [aCoder encodeObject:_photoSetListMode forKey:@"_photoSetListMode"];
	if(_groupListMode) [aCoder encodeObject:_groupListMode forKey:@"_groupListMode"];
	if(_autoZoomPhotos) [aCoder encodeObject:_autoZoomPhotos forKey:@"_autoZoomPhotos"];
	if(_autoAllowXXLImages) [aCoder encodeObject:_autoAllowXXLImages forKey:@"_autoAllowXXLImages"];
	if(_didUpgradeUploadQueue) [aCoder encodeObject:_didUpgradeUploadQueue forKey:@"_didUpgradeUploadQueue"];
	if(_defaultSlideshowOptions) [aCoder encodeObject:_defaultSlideshowOptions forKey:@"_defaultSlideshowOptions"];
	if(_defaultBrowserViewOptions) [aCoder encodeObject:_defaultBrowserViewOptions forKey:@"_defaultBrowserViewOptions"];
	[super encodeWithCoder:aCoder];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		_defaultUploadGallery = FLRetain([aDecoder decodeObjectForKey:@"_defaultUploadGallery"]);
		_saveImagesToPhoneGalleryOnUpload = FLRetain([aDecoder decodeObjectForKey:@"_saveImagesToPhoneGalleryOnUpload"]);
		_slideShowLength = FLRetain([aDecoder decodeObjectForKey:@"_slideShowLength"]);
		_autoRotateImagesInSlideshow = FLRetain([aDecoder decodeObjectForKey:@"_autoRotateImagesInSlideshow"]);
		_allowRefreshOnHomePage = FLRetain([aDecoder decodeObjectForKey:@"_allowRefreshOnHomePage"]);
		_showFeaturedGalleries = FLRetain([aDecoder decodeObjectForKey:@"_showFeaturedGalleries"]);
		_showRecentGalleries = FLRetain([aDecoder decodeObjectForKey:@"_showRecentGalleries"]);
		_defaultAccessDescriptor = FLRetain([aDecoder decodeObjectForKey:@"_defaultAccessDescriptor"]);
		_defaultUploadSize = FLRetain([aDecoder decodeObjectForKey:@"_defaultUploadSize"]);
		_lastPhotoID = FLRetain([aDecoder decodeObjectForKey:@"_lastPhotoID"]);
		_disableHighPerformanceCache = FLRetain([aDecoder decodeObjectForKey:@"_disableHighPerformanceCache"]);
		_disableDiskCache = FLRetain([aDecoder decodeObjectForKey:@"_disableDiskCache"]);
		_uploadQueueSortType = FLRetain([aDecoder decodeObjectForKey:@"_uploadQueueSortType"]);
		_landingPageScrollPosition = FLRetain([aDecoder decodeObjectForKey:@"_landingPageScrollPosition"]);
		_landingPageScrollPositionLandscape = FLRetain([aDecoder decodeObjectForKey:@"_landingPageScrollPositionLandscape"]);
		_syncLargeImages = FLRetain([aDecoder decodeObjectForKey:@"_syncLargeImages"]);
		_openCameraOnLaunch = FLRetain([aDecoder decodeObjectForKey:@"_openCameraOnLaunch"]);
		_experimentalCamera = FLRetain([aDecoder decodeObjectForKey:@"_experimentalCamera"]);
		_experimentalTabBar = FLRetain([aDecoder decodeObjectForKey:@"_experimentalTabBar"]);
		_photoSetListMode = FLRetain([aDecoder decodeObjectForKey:@"_photoSetListMode"]);
		_groupListMode = FLRetain([aDecoder decodeObjectForKey:@"_groupListMode"]);
		_autoZoomPhotos = FLRetain([aDecoder decodeObjectForKey:@"_autoZoomPhotos"]);
		_autoAllowXXLImages = FLRetain([aDecoder decodeObjectForKey:@"_autoAllowXXLImages"]);
		_didUpgradeUploadQueue = FLRetain([aDecoder decodeObjectForKey:@"_didUpgradeUploadQueue"]);
		_defaultSlideshowOptions = FLRetain([aDecoder decodeObjectForKey:@"_defaultSlideshowOptions"]);
		_defaultBrowserViewOptions = FLRetain([aDecoder decodeObjectForKey:@"_defaultBrowserViewOptions"]);
	}
	return self;
}

+ (ZFLocalPreferences*) localPreferences
{
	return FLAutorelease([[ZFLocalPreferences alloc] init]);
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"defaultUploadGallery" propertyClass:[ZFUploadGallery class] propertyType:FLDataTypeObject] forPropertyName:@"defaultUploadGallery"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"saveImagesToPhoneGalleryOnUpload" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"saveImagesToPhoneGalleryOnUpload"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"slideShowLength" propertyClass:[NSNumber class] propertyType:FLDataTypeFloat] forPropertyName:@"slideShowLength"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoRotateImagesInSlideshow" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoRotateImagesInSlideshow"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"allowRefreshOnHomePage" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"allowRefreshOnHomePage"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"showFeaturedGalleries" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"showFeaturedGalleries"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"showRecentGalleries" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"showRecentGalleries"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"defaultAccessDescriptor" propertyClass:[ZFAccessDescriptor class] propertyType:FLDataTypeObject] forPropertyName:@"defaultAccessDescriptor"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"defaultUploadSize" propertyClass:[NSNumber class] propertyType:FLDataTypeNSInteger] forPropertyName:@"defaultUploadSize"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"lastPhotoID" propertyClass:[NSNumber class] propertyType:FLDataTypeNSInteger] forPropertyName:@"lastPhotoID"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"disableHighPerformanceCache" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"disableHighPerformanceCache"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"disableDiskCache" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"disableDiskCache"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadQueueSortType" propertyClass:[NSNumber class] propertyType:FLDataTypeNSInteger] forPropertyName:@"uploadQueueSortType"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"landingPageScrollPosition" propertyClass:[NSValue class] propertyType:FLDataTypePoint] forPropertyName:@"landingPageScrollPosition"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"landingPageScrollPositionLandscape" propertyClass:[NSValue class] propertyType:FLDataTypePoint] forPropertyName:@"landingPageScrollPositionLandscape"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"syncLargeImages" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"syncLargeImages"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"openCameraOnLaunch" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"openCameraOnLaunch"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"experimentalCamera" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"experimentalCamera"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"experimentalTabBar" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"experimentalTabBar"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoSetListMode" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"photoSetListMode"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"groupListMode" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"groupListMode"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoZoomPhotos" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoZoomPhotos"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoAllowXXLImages" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoAllowXXLImages"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"didUpgradeUploadQueue" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"didUpgradeUploadQueue"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"defaultSlideshowOptions" propertyClass:[FLSlideshowOptions class] propertyType:FLDataTypeObject] forPropertyName:@"defaultSlideshowOptions"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"defaultBrowserViewOptions" propertyClass:[ZFBrowserViewOptions class] propertyType:FLDataTypeObject] forPropertyName:@"defaultBrowserViewOptions"];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"defaultUploadGallery" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"saveImagesToPhoneGalleryOnUpload" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"slideShowLength" columnType:FLDatabaseTypeFloat columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoRotateImagesInSlideshow" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"allowRefreshOnHomePage" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showFeaturedGalleries" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showRecentGalleries" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"defaultAccessDescriptor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"defaultUploadSize" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastPhotoID" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"disableHighPerformanceCache" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"disableDiskCache" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadQueueSortType" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"landingPageScrollPosition" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"landingPageScrollPositionLandscape" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"syncLargeImages" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"openCameraOnLaunch" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"experimentalCamera" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"experimentalTabBar" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetListMode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"groupListMode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoZoomPhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoAllowXXLImages" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"didUpgradeUploadQueue" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"defaultSlideshowOptions" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"defaultBrowserViewOptions" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLocalPreferences (ValueProperties) 

- (BOOL) saveImagesToPhoneGalleryOnUploadValue
{
	return [self.saveImagesToPhoneGalleryOnUpload boolValue];
}

- (void) setSaveImagesToPhoneGalleryOnUploadValue:(BOOL) value
{
	self.saveImagesToPhoneGalleryOnUpload = [NSNumber numberWithBool:value];
}

- (float) slideShowLengthValue
{
	return [self.slideShowLength floatValue];
}

- (void) setSlideShowLengthValue:(float) value
{
	self.slideShowLength = [NSNumber numberWithFloat:value];
}

- (BOOL) autoRotateImagesInSlideshowValue
{
	return [self.autoRotateImagesInSlideshow boolValue];
}

- (void) setAutoRotateImagesInSlideshowValue:(BOOL) value
{
	self.autoRotateImagesInSlideshow = [NSNumber numberWithBool:value];
}

- (BOOL) allowRefreshOnHomePageValue
{
	return [self.allowRefreshOnHomePage boolValue];
}

- (void) setAllowRefreshOnHomePageValue:(BOOL) value
{
	self.allowRefreshOnHomePage = [NSNumber numberWithBool:value];
}

- (BOOL) showFeaturedGalleriesValue
{
	return [self.showFeaturedGalleries boolValue];
}

- (void) setShowFeaturedGalleriesValue:(BOOL) value
{
	self.showFeaturedGalleries = [NSNumber numberWithBool:value];
}

- (BOOL) showRecentGalleriesValue
{
	return [self.showRecentGalleries boolValue];
}

- (void) setShowRecentGalleriesValue:(BOOL) value
{
	self.showRecentGalleries = [NSNumber numberWithBool:value];
}

- (NSInteger) defaultUploadSizeValue
{
	return [self.defaultUploadSize integerValue];
}

- (void) setDefaultUploadSizeValue:(NSInteger) value
{
	self.defaultUploadSize = [NSNumber numberWithInteger:value];
}

- (NSInteger) lastPhotoIDValue
{
	return [self.lastPhotoID integerValue];
}

- (void) setLastPhotoIDValue:(NSInteger) value
{
	self.lastPhotoID = [NSNumber numberWithInteger:value];
}

- (BOOL) disableHighPerformanceCacheValue
{
	return [self.disableHighPerformanceCache boolValue];
}

- (void) setDisableHighPerformanceCacheValue:(BOOL) value
{
	self.disableHighPerformanceCache = [NSNumber numberWithBool:value];
}

- (BOOL) disableDiskCacheValue
{
	return [self.disableDiskCache boolValue];
}

- (void) setDisableDiskCacheValue:(BOOL) value
{
	self.disableDiskCache = [NSNumber numberWithBool:value];
}

- (NSInteger) uploadQueueSortTypeValue
{
	return [self.uploadQueueSortType integerValue];
}

- (void) setUploadQueueSortTypeValue:(NSInteger) value
{
	self.uploadQueueSortType = [NSNumber numberWithInteger:value];
}

- (CGPoint) landingPageScrollPositionValue
{
	return [self.landingPageScrollPosition CGPointValue];
}

- (void) setLandingPageScrollPositionValue:(CGPoint) value
{
	self.landingPageScrollPosition = [NSValue valueWithCGPoint:value];
}

- (CGPoint) landingPageScrollPositionLandscapeValue
{
	return [self.landingPageScrollPositionLandscape CGPointValue];
}

- (void) setLandingPageScrollPositionLandscapeValue:(CGPoint) value
{
	self.landingPageScrollPositionLandscape = [NSValue valueWithCGPoint:value];
}

- (BOOL) syncLargeImagesValue
{
	return [self.syncLargeImages boolValue];
}

- (void) setSyncLargeImagesValue:(BOOL) value
{
	self.syncLargeImages = [NSNumber numberWithBool:value];
}

- (BOOL) openCameraOnLaunchValue
{
	return [self.openCameraOnLaunch boolValue];
}

- (void) setOpenCameraOnLaunchValue:(BOOL) value
{
	self.openCameraOnLaunch = [NSNumber numberWithBool:value];
}

- (BOOL) experimentalCameraValue
{
	return [self.experimentalCamera boolValue];
}

- (void) setExperimentalCameraValue:(BOOL) value
{
	self.experimentalCamera = [NSNumber numberWithBool:value];
}

- (BOOL) experimentalTabBarValue
{
	return [self.experimentalTabBar boolValue];
}

- (void) setExperimentalTabBarValue:(BOOL) value
{
	self.experimentalTabBar = [NSNumber numberWithBool:value];
}

- (BOOL) photoSetListModeValue
{
	return [self.photoSetListMode boolValue];
}

- (void) setPhotoSetListModeValue:(BOOL) value
{
	self.photoSetListMode = [NSNumber numberWithBool:value];
}

- (BOOL) groupListModeValue
{
	return [self.groupListMode boolValue];
}

- (void) setGroupListModeValue:(BOOL) value
{
	self.groupListMode = [NSNumber numberWithBool:value];
}

- (BOOL) autoZoomPhotosValue
{
	return [self.autoZoomPhotos boolValue];
}

- (void) setAutoZoomPhotosValue:(BOOL) value
{
	self.autoZoomPhotos = [NSNumber numberWithBool:value];
}

- (BOOL) autoAllowXXLImagesValue
{
	return [self.autoAllowXXLImages boolValue];
}

- (void) setAutoAllowXXLImagesValue:(BOOL) value
{
	self.autoAllowXXLImages = [NSNumber numberWithBool:value];
}

- (BOOL) didUpgradeUploadQueueValue
{
	return [self.didUpgradeUploadQueue boolValue];
}

- (void) setDidUpgradeUploadQueueValue:(BOOL) value
{
	self.didUpgradeUploadQueue = [NSNumber numberWithBool:value];
}
@end

