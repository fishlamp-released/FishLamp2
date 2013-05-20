//	This file was generated at 10/11/11 11:00 AM by PackMule. DO NOT MODIFY!!
//
//	GtQueuedAsset.m
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtQueuedAsset.h"
#import "GtAsset.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtQueuedAsset


@synthesize assetDescription = m_assetDescription;
@synthesize assetFileName = m_assetFileName;
@synthesize assetName = m_assetName;
@synthesize assetObject = m_assetObject;
@synthesize assetSize = m_assetSize;
@synthesize assetState = m_assetState;
@synthesize assetType = m_assetType;
@synthesize assetUID = m_assetUID;
@synthesize assetURL = m_assetURL;
@synthesize copyright = m_copyright;
@synthesize createdDate = m_createdDate;
@synthesize keywords = m_keywords;
@synthesize modifiedDate = m_modifiedDate;
@synthesize positionInQueue = m_positionInQueue;
@synthesize queueUID = m_queueUID;
@synthesize queuedDate = m_queuedDate;
@synthesize uploadDestinationId = m_uploadDestinationId;
@synthesize uploadDestinationName = m_uploadDestinationName;
@synthesize uploadDestinationURL = m_uploadDestinationURL;
@synthesize uploadedAssetId = m_uploadedAssetId;
@synthesize uploadedAssetURL = m_uploadedAssetURL;

+ (NSString*) assetDescriptionKey
{
	return @"assetDescription";
}

+ (NSString*) assetFileNameKey
{
	return @"assetFileName";
}

+ (NSString*) assetNameKey
{
	return @"assetName";
}

+ (NSString*) assetObjectKey
{
	return @"assetObject";
}

+ (NSString*) assetSizeKey
{
	return @"assetSize";
}

+ (NSString*) assetStateKey
{
	return @"assetState";
}

+ (NSString*) assetTypeKey
{
	return @"assetType";
}

+ (NSString*) assetUIDKey
{
	return @"assetUID";
}

+ (NSString*) assetURLKey
{
	return @"assetURL";
}

+ (NSString*) copyrightKey
{
	return @"copyright";
}

+ (NSString*) createdDateKey
{
	return @"createdDate";
}

+ (NSString*) keywordsKey
{
	return @"keywords";
}

+ (NSString*) modifiedDateKey
{
	return @"modifiedDate";
}

+ (NSString*) positionInQueueKey
{
	return @"positionInQueue";
}

+ (NSString*) queueUIDKey
{
	return @"queueUID";
}

+ (NSString*) queuedDateKey
{
	return @"queuedDate";
}

+ (NSString*) uploadDestinationIdKey
{
	return @"uploadDestinationId";
}

+ (NSString*) uploadDestinationNameKey
{
	return @"uploadDestinationName";
}

+ (NSString*) uploadDestinationURLKey
{
	return @"uploadDestinationURL";
}

+ (NSString*) uploadedAssetIdKey
{
	return @"uploadedAssetId";
}

