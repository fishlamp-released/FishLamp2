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
#import "FLDispatch.h"

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
//static int s_count = 0;

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

- (void) dispatchFifoBlock:(dispatch_block_t) block {
    FLDispatchSync(_dispatchQueue, block);
}

- (void) handleLowMemory:(id)sender {
	[self purgeMemoryIfPossible];
}

- (id) init {
    return [self initWithFilePath:nil];
}

- (id) initWithFilePath:(NSString*) filePath {
    self = [super init];
	if(self) {
		_filePath = [filePath copy];
		_sqlite = nil;
        self.columnDecoder = s_decoder;

        _dispatchQueue = FLRetain([FLFifoAsyncQueue fifoAsyncQueue]);

#if IOS
	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(handleLowMemory:)
		name: UIApplicationDidReceiveMemoryWarningNotification
		object: [UIApplication sharedApplication]];
#endif

	}
	
	return self;
}

- (void) dealloc {
#if IOS
  	[[NSNotificationCenter defaultCenter] removeObserver:self];
#endif

	FLAssertIsNilWithComment(_sqlite, nil);
    
    [_dispatchQueue releaseToPool];
    
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
        FLThrowIfError(FLAutorelease(error));
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
        FLThrowIfError(FLAutorelease(error));
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
        FLThrowErrorCodeWithComment( 
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
        FLThrowErrorCodeWithComment( 
        FLDatabaseErrorDomain,
        FLDatabaseErrorDatabaseAlreadyOpen, 
        @"Database is already open");
    }
    
        NSString* folderPath = [self.filePath stringByDeletingLastPathComponent];
        
        NSError* error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error) {
            FLLog(@"database open error %@", [error description]);
            // die if it's not "already exists error" 
        }
    
	[self dispatchFifoBlock:^{ 
        [self sqliteOpen:flags]; 
        self.isOpen = YES;
    }];
    
    [self initializeVersioning];
    needsUpgrade = [self databaseNeedsUpgrade];
    
    return needsUpgrade;
}

- (BOOL) openDatabase {
    return [self openDatabase:FLDatabaseOpenFlagsDefault];
}

- (void) closeDatabase  {
    
    [self dispatchFifoBlock:^{
        sqlite3* sqlite3 = self.sqlite3;
        self.sqlite3 = nil;
    
        if(sqlite3 == nil) {
            FLThrowErrorCodeWithComment( 
                FLDatabaseErrorDomain,
                FLDatabaseErrorDatabaseAlreadyOpen, 
                @"Database is already closed");
        }

        if(sqlite3_close(sqlite3)) {
            [self throwSqliteError:nil];
        }
        
        self.tables = nil;
        self.isOpen = NO;
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

	FLThrowIfError(error);
}

- (void) runQueryWithString:(NSString*) statementString
                    outRows:(NSArray**) outRows {
    [self runQueryOnTable:nil withString:statementString outRows:outRows];
}

- (void) executeTransaction:(dispatch_block_t) block {

    [self dispatchFifoBlock:^{
        @try {
            [self execute:@"BEGIN TRANSACTION;"];
            if(block) block();
            [self execute:@"COMMIT;"];
        }
        @catch(NSException* ex) {
            [self execute:@"ROLLBACK;"];
            @throw;
        } 
    }];
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
    
    rowResultBlock = FLCopyWithAutorelease(rowResultBlock);
    
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
    
    FLAssertNotNil(statement);

    FLDecodeColumnObjectBlock decoder = nil;
    if(statement.table && self.columnDecoder) {
        decoder = ^ id (NSString* column, id object) {
            return self.columnDecoder(self, statement.table, [statement.table columnByName:column], object);
        };
    }

    [self dispatchFifoBlock:^{
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
                        FLAssertIsNotNilWithComment(statement.table, @"table is required in statement to decode object");
                        statement.objectResultBlock([statement.table objectForRow:row], &stop);
                    }
                }
            }

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






