//
//  GtSqliteDatabaseVersioner.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqliteDatabase.h"
#import "GtSqliteTable.h"

#define GtDatabaseVersionTableName @"gt_version"

/**
 * This class reads and writes version information to a database. 
 * This info is stored in a special table. 
 * The version is the same as the app version, e.g. 1.0.0 
 * 1.0.0 are 1.0.1 considered different versions of the database.
 * Use a GtSqliteDatabaseUpgrader to convert the schema to a new version. After you do that,
 * update the version using writeVersion. 
 */
@interface GtSqliteDatabaseVersioner : NSObject {
@private
	GtSqliteTable* m_versionTable;
}

GtSingletonProperty(GtSqliteDatabaseVersioner);

/// Reads version saved in database
- (NSString*) readVersionForDatabase:(GtSqliteDatabase*) database;

/// writes current version of app to database for the database version
- (void) writeVersion:(NSString*) version toDatabase:(GtSqliteDatabase*) database;

/// write current version (same as app version) to database
- (void) writeCurrentAppVersionToDatabase:(GtSqliteDatabase*) database;

/// returns YES if version saved in database is not the same version as the current app version
- (BOOL) databaseVersionEqualToAppVersion:(GtSqliteDatabase*) database;

/// returns YES if name is equal to internal table used to store database version.
- (BOOL) isVersionTableName:(NSString*) tableName;

@end
