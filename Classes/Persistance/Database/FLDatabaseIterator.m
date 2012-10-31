//
//  FLDatabaseIteratorIterator.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDatabaseIterator.h"
#import "FLGuid.h"
#import "FLDatabaseErrors.h"
#import "FLDatabase.h"
#import "FLColor+FLExtras.h"
#import "FLDatabase.h"
#import "FLDatabase_Internal.h"

@interface FLDatabaseIterator ()
@property (readwrite, assign, nonatomic) sqlite3_stmt* statement;
@property (readwrite, strong, nonatomic) FLDatabase* database;
@property (readwrite, strong, nonatomic) FLDatabaseTable* table;
@property (readwrite, assign, nonatomic) NSInteger stepValue;
// set to database's by default.
@property (readwrite, assign, nonatomic) FLDatabaseColumnDecoder columnDecoder;

@property (readonly, assign, nonatomic) BOOL willStep;
- (NSDictionary*) step;
- (void) finalizeStatement; // automatically called when done stepping. be sure to call this if you terminate early.

@end

@implementation FLDatabaseIterator

@synthesize database = _database;
@synthesize statement = _statement;
@synthesize stepValue = _stepValue;
@synthesize lastRow = _lastRow;
@synthesize columnDecoder = _columnDecoder;
@synthesize table = _table;

- (id) initWithDatabase:(FLDatabase*) database
                        table:(FLDatabaseTable*) table {
	if((self = [super init])) {
		self.database = database;
        self.table = table;
        self.columnDecoder = database.columnDecoder;
   }
	return self;
}

+ (id) databaseIterator:(FLDatabase*) database  table:(FLDatabaseTable*) table {
	return FLReturnAutoreleased([[[self class] alloc] initWithDatabase:database table:table]);
}

- (void) prepareStatement{
	FLAssertIsNotNil_v(_database, nil);

    const char* sql_c = [self.sqlString UTF8String];
    if(sqlite3_prepare_v2(_database.sqlite3, sql_c, -1, &_statement, nil)) {
        [_database throwSqliteError:sql_c];
    }
    
    if(self.objects) {
        int parmIdx = 0;
        for(id data in self.objects) {
            [data bindToStatement:self parameterIndex:++parmIdx];
        }
    }
    
    [self setFinishedPreparing];
}

- (void) finalizeStatement {


	if(_statement) {
        FLDbLog(@"%@ -> DONE", self.database.fileName);
		sqlite3_finalize(_statement);
		_statement = nil;
	}
	
	FLReleaseWithNil(_lastRow);
    FLReleaseWithNil(_database);
    FLReleaseWithNil(_table);
}

- (void) dealloc {
    FLRelease(_database);
    FLRelease(_table);
	FLRelease(_lastRow);
	FLAssertIsNil_(_statement);
	FLSuperDealloc();
}

- (void) buildRow {
	int columnCount = sqlite3_column_count(_statement);
	
	if(columnCount) {
		NSMutableDictionary* row = nil; 
		@try {
			for(int i = 0; i < columnCount; i++) {
                const char* c_colName = sqlite3_column_name(_statement, i);
				NSString* colName = [NSString stringWithCString:c_colName encoding:NSUTF8StringEncoding];
				FLAssertStringIsNotEmpty_v(colName, nil);
                
                FLDatabaseType type = sqlite3_column_type(_statement, i);
				id data = nil;
				switch(type)
				{
					case SQLITE_INTEGER:
						data = [self integerForColumn:i];
						FLAssertIsNotNil_(data);
					break;
					
					case SQLITE_FLOAT:
						data = [self doubleForColumn:i];
						FLAssertIsNotNil_(data);
					break;
					
					case SQLITE_BLOB:
						data = [self blobForColumn:i];
						FLAssertIsNotNil_(data);
					break;
					
					case SQLITE_NULL:
                        data = nil; // to be clear, we don't inflate to NSNULL
					break;
					
					case SQLITE_TEXT:
						data = [self textForColumn:i];
						FLAssertIsNotNil_(data);
					break;
                    
                    default:
                        FLAssertFailed_v(@"Unknown data type from sqlite: %d", type);
                        break;
                }
			
            	if(data && _columnDecoder && _table) {
                    FLDatabaseColumn* column = [_table columnByName:colName];
                    if(column) {
                        data = _columnDecoder(_database, _table, column, data);
                    }
                }

				if(data) {
					if(!row) {
						row = [[NSMutableDictionary alloc] initWithCapacity:columnCount];
					}
				
					[row setObject:data forKey:colName];
				}
			}
			
			FLAssignObject(_lastRow, row);
		}
		@finally {
			FLReleaseWithNil(row);
		}
	}
}