+ (NSString*) uploadedAssetURLKey
{
	return @"uploadedAssetURL";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtQueuedAsset*)object).assetObject = GtCopyOrRetainObject(m_assetObject);
	((GtQueuedAsset*)object).queueUID = GtCopyOrRetainObject(m_queueUID);
	((GtQueuedAsset*)object).assetState = GtCopyOrRetainObject(m_assetState);
	((GtQueuedAsset*)object).assetFileName = GtCopyOrRetainObject(m_assetFileName);
	((GtQueuedAsset*)object).positionInQueue = GtCopyOrRetainObject(m_positionInQueue);
	((GtQueuedAsset*)object).uploadDestinationId = GtCopyOrRetainObject(m_uploadDestinationId);
	((GtQueuedAsset*)object).uploadDestinationName = GtCopyOrRetainObject(m_uploadDestinationName);
	((GtQueuedAsset*)object).keywords = GtCopyOrRetainObject(m_keywords);
	((GtQueuedAsset*)object).assetType = GtCopyOrRetainObject(m_assetType);
	((GtQueuedAsset*)object).uploadedAssetId = GtCopyOrRetainObject(m_uploadedAssetId);
	((GtQueuedAsset*)object).assetSize = GtCopyOrRetainObject(m_assetSize);
	((GtQueuedAsset*)object).modifiedDate = GtCopyOrRetainObject(m_modifiedDate);
	((GtQueuedAsset*)object).queuedDate = GtCopyOrRetainObject(m_queuedDate);
	((GtQueuedAsset*)object).assetDescription = GtCopyOrRetainObject(m_assetDescription);
	((GtQueuedAsset*)object).assetURL = GtCopyOrRetainObject(m_assetURL);
	((GtQueuedAsset*)object).createdDate = GtCopyOrRetainObject(m_createdDate);
	((GtQueuedAsset*)object).uploadedAssetURL = GtCopyOrRetainObject(m_uploadedAssetURL);
	((GtQueuedAsset*)object).assetName = GtCopyOrRetainObject(m_assetName);
	((GtQueuedAsset*)object).uploadDestinationURL = GtCopyOrRetainObject(m_uploadDestinationURL);
	((GtQueuedAsset*)object).copyright = GtCopyOrRetainObject(m_copyright);
	((GtQueuedAsset*)object).assetUID = GtCopyOrRetainObject(m_assetUID);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_queueUID);
	GtRelease(m_assetUID);
	GtRelease(m_assetURL);
	GtRelease(m_assetType);
	GtRelease(m_positionInQueue);
	GtRelease(m_assetState);
	GtRelease(m_queuedDate);
	GtRelease(m_createdDate);
	GtRelease(m_modifiedDate);
	GtRelease(m_uploadedAssetURL);
	GtRelease(m_uploadedAssetId);
	GtRelease(m_uploadDestinationId);
	GtRelease(m_uploadDestinationName);
	GtRelease(m_uploadDestinationURL);
	GtRelease(m_assetSize);
	GtRelease(m_assetName);
	GtRelease(m_assetDescription);
	GtRelease(m_assetFileName);
	GtRelease(m_copyright);
	GtRelease(m_keywords);
	GtRelease(m_assetObject);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_queueUID) [aCoder encodeObject:m_queueUID forKey:@"m_queueUID"];
	if(m_assetUID) [aCoder encodeObject:m_assetUID forKey:@"m_assetUID"];
	if(m_assetURL) [aCoder encodeObject:m_assetURL forKey:@"m_assetURL"];
	if(m_assetType) [aCoder encodeObject:m_assetType forKey:@"m_assetType"];
	if(m_positionInQueue) [aCoder encodeObject:m_positionInQueue forKey:@"m_positionInQueue"];
	if(m_assetState) [aCoder encodeObject:m_assetState forKey:@"m_assetState"];
	if(m_queuedDate) [aCoder encodeObject:m_queuedDate forKey:@"m_queuedDate"];
	if(m_createdDate) [aCoder encodeObject:m_createdDate forKey:@"m_createdDate"];
	if(m_modifiedDate) [aCoder encodeObject:m_modifiedDate forKey:@"m_modifiedDate"];
	if(m_uploadedAssetURL) [aCoder encodeObject:m_uploadedAssetURL forKey:@"m_uploadedAssetURL"];
	if(m_uploadedAssetId) [aCoder encodeObject:m_uploadedAssetId forKey:@"m_uploadedAssetId"];
	if(m_uploadDestinationId) [aCoder encodeObject:m_uploadDestinationId forKey:@"m_uploadDestinationId"];
	if(m_uploadDestinationName) [aCoder encodeObject:m_uploadDestinationName forKey:@"m_uploadDestinationName"];
	if(m_uploadDestinationURL) [aCoder encodeObject:m_uploadDestinationURL forKey:@"m_uploadDestinationURL"];
	if(m_assetSize) [aCoder encodeObject:m_assetSize forKey:@"m_assetSize"];
	if(m_assetName) [aCoder encodeObject:m_assetName forKey:@"m_assetName"];
	if(m_assetDescription) [aCoder encodeObject:m_assetDescription forKey:@"m_assetDescription"];
	if(m_assetFileName) [aCoder encodeObject:m_assetFileName forKey:@"m_assetFileName"];
	if(m_copyright) [aCoder encodeObject:m_copyright forKey:@"m_copyright"];
	if(m_keywords) [aCoder encodeObject:m_keywords forKey:@"m_keywords"];
	if(m_assetObject) [aCoder encodeObject:m_assetObject forKey:@"m_assetObject"];
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
	if((self = [super init]))
	{
		m_queueUID = [[aDecoder decodeObjectForKey:@"m_queueUID"] retain];
		m_assetUID = [[aDecoder decodeObjectForKey:@"m_assetUID"] retain];
		m_assetURL = [[aDecoder decodeObjectForKey:@"m_assetURL"] retain];
		m_assetType = [[aDecoder decodeObjectForKey:@"m_assetType"] retain];
		m_positionInQueue = [[aDecoder decodeObjectForKey:@"m_positionInQueue"] retain];
		m_assetState = [[aDecoder decodeObjectForKey:@"m_assetState"] retain];
		m_queuedDate = [[aDecoder decodeObjectForKey:@"m_queuedDate"] retain];
		m_createdDate = [[aDecoder decodeObjectForKey:@"m_createdDate"] retain];
		m_modifiedDate = [[aDecoder decodeObjectForKey:@"m_modifiedDate"] retain];
		m_uploadedAssetURL = [[aDecoder decodeObjectForKey:@"m_uploadedAssetURL"] retain];
		m_uploadedAssetId = [[aDecoder decodeObjectForKey:@"m_uploadedAssetId"] retain];
		m_uploadDestinationId = [[aDecoder decodeObjectForKey:@"m_uploadDestinationId"] retain];
		m_uploadDestinationName = [[aDecoder decodeObjectForKey:@"m_uploadDestinationName"] retain];
		m_uploadDestinationURL = [[aDecoder decodeObjectForKey:@"m_uploadDestinationURL"] retain];
		m_assetSize = [[aDecoder decodeObjectForKey:@"m_assetSize"] retain];
		m_assetName = [[aDecoder decodeObjectForKey:@"m_assetName"] retain];
		m_assetDescription = [[aDecoder decodeObjectForKey:@"m_assetDescription"] retain];
		m_assetFileName = [[aDecoder decodeObjectForKey:@"m_assetFileName"] retain];
		m_copyright = [[aDecoder decodeObjectForKey:@"m_copyright"] retain];
		m_keywords = [[aDecoder decodeObjectForKey:@"m_keywords"] mutableCopy];
		m_assetObject = [[aDecoder decodeObjectForKey:@"m_assetObject"] retain];
	}
	return self;
}

