//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPreferences.m
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFPreferences.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFPreferences


@synthesize allowRefreshOnHomePage = _allowRefreshOnHomePage;
@synthesize autoAddNewPhotos = _autoAddNewPhotos;
@synthesize autoAddStartDate = _autoAddStartDate;
@synthesize autoUploadPhotos = _autoUploadPhotos;
@synthesize autoZoomPhotos = _autoZoomPhotos;
@synthesize defaultUploadSize = _defaultUploadSize;
@synthesize didCheckScrapbookPrivilege = _didCheckScrapbookPrivilege;
@synthesize didUpgradeCache = _didUpgradeCache;
@synthesize didUpgradeUploadQueue = _didUpgradeUploadQueue;
@synthesize geoTagPhotosByDefault = _geoTagPhotosByDefault;
@synthesize hasScrapbookPrivilege = _hasScrapbookPrivilege;
@synthesize landingPageScrollPosition = _landingPageScrollPosition;
@synthesize landingPageScrollPositionLandscape = _landingPageScrollPositionLandscape;
@synthesize openCameraOnLaunch = _openCameraOnLaunch;
@synthesize saveImagesToPhoneGalleryOnUpload = _saveImagesToPhoneGalleryOnUpload;
@synthesize syncLargeImages = _syncLargeImages;

+ (NSString*) allowRefreshOnHomePageKey
{
	return @"allowRefreshOnHomePage";
}

+ (NSString*) autoAddNewPhotosKey
{
	return @"autoAddNewPhotos";
}

+ (NSString*) autoAddStartDateKey
{
	return @"autoAddStartDate";
}

+ (NSString*) autoUploadPhotosKey
{
	return @"autoUploadPhotos";
}

+ (NSString*) autoZoomPhotosKey
{
	return @"autoZoomPhotos";
}

+ (NSString*) defaultUploadSizeKey
{
	return @"defaultUploadSize";
}

+ (NSString*) didCheckScrapbookPrivilegeKey
{
	return @"didCheckScrapbookPrivilege";
}

+ (NSString*) didUpgradeCacheKey
{
	return @"didUpgradeCache";
}

+ (NSString*) didUpgradeUploadQueueKey
{
	return @"didUpgradeUploadQueue";
}

+ (NSString*) geoTagPhotosByDefaultKey
{
	return @"geoTagPhotosByDefault";
}

+ (NSString*) hasScrapbookPrivilegeKey
{
	return @"hasScrapbookPrivilege";
}

+ (NSString*) landingPageScrollPositionKey
{
	return @"landingPageScrollPosition";
}

+ (NSString*) landingPageScrollPositionLandscapeKey
{
	return @"landingPageScrollPositionLandscape";
}

+ (NSString*) openCameraOnLaunchKey
{
	return @"openCameraOnLaunch";
}

+ (NSString*) saveImagesToPhoneGalleryOnUploadKey
{
	return @"saveImagesToPhoneGalleryOnUpload";
}

