//
//  NSError+(Sqlite).h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqlite.h"

extern NSString* GtSqliteErrorToString(int error);

typedef enum {
	GtSqliteDatabaseErrorDatabaseAlreadyOpen = 1,
	GtSqliteDatabaseErrorDatabaseAlreadyClosed
} GtSqliteDatabaseErrorCode;

extern NSString* const GtSqliteDatabaseErrorDomain;

#define GtSqliteErrorMessageKey @"GtSqliteErrorMessageKey" 
#define GtSqliteErrorFailedSqlKey @"GtSqliteErrorFailedSqlKey" 

@interface NSError (GtSqlite)

- (id) initWithSqlite:(sqlite3*) sqlite sql:(const char*) sql;
+ (id) sqliteError:(sqlite3*) sqlite sql:(const char*) sql;

@property (readonly, retain, nonatomic) NSString* failedSql;
@property (readonly, retain, nonatomic) NSString* sqliteErrorMessage;

@property (readonly, assign, nonatomic) BOOL isTableDoesNotExistError;

@end