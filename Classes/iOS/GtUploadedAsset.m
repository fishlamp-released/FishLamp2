//	This file was generated at 7/16/11 4:17 PM by PackMule. DO NOT MODIFY!!
//
//	GtUploadedAsset.m
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUploadedAsset.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtUploadedAsset


@synthesize assetName = m_assetName;
@synthesize assetType = m_assetType;
@synthesize assetUID = m_assetUID;
@synthesize assetURL = m_assetURL;
@synthesize queueUID = m_queueUID;
@synthesize thumbnail = m_thumbnail;
@synthesize uploadDestinationId = m_uploadDestinationId;
@synthesize uploadDestinationName = m_uploadDestinationName;
@synthesize uploadDestinationURL = m_uploadDestinationURL;
@synthesize uploadedAssetId = m_uploadedAssetId;
@synthesize uploadedAssetUID = m_uploadedAssetUID;
@synthesize uploadedAssetURL = m_uploadedAssetURL;
@synthesize uploadedDate = m_uploadedDate;

+ (NSString*) assetNameKey
{
	return @"assetName";
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

+ (NSString*) queueUIDKey
{
	return @"queueUID";
}

+ (NSString*) thumbnailKey
{
	return @"thumbnail";
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

+ (NSString*) uploadedAssetUIDKey
{
	return @"uploadedAssetUID";
}

+ (NSString*) uploadedAssetURLKey
{
	return @"uploadedAssetURL";
}

+ (NSString*) uploadedDateKey
{
	return @"uploadedDate";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtUploadedAsset*)object).uploadDestinationName = GtCopyOrRetainObject(m_uploadDestinationName);
	((GtUploadedAsset*)object).assetURL = GtCopyOrRetainObject(m_assetURL);
	((GtUploadedAsset*)object).uploadedAssetUID = GtCopyOrRetainObject(m_uploadedAssetUID);
	((GtUploadedAsset*)object).uploadDestinationURL = GtCopyOrRetainObject(m_uploadDestinationURL);
	((GtUploadedAsset*)object).queueUID = GtCopyOrRetainObject(m_queueUID);
	((GtUploadedAsset*)object).uploadedAssetURL = GtCopyOrRetainObject(m_uploadedAssetURL);
	((GtUploadedAsset*)object).uploadedAssetId = GtCopyOrRetainObject(m_uploadedAssetId);
	((GtUploadedAsset*)object).assetName = GtCopyOrRetainObject(m_assetName);
	((GtUploadedAsset*)object).uploadedDate = GtCopyOrRetainObject(m_uploadedDate);
	((GtUploadedAsset*)object).assetUID = GtCopyOrRetainObject(m_assetUID);
	((GtUploadedAsset*)object).uploadDestinationId = GtCopyOrRetainObject(m_uploadDestinationId);
	((GtUploadedAsset*)object).assetType = GtCopyOrRetainObject(m_assetType);
	((GtUploadedAsset*)object).thumbnail = GtCopyOrRetainObject(m_thumbnail);
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
	GtRelease(m_uploadedAssetUID);
	GtRelease(m_assetType);
	GtRelease(m_assetURL);
	GtRelease(m_assetUID);
	GtRelease(m_uploadedAssetURL);
	GtRelease(m_uploadedAssetId);
	GtRelease(m_uploadDestinationId);
	GtRelease(m_uploadDestinationName);
	GtRelease(m_uploadDestinationURL);
	GtRelease(m_assetName);
	GtRelease(m_thumbnail);
	GtRelease(m_uploadedDate);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_queueUID) [aCoder encodeObject:m_queueUID forKey:@"m_queueUID"];
	if(m_uploadedAssetUID) [aCoder encodeObject:m_uploadedAssetUID forKey:@"m_uploadedAssetUID"];
	if(m_assetType) [aCoder encodeObject:m_assetType forKey:@"m_assetType"];
	if(m_assetURL) [aCoder encodeObject:m_assetURL forKey:@"m_assetURL"];
	if(m_assetUID) [aCoder encodeObject:m_assetUID forKey:@"m_assetUID"];
	if(m_uploadedAssetURL) [aCoder encodeObject:m_uploadedAssetURL forKey:@"m_uploadedAssetURL"];
	if(m_uploadedAssetId) [aCoder encodeObject:m_uploadedAssetId forKey:@"m_uploadedAssetId"];
	if(m_uploadDestinationId) [aCoder encodeObject:m_uploadDestinationId forKey:@"m_uploadDestinationId"];
	if(m_uploadDestinationName) [aCoder encodeObject:m_uploadDestinationName forKey:@"m_uploadDestinationName"];
	if(m_uploadDestinationURL) [aCoder encodeObject:m_uploadDestinationURL forKey:@"m_uploadDestinationURL"];
	if(m_assetName) [aCoder encodeObject:m_assetName forKey:@"m_assetName"];
	if(m_thumbnail) [aCoder encodeObject:m_thumbnail forKey:@"m_thumbnail"];
	if(m_uploadedDate) [aCoder encodeObject:m_uploadedDate forKey:@"m_uploadedDate"];
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
		m_uploadedAssetUID = [[aDecoder decodeObjectForKey:@"m_uploadedAssetUID"] retain];
		m_assetType = [[aDecoder decodeObjectForKey:@"m_assetType"] retain];
		m_assetURL = [[aDecoder decodeObjectForKey:@"m_assetURL"] retain];
		m_assetUID = [[aDecoder decodeObjectForKey:@"m_assetUID"] retain];
		m_uploadedAssetURL = [[aDecoder decodeObjectForKey:@"m_uploadedAssetURL"] retain];
		m_uploadedAssetId = [[aDecoder decodeObjectForKey:@"m_uploadedAssetId"] retain];
		m_uploadDestinationId = [[aDecoder decodeObjectForKey:@"m_uploadDestinationId"] retain];
		m_uploadDestinationName = [[aDecoder decodeObjectForKey:@"m_uploadDestinationName"] retain];
		m_uploadDestinationURL = [[aDecoder decodeObjectForKey:@"m_uploadDestinationURL"] retain];
		m_assetName = [[aDecoder decodeObjectForKey:@"m_assetName"] retain];
		m_thumbnail = [[aDecoder decodeObjectForKey:@"m_thumbnail"] retain];
		m_uploadedDate = [[aDecoder decodeObjectForKey:@"m_uploadedDate"] retain];
	}
	return self;
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadedAssetUID" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"uploadedAssetUID"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetType" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"assetType"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetUID" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetUID"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadedAssetURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"uploadedAssetURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadedAssetId" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"uploadedAssetId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadDestinationId" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"uploadDestinationId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadDestinationName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"uploadDestinationName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadDestinationURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"uploadDestinationURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"thumbnail" propertyClass:[UIImage class] propertyType:GtDataTypeObject] forPropertyName:@"thumbnail"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"uploadedDate" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"uploadedDate"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetUID" columnType:GtSqliteTypeInteger columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetType" columnType:GtSqliteTypeInteger columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"assetType" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetURL" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"assetURL" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetUID" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetURL" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetId" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationId" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationURL" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"thumbnail" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"uploadedDate" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtUploadedAsset*) uploadedAsset
{
	return GtReturnAutoreleased([[GtUploadedAsset alloc] init]);
}

@end

@implementation GtUploadedAsset (ValueProperties) 

- (int) uploadedAssetUIDValue
{
	return [self.uploadedAssetUID intValue];
}

- (void) setUploadedAssetUIDValue:(int) value
{
	self.uploadedAssetUID = [NSNumber numberWithInt:value];
}

- (int) assetTypeValue
{
	return [self.assetType intValue];
}

- (void) setAssetTypeValue:(int) value
{
	self.assetType = [NSNumber numberWithInt:value];
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
@end

