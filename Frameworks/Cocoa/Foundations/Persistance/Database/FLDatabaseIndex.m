//
//  FLDatabaseIndex.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDatabaseIndex.h"
#import "FLDatabase_Internal.h"

@implementation FLDatabaseIndex

@synthesize columnName = _columnName;
@synthesize indexProperties = _indexMask;

- (id) initWithColumnName:(NSString*) columnName indexProperties:(FLDatabaseColumnIndexProperties) indexProperties
{
	if((self = [super init]))
	{
		_columnName = FLDatabaseNameEncode(FLRetain(columnName));
		_indexMask = indexProperties;
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_columnName);
	super_dealloc_();
}

+ (FLDatabaseIndex*) databaseIndex:(NSString*) columnName indexProperties:(FLDatabaseColumnIndexProperties) indexProperties
{
	return FLAutorelease([[FLDatabaseIndex alloc] initWithColumnName:columnName indexProperties:indexProperties]);
}

- (id) copyWithZone:(NSZone *)zone
{
	FLDatabaseIndex* idx = [[FLDatabaseIndex alloc] initWithColumnName:self.columnName indexProperties:self.indexProperties];
	return idx;
}

- (NSString*) createIndexSqlForTableName:(NSString*) tableName
{
	NSMutableString* sql = [NSMutableString stringWithString:@"CREATE"];
	if(FLTestBits(_indexMask, FLDatabaseColumnIndexPropertyUnique))
	{
		[sql appendString:@" UNIQUE"];
	}

	[sql appendFormat:@" INDEX idx_%@_%@ ON %@ (%@", // IF NOT EXISTS
		tableName, 
		self.columnName,
		tableName, 
		self.columnName];
	
	if(FLTestBits(_indexMask, FLDatabaseColumnIndexPropertyCollateBinary))
	{
		[sql appendString:@" COLLATE BINARY"];
	}
	else if(FLTestBits(_indexMask, FLDatabaseColumnIndexPropertyCollateNoCase))
	{
		[sql appendString:@" COLLATE NOCASE"];
	}
	else if(FLTestBits(_indexMask, FLDatabaseColumnIndexPropertyCollateTrim))
	{
		[sql appendString:@" COLLATE RTRIM"];
	}
	
	if(FLTestBits(_indexMask, FLDatabaseColumnIndexPropertyAsc))
	{
		[sql appendString:@" ASC"];
	}
	else if(FLTestBits(_indexMask, FLDatabaseColumnIndexPropertyDesc))
	{
		[sql appendString:@" DESC"];
	}

	[sql appendString:@")"];
	
	return sql;
}

@end
