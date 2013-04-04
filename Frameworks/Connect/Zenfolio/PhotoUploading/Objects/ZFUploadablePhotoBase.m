//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUploadablePhotoBase.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUploadablePhotoBase.h"
#import "ZFUploadGallery.h"
#import "ZFAccessDescriptor.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUploadablePhotoBase


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
	((ZFUploadablePhotoBase*)object).takenDate = FLCopyOrRetainObject(_takenDate);
	((ZFUploadablePhotoBase*)object).photoDataFileName = FLCopyOrRetainObject(_photoDataFileName);
	((ZFUploadablePhotoBase*)object).dimensions = FLCopyOrRetainObject(_dimensions);
	((ZFUploadablePhotoBase*)object).loginName = FLCopyOrRetainObject(_loginName);
	((ZFUploadablePhotoBase*)object).wasSavedToPhotoGallery = FLCopyOrRetainObject(_wasSavedToPhotoGallery);
	((ZFUploadablePhotoBase*)object).uploadSize = FLCopyOrRetainObject(_uploadSize);
	((ZFUploadablePhotoBase*)object).isCameraImage = FLCopyOrRetainObject(_isCameraImage);
	((ZFUploadablePhotoBase*)object).originalFileName = FLCopyOrRetainObject(_originalFileName);
	((ZFUploadablePhotoBase*)object).uploadedPhotoId = FLCopyOrRetainObject(_uploadedPhotoId);
	((ZFUploadablePhotoBase*)object).sortId = FLCopyOrRetainObject(_sortId);
	((ZFUploadablePhotoBase*)object).saveToPhoneGalleryOnUpload = FLCopyOrRetainObject(_saveToPhoneGalleryOnUpload);
	((ZFUploadablePhotoBase*)object).uploadFileId = FLCopyOrRetainObject(_uploadFileId);
	((ZFUploadablePhotoBase*)object).uploaded = FLCopyOrRetainObject(_uploaded);
	((ZFUploadablePhotoBase*)object).modifiedDate = FLCopyOrRetainObject(_modifiedDate);
	((ZFUploadablePhotoBase*)object).uploadGallery = FLCopyOrRetainObject(_uploadGallery);
	((ZFUploadablePhotoBase*)object).categoryArray = FLCopyOrRetainObject(_categoryArray);
	((ZFUploadablePhotoBase*)object).accessDescriptor = FLCopyOrRetainObject(_accessDescriptor);
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

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addChildDescriberWithName:@"photoDataFileName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"uploadFileId" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"sortId" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"uploadGallery" withClass:[ZFUploadGallery class]];
		[s_describer addChildDescriberWithName:@"uploadSize" withClass:[FLUnsignedLongNumber class] ];
		[s_describer addChildDescriberWithName:@"accessDescriptor" withClass:[ZFAccessDescriptor class]];
		[s_describer addChildDescriberWithName:@"saveToPhoneGalleryOnUpload" withClass:[FLBoolNumber class] ];
		[s_describer addChildDescriberWithName:@"wasSavedToPhotoGallery" withClass:[FLBoolNumber class] ];
		[s_describer addChildDescriberWithName:@"isCameraImage" withClass:[FLBoolNumber class] ];
		[s_describer addChildDescriberWithName:@"loginName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"originalFileName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"categoryArray" withClass:[NSMutableArray class]];
		[s_describer addChildDescriberWithName:@"uploadedPhotoId" withClass:[FLUnsignedLongNumber class] ];
		[s_describer addChildDescriberWithName:@"dimensions" withClass:[FLGeometrySize class] ];
		[s_describer addChildDescriberWithName:@"uploaded" withClass:[FLBoolNumber class] ];
		[s_describer addChildDescriberWithName:@"takenDate" withClass:[NSDate class]];
		[s_describer addChildDescriberWithName:@"modifiedDate" withClass:[NSDate class]];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
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

+ (ZFUploadablePhotoBase*) uploadablePhotoBase
{
	return FLAutorelease([[ZFUploadablePhotoBase alloc] init]);
}

@end

@implementation ZFUploadablePhotoBase (ValueProperties) 

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

