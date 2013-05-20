//
//  GtSqliteDatabaseVersioner.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteDatabaseVersioner.h"
#import "GtSqliteTable.h"
#import "NSFileManager+GtExtras.h"


#define ID_COL @"gt_id"
#define VERSION_COL @"gt_version"

@implementation GtSqliteDatabaseVersioner

GtSynthesizeSingleton(GtSqliteDatabaseVersioner);

- (id) init
{
	if((self = [super init]))
	{
		m_versionTable = [[GtSqliteTable alloc] initWithTableName:GtDatabaseVersionTableName];
		
		[m_versionTable addColumn:[GtSqliteColumn sqliteColumnWithColumnName:ID_COL 
				columnType:GtSqliteTypeInteger 
				columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]
				]];

		[m_versionTable addColumn:[GtSqliteColumn sqliteColumnWithColumnName:VERSION_COL 
				columnType:SQLITE_TEXT 
				columnConstraints:nil
				]];
	}
	return self;
}

- (BOOL) isVersionTableName:(NSString*) tableName
{
	return GtStringsAreEqual(tableName, VERSION_COL);
}

- (void) dealloc
{	
	GtRelease(m_versionTable);
	
	GtSuperDealloc();
}

- (NSString*) readVersionForDatabase:(GtSqliteDatabase*) database
{
	@synchronized(database) {
		[database createTableIfNeeded:m_versionTable];

		GtSqliteStatement* statement = [GtSqliteStatement sqliteStatement:database];
		@try
		{
			[statement prepareStatement:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=1", VERSION_COL, GtDatabaseVersionTableName, ID_COL]];

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
           toDatabase:(GtSqliteDatabase*) database
{
	@synchronized(database) {
		[database createTableIfNeeded:m_versionTable];

		NSDictionary* newData = [[NSDictionary alloc] initWithObjectsAndKeys:
				[NSNumber numberWithInt:1], ID_COL,
				version, VERSION_COL,
				nil
				] ;
        GtAutorelease(newData);

		
		[database insertOrUpdateRowInTable:m_versionTable.tableName row:newData];
	}

}

- (void) writeCurrentAppVersionToDatabase:(GtSqliteDatabase*) database
{
	[self writeVersion:[NSFileManager appVersion] toDatabase:database];
}

- (BOOL) databaseVersionEqualToAppVersion:(GtSqliteDatabase*) database
{
	return GtStringsAreEqual( [NSFileManager appVersion], [self readVersionForDatabase:database]);
}

@end
