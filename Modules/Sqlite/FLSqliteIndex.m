//
//  FLSqliteIndex.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSqliteIndex.h"


@implementation FLSqliteIndex

@synthesize columnName = _columnName;
@synthesize indexProperties = _indexMask;

- (id) initWithColumnName:(NSString*) columnName indexProperties:(FLSqliteColumnIndexProperties) indexProperties
{
	if((self = [super init]))
	{
		_columnName = FLSqliteNameEncode(FLReturnRetained(columnName));
		_indexMask = indexProperties;
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_columnName);
	FLSuperDealloc();
}

+ (FLSqliteIndex*) sqliteIndex:(NSString*) columnName indexProperties:(FLSqliteColumnIndexProperties) indexProperties
{
	return FLReturnAutoreleased([[FLSqliteIndex alloc] initWithColumnName:columnName indexProperties:indexProperties]);
}

- (id) copyWithZone:(NSZone *)zone
{
	FLSqliteIndex* idx = [[FLSqliteIndex alloc] initWithColumnName:self.columnName indexProperties:self.indexProperties];
	return idx;
}

- (NSString*) createIndexSqlForTableName:(NSString*) tableName
{
	NSMutableString* sql = [NSMutableString stringWithString:@"CREATE"];
	if(FLBitTest(_indexMask, FLSqliteColumnIndexPropertyUnique))
	{
		[sql appendString:@" UNIQUE"];
	}

	[sql appendFormat:@" INDEX idx_%@_%@ ON %@ (%@", // IF NOT EXISTS
		tableName, 
		self.columnName,
		tableName, 
		self.columnName];
	
	if(FLBitTest(_indexMask, FLSqliteColumnIndexPropertyCollateBinary))
	{
		[sql appendString:@" COLLATE BINARY"];
	}
	else if(FLBitTest(_indexMask, FLSqliteColumnIndexPropertyCollateNoCase))
	{
		[sql appendString:@" COLLATE NOCASE"];
	}
	else if(FLBitTest(_indexMask, FLSqliteColumnIndexPropertyCollateTrim))
	{
		[sql appendString:@" COLLATE RTRIM"];
	}
	
	if(FLBitTestAny(_indexMask, FLSqliteColumnIndexPropertyAsc))
	{
		[sql appendString:@" ASC"];
	}
	else if(FLBitTestAny(_indexMask, FLSqliteColumnIndexPropertyDesc))
	{
		[sql appendString:@" DESC"];
	}

	[sql appendString:@")"];
	
	return sql;
}

@end
