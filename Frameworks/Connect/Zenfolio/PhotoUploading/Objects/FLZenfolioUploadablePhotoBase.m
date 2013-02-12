//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUploadablePhotoBase.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioUploadablePhotoBase.h"
#import "FLZenfolioUploadGallery.h"
#import "FLZenfolioAccessDescriptor.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioUploadablePhotoBase


@synthesize accessDescriptor = _accessDescriptor;
@synthesize categoryArray = _categoryArray;
@synthesize dimensions = _dimensions;
@synthesize isCameraImage = _isCameraImage;
@synthesize loginName = _loginName;
@synthesize modifiedDate = _modifiedDate;
@synthesize originalFileName = _originalFileName;
@synthesize photoDataFileName = _photoDataFileName;
@synthesize saveToPhoneGalleryOnUpload = _saveToPhoneGalleryOnUpload;
@synthesize sortId = _sortId;
@synthesize takenDate = _takenDate;
@synthesize uploadFileId = _uploadFileId;
@synthesize uploadGallery = _uploadGallery;
@synthesize uploadSize = _uploadSize;
@synthesize uploaded = _uploaded;
@synthesize uploadedPhotoId = _uploadedPhotoId;
@synthesize wasSavedToPhotoGallery = _wasSavedToPhotoGallery;

+ (NSString*) accessDescriptorKey
{
	return @"accessDescriptor";
}

+ (NSString*) categoryArrayKey
{
	return @"categoryArray";
}

+ (NSString*) dimensionsKey
{
	return @"dimensions";
}

+ (NSString*) isCameraImageKey
{
	return @"isCameraImage";
}

+ (NSString*) loginNameKey
{
	return @"loginName";
}

+ (NSString*) modifiedDateKey
{
	return @"modifiedDate";
}

+ (NSString*) originalFileNameKey
{
	return @"originalFileName";
}

+ (NSString*) photoDataFileNameKey
{
	return @"photoDataFileName";
}

+ (NSString*) saveToPhoneGalleryOnUploadKey
{
	return @"saveToPhoneGalleryOnUpload";
}

+ (NSString*) sortIdKey
{
	return @"sortId";
}

+ (NSString*) takenDateKey
{
	return @"takenDate";
}

+ (NSString*) uploadFileIdKey
{
	return @"uploadFileId";
}

+ (NSString*) uploadGalleryKey
{
	return @"uploadGallery";
}

+ (NSString*) uploadSizeKey
{
	return @"uploadSize";
}

+ (NSString*) uploadedKey
{
	return @"uploaded";
}

+ (NSString*) uploadedPhotoIdKey
{
	return @"uploadedPhotoId";
}