- (void) resetStatement {
	sqlite3_reset(_statement);
}

- (NSDictionary*) step {
	@synchronized(_database) {
		@try
		{
            if(!_statement) {
                if(_table) {
                    [self.database createTableIfNeeded:_table];
                }

                [self prepareStatement];

                FLDbLog(@"%@ <- \"%s\"", self.database.fileName, sqlite3_sql(_statement));
            }
        
			FLAssertIsNotNil_(_database);
			FLReleaseWithNil(_lastRow);
			
			_stepValue = sqlite3_step(_statement);
			switch(_stepValue) {
				case SQLITE_ROW:
					[self buildRow];

                FLDbLog(@"%@ -> %@", self.database.fileName, [_lastRow description]);
				break;

				case SQLITE_DONE:
					[self finalizeStatement];
				break;

				case SQLITE_BUSY:
				// start over. note we don't support transaction yet, but if we do it will need to be rolled back here
					[self resetStatement];
				break;

				case SQLITE_OK:
					FLAssertFailed_v(@"not expecting SQLITE_OK here");
					break;
					
				default:
				case SQLITE_MISUSE:
				case SQLITE_ERROR:
					[_database throwSqliteError:sqlite3_sql(_statement)];
					break;
			} 
		}
		@catch(NSException* ex) {
			[self finalizeStatement];
			@throw;
		}
	}
	
	return _lastRow;
}

- (BOOL) willStep {
	return _stepValue != SQLITE_DONE;
}

- (NSString*) textForColumn:(int) col {
	NSString* outString = nil;
	const char* cstr = (const char*) sqlite3_column_text(_statement, col);
	if(cstr) {
		outString = FLReturnAutoreleased([[NSString alloc] initWithUTF8String:cstr]);
	}
	
	return outString;
}

- (NSData*) blobForColumn:(int) col {
	return [NSData dataWithBytes:sqlite3_column_blob(_statement, col) 
													length:sqlite3_column_bytes(_statement, col)];
}

- (NSNumber*) integerForColumn:(int) col {
	long long intValue = sqlite3_column_int64(_statement, col);
	if(intValue == 0) {
		return [NSNumber numberWithInt:(int)0];
	}
	else if(intValue >= INT32_MAX || intValue <= INT32_MIN) {
		return [NSNumber numberWithLongLong:intValue];
	}
	else if(intValue >= INT16_MAX || intValue <= INT16_MIN) {
		return [NSNumber numberWithLong:(long)intValue];
	}
	else if(intValue >= INT8_MAX || intValue <= INT8_MIN) {
		return [NSNumber numberWithShort:(short)intValue];
	}
	else {
		return [NSNumber numberWithChar:(char)intValue];
	}

	return nil;
}

- (NSNumber*) doubleForColumn:(int) col {
	return [NSNumber numberWithDouble:sqlite3_column_double(_statement, col)] ;
}

- (void) bindBlob:(int) parameterIndex data:(NSData*) data {
	if(!data || data.length == 0) {
		[self bindNull:parameterIndex];
	}
	else {
		if(sqlite3_bind_blob(_statement, parameterIndex, data.bytes, (int) data.length, SQLITE_TRANSIENT)) {
			[_database throwSqliteError:nil];
		}	
	}
}

