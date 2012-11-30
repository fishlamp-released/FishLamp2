//
//  FLDatabase.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDatabase.h"
#import "FLDatabase_Internal.h"

#import "NSFileManager+FLExtras.h"

#import "FLDatabaseColumnDecoder.h"
#import "FLDatabase+Tables.h"
#import "FLDatabase.h"
#import "FLAppInfo.h"
#import "FLSqlStatement.h"

@implementation FLDatabase

@synthesize sqlite3 = _sqlite;
@synthesize filePath = _filePath;
@synthesize columnDecoder = _columnDecoder;

static FLDatabaseColumnDecoder s_decoder = nil;

+ (FLDatabaseColumnDecoder) defaultColumnDecoder {
    return s_decoder;
}

+ (void) setDefaultColumnDecoder:(FLDatabaseColumnDecoder) decoder {
    s_decoder = decoder;
}

+ (void) initialize {
    static BOOL didInit = NO;
    if(!didInit) {
        [FLDatabase setCurrentRuntimeVersion:[FLAppInfo appVersion]];

#if FL_LEGACY_DB_ENCODING
        [FLDatabase setDefaultColumnDecoder:FLLegacyDatabaseColumnDecoder];
#else
        [FLDatabase setDefaultColumnDecoder:FLDefaultDatabaseColumnDecoder];
#endif
    }
}

- (void) handleLowMemory:(id)sender {
	[self purgeMemoryIfPossible];
}

- (id) init {
    self = [super init];
    if(self)  {
		_sqlite = nil;
        self.columnDecoder = s_decoder;

#if IOS
	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(handleLowMemory:)
		name: UIApplicationDidReceiveMemoryWarningNotification
		object: [UIApplication sharedApplication]];
#endif

    }
    
    return self;
}

- (id) initWithFilePath:(NSString*) filePath {
	if((self = [self init])) {
		_filePath = [filePath copy];
	}
	
	return self;
}

- (void) dealloc {
#if IOS
  	[[NSNotificationCenter defaultCenter] removeObserver:self];
#endif

	FLAssertIsNil_v(_sqlite, nil);
	release_(_filePath);
	super_dealloc_();
}

