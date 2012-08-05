//
//  NSError+(Sqlite).m
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSError+Sqlite.h"

NSString* const FLSqliteDatabaseErrorDomain = @"FLSqliteDatabaseErrorDomain";

@implementation NSError (FLSqlite)

- (id) initWithSqlite:(sqlite3*) sqlite sql:(const char*) sql
{
	int errorCode = sqlite3_errcode(sqlite);
	const char* c_message = sqlite3_errmsg(sqlite);

	NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
	
	if(c_message)
	{
		NSString* msg = [NSString stringWithCString:c_message encoding:NSASCIIStringEncoding];
		[userInfo setObject:msg forKey:FLSqliteErrorMessageKey];

		[userInfo setObject:[NSString stringWithFormat:@"Sqlite error: %@ (%d) (%@)", FLSqliteErrorToString(errorCode), errorCode, msg] 
					 forKey:NSLocalizedFailureReasonErrorKey];
	}
	else
	{
		[userInfo setObject:[NSString stringWithFormat:@"Sqlite error: %@ (%d)", FLSqliteErrorToString(errorCode), errorCode] 
			         forKey:NSLocalizedFailureReasonErrorKey];
	}
	
	if(sql)
	{
		[userInfo setObject:[NSString stringWithCString:sql encoding:NSASCIIStringEncoding] forKey:FLSqliteErrorFailedSqlKey];
	}
	
	if((self = [self initWithDomain:FLSqliteDatabaseErrorDomain code:errorCode userInfo:userInfo]))
	{
	}
	
	return self;
}

+ (id) sqliteError:(sqlite3*) sqlite sql:(const char*) sql
{
	return FLReturnAutoreleased([[NSError alloc] initWithSqlite:sqlite sql:sql]);
}

- (NSString*) failedSql
{
	return [self.userInfo objectForKey:FLSqliteErrorFailedSqlKey];
}

- (NSString*) sqliteErrorMessage
{
	return [self.userInfo objectForKey:FLSqliteErrorMessageKey];
}

- (BOOL) isTableDoesNotExistError
{
	NSString* sqliteErrorMsg = self.sqliteErrorMessage;
	return [sqliteErrorMsg rangeOfString:@"no such table"].length > 0;
}


@end

NSString* FLSqliteErrorToString(int error)
{
	switch(error)
	{
		case SQLITE_OK: return @"SQLITE_OK";
		case SQLITE_ERROR: return @"SQLITE_ERROR";
		case SQLITE_INTERNAL: return @"SQLITE_INTERNAL";
		case SQLITE_PERM: return @"SQLITE_PERM";
		case SQLITE_ABORT: return @"SQLITE_ABORT";
		case SQLITE_BUSY: return @"SQLITE_BUSY";
		case SQLITE_LOCKED: return @"SQLITE_LOCKED";
		case SQLITE_NOMEM: return @"SQLITE_NOMEM";
		case SQLITE_READONLY: return @"SQLITE_READONLY";
		case SQLITE_INTERRUPT: return @"SQLITE_INTERRUPT";
		case SQLITE_IOERR: return @"SQLITE_IOERR";
		case SQLITE_CORRUPT: return @"SQLITE_CORRUPT";
		case SQLITE_NOTFOUND: return @"SQLITE_NOTFOUND";
		case SQLITE_FULL: return @"SQLITE_FULL";
		case SQLITE_CANTOPEN: return @"SQLITE_CANTOPEN";
		case SQLITE_PROTOCOL: return @"SQLITE_PROTOCOL";
		case SQLITE_EMPTY: return @"SQLITE_EMPTY";
		case SQLITE_SCHEMA: return @"SQLITE_SCHEMA";
		case SQLITE_TOOBIG: return @"SQLITE_TOOBIG";
		case SQLITE_CONSTRAINT: return @"SQLITE_CONSTRAINT";
		case SQLITE_MISMATCH: return @"SQLITE_MISMATCH";
		case SQLITE_MISUSE: return @"SQLITE_MISUSE";
		case SQLITE_NOLFS: return @"SQLITE_NOLFS";
		case SQLITE_AUTH: return @"SQLITE_AUTH";
		case SQLITE_FORMAT: return @"SQLITE_FORMAT";
		case SQLITE_RANGE: return @"SQLITE_RANGE";
		case SQLITE_NOTADB: return @"SQLITE_NOTADB";
		case SQLITE_ROW: return @"SQLITE_ROW";
		case SQLITE_DONE: return @"SQLITE_DONE";
		
		break;
	}
	
	return @"SQLITE_UNKNOWN_ERROR";
}