+ (NSString*) syncLargeImagesKey
{
	return @"syncLargeImages";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFPreferences*)object).landingPageScrollPosition = FLCopyOrRetainObject(_landingPageScrollPosition);
	((ZFPreferences*)object).didUpgradeCache = FLCopyOrRetainObject(_didUpgradeCache);
	((ZFPreferences*)object).autoAddNewPhotos = FLCopyOrRetainObject(_autoAddNewPhotos);
	((ZFPreferences*)object).autoZoomPhotos = FLCopyOrRetainObject(_autoZoomPhotos);
	((ZFPreferences*)object).openCameraOnLaunch = FLCopyOrRetainObject(_openCameraOnLaunch);
	((ZFPreferences*)object).hasScrapbookPrivilege = FLCopyOrRetainObject(_hasScrapbookPrivilege);
	((ZFPreferences*)object).syncLargeImages = FLCopyOrRetainObject(_syncLargeImages);
	((ZFPreferences*)object).autoUploadPhotos = FLCopyOrRetainObject(_autoUploadPhotos);
	((ZFPreferences*)object).didCheckScrapbookPrivilege = FLCopyOrRetainObject(_didCheckScrapbookPrivilege);
	((ZFPreferences*)object).didUpgradeUploadQueue = FLCopyOrRetainObject(_didUpgradeUploadQueue);
	((ZFPreferences*)object).defaultUploadSize = FLCopyOrRetainObject(_defaultUploadSize);
	((ZFPreferences*)object).saveImagesToPhoneGalleryOnUpload = FLCopyOrRetainObject(_saveImagesToPhoneGalleryOnUpload);
	((ZFPreferences*)object).landingPageScrollPositionLandscape = FLCopyOrRetainObject(_landingPageScrollPositionLandscape);
	((ZFPreferences*)object).autoAddStartDate = FLCopyOrRetainObject(_autoAddStartDate);
	((ZFPreferences*)object).geoTagPhotosByDefault = FLCopyOrRetainObject(_geoTagPhotosByDefault);
	((ZFPreferences*)object).allowRefreshOnHomePage = FLCopyOrRetainObject(_allowRefreshOnHomePage);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_saveImagesToPhoneGalleryOnUpload);
	FLRelease(_allowRefreshOnHomePage);
	FLRelease(_defaultUploadSize);
	FLRelease(_landingPageScrollPosition);
	FLRelease(_landingPageScrollPositionLandscape);
	FLRelease(_syncLargeImages);
	FLRelease(_openCameraOnLaunch);
	FLRelease(_autoZoomPhotos);
	FLRelease(_didUpgradeUploadQueue);
	FLRelease(_autoUploadPhotos);
	FLRelease(_autoAddNewPhotos);
	FLRelease(_autoAddStartDate);
	FLRelease(_didCheckScrapbookPrivilege);
	FLRelease(_hasScrapbookPrivilege);
	FLRelease(_geoTagPhotosByDefault);
	FLRelease(_didUpgradeCache);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_saveImagesToPhoneGalleryOnUpload) [aCoder encodeObject:_saveImagesToPhoneGalleryOnUpload forKey:@"_saveImagesToPhoneGalleryOnUpload"];
	if(_allowRefreshOnHomePage) [aCoder encodeObject:_allowRefreshOnHomePage forKey:@"_allowRefreshOnHomePage"];
	if(_defaultUploadSize) [aCoder encodeObject:_defaultUploadSize forKey:@"_defaultUploadSize"];
	if(_landingPageScrollPosition) [aCoder encodeObject:_landingPageScrollPosition forKey:@"_landingPageScrollPosition"];
	if(_landingPageScrollPositionLandscape) [aCoder encodeObject:_landingPageScrollPositionLandscape forKey:@"_landingPageScrollPositionLandscape"];
	if(_syncLargeImages) [aCoder encodeObject:_syncLargeImages forKey:@"_syncLargeImages"];
	if(_openCameraOnLaunch) [aCoder encodeObject:_openCameraOnLaunch forKey:@"_openCameraOnLaunch"];
	if(_autoZoomPhotos) [aCoder encodeObject:_autoZoomPhotos forKey:@"_autoZoomPhotos"];
	if(_didUpgradeUploadQueue) [aCoder encodeObject:_didUpgradeUploadQueue forKey:@"_didUpgradeUploadQueue"];
	if(_autoUploadPhotos) [aCoder encodeObject:_autoUploadPhotos forKey:@"_autoUploadPhotos"];
	if(_autoAddNewPhotos) [aCoder encodeObject:_autoAddNewPhotos forKey:@"_autoAddNewPhotos"];
	if(_autoAddStartDate) [aCoder encodeObject:_autoAddStartDate forKey:@"_autoAddStartDate"];
	if(_didCheckScrapbookPrivilege) [aCoder encodeObject:_didCheckScrapbookPrivilege forKey:@"_didCheckScrapbookPrivilege"];
	if(_hasScrapbookPrivilege) [aCoder encodeObject:_hasScrapbookPrivilege forKey:@"_hasScrapbookPrivilege"];
	if(_geoTagPhotosByDefault) [aCoder encodeObject:_geoTagPhotosByDefault forKey:@"_geoTagPhotosByDefault"];
	if(_didUpgradeCache) [aCoder encodeObject:_didUpgradeCache forKey:@"_didUpgradeCache"];
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
		_saveImagesToPhoneGalleryOnUpload = FLRetain([aDecoder decodeObjectForKey:@"_saveImagesToPhoneGalleryOnUpload"]);
		_allowRefreshOnHomePage = FLRetain([aDecoder decodeObjectForKey:@"_allowRefreshOnHomePage"]);
		_defaultUploadSize = FLRetain([aDecoder decodeObjectForKey:@"_defaultUploadSize"]);
		_landingPageScrollPosition = FLRetain([aDecoder decodeObjectForKey:@"_landingPageScrollPosition"]);
		_landingPageScrollPositionLandscape = FLRetain([aDecoder decodeObjectForKey:@"_landingPageScrollPositionLandscape"]);
		_syncLargeImages = FLRetain([aDecoder decodeObjectForKey:@"_syncLargeImages"]);
		_openCameraOnLaunch = FLRetain([aDecoder decodeObjectForKey:@"_openCameraOnLaunch"]);
		_autoZoomPhotos = FLRetain([aDecoder decodeObjectForKey:@"_autoZoomPhotos"]);
		_didUpgradeUploadQueue = FLRetain([aDecoder decodeObjectForKey:@"_didUpgradeUploadQueue"]);
		_autoUploadPhotos = FLRetain([aDecoder decodeObjectForKey:@"_autoUploadPhotos"]);
		_autoAddNewPhotos = FLRetain([aDecoder decodeObjectForKey:@"_autoAddNewPhotos"]);
		_autoAddStartDate = FLRetain([aDecoder decodeObjectForKey:@"_autoAddStartDate"]);
		_didCheckScrapbookPrivilege = FLRetain([aDecoder decodeObjectForKey:@"_didCheckScrapbookPrivilege"]);
		_hasScrapbookPrivilege = FLRetain([aDecoder decodeObjectForKey:@"_hasScrapbookPrivilege"]);
		_geoTagPhotosByDefault = FLRetain([aDecoder decodeObjectForKey:@"_geoTagPhotosByDefault"]);
		_didUpgradeCache = FLRetain([aDecoder decodeObjectForKey:@"_didUpgradeCache"]);
	}
	return self;
}

