//
//  FLSqliteDatabaseVersioner.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSqliteDatabaseVersioner.h"
#import "FLSqliteTable.h"
#import "NSFileManager+FLExtras.h"


#define ID_COL @"gt_id"
#define VERSION_COL @"gt_version"

@implementation FLSqliteDatabaseVersioner

FLSynthesizeSingleton(FLSqliteDatabaseVersioner);

- (id) init
{
	if((self = [super init]))
	{
		_versionTable = [[FLSqliteTable alloc] initWithTableName:FLDatabaseVersionTableName];
		
		[_versionTable addColumn:[FLSqliteColumn sqliteColumnWithColumnName:ID_COL 
				columnType:FLSqliteTypeInteger 
				columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]
				]];

		[_versionTable addColumn:[FLSqliteColumn sqliteColumnWithColumnName:VERSION_COL 
				columnType:SQLITE_TEXT 
				columnConstraints:nil
				]];
	}
	return self;
}

- (BOOL) isVersionTableName:(NSString*) tableName
{
	return FLStringsAreEqual(tableName, VERSION_COL);
}

- (void) dealloc
{	
	FLRelease(_versionTable);
	
	FLSuperDealloc();
}

- (NSString*) readVersionForDatabase:(FLSqliteDatabase*) database
{
	@synchronized(database) {
		[database createTableIfNeeded:_versionTable];

		FLSqliteStatement* statement = [FLSqliteStatement sqliteStatement:database];
		@try
		{
			[statement prepareStatement:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=1", VERSION_COL, FLDatabaseVersionTableName, ID_COL]];

			while(statement.willStep)
			{
				NSDictionary* row = [statement step];
				
				if(row)
				{
					return [row objectForKey:VERSION_COL];
				}
			}
		}
		@finally 
		{
			[statement finalizeStatement];
		}
	}
	
	return nil;
}

- (void) writeVersion:(NSString*) version 
           toDatabase:(FLSqliteDatabase*) database
{
	@synchronized(database) {
		[database createTableIfNeeded:_versionTable];

		NSDictionary* newData = [[NSDictionary alloc] initWithObjectsAndKeys:
				[NSNumber numberWithInt:1], ID_COL,
				version, VERSION_COL,
				nil
				] ;
        FLAutorelease(newData);

		
		[database insertOrUpdateRowInTable:_versionTable.tableName row:newData];
	}

}

- (void) writeCurrentAppVersionToDatabase:(FLSqliteDatabase*) database
{
	[self writeVersion:[NSFileManager appVersion] toDatabase:database];
}

- (BOOL) databaseVersionEqualToAppVersion:(FLSqliteDatabase*) database
{
	return FLStringsAreEqual( [NSFileManager appVersion], [self readVersionForDatabase:database]);
}

@end
