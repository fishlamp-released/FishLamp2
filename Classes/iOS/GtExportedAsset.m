//	This file was generated at 11/6/11 3:34 PM by PackMule. DO NOT MODIFY!!
//
//	GtExportedAsset.m
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtExportedAsset.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtExportedAsset


@synthesize assetURL = m_assetURL;
@synthesize exportedDate = m_exportedDate;
@synthesize originalID = m_originalID;

+ (NSString*) assetURLKey
{
	return @"assetURL";
}

+ (NSString*) exportedDateKey
{
	return @"exportedDate";
}

+ (NSString*) originalIDKey
{
	return @"originalID";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtExportedAsset*)object).assetURL = GtCopyOrRetainObject(m_assetURL);
	((GtExportedAsset*)object).exportedDate = GtCopyOrRetainObject(m_exportedDate);
	((GtExportedAsset*)object).originalID = GtCopyOrRetainObject(m_originalID);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_originalID);
	GtRelease(m_assetURL);
	GtRelease(m_exportedDate);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_originalID) [aCoder encodeObject:m_originalID forKey:@"m_originalID"];
	if(m_assetURL) [aCoder encodeObject:m_assetURL forKey:@"m_assetURL"];
	if(m_exportedDate) [aCoder encodeObject:m_exportedDate forKey:@"m_exportedDate"];
}

+ (GtExportedAsset*) exportedAsset
{
	return GtReturnAutoreleased([[GtExportedAsset alloc] init]);
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
		m_originalID = [[aDecoder decodeObjectForKey:@"m_originalID"] retain];
		m_assetURL = [[aDecoder decodeObjectForKey:@"m_assetURL"] retain];
		m_exportedDate = [[aDecoder decodeObjectForKey:@"m_exportedDate"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"originalID" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"originalID"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"assetURL" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"assetURL"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"exportedDate" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"exportedDate"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"originalID" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"originalID" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"assetURL" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"assetURL" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"exportedDate" columnType:GtSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtExportedAsset (ValueProperties) 
@end