+ (NSString*) wasSavedToPhotoGalleryKey
{
	return @"wasSavedToPhotoGallery";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioUploadablePhotoBase*)object).takenDate = FLCopyOrRetainObject(_takenDate);
	((FLZenfolioUploadablePhotoBase*)object).photoDataFileName = FLCopyOrRetainObject(_photoDataFileName);
	((FLZenfolioUploadablePhotoBase*)object).dimensions = FLCopyOrRetainObject(_dimensions);
	((FLZenfolioUploadablePhotoBase*)object).loginName = FLCopyOrRetainObject(_loginName);
	((FLZenfolioUploadablePhotoBase*)object).wasSavedToPhotoGallery = FLCopyOrRetainObject(_wasSavedToPhotoGallery);
	((FLZenfolioUploadablePhotoBase*)object).uploadSize = FLCopyOrRetainObject(_uploadSize);
	((FLZenfolioUploadablePhotoBase*)object).isCameraImage = FLCopyOrRetainObject(_isCameraImage);
	((FLZenfolioUploadablePhotoBase*)object).originalFileName = FLCopyOrRetainObject(_originalFileName);
	((FLZenfolioUploadablePhotoBase*)object).uploadedPhotoId = FLCopyOrRetainObject(_uploadedPhotoId);
	((FLZenfolioUploadablePhotoBase*)object).sortId = FLCopyOrRetainObject(_sortId);
	((FLZenfolioUploadablePhotoBase*)object).saveToPhoneGalleryOnUpload = FLCopyOrRetainObject(_saveToPhoneGalleryOnUpload);
	((FLZenfolioUploadablePhotoBase*)object).uploadFileId = FLCopyOrRetainObject(_uploadFileId);
	((FLZenfolioUploadablePhotoBase*)object).uploaded = FLCopyOrRetainObject(_uploaded);
	((FLZenfolioUploadablePhotoBase*)object).modifiedDate = FLCopyOrRetainObject(_modifiedDate);
	((FLZenfolioUploadablePhotoBase*)object).uploadGallery = FLCopyOrRetainObject(_uploadGallery);
	((FLZenfolioUploadablePhotoBase*)object).categoryArray = FLCopyOrRetainObject(_categoryArray);
	((FLZenfolioUploadablePhotoBase*)object).accessDescriptor = FLCopyOrRetainObject(_accessDescriptor);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoDataFileName);
	FLRelease(_uploadFileId);
	FLRelease(_sortId);
	FLRelease(_uploadGallery);
	FLRelease(_uploadSize);
	FLRelease(_accessDescriptor);
	FLRelease(_saveToPhoneGalleryOnUpload);
	FLRelease(_wasSavedToPhotoGallery);
	FLRelease(_isCameraImage);
	FLRelease(_loginName);
	FLRelease(_originalFileName);
	FLRelease(_categoryArray);
	FLRelease(_uploadedPhotoId);
	FLRelease(_dimensions);
	FLRelease(_uploaded);
	FLRelease(_takenDate);
	FLRelease(_modifiedDate);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoDataFileName) [aCoder encodeObject:_photoDataFileName forKey:@"_photoDataFileName"];
	if(_uploadFileId) [aCoder encodeObject:_uploadFileId forKey:@"_uploadFileId"];
	if(_sortId) [aCoder encodeObject:_sortId forKey:@"_sortId"];
	if(_uploadGallery) [aCoder encodeObject:_uploadGallery forKey:@"_uploadGallery"];
	if(_uploadSize) [aCoder encodeObject:_uploadSize forKey:@"_uploadSize"];
	if(_accessDescriptor) [aCoder encodeObject:_accessDescriptor forKey:@"_accessDescriptor"];
	if(_saveToPhoneGalleryOnUpload) [aCoder encodeObject:_saveToPhoneGalleryOnUpload forKey:@"_saveToPhoneGalleryOnUpload"];
	if(_wasSavedToPhotoGallery) [aCoder encodeObject:_wasSavedToPhotoGallery forKey:@"_wasSavedToPhotoGallery"];
	if(_isCameraImage) [aCoder encodeObject:_isCameraImage forKey:@"_isCameraImage"];
	if(_loginName) [aCoder encodeObject:_loginName forKey:@"_loginName"];
	if(_originalFileName) [aCoder encodeObject:_originalFileName forKey:@"_originalFileName"];
	if(_categoryArray) [aCoder encodeObject:_categoryArray forKey:@"_categoryArray"];
	if(_uploadedPhotoId) [aCoder encodeObject:_uploadedPhotoId forKey:@"_uploadedPhotoId"];
	if(_dimensions) [aCoder encodeObject:_dimensions forKey:@"_dimensions"];
	if(_uploaded) [aCoder encodeObject:_uploaded forKey:@"_uploaded"];
	if(_takenDate) [aCoder encodeObject:_takenDate forKey:@"_takenDate"];
	if(_modifiedDate) [aCoder encodeObject:_modifiedDate forKey:@"_modifiedDate"];
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
		_photoDataFileName = FLRetain([aDecoder decodeObjectForKey:@"_photoDataFileName"]);
		_uploadFileId = FLRetain([aDecoder decodeObjectForKey:@"_uploadFileId"]);
		_sortId = FLRetain([aDecoder decodeObjectForKey:@"_sortId"]);
		_uploadGallery = FLRetain([aDecoder decodeObjectForKey:@"_uploadGallery"]);
		_uploadSize = FLRetain([aDecoder decodeObjectForKey:@"_uploadSize"]);
		_accessDescriptor = FLRetain([aDecoder decodeObjectForKey:@"_accessDescriptor"]);
		_saveToPhoneGalleryOnUpload = FLRetain([aDecoder decodeObjectForKey:@"_saveToPhoneGalleryOnUpload"]);
		_wasSavedToPhotoGallery = FLRetain([aDecoder decodeObjectForKey:@"_wasSavedToPhotoGallery"]);
		_isCameraImage = FLRetain([aDecoder decodeObjectForKey:@"_isCameraImage"]);
		_loginName = FLRetain([aDecoder decodeObjectForKey:@"_loginName"]);
		_originalFileName = FLRetain([aDecoder decodeObjectForKey:@"_originalFileName"]);
		_categoryArray = [[aDecoder decodeObjectForKey:@"_categoryArray"] mutableCopy];
		_uploadedPhotoId = FLRetain([aDecoder decodeObjectForKey:@"_uploadedPhotoId"]);
		_dimensions = FLRetain([aDecoder decodeObjectForKey:@"_dimensions"]);
		_uploaded = FLRetain([aDecoder decodeObjectForKey:@"_uploaded"]);
		_takenDate = FLRetain([aDecoder decodeObjectForKey:@"_takenDate"]);
		_modifiedDate = FLRetain([aDecoder decodeObjectForKey:@"_modifiedDate"]);
	}
	return self;
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoDataFileName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"photoDataFileName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadFileId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"uploadFileId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"sortId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"sortId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadGallery" propertyClass:[FLZenfolioUploadGallery class] propertyType:FLDataTypeObject] forPropertyName:@"uploadGallery"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadSize" propertyClass:[NSNumber class] propertyType:FLDataTypeUnsignedLong] forPropertyName:@"uploadSize"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"accessDescriptor" propertyClass:[FLZenfolioAccessDescriptor class] propertyType:FLDataTypeObject] forPropertyName:@"accessDescriptor"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"saveToPhoneGalleryOnUpload" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"saveToPhoneGalleryOnUpload"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"wasSavedToPhotoGallery" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"wasSavedToPhotoGallery"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"isCameraImage" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"isCameraImage"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"loginName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"loginName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"originalFileName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"originalFileName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"categoryArray" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject] forPropertyName:@"categoryArray"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedPhotoId" propertyClass:[NSNumber class] propertyType:FLDataTypeUnsignedLong] forPropertyName:@"uploadedPhotoId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"dimensions" propertyClass:[NSValue class] propertyType:FLDataTypeSize] forPropertyName:@"dimensions"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploaded" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"uploaded"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"takenDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"takenDate"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"modifiedDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"modifiedDate"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoDataFileName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadFileId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sortId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadGallery" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadSize" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"accessDescriptor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"saveToPhoneGalleryOnUpload" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"wasSavedToPhotoGallery" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"isCameraImage" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"loginName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"originalFileName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"categoryArray" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedPhotoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"dimensions" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploaded" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"takenDate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"modifiedDate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
	});
	return s_table;
}

