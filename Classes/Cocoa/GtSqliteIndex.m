//
//  GtSqliteIndex.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/3/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteIndex.h"


@implementation GtSqliteIndex

@synthesize columnName = m_columnName;
@synthesize indexProperties = m_indexMask;

- (id) initWithColumnName:(NSString*) columnName indexProperties:(GtSqliteColumnIndexProperties) indexProperties
{
	if((self = [super init]))
	{
		m_columnName = GtSqliteNameEncode(GtRetain(columnName));
		m_indexMask = indexProperties;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_columnName);
	GtSuperDealloc();
}

+ (GtSqliteIndex*) sqliteIndex:(NSString*) columnName indexProperties:(GtSqliteColumnIndexProperties) indexProperties
{
	return GtReturnAutoreleased([[GtSqliteIndex alloc] initWithColumnName:columnName indexProperties:indexProperties]);
}

- (id) copyWithZone:(NSZone *)zone
{
	GtSqliteIndex* idx = [[GtSqliteIndex alloc] initWithColumnName:self.columnName indexProperties:self.indexProperties];
	return idx;
}

- (NSString*) createIndexSqlForTableName:(NSString*) tableName
{
	NSMutableString* sql = [NSMutableString stringWithString:@"CREATE"];
	if(GtBitMaskTest(m_indexMask, GtSqliteColumnIndexPropertyUnique))
	{
		[sql appendString:@" UNIQUE"];
	}

	[sql appendFormat:@" INDEX idx_%@_%@ ON %@ (%@", // IF NOT EXISTS
		tableName, 
		self.columnName,
		tableName, 
		self.columnName];
	
	if(GtBitMaskTest(m_indexMask, GtSqliteColumnIndexPropertyCollateBinary))
	{
		[sql appendString:@" COLLATE BINARY"];
	}
	else if(GtBitMaskTest(m_indexMask, GtSqliteColumnIndexPropertyCollateNoCase))
	{
		[sql appendString:@" COLLATE NOCASE"];
	}
	else if(GtBitMaskTest(m_indexMask, GtSqliteColumnIndexPropertyCollateTrim))
	{
		[sql appendString:@" COLLATE RTRIM"];
	}
	
	if(GtBitTestAny(m_indexMask, GtSqliteColumnIndexPropertyAsc))
	{
		[sql appendString:@" ASC"];
	}
	else if(GtBitTestAny(m_indexMask, GtSqliteColumnIndexPropertyDesc))
	{
		[sql appendString:@" DESC"];
	}

	[sql appendString:@")"];
	
	return sql;
}

@end