- (void) deleteOnDisk {
	NSError* error = nil;
	[[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:&error];
    if(error) {
        FLThrowError_(autorelease_(error));
    }
}

- (BOOL) databaseFileExistsOnDisk {
	return [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
}

- (unsigned long long) databaseFileSize {
	unsigned long long size = 0;
	NSError* error = nil;
	[NSFileManager getFileSize:self.filePath outSize:&size outError:&error];
    if(error){
        FLThrowError_(autorelease_(error));
    }

	return size;
}

- (void) cancelCurrentOperation {
	if(_sqlite) {
		@synchronized(self) {
			sqlite3_interrupt(_sqlite);
		}
	}
}

- (void) purgeMemoryIfPossible {
	@synchronized(self) {
		sqlite3_release_memory(INT32_MAX);
	}
}

- (NSString*) fileName {
    return [self.filePath lastPathComponent];
}

- (void) exec:(NSString*) sql {	
    const char* c_sql = [sql UTF8String];
    @synchronized(self) {

        FLDbLog(@"%@ <- %@", self.fileName, sql);
		if(sqlite3_exec(_sqlite, c_sql, NULL, NULL, nil)) {
			[self throwSqliteError:c_sql];
		}	

        FLDbLog(@"%@ -> DONE", self.fileName);
	}
}

- (BOOL) isOpen {
    BOOL isOpen = NO;
    @synchronized(self) {
        isOpen = _sqlite != nil;
    }
	return isOpen;
}

- (BOOL) openDatabase:(FLDatabaseOpenFlags) flags
{
	if(_sqlite != nil) {
        FLThrowErrorCode_v( 
            FLDatabaseErrorDomain,
            FLDatabaseErrorDatabaseAlreadyOpen, 
            @"Database is already open");
    }
	
    BOOL needsUpgrade = NO;
	@synchronized(self) {
		@try {
            if(sqlite3_open_v2([_filePath UTF8String], &_sqlite, flags, nil)) {
                [self throwSqliteError:nil];
            }
            
            _tables = [[NSMutableDictionary alloc] init];
            [self initializeVersioning];
            needsUpgrade = [self databaseNeedsUpgrade];
        }
        @catch(NSException* ex) {
            if(_sqlite) {
                [self closeDatabase];
            }
            
            @throw;
        }
    }
    
    return needsUpgrade;
}

- (void) closeDatabase  {
	if(_sqlite == nil) {
        FLThrowErrorCode_v( 
            FLDatabaseErrorDomain,
            FLDatabaseErrorDatabaseAlreadyOpen, 
            @"Database is already closed");
    }

	@synchronized(self) {
		if(sqlite3_close(_sqlite)) {
			[self throwSqliteError:nil];
		}
		
		_sqlite = nil;
        FLReleaseWithNil_(_tables);
	}
}

- (void) throwSqliteError:(const char*) sql {

	int errorCode = sqlite3_errcode(_sqlite);
	const char* c_message = sqlite3_errmsg(_sqlite);

	NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
	
	if(c_message) {
		NSString* msg = [NSString stringWithCString:c_message encoding:NSUTF8StringEncoding ];
		[userInfo setObject:msg forKey:FLDatabaseErrorMessageKey];

		[userInfo setObject:[NSString stringWithFormat:@"Database Error: %@ (%d) (%@)", FLDatabaseErrorToString(errorCode), errorCode, msg]
					 forKey:NSLocalizedDescriptionKey];
	}
	else {
		[userInfo setObject:[NSString stringWithFormat:@"Database Error: %@ (%d)", FLDatabaseErrorToString(errorCode), errorCode]
			         forKey:NSLocalizedDescriptionKey];
	}
	
	if(sql) {
		[userInfo setObject:[NSString stringWithCString:sql encoding:NSUTF8StringEncoding] forKey:FLDatabaseErrorFailedSqlKey];
	}
	
    NSError* error = [NSError errorWithDomain:FLDatabaseErrorDomain code:errorCode userInfo:userInfo];
    
    FLDbLog(@"%@ -> ERROR: %@", self.fileName, [error localizedDescription]);
    FLDbLogIf(sql != nil, @"\"%s\"", sql);

	FLThrowError_(error);
}

- (void) runQueryWithString:(NSString*) statementString
                    outRows:(NSArray**) outRows {
    [self runQueryOnTable:nil withString:statementString outRows:outRows];
}

- (void) executeTransaction:(void (^)()) block {

    @try {
        [self exec:@"BEGIN TRANSACTION;"];
        block();
        [self exec:@"COMMIT;"];
    }
    @catch(NSException* ex) {
        [self exec:@"ROLLBACK;"];
        @throw;
    } 
}


- (void) beginAsyncBlock:(void(^)(FLDatabase*)) asyncBlock
              errorBlock:(void(^)(FLDatabase*, NSError*)) errorBlock
{
    asyncBlock = autorelease_([asyncBlock copy]);
    errorBlock = autorelease_([errorBlock copy]);

    dispatch_async(
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
        ^{
            @try {
                if(asyncBlock) {
                    asyncBlock(self);
                }
            }
            @catch(NSException* ex) {
                if(errorBlock) {
                    errorBlock(self, ex.error); 
                }
            }
         });
}                       

- (void) executeSql:(FLSqlBuilder*) sql 
        rowResultBlock:(FLDatabaseStatementDidSelectRowBlock) rowResultBlock {
    
    FLSqlStatement* sqlStatement = [FLSqlStatement sqlStatement:self columnDecoder:nil];
	@try {
        BOOL stop = NO;
        @synchronized(self) {
            [sqlStatement prepareWithSql:sql];
            while(!stop && !sqlStatement.isDone) {
                NSDictionary* row = [sqlStatement step];
                if(row) {
                    if(rowResultBlock) {
                        rowResultBlock(row, &stop);
                    }
                }
            }
		}
    }
    @finally {
        [sqlStatement finalizeStatement];
    }
}

- (void) executeStatement:(FLDatabaseStatement*) statement {

    FLAssertNotNil_(statement);

    FLDecodeColumnObjectBlock decoder = nil;
    if(statement.table && self.columnDecoder) {
        decoder = ^ id (NSString* column, id object) {
            return self.columnDecoder(self, statement.table, [statement.table columnByName:column], object);
        };
    }

    FLSqlStatement* sqlStatement = [FLSqlStatement sqlStatement:self columnDecoder:decoder];
	@try {
    
        BOOL stop = NO;
        
        if(statement.prepare) {
            statement.prepare(&stop);
            if(stop) {
                return;
            }
        }
        
        if(statement.table) {
            [self createTableIfNeeded:statement.table];
        }
        
        @synchronized(self) {
            [sqlStatement prepareWithSql:statement];
            while(!stop && !sqlStatement.isDone) {
                NSDictionary* row = [sqlStatement step];
                if(row) {
                
                    if(statement.rowResultBlock) {
                        statement.rowResultBlock(row, &stop);
                    }
                    if(statement.objectResultBlock) {
                        FLAssertIsNotNil_v(statement.table, @"table is required in statement to decode object");
                        statement.objectResultBlock([statement.table objectForRow:row], &stop);
                    }
                }
            }
		}

        // must be outside of @synchronized lock.
        if(statement.finished) {
            statement.finished(nil);
        }
    }
    @catch(NSException* ex) {
        if(statement.finished) {
            statement.finished(ex.error);
        }
        
        @throw;
    }
    @finally {
        [sqlStatement finalizeStatement];
    }
}



@end