+ (GtQueuedAsset*) queuedAsset
{
	return GtReturnAutoreleased([[GtQueuedAsset alloc] init]);
}

+ (GtObjectDescriber*) sharedObjectDescriber
{
	static GtObjectDescriber* s_describer = nil;
	if(!s_describer)
	{
		@synchronized(self) {
			if(!s_describer)
			{
				s_describer = [[super sharedObjectDescriber] copy];
				if(!s_describer)
				{
					s_describer = [[GtObjectDescriber alloc] init];
				}
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"queueUID" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"queueUID"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetUID" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetUID"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetType" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"assetType"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"positionInQueue" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"positionInQueue"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetState" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"assetState"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"queuedDate" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"queuedDate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"createdDate" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"createdDate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"modifiedDate" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"modifiedDate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadedAssetURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"uploadedAssetURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadedAssetId" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"uploadedAssetId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadDestinationId" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"uploadDestinationId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadDestinationName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"uploadDestinationName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadDestinationURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"uploadDestinationURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetSize" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"assetSize"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetDescription" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetDescription"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetFileName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetFileName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"copyright" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"copyright"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"keywords" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject] forPropertyName:@"keywords"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetObject" propertyClass:[GtAsset class] propertyType:GtDataTypeObject] forPropertyName:@"assetObject"];
			}
		}
	}
	return s_describer;
}

+ (GtObjectInflator*) sharedObjectInflator
{
	static GtObjectInflator* s_inflator = nil;
	if(!s_inflator)
	{
		@synchronized(self) {
			if(!s_inflator)
			{
				s_inflator = [[GtObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
			}
		}
	}
	return s_inflator;
}

+ (GtSqliteTable*) sharedSqliteTable
{
	static GtSqliteTable* s_table = nil;
	if(!s_table)
	{
		@synchronized(self) {
			if(!s_table)
			{
				GtSqliteTable* superTable = [super sharedSqliteTable];
				if(superTable)
				{
					s_table = [superTable copy];
					s_table.tableName = [self sqliteTableName];
				}
				else
				{
					s_table = [[GtSqliteTable alloc] initWithTableName:[self sqliteTableName]];
				}
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"queueUID" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"queueUID" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetUID" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetURL" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"assetURL" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetType" columnType:GtSqliteTypeInteger columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"assetType" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"positionInQueue" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"positionInQueue" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetState" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"queuedDate" columnType:GtSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"queuedDate" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"createdDate" columnType:GtSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"createdDate" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"modifiedDate" columnType:GtSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"modifiedDate" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetURL" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetId" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationId" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationURL" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetSize" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetDescription" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetFileName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"copyright" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"keywords" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtQueuedAsset (ValueProperties) 

- (int) assetTypeValue
{
	return [self.assetType intValue];
}

- (void) setAssetTypeValue:(int) value
{
	self.assetType = [NSNumber numberWithInt:value];
}

- (int) positionInQueueValue
{
	return [self.positionInQueue intValue];
}

- (void) setPositionInQueueValue:(int) value
{
	self.positionInQueue = [NSNumber numberWithInt:value];
}

- (int) assetStateValue
{
	return [self.assetState intValue];
}

- (void) setAssetStateValue:(int) value
{
	self.assetState = [NSNumber numberWithInt:value];
}

- (long) uploadedAssetIdValue
{
	return [self.uploadedAssetId longValue];
}

- (void) setUploadedAssetIdValue:(long) value
{
	self.uploadedAssetId = [NSNumber numberWithLong:value];
}

- (long) uploadDestinationIdValue
{
	return [self.uploadDestinationId longValue];
}

- (void) setUploadDestinationIdValue:(long) value
{
	self.uploadDestinationId = [NSNumber numberWithLong:value];
}

- (long) assetSizeValue
{
	return [self.assetSize longValue];
}

- (void) setAssetSizeValue:(long) value
{
	self.assetSize = [NSNumber numberWithLong:value];
}
@end

