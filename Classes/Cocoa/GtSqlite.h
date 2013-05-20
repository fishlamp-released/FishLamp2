//
//  GtSqlite.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

//#include "/usr/include/sqlite3.h"

#import <sqlite3.h>

/**
	This file contains various defines, enums, and utils used commonly by the GtSqlite code.
*/

// helpful enums that are the same as the SQL defines
typedef enum {
	GtSqliteTypeInteger	= SQLITE_INTEGER,
	GtSqliteTypeBlob	= SQLITE_BLOB,
	GtSqliteTypeFloat	= SQLITE_FLOAT,
	GtSqliteTypeText	= SQLITE_TEXT,
	GtSqliteTypeNull	= SQLITE_NULL,
	GtSqliteTypeDate,
	GtSqliteTypeObject,
    GtSqliteTypeNone  
} GtSqliteType;

// flag descriptions are here: http://www.sqlite.org/c3ref/open.html
typedef enum {
	GtSqliteDatabaseOpenFlagReadOnly = SQLITE_OPEN_READONLY,
	GtSqliteDatabaseOpenFlagReadWrite = SQLITE_OPEN_READWRITE,
	GtSqliteDatabaseOpenFlagCreate = SQLITE_OPEN_CREATE,
	GtSqliteDatabaseOpenFlagDeleteOnClose = SQLITE_OPEN_DELETEONCLOSE,
	GtSqliteDatabaseOpenFlagExclusive = SQLITE_OPEN_EXCLUSIVE,
	GtSqliteDatabaseOpenFlagAutoProxy = SQLITE_OPEN_AUTOPROXY,
	GtSqliteDatabaseOpenFlagMainDB = SQLITE_OPEN_MAIN_DB,
	GtSqliteDatabaseOpenFlagTempDB = SQLITE_OPEN_TEMP_DB,
	GtSqliteDatabaseOpenFlagTransientDB = SQLITE_OPEN_TRANSIENT_DB,
	GtSqliteDatabaseOpenFlagMainJournal = SQLITE_OPEN_MAIN_JOURNAL,
	GtSqliteDatabaseOpenFlagTempJournal = SQLITE_OPEN_TEMP_JOURNAL,
	GtSqliteDatabaseOpenFlagSubJournal = SQLITE_OPEN_SUBJOURNAL,
	GtSqliteDatabaseOpenFlagMasterJournal = SQLITE_OPEN_MASTER_JOURNAL,
	GtSqliteDatabaseOpenFlagNoMutex = SQLITE_OPEN_NOMUTEX,
	GtSqliteDatabaseOpenFlagFullMutex = SQLITE_OPEN_FULLMUTEX,

	GtSqliteDatabaseOpenFlagsDefault = GtSqliteDatabaseOpenFlagCreate | GtSqliteDatabaseOpenFlagReadWrite | GtSqliteDatabaseOpenFlagNoMutex /// Default 

} GtSqliteDatabaseOpenFlags;

// sends in the normal object (e.g value created with integerForColumn). 
// The handler should returns a new object, or the object passed in. 
// The resulting object is assigned to column in row dictionary.
typedef id (^GtSqliteColumnDecoder)(NSString* columnName, id object, GtSqliteType sqlType);

extern NSString* GtSqliteTypeToString(GtSqliteType type);


NS_INLINE
BOOL GtSqliteIsInternalNameEncoded(NSString* name)
{
	return [name hasPrefix:@"gt_"];
}

NS_INLINE 
NSString* GtSqliteNameEncode(NSString* name)
{
	return [name hasPrefix:@"gt_" ] ? name : [NSString stringWithFormat:@"gt_%@", name];
}

NS_INLINE 
NSString* GtSqliteNameDecode(NSString* internalName)
{
	return [internalName hasPrefix:@"gt_" ] ? [internalName substringFromIndex:3] : internalName;
}

