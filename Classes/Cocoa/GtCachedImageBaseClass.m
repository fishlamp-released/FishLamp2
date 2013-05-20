//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCachedImageBaseClass.m
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCachedImageBaseClass.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCachedImageBaseClass


@synthesize canCacheInMemory = m_canCacheInMemory;
@synthesize fileName = m_fileName;
@synthesize host = m_host;
@synthesize imageId = m_imageId;
@synthesize imageVersion = m_imageVersion;
@synthesize photoUrl = m_photoUrl;
@synthesize url = m_url;

+ (NSString*) canCacheInMemoryKey
{
	return @"canCacheInMemory";
}

+ (NSString*) fileNameKey
{
	return @"fileName";
}

+ (NSString*) hostKey
{
	return @"host";
}

+ (NSString*) imageIdKey
{
	return @"imageId";
}

+ (NSString*) imageVersionKey
{
	return @"imageVersion";
}

+ (NSString*) photoUrlKey
{
	return @"photoUrl";
}

+ (NSString*) urlKey
{
	return @"url";
}

+ (GtCachedImageBaseClass*) cachedImageBaseClass
{
	return GtReturnAutoreleased([[GtCachedImageBaseClass alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCachedImageBaseClass*)object).imageId = GtCopyOrRetainObject(m_imageId);
	((GtCachedImageBaseClass*)object).imageVersion = GtCopyOrRetainObject(m_imageVersion);
	((GtCachedImageBaseClass*)object).fileName = GtCopyOrRetainObject(m_fileName);
	((GtCachedImageBaseClass*)object).host = GtCopyOrRetainObject(m_host);
	((GtCachedImageBaseClass*)object).photoUrl = GtCopyOrRetainObject(m_photoUrl);
	((GtCachedImageBaseClass*)object).canCacheInMemory = GtCopyOrRetainObject(m_canCacheInMemory);
	((GtCachedImageBaseClass*)object).url = GtCopyOrRetainObject(m_url);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_fileName);
	GtRelease(m_url);
	GtRelease(m_imageId);
	GtRelease(m_photoUrl);
	GtRelease(m_host);
	GtRelease(m_imageVersion);
	GtRelease(m_canCacheInMemory);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_fileName) [aCoder encodeObject:m_fileName forKey:@"m_fileName"];
	if(m_url) [aCoder encodeObject:m_url forKey:@"m_url"];
	if(m_imageId) [aCoder encodeObject:m_imageId forKey:@"m_imageId"];
	if(m_photoUrl) [aCoder encodeObject:m_photoUrl forKey:@"m_photoUrl"];
	if(m_host) [aCoder encodeObject:m_host forKey:@"m_host"];
	if(m_imageVersion) [aCoder encodeObject:m_imageVersion forKey:@"m_imageVersion"];
	if(m_canCacheInMemory) [aCoder encodeObject:m_canCacheInMemory forKey:@"m_canCacheInMemory"];
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
		m_fileName = [[aDecoder decodeObjectForKey:@"m_fileName"] retain];
		m_url = [[aDecoder decodeObjectForKey:@"m_url"] retain];
		m_imageId = [[aDecoder decodeObjectForKey:@"m_imageId"] retain];
		m_photoUrl = [[aDecoder decodeObjectForKey:@"m_photoUrl"] retain];
		m_host = [[aDecoder decodeObjectForKey:@"m_host"] retain];
		m_imageVersion = [[aDecoder decodeObjectForKey:@"m_imageVersion"] retain];
		m_canCacheInMemory = [[aDecoder decodeObjectForKey:@"m_canCacheInMemory"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"fileName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"fileName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"url" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"url"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"imageId" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"imageId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"photoUrl" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"photoUrl"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"host" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"host"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"imageVersion" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"imageVersion"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"canCacheInMemory" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"canCacheInMemory"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"fileName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"url" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"imageId" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"photoUrl" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"host" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"host" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"imageVersion" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"canCacheInMemory" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCachedImageBaseClass (ValueProperties) 

- (BOOL) canCacheInMemoryValue
{
	return [self.canCacheInMemory boolValue];
}

- (void) setCanCacheInMemoryValue:(BOOL) value
{
	self.canCacheInMemory = [NSNumber numberWithBool:value];
}
@end

