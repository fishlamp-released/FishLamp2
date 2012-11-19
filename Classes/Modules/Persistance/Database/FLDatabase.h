//
//  FLDatabase.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

/** 
	Abstraction for SqlDatabase that doesn't take a dependency on the rest of FishLamp.
*/

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "FishLampCore.h"
#import "FLDatabaseDefines.h"
#import "FLDatabaseIterator.h"
#import "FLDatabaseTable.h"
#import "FLDatabaseErrors.h"
#import "FLDatabaseColumnDecoder.h"

@class FLDatabaseIterator;

@interface FLDatabase : NSObject {
@private
	sqlite3* _database;
	NSString* _filePath;
	NSMutableDictionary* _tables;
	FLDatabaseColumnDecoder _columnDecoder;
}

@property (readwrite, assign, nonatomic) FLDatabaseColumnDecoder columnDecoder;

/// returns path to db file
@property (readonly, retain, nonatomic) NSString* filePath;
@property (readonly, retain, nonatomic) NSString* fileName;

/// returns point to sqlite3 reference
@property (readonly, assign, nonatomic) sqlite3* sqlite3;

/// returns YES is db is open
@property (readonly, assign, nonatomic) BOOL isOpen;

/// Initialize database object. This doesn't open the db.
- (id) initWithFilePath:(NSString*) filePath;

/// Deletes the .sqlite file on disk.
- (void) deleteOnDisk;

/// Returns true if file exists on disk 
- (BOOL) databaseFileExistsOnDisk;

///	Size of file on disk 
- (unsigned long long) databaseFileSize;

/// Open the database. Use the flags to specify the behavior, for example: @see FLDatabaseOpenFlagsDefault
- (BOOL) openDatabase:(FLDatabaseOpenFlags) flags;

/// Close the database
- (void) closeDatabase;

/// Will cancel the current operation
- (void) cancelCurrentOperation; 

/// Exec a command. Threadsafe.
- (void) exec:(NSString*) sql;

- (void) executeTransaction:(void (^)()) block;

- (void) runQueryWithString:(NSString*) statementString
                    outRows:(NSArray**) outRows;

// misc
- (void) purgeMemoryIfPossible;

// utils
- (void) beginAsyncBlock:(void(^)(FLDatabase*)) asyncBlock
              errorBlock:(void(^)(FLDatabase*, NSError*)) errorBlock;

+ (FLDatabaseColumnDecoder) defaultColumnDecoder;

+ (void) setDefaultColumnDecoder:(FLDatabaseColumnDecoder) decoder;

@end

#import "FLDatabase+Introspection.h"
#import "FLDatabase+Objects.h"
#import "FLDatabase+Tables.h"
#import "FLDatabase+Tests.h"
#import "FLDatabase+Versioning.h"

#if FL_DATABASE_DEBUG
#define FLDbLog(__FORMAT__, ...)   \
        FLLogWithType(FLLogTypeDatabase, __FORMAT__, ##__VA_ARGS__)

#define FLDbLogIf(__CONDITION__, __FORMAT__, ...)   \
        if(__CONDITION__) FLLogWithType(FLLogTypeDatabase, __FORMAT__, ##__VA_ARGS__)

#else 
#define FLDbLog(__FORMAT__, ...)
#define FLDbLogIf(__CONDITION__, __FORMAT__, ...)
#endif

NS_INLINE
BOOL FLDatabaseIsInternalNameEncoded(NSString* name) {
	return [name hasPrefix:FL_DATABASE_PREFIX];
}

NS_INLINE 
NSString* FLDatabaseNameEncode(NSString* name) {
	return [name hasPrefix:FL_DATABASE_PREFIX ] ? name : [NSString stringWithFormat:@"%@%@", FL_DATABASE_PREFIX, name];
}

NS_INLINE 
NSString* FLDatabaseNameDecode(NSString* internalName) {
	return [internalName hasPrefix:FL_DATABASE_PREFIX ] ? [internalName substringFromIndex:FL_DATABASE_PREFIX.length] : internalName;
}




