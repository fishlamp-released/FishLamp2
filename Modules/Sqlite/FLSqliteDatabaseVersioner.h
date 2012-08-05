//
//  FLSqliteDatabaseVersioner.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLSqliteDatabase.h"
#import "FLSqliteTable.h"

#define FLDatabaseVersionTableName @"gt_version"

/**
 * This class reads and writes version information to a database. 
 * This info is stored in a special table. 
 * The version is the same as the app version, e.g. 1.0.0 
 * 1.0.0 are 1.0.1 considered different versions of the database.
 * Use a FLSqliteDatabaseUpgrader to convert the schema to a new version. After you do that,
 * update the version using writeVersion. 
 */
@interface FLSqliteDatabaseVersioner : NSObject {
@private
	FLSqliteTable* _versionTable;
}

FLSingletonProperty(FLSqliteDatabaseVersioner);

/// Reads version saved in database
- (NSString*) readVersionForDatabase:(FLSqliteDatabase*) database;

/// writes current version of app to database for the database version
- (void) writeVersion:(NSString*) version toDatabase:(FLSqliteDatabase*) database;

/// write current version (same as app version) to database
- (void) writeCurrentAppVersionToDatabase:(FLSqliteDatabase*) database;

/// returns YES if version saved in database is not the same version as the current app version
- (BOOL) databaseVersionEqualToAppVersion:(FLSqliteDatabase*) database;

/// returns YES if name is equal to internal table used to store database version.
- (BOOL) isVersionTableName:(NSString*) tableName;

@end
