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

#import "FLCocoaRequired.h"
#import <sqlite3.h>

#import "FishLampCore.h"
#import "FLDatabaseDefines.h"
#import "FLDatabaseTable.h"
#import "FLDatabaseErrors.h"
#import "FLDatabaseColumnDecoder.h"
#import "FLDatabaseStatement.h"
#import "FLAsyncQueue.h"
#import "FLFinisher.h"
#import "FLObjectStorage.h"

@interface FLDatabase : NSObject {
@private
	sqlite3* _sqlite;
	NSString* _filePath;
	NSMutableDictionary* _tables;
	FLDatabaseColumnDecoder _columnDecoder;
    FLAsyncQueue* _dispatchQueue;
    BOOL _isOpen;
}

@property (readwrite, assign, nonatomic) FLDatabaseColumnDecoder columnDecoder;

/// returns path to db file
@property (readonly, retain, nonatomic) NSString* filePath;
@property (readonly, retain, nonatomic) NSString* fileName;

/// returns point to sqlite3 reference
@property (readonly, assign) sqlite3* sqlite3;

/// returns YES is db is open
@property (readonly, assign) BOOL isOpen;

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
//- (void) exec:(NSString*) sql;

- (void) executeTransaction:(dispatch_block_t) block;

- (NSArray*) execute:(NSString*) sqlString;

- (void) execute:(NSString*) sqlString
  rowResultBlock:(FLDatabaseStatementDidSelectRowBlock) rowResultBlock;

- (void) executeStatement:(FLDatabaseStatement*) statement;

- (void) executeSql:(FLSqlBuilder*) sql 
     rowResultBlock:(FLDatabaseStatementDidSelectRowBlock) rowResultBlock;

// misc
- (void) purgeMemoryIfPossible;

// utils
+ (FLDatabaseColumnDecoder) defaultColumnDecoder;
+ (void) setDefaultColumnDecoder:(FLDatabaseColumnDecoder) decoder;

- (FLResult) queueBlock:(dispatch_block_t) block;
- (FLResult) dispatchFifoBlock:(dispatch_block_t) block;
@property (readonly, strong) FLAsyncQueue* dispatchQueue;

@end

#import "FLDatabase+Introspection.h"
#import "FLDatabase+Objects.h"
#import "FLDatabase+Tables.h"
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

#define FLDatabaseIsInternalNameEncoded_(__NAME__) [__NAME__ hasPrefix:FL_DATABASE_PREFIX]

NS_INLINE 
NSString* FLDatabaseNameEncode(NSString* name) {
	return FLDatabaseIsInternalNameEncoded_(name) ? name : [NSString stringWithFormat:@"%@%@", FL_DATABASE_PREFIX, name];
}

NS_INLINE 
NSString* FLDatabaseNameDecode(NSString* internalName) {
	return FLDatabaseIsInternalNameEncoded_(internalName) ? [internalName substringFromIndex:FL_DATABASE_PREFIX.length] : internalName;
}