+ (FLZenfolioUploadablePhotoBase*) uploadablePhotoBase
{
	return FLAutorelease([[FLZenfolioUploadablePhotoBase alloc] init]);
}

@end

@implementation FLZenfolioUploadablePhotoBase (ValueProperties) 

- (int) uploadFileIdValue
{
	return [self.uploadFileId intValue];
}

- (void) setUploadFileIdValue:(int) value
{
	self.uploadFileId = [NSNumber numberWithInt:value];
}

- (int) sortIdValue
{
	return [self.sortId intValue];
}

- (void) setSortIdValue:(int) value
{
	self.sortId = [NSNumber numberWithInt:value];
}

- (NSInteger) uploadSizeValue
{
	return [self.uploadSize integerValue];
}

- (void) setUploadSizeValue:(NSInteger) value
{
	self.uploadSize = [NSNumber numberWithInteger:value];
}

- (BOOL) saveToPhoneGalleryOnUploadValue
{
	return [self.saveToPhoneGalleryOnUpload boolValue];
}

- (void) setSaveToPhoneGalleryOnUploadValue:(BOOL) value
{
	self.saveToPhoneGalleryOnUpload = [NSNumber numberWithBool:value];
}

- (BOOL) wasSavedToPhotoGalleryValue
{
	return [self.wasSavedToPhotoGallery boolValue];
}

- (void) setWasSavedToPhotoGalleryValue:(BOOL) value
{
	self.wasSavedToPhotoGallery = [NSNumber numberWithBool:value];
}

- (BOOL) isCameraImageValue
{
	return [self.isCameraImage boolValue];
}

- (void) setIsCameraImageValue:(BOOL) value
{
	self.isCameraImage = [NSNumber numberWithBool:value];
}

- (unsigned long) uploadedPhotoIdValue
{
	return [self.uploadedPhotoId unsignedLongValue];
}

- (void) setUploadedPhotoIdValue:(unsigned long) value
{
	self.uploadedPhotoId = [NSNumber numberWithUnsignedLong:value];
}

- (CGSize) dimensionsValue
{
	return [self.dimensions CGSizeValue];
}

- (void) setDimensionsValue:(CGSize) value
{
	self.dimensions = [NSValue valueWithCGSize:value];
}

- (BOOL) uploadedValue
{
	return [self.uploaded boolValue];
}

- (void) setUploadedValue:(BOOL) value
{
	self.uploaded = [NSNumber numberWithBool:value];
}
@end

