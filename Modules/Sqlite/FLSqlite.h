//
//  FLSqlite.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

//#include "/usr/include/sqlite3.h"

#import <sqlite3.h>

/**
	This file contains various defines, enums, and utils used commonly by the FLSqlite code.
*/

// helpful enums that are the same as the SQL defines
typedef enum {
	FLSqliteTypeInteger	= SQLITE_INTEGER,
	FLSqliteTypeBlob	= SQLITE_BLOB,
	FLSqliteTypeFloat	= SQLITE_FLOAT,
	FLSqliteTypeText	= SQLITE_TEXT,
	FLSqliteTypeNull	= SQLITE_NULL,
	FLSqliteTypeDate,
	FLSqliteTypeObject,
    FLSqliteTypeNone  
} FLSqliteType;

// flag descriptions are here: http://www.sqlite.org/c3ref/open.html
typedef enum {
	FLSqliteDatabaseOpenFlagReadOnly = SQLITE_OPEN_READONLY,
	FLSqliteDatabaseOpenFlagReadWrite = SQLITE_OPEN_READWRITE,
	FLSqliteDatabaseOpenFlagCreate = SQLITE_OPEN_CREATE,
	FLSqliteDatabaseOpenFlagDeleteOnClose = SQLITE_OPEN_DELETEONCLOSE,
	FLSqliteDatabaseOpenFlagExclusive = SQLITE_OPEN_EXCLUSIVE,
	FLSqliteDatabaseOpenFlagAutoProxy = SQLITE_OPEN_AUTOPROXY,
	FLSqliteDatabaseOpenFlagMainDB = SQLITE_OPEN_MAIN_DB,
	FLSqliteDatabaseOpenFlagTempDB = SQLITE_OPEN_TEMP_DB,
	FLSqliteDatabaseOpenFlagTransientDB = SQLITE_OPEN_TRANSIENT_DB,
	FLSqliteDatabaseOpenFlagMainJournal = SQLITE_OPEN_MAIN_JOURNAL,
	FLSqliteDatabaseOpenFlagTempJournal = SQLITE_OPEN_TEMP_JOURNAL,
	FLSqliteDatabaseOpenFlagSubJournal = SQLITE_OPEN_SUBJOURNAL,
	FLSqliteDatabaseOpenFlagMasterJournal = SQLITE_OPEN_MASTER_JOURNAL,
	FLSqliteDatabaseOpenFlagNoMutex = SQLITE_OPEN_NOMUTEX,
	FLSqliteDatabaseOpenFlagFullMutex = SQLITE_OPEN_FULLMUTEX,

	FLSqliteDatabaseOpenFlagsDefault = FLSqliteDatabaseOpenFlagCreate | FLSqliteDatabaseOpenFlagReadWrite | FLSqliteDatabaseOpenFlagNoMutex /// Default 

} FLSqliteDatabaseOpenFlags;

// sends in the normal object (e.g value created with integerForColumn). 
// The handler should returns a new object, or the object passed in. 
// The resulting object is assigned to column in row dictionary.
typedef void (^FLSqliteColumnDecoder)(NSString* columnName, FLSqliteType sqlType, id inObject, id* outObject);

extern NSString* FLSqliteTypeToString(FLSqliteType type);

NS_INLINE
BOOL FLSqliteIsInternalNameEncoded(NSString* name) {
	return [name hasPrefix:@"gt_"];
}

NS_INLINE 
NSString* FLSqliteNameEncode(NSString* name) {
	return [name hasPrefix:@"gt_" ] ? name : [NSString stringWithFormat:@"gt_%@", name];
}

NS_INLINE 
NSString* FLSqliteNameDecode(NSString* internalName) {
	return [internalName hasPrefix:@"gt_" ] ? [internalName substringFromIndex:3] : internalName;
}

