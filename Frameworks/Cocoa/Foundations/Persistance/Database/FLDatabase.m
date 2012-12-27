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

@interface FLDatabase ()
@property (readwrite, assign) sqlite3* sqlite3;
@property (readwrite, assign) BOOL isOpen;
@property (readwrite, strong, nonatomic) NSMutableDictionary* tables;
@end

@implementation FLDatabase

@synthesize sqlite3 = _sqlite;
@synthesize filePath = _filePath;
@synthesize columnDecoder = _columnDecoder;
@synthesize tables = _tables;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize isOpen = _isOpen;

static FLDatabaseColumnDecoder s_decoder = nil;
static int s_count = 0;

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

- (FLResult) dispatchBlock:(dispatch_block_t) block {
    return [[FLDefaultQueue dispatchBlock:block] waitUntilFinished];
}

- (FLResult) dispatchFifoBlock:(dispatch_block_t) block {
    return [[_dispatchQueue dispatchBlock:block] waitUntilFinished];
}

- (void) handleLowMemory:(id)sender {
	[self purgeMemoryIfPossible];
}

- (id) init {
    self = [super init];
    if(self)  {
		_sqlite = nil;
        self.columnDecoder = s_decoder;

        _dispatchQueue = [[FLDispatchQueue alloc] initWithLabel:[NSString stringWithFormat:@"com.fishlamp.queue.database-%d", ++s_count] 
            attr:DISPATCH_QUEUE_SERIAL];

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
    
#if FL_MRC    
    [_dispatchQueue release];
    [_filePath release];
    [super dealloc];
#endif    
}

- (void) deleteOnDisk {
	[self dispatchFifoBlock:^{
        NSError* error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:&error];
        FLThrowError(FLAutorelease(error));
    }];
}

- (BOOL) databaseFileExistsOnDisk {
	return [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
}

- (unsigned long long) databaseFileSize {
	unsigned long long size = 0;
	NSError* error = nil;
	[NSFileManager getFileSize:self.filePath outSize:&size outError:&error];
    if(error){
        FLThrowError(FLAutorelease(error));
    }

	return size;
}

- (void) cancelCurrentOperation {
    sqlite3_interrupt(self.sqlite3);
    
//	if(_sqlite) {
//		@synchronized(self) {
//		}
//	}
}

- (void) purgeMemoryIfPossible {
    [self dispatchFifoBlock:^{
        sqlite3_release_memory(INT32_MAX);
    }];
}

- (NSString*) fileName {
    return [self.filePath lastPathComponent];
}

//- (void) exec:(NSString*) sql {	
//    const char* c_sql = [sql UTF8String];
//    @synchronized(self) {
//
//        FLDbLog(@"%@ <- %@", self.fileName, sql);
//		if(sqlite3_exec(_sqlite, c_sql, NULL, NULL, nil)) {
//			[self throwSqliteError:c_sql];
//		}	
//
//        FLDbLog(@"%@ -> DONE", self.fileName);
//	}
//}

- (void) sqliteOpen:(FLDatabaseOpenFlags) flags {
    sqlite3* sqlite3 = self.sqlite3;
    
    if(sqlite3 != nil || self.isOpen) {
        FLThrowErrorCode_v( 
        FLDatabaseErrorDomain,
        FLDatabaseErrorDatabaseAlreadyOpen, 
        @"Database is already open");
    }
    
    @try {
        if(sqlite3_open_v2([_filePath UTF8String], &sqlite3, flags, nil)) {
            [self throwSqliteError:nil];
        }
    }
    @catch(NSException* ex) {
        if(sqlite3) {
            sqlite3_close(sqlite3);
        }
        self.tables = nil;
        @throw;
    }
    
    self.tables = [NSMutableDictionary dictionary];
    self.sqlite3 = sqlite3;
}

- (BOOL) openDatabase:(FLDatabaseOpenFlags) flags {
    
    __block BOOL needsUpgrade = NO;

    if(self.sqlite3 != nil || self.isOpen) {
        FLThrowErrorCode_v( 
        FLDatabaseErrorDomain,
        FLDatabaseErrorDatabaseAlreadyOpen, 
        @"Database is already open");
    }
    
	[self dispatchFifoBlock:^{ 
        [self sqliteOpen:flags]; 
    }];
    [self initializeVersioning];
    [self dispatchFifoBlock:^{
        needsUpgrade = [self databaseNeedsUpgrade];
    }];

    self.isOpen = YES;
           
    return needsUpgrade;
}

- (void) closeDatabase  {
    
    [self dispatchFifoBlock:^{
        sqlite3* sqlite3 = self.sqlite3;
        self.sqlite3 = nil;
    
        if(sqlite3 == nil) {
            FLThrowErrorCode_v( 
                FLDatabaseErrorDomain,
                FLDatabaseErrorDatabaseAlreadyOpen, 
                @"Database is already closed");
        }

        if(sqlite3_close(sqlite3)) {
            [self throwSqliteError:nil];
        }
        
        self.tables = nil;
    }];
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

	FLThrowError(error);
}

- (void) runQueryWithString:(NSString*) statementString
                    outRows:(NSArray**) outRows {
    [self runQueryOnTable:nil withString:statementString outRows:outRows];
}

- (void) executeTransaction:(dispatch_block_t) block {

    @try {
        [self execute:@"BEGIN TRANSACTION;"];
        [self dispatchFifoBlock:block];
        [self execute:@"COMMIT;"];
    }
    @catch(NSException* ex) {
        [self execute:@"ROLLBACK;"];
        @throw;
    } 
}

//- (void) beginAsyncBlock:(void(^)(FLDatabase*)) asyncBlock
//              errorBlock:(void(^)(FLDatabase*, NSError*)) errorBlock
//{
//    asyncBlock = FLAutorelease([asyncBlock copy]);
//    errorBlock = FLAutorelease([errorBlock copy]);
//
//    dispatch_async(
//        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//        ^{
//            @try {
//                if(asyncBlock) {
//                    asyncBlock(self);
//                }
//            }
//            @catch(NSException* ex) {
//                if(errorBlock) {
//                    errorBlock(self, ex.error); 
//                }
//            }
//         });
//}                       

- (void) executeSql:(FLSqlBuilder*) sql 
        rowResultBlock:(FLDatabaseStatementDidSelectRowBlock) rowResultBlock {
    
    rowResultBlock = FLAutoreleasedCopy(rowResultBlock);
    
    [self dispatchFifoBlock:^{
        FLSqlStatement* sqlStatement = [FLSqlStatement sqlStatement:self columnDecoder:nil];
        @try {
            BOOL stop = NO;
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
        @finally {
            [sqlStatement finalizeStatement];
        }
    }];
    
}

- (NSArray*) execute:(NSString*) sqlString {
    NSMutableArray* array = [NSMutableArray array];
    [self execute:sqlString rowResultBlock:^(NSDictionary *row, BOOL *stop) {
        [array addObject:row];
    }];
    
    return array;
}

- (void) execute:(NSString*) sqlString
  rowResultBlock:(FLDatabaseStatementDidSelectRowBlock) rowResultBlock {
 
    [self executeSql:[FLSqlBuilder sqlBuilderWithString:sqlString] rowResultBlock:rowResultBlock];
}               


- (void) executeStatement:(FLDatabaseStatement*) statement {
    
    [self dispatchFifoBlock:^{
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
    }];
}



@end