+ (ZFPreferences*) preferences
{
	return FLAutorelease([[ZFPreferences alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"saveImagesToPhoneGalleryOnUpload" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"saveImagesToPhoneGalleryOnUpload"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"allowRefreshOnHomePage" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"allowRefreshOnHomePage"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"defaultUploadSize" propertyClass:[NSNumber class] propertyType:FLDataTypeNSInteger] forPropertyName:@"defaultUploadSize"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"landingPageScrollPosition" propertyClass:[NSValue class] propertyType:FLDataTypePoint] forPropertyName:@"landingPageScrollPosition"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"landingPageScrollPositionLandscape" propertyClass:[NSValue class] propertyType:FLDataTypePoint] forPropertyName:@"landingPageScrollPositionLandscape"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"syncLargeImages" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"syncLargeImages"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"openCameraOnLaunch" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"openCameraOnLaunch"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoZoomPhotos" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoZoomPhotos"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"didUpgradeUploadQueue" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"didUpgradeUploadQueue"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoUploadPhotos" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoUploadPhotos"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoAddNewPhotos" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoAddNewPhotos"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoAddStartDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"autoAddStartDate"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"didCheckScrapbookPrivilege" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"didCheckScrapbookPrivilege"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"hasScrapbookPrivilege" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"hasScrapbookPrivilege"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"geoTagPhotosByDefault" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"geoTagPhotosByDefault"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"didUpgradeCache" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"didUpgradeCache"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"saveImagesToPhoneGalleryOnUpload" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"allowRefreshOnHomePage" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"defaultUploadSize" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"landingPageScrollPosition" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"landingPageScrollPositionLandscape" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"syncLargeImages" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"openCameraOnLaunch" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoZoomPhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"didUpgradeUploadQueue" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoUploadPhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoAddNewPhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoAddStartDate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"didCheckScrapbookPrivilege" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"hasScrapbookPrivilege" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"geoTagPhotosByDefault" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"didUpgradeCache" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFPreferences (ValueProperties) 

- (BOOL) saveImagesToPhoneGalleryOnUploadValue
{
	return [self.saveImagesToPhoneGalleryOnUpload boolValue];
}

- (void) setSaveImagesToPhoneGalleryOnUploadValue:(BOOL) value
{
	self.saveImagesToPhoneGalleryOnUpload = [NSNumber numberWithBool:value];
}

- (BOOL) allowRefreshOnHomePageValue
{
	return [self.allowRefreshOnHomePage boolValue];
}

- (void) setAllowRefreshOnHomePageValue:(BOOL) value
{
	self.allowRefreshOnHomePage = [NSNumber numberWithBool:value];
}

- (NSInteger) defaultUploadSizeValue
{
	return [self.defaultUploadSize integerValue];
}

- (void) setDefaultUploadSizeValue:(NSInteger) value
{
	self.defaultUploadSize = [NSNumber numberWithInteger:value];
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

- (BOOL) autoZoomPhotosValue
{
	return [self.autoZoomPhotos boolValue];
}

- (void) setAutoZoomPhotosValue:(BOOL) value
{
	self.autoZoomPhotos = [NSNumber numberWithBool:value];
}

- (BOOL) didUpgradeUploadQueueValue
{
	return [self.didUpgradeUploadQueue boolValue];
}

- (void) setDidUpgradeUploadQueueValue:(BOOL) value
{
	self.didUpgradeUploadQueue = [NSNumber numberWithBool:value];
}

- (BOOL) autoUploadPhotosValue
{
	return [self.autoUploadPhotos boolValue];
}

- (void) setAutoUploadPhotosValue:(BOOL) value
{
	self.autoUploadPhotos = [NSNumber numberWithBool:value];
}

- (BOOL) autoAddNewPhotosValue
{
	return [self.autoAddNewPhotos boolValue];
}

- (void) setAutoAddNewPhotosValue:(BOOL) value
{
	self.autoAddNewPhotos = [NSNumber numberWithBool:value];
}

- (BOOL) didCheckScrapbookPrivilegeValue
{
	return [self.didCheckScrapbookPrivilege boolValue];
}

- (void) setDidCheckScrapbookPrivilegeValue:(BOOL) value
{
	self.didCheckScrapbookPrivilege = [NSNumber numberWithBool:value];
}

- (BOOL) hasScrapbookPrivilegeValue
{
	return [self.hasScrapbookPrivilege boolValue];
}

- (void) setHasScrapbookPrivilegeValue:(BOOL) value
{
	self.hasScrapbookPrivilege = [NSNumber numberWithBool:value];
}

- (BOOL) geoTagPhotosByDefaultValue
{
	return [self.geoTagPhotosByDefault boolValue];
}

- (void) setGeoTagPhotosByDefaultValue:(BOOL) value
{
	self.geoTagPhotosByDefault = [NSNumber numberWithBool:value];
}

- (BOOL) didUpgradeCacheValue
{
	return [self.didUpgradeCache boolValue];
}

- (void) setDidUpgradeCacheValue:(BOOL) value
{
	self.didUpgradeCache = [NSNumber numberWithBool:value];
}
@end

