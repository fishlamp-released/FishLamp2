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
#import "FLDatabase.h"
#import "FLAppInfo.h"
#import "FLSqlStatement.h"
#import "FLDispatch.h"
#import "FLDatabase+Introspection.h"

static NSString* kVersionId = nil;
static NSString* kVersion = nil;
static NSString* kName = nil;
static NSString* kEntry = nil;
static NSString* kWrittenDate = nil;
static NSString* kHistory = nil;
static NSString* s_version = nil;

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
@synthesize isOpen = _isOpen;
@synthesize delegate = _delegate;

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
        kVersionId = FLRetain(FLDatabaseNameEncode(@"version_id"));
        kVersion = FLRetain(FLDatabaseNameEncode(@"version"));
        kHistory = FLRetain(FLDatabaseNameEncode(@"history"));
        kName = FLRetain(FLDatabaseNameEncode(@"name"));
        kEntry = FLRetain(FLDatabaseNameEncode(@"entry"));
        kWrittenDate = FLRetain(FLDatabaseNameEncode(@"written_date"));

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
    return [self initWithFilePath:nil];
}

- (id) initWithFilePath:(NSString*) filePath {
    self = [super init];
	if(self) {
		_filePath = [filePath copy];
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

- (void) dealloc {
#if IOS
  	[[NSNotificationCenter defaultCenter] removeObserver:self];
#endif

	FLAssertIsNilWithComment(_sqlite, nil);
    
#if FL_MRC    
    [_filePath release];
    [super dealloc];
#endif    
}

- (void) deleteOnDisk {
    FLConfirm(self.isOpen == NO);

    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:&error];
    FLThrowIfError(FLAutorelease(error));
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
}

- (void) purgeMemoryIfPossible {
    sqlite3_release_memory(INT32_MAX);
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

- (void) addVersionTables {

    FLDatabaseTable* historyTable = [FLDatabaseTable databaseTableWithTableName:kHistory];
    
    [historyTable addColumn:[FLDatabaseColumn databaseColumnWithName:kName
        columnType:FLDatabaseTypeText 
        columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];

    [historyTable addColumn:[FLDatabaseColumn databaseColumnWithName:kEntry
        columnType:FLDatabaseTypeText 
        columnConstraints:nil]];

    [historyTable addColumn:[FLDatabaseColumn databaseColumnWithName:kWrittenDate
        columnType:FLDatabaseTypeDate
        columnConstraints:nil]];

	[self createTableIfNeeded:historyTable];

    FLDatabaseTable* versionTable = [FLDatabaseTable databaseTableWithTableName:kVersion];
    
    [versionTable addColumn:[FLDatabaseColumn databaseColumnWithName:kVersionId
            columnType:FLDatabaseTypeInteger 
            columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]
            ]];

    [versionTable addColumn:[FLDatabaseColumn databaseColumnWithName:kVersion
            columnType:SQLITE_TEXT 
            columnConstraints:nil
            ]];
	[self createTableIfNeeded:versionTable];

}


- (BOOL) openDatabase:(FLDatabaseOpenFlags) flags {
    
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
    
    [self sqliteOpen:flags]; 
    self.isOpen = YES;
    
    NSInteger tableCount = [self tableCount];
    
    [self addVersionTables];
    
    if(tableCount == 0) {
        [self writeDatabaseVersion:[[self class] currentRuntimeVersion]];
    }
    else {
        BOOL needsUpgrade = [self databaseNeedsUpgrade];
        
        if(needsUpgrade && tableCount > 0) {
            [self.delegate databaseVersionDidChange:self];
        }
        
        return needsUpgrade;
    }
    
    
    return NO;
}

- (BOOL) openDatabase {
    return [self openDatabase:FLDatabaseOpenFlagsDefault];
}

- (void) closeDatabase  {
    
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
    @try {
        [self execute:@"BEGIN TRANSACTION;"];
        if(block) block();
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
    
    rowResultBlock = FLCopyWithAutorelease(rowResultBlock);
    
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
}


- (FLDatabaseTable*) tableForName:(NSString*) name {

    NSString* className = FLDatabaseNameDecode(name);
    FLDatabaseTable* table = [_tables objectForKey:className];
    if(!table) {
        Class theClass = NSClassFromString(className);
        if(theClass) {
            table = [theClass sharedDatabaseTable];
        }
	}
    return table;
}

- (void) _createTableIfNotInDatabase:(FLDatabaseTable*) table {

	FLAssertIsNotNil(table);
	FLAssertIsNotNil(table.columns);
	FLAssertWithComment([self isOpen], @"Database isn't open");
	FLAssertWithComment([table.columns count] > 0, @"no columns in the table, bub");

    if(![self tableExists:table]) {
        [self execute:[table createTableSql]];
        for(NSArray* indexes in table.indexes.objectEnumerator) {
            for(FLDatabaseIndex* idx in indexes) {
                NSString* createIndex = [idx createIndexSqlForTableName:table.tableName];
                
                if(FLStringIsNotEmpty(createIndex)) {
                    [self execute:createIndex];
                }
            }
        }
        [self writeHistoryForTable:table entry:[table createTableSqlWithIndexes]];
    }
}

- (void) createTableIfNeeded:(FLDatabaseTable*) table  {
	
    if(![_tables objectForKey:table.decodedTableName]) {
        [self _createTableIfNotInDatabase:table];
        [_tables setObject:table forKey:table.decodedTableName];
    }
}

- (void) dropTable:(FLDatabaseTable*) table {
	[self dropTableByName:table.tableName];
}

- (BOOL) tableExists:(FLDatabaseTable*) table {
	return [self tableExistsByName:table.tableName];
}

- (NSUInteger) rowCountForTable:(FLDatabaseTable*) table {
	[self createTableIfNeeded:table];
	return [self rowCountForTableByName:table.tableName];
}

- (NSUInteger) rowCountForTableByName:(NSString*) table {
	
    __block NSUInteger count = 0;
    
    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    [sql appendFormat:@"SELECT COUNT(*) FROM %@", table];
    
    [self executeSql:sql rowResultBlock: ^(NSDictionary* row, BOOL* stop) {
        NSNumber* number = [row objectForKey:@"COUNT(*)"];
        if(number) {
            count = [number integerValue];
        }
    }];

    return count;
}

- (BOOL) tableExistsByName:(NSString*) tableName
{
	FLAssertStringIsNotEmpty(tableName);
    
    __block BOOL exists = NO;

    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    [sql appendFormat:@"SELECT name FROM sqlite_master WHERE name='%@'", tableName];

    [self executeSql:sql rowResultBlock:^(NSDictionary* row, BOOL* stop) {
        exists = FLStringsAreEqual([row objectForKey:@"name"], tableName);
        if(exists) {
            *stop = YES;
        }
    }];

    return exists;
}

- (void) dropTableByName:(NSString*) tableName {
	FLAssertStringIsNotEmpty(tableName);

	@try  {
		[self execute:[NSString stringWithFormat:@"DROP TABLE %@", tableName]];
	}
	@catch(NSException* ex) {
		if(!ex.error.isTableDoesNotExistError) {
			@throw;
		}
	}
	
	[_tables removeObjectForKey:tableName];
	[_tables removeObjectForKey:FLDatabaseNameDecode(tableName)];
}

- (void) _insertOrUpdateRowInTable:(NSString*) tableName
                               row:(NSDictionary*) row
                            action:(NSString*) action {

//    FLDatabaseTable* table = [[object class] sharedDatabaseTable];
//    [self createTableIfNeeded:table];

    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    sql.sqlString = action;
    [sql appendString:SQL_INTO andString:tableName];
    [sql appendInsertClauseForRow:row];

    [self executeSql:sql rowResultBlock:nil];
}

- (void) replaceRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row   {
	[self _insertOrUpdateRowInTable:tableName row:row action:@"REPLACE"];
}

- (void) insertRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row  {
	[self _insertOrUpdateRowInTable:tableName row:row action:@"INSERT"];
}

- (void) insertOrReplaceRowInTable:(NSString*) tableName row:(NSDictionary*) row {
	[self _insertOrUpdateRowInTable:tableName row:row action:@"INSERT OR REPLACE"];
}

- (void) runQueryOnTable:(FLDatabaseTable*) table
              withString:(NSString*) statementString
                 outRows:(NSArray**) outRows {
    
    NSMutableArray* result = [NSMutableArray array];

    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    [statement appendString:statementString];
    
    statement.rowResultBlock = ^(NSDictionary* row, BOOL* stop) {
        [result addObject:row];
    };
     
    [self executeStatement:statement];

    *outRows = FLRetain(result);
}

+ (void) setCurrentRuntimeVersion:(NSString*) version {
    FLSetObjectWithRetain(s_version, version);
}

+ (NSString*) currentRuntimeVersion {
    return s_version;
}

- (NSDictionary*) readHistoryForTable:(FLDatabaseTable*) table {
	NSArray* rows = [self execute:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@'", 
		kHistory,
		kName,
		table.tableName]];
		
	return rows.count == 1 ? rows.firstObject : nil;
}

- (NSString*) readDatabaseVersion {
    
    __block NSString* version = nil;
    
    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    [sql appendFormat:@"SELECT %@ FROM %@ WHERE %@=1",
            kVersion,
            kVersion,
            kVersionId];

    [self executeSql:sql rowResultBlock:^(NSDictionary* row, BOOL* stop) {
        version = [row objectForKey:kVersion];
        *stop = YES;
    }];

    return version;
}

- (void) writeDatabaseVersion:(NSString*) version {

    NSDictionary* newData = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:1], kVersionId,
            version, kVersion,
            nil
            ] ;

    [self insertOrReplaceRowInTable:kVersion row:newData];
}

- (BOOL) databaseNeedsUpgrade {
    
    NSString* version = [self readDatabaseVersion];
    if(FLStringIsNotEmpty(version)) {
        return FLStringsAreNotEqual( version, [FLDatabase currentRuntimeVersion]);
    }

    return YES;
}


- (void) writeHistoryForTable:(FLDatabaseTable*) table entry:(NSString*) entry {
	
    NSDictionary* row = [NSDictionary dictionaryWithObjectsAndKeys:table.tableName, kName,
                         entry, kEntry,
                         [NSDate date], kWrittenDate,
                         nil];
	[self insertOrReplaceRowInTable:kHistory row:row];
}


@end