- (void) bindZeroBlob:(int) parameterIndex size:(int) size {
	if(sqlite3_bind_zeroblob(_statement, parameterIndex, size)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindDouble:(int) parameterIndex doubleValue:(double) aDouble {
	if(sqlite3_bind_double(_statement, parameterIndex, aDouble)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindInt:(int) parameterIndex intValue:(int) aInt {
	if(sqlite3_bind_int(_statement, parameterIndex, aInt)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindInt64:(int) parameterIndex intValue:(sqlite3_int64) aInt {
	if(sqlite3_bind_int64(_statement, parameterIndex, aInt)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindNull:(int) parameterIndex {
	int result = sqlite3_bind_null(_statement, parameterIndex);
	if(result) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindText:(int) parameterIndex text:(NSString*) text
{
	if(!text || text.length == 0) {
		[self bindNull:parameterIndex];
	}
	else {
		const char* utf8String = [text UTF8String];
		if(sqlite3_bind_text(_statement, parameterIndex, utf8String, (int) strlen(utf8String), SQLITE_TRANSIENT)) {
			[_database throwSqliteError:nil];
		}	
	}
}

- (int) bindParameterCount {
	return sqlite3_bind_parameter_count(_statement);
}

- (const char *) bindParameterName:(int) idx {
	return sqlite3_bind_parameter_name(_statement, idx);
}

- (int) bindParameterIndex:(const char*) zName {
	return sqlite3_bind_parameter_index(_statement, zName);
}

- (void) clearBindings {
	if(sqlite3_clear_bindings(_statement)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) execute:(void (^)(NSDictionary* row, BOOL* stop)) resultRow
          failed:(void (^)(NSError* ex)) failed {

	@try {
        
        BOOL stop = NO;
        while(!stop && self.willStep) {
            NSDictionary* row = [self step];
            if(row && resultRow) {
                resultRow(row, &stop);
            }
		}
    }
    @catch(NSException* ex) {
        if(failed) {
            failed(ex.error);
        }
        @throw;
    }
    @finally {
        [self finalizeStatement];
    }
}
- (void) execute {
    [self execute:nil failed:nil];
}


- (void) execute:(void (^)(NSDictionary* row, BOOL* stop)) resultRow {
    [self execute:resultRow failed:nil];
}

- (void) selectRows:(void (^)(BOOL* stop)) prepareStatement
       didSelectRow:(void (^)(NSDictionary* row, BOOL* stop)) didSelectRow
          didFinish:(void (^)()) didFinish
{
	FLAssertIsNotNil_(self.table);

    FLAssertIsNotNil_(prepareStatement);
    FLAssertIsNotNil_(didSelectRow);
    FLAssertIsNotNil_(didFinish);

	@try {
        
        BOOL stop = NO;
        @synchronized(self.database) {
			prepareStatement(&stop);
            while(!stop && self.willStep) {
                NSDictionary* row = [self step];
                if(row) {
                    didSelectRow(row, &stop);
                }
            }
		}

        // must be outside of @synchronized lock.
        didFinish();
    }
    @finally {
        [self finalizeStatement];
    }

}

- (NSDictionary*) filterColumnsForObject:(id) object
                                  filter:(void (^)(FLDatabaseColumn* column, BOOL* useIt, BOOL* cancel)) filter
{
    NSMutableDictionary* values = nil;
    
    FLDatabaseTable* table = self.table;
    BOOL cancel = NO;

	for(FLDatabaseColumn* col in table.columns.objectEnumerator) {
        BOOL useIt = NO;
        filter(col, &useIt, &cancel);
        if(cancel) {
            return nil;
        }
        if(useIt) {
        
            id data = [object valueForKey:col.decodedColumnName];
			
			if(data) {
                if(!values) {
                    values = [NSMutableDictionary dictionaryWithCapacity:table.columns.count];
                }
            
                [values setObject:data forKey:col.columnName];
			}
		}
	}

    return values;
}



//- (BOOL) bindAndPrepareStatementForSelect:(NSString*) sqlStatement forObject:(id) object {
//	
//    BOOL foundPrimaryKey = NO;
//    
//    FLDatabaseTable* table = self.table;
//	
//	NSMutableArray* objects = [[NSMutableArray alloc] initWithCapacity:table.columns.count];
//	
//	NSMutableString* sql = FLReturnAutoreleased([sqlStatement mutableCopy]);
//	
//	for(FLDatabaseColumn* col in table.columns.objectEnumerator) {
//		if(col.isPrimaryKey) {
//			id data = [object valueForKey:col.decodedColumnName];
//			
//			if(data) {	
//				[objects addObject:data];
//				foundPrimaryKey = YES;
//		
//				if(objects.count == 1)  {
//					[sql appendFormat:@" %@=?", col.columnName];
//				}
//				else {
//					[sql appendFormat:@" AND %@=?", col.columnName];
//				}
//			}
//		}
//	}
//	
//	if(!foundPrimaryKey) {
//		for(FLDatabaseColumn* col in table.columns.objectEnumerator) {
//			id data = [object valueForKey:col.decodedColumnName];
//			
//			if(data) {	
//				[objects addObject:data];
//				
//#if DEBUG		
//				if(!col.isIndexed) {
//					FLDebugLog(@"WARNING!! Searching on non-indexed column for table: %@, column: %@", table.tableName, col.columnName);
//				}
//#endif			
//				if(objects.count == 1)  {
//					[sql appendFormat:@" %@=?", col.columnName];
//				}
//				else {
//					[sql appendFormat:@" AND %@=?", col.columnName];
//				}
//			
//			}
//		}
//	}
//
//	BOOL hasBoundData = objects.count > 0;
//	if(hasBoundData) {
//		[self prepareStatement:sql];
//	
//		int parmIdx = 0;
//		for(id data in objects) {
//			[data bindToStatement:self parameterIndex:++parmIdx];
//		}
//	}
//
//	FLRelease(objects);
//    
//    // return NO if nothing to bind against. May or may not be an error, depending on context.
//    return hasBoundData;
//}

- (void) bindAndPrepareStatementForWrite:(NSString *)sqlStatement forObject:(id) object {

    int idx = 1;
    for(FLDatabaseColumn* column in self.table.columns.objectEnumerator)
    {
        id dataToSave = [object valueForKey:column.decodedColumnName];
                                        
        if(dataToSave) {
            [dataToSave bindToStatement:self parameterIndex:idx];
        }
        else {
            [self bindNull:idx];
        }
        
        ++idx;
    }


}



- (void) selectObjects:(void (^)(BOOL* stop)) prepareStatement
       didSelectObject:(void (^)(id object, BOOL* stop)) didSelectObject
             didFinish:(void (^)()) didFinishBlock {
    
	FLAssertIsNotNil_(self.table);
	FLAssertIsNotNil_(prepareStatement);

	Class objectClass = self.table.classRepresentedByTable;
	
    [self selectRows:prepareStatement
        didSelectRow:^(NSDictionary* row, BOOL* stop)  {
            id newObject = nil;
            @try {
                newObject = [[objectClass alloc] init];
                FLAssertIsNotNil_(newObject);
                
                for(NSString* columnName in row) {
                    id data = [row objectForKey:columnName];
                    if(data && ![data isEqual:[NSNull null]]) {
                        [newObject setValue:data forKey:FLDatabaseNameDecode(columnName)];
                    }
                }
                
//                if(behavior && ![behavior didLoadObjectFromDatabaseCache:newObject]) {
//                    [_objectDatabase deleteObject:newObject];
//                    FLReleaseWithNil(newObject);
//                }
//                
                if(newObject) {
                    didSelectObject(newObject, stop);
                }
            }
            @finally {
                FLRelease(newObject);
            }
        }
        didFinish:didFinishBlock];
}

@end

@implementation NSNumber (FLDatabaseIterator)
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	
    switch(CFNumberGetType(FLBridge(CFNumberRef, self))) {
		case kCFNumberCGFloatType: 
		case kCFNumberDoubleType:
		case kCFNumberFloatType:
		case kCFNumberFloat32Type:
		case kCFNumberFloat64Type:
			[statement bindDouble:parameterIndex doubleValue:[self doubleValue]];
		break;
		
		case kCFNumberSInt64Type:
		case kCFNumberLongLongType:
			[statement bindInt64:parameterIndex intValue:[self longLongValue]];
		break;
		
		case kCFNumberCFIndexType:
		case kCFNumberCharType:
		case kCFNumberShortType:
		case kCFNumberIntType:
		case kCFNumberLongType:
		case kCFNumberSInt8Type:
		case kCFNumberSInt16Type:
		case kCFNumberSInt32Type:
        case kCFNumberNSIntegerType:
			[statement bindInt:parameterIndex intValue:[self intValue]];
		break;
	}
}
+ (FLDatabaseType) sqlType
{
//	switch(CFNumberGetType((CFNumberRef) self))
//	{
//		case kCFNumberCGFloatType: 
//		case kCFNumberDoubleType:
//		case kCFNumberFloatType:
//		case kCFNumberFloat32Type:
//		case kCFNumberFloat64Type:
//			return FLDatabaseTypeFloat;
//		break;
//		
//		case kCFNumberSInt64Type:
//		case kCFNumberLongLongType:
//		case kCFNumberCFIndexType:
//		case kCFNumberCharType:
//		case kCFNumberShortType:
//		case kCFNumberIntType:
//		case kCFNumberLongType:
//		case kCFNumberSInt8Type:
//		case kCFNumberSInt16Type:
//		case kCFNumberSInt32Type:
//			return FLDatabaseTypeInteger;
//		break;
//	}
	
	return FLDatabaseTypeFloat;
	
}
@end

@implementation NSString (FLDatabaseIterator) 
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	[statement bindText:parameterIndex text:self];
}
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return string;
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeText;
}
@end

@implementation NSData (FLDatabaseIterator) 
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	[statement bindBlob:parameterIndex data:self];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeBlob;
}

@end

@implementation NSNull (FLDatabaseIterator)
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	[statement bindNull:parameterIndex];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeNull;
}

@end

@implementation NSDate (FLDatabaseIterator)
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	[statement bindInt64:parameterIndex intValue:(sqlite3_int64)[self timeIntervalSinceReferenceDate]];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeFloat;
}
@end

@implementation NSURL (SqlObjectDatabase) 
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return [NSURL URLWithString:string];
}
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	[statement bindText:parameterIndex text:[self absoluteString]];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeText;
}
@end

@implementation NSObject (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data {
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    FLAssertFailed_v(@"can't decode an object with a string");
    return nil;
}
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	if([self conformsToProtocol:@protocol(NSCoding)]) {
		[statement bindBlob:parameterIndex data:[NSKeyedArchiver archivedDataWithRootObject:self]];
	}
	else {
		// throw error?
	}
}
+ (FLDatabaseType) sqlType {
	return [self conformsToProtocol:@protocol(NSCoding)] ? FLDatabaseTypeBlob : FLDatabaseTypeNone;
}
@end

//
//@implementation FLColor (FLDatabaseIterator) 
//- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex
//{
//	[statement bindText:parameterIndex text:[self toRgbString]];
//}
//+ (FLDatabaseType) sqlType
//{
//	return FLDatabaseTypeColor;
//}
//@end

#import "FLObjectDescriber.h"



