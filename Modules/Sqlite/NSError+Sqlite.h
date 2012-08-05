//
//  NSError+(Sqlite).h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLSqlite.h"

extern NSString* FLSqliteErrorToString(int error);

typedef enum {
	FLSqliteDatabaseErrorDatabaseAlreadyOpen = 1,
	FLSqliteDatabaseErrorDatabaseAlreadyClosed
} FLSqliteDatabaseErrorCode;

extern NSString* const FLSqliteDatabaseErrorDomain;

#define FLSqliteErrorMessageKey @"FLSqliteErrorMessageKey" 
#define FLSqliteErrorFailedSqlKey @"FLSqliteErrorFailedSqlKey" 

@interface NSError (FLSqlite)

- (id) initWithSqlite:(sqlite3*) sqlite sql:(const char*) sql;
+ (id) sqliteError:(sqlite3*) sqlite sql:(const char*) sql;

@property (readonly, retain, nonatomic) NSString* failedSql;
@property (readonly, retain, nonatomic) NSString* sqliteErrorMessage;

@property (readonly, assign, nonatomic) BOOL isTableDoesNotExistError;

@end