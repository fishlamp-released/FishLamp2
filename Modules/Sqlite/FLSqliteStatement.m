//
//  FLSqliteStatementIterator.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSqliteStatement.h"
#import "FLGuid.h"
#import "NSError+Sqlite.h"
#import "FLSqliteDatabase.h"
#import "CocoaColor+FLExtras.h"

@implementation FLSqliteStatement

@synthesize database = _database;
@synthesize statement = _statement;
@synthesize stepValue = _stepValue;
@synthesize lastRow = _lastRow;
@synthesize columnDecoder = _columnDecoder;

- (id) initWithSqliteDatabase:(FLSqliteDatabase*) database {
	if((self = [super init])) {
		_database = database;
        self.columnDecoder = s_default_decoder;
	}
	return self;
}

+ (FLSqliteStatement*) sqliteStatement:(FLSqliteDatabase*) database {
	return FLReturnAutoreleased([[FLSqliteStatement alloc] initWithSqliteDatabase:database]);
}

- (void) prepareStatement:(NSString*) sql {
	FLAssertIsNotNil(_database);
	if(_database) {
        @synchronized(_database) {
            const char* sql_c = [sql UTF8String];
            if(sqlite3_prepare_v2(_database.sqlite3, sql_c, -1, &_statement, nil))
            {
                [_database throwSqliteError:sql_c];
            }
        }
    }
}

- (void) finalizeStatement {
	if(_statement) {
		sqlite3_finalize(_statement);
		_statement = nil;
	}
	
	FLReleaseWithNil(_lastRow);
}

- (void) dealloc {
	FLRelease(_lastRow);
	FLAssertIsNil(_statement);
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
				FLAssertStringIsNotEmpty(colName);
                
                FLSqliteType type = sqlite3_column_type(_statement, i);
				id data = nil;
				switch(type)
				{
					case SQLITE_INTEGER:
						data = [self integerForColumn:i];
						FLAssertIsNotNil(data);
					break;
					
					case SQLITE_FLOAT:
						data = [self doubleForColumn:i];
						FLAssertIsNotNil(data);
					break;
					
					case SQLITE_BLOB:
						data = [self blobForColumn:i];
						FLAssertIsNotNil(data);
					break;
					
					case SQLITE_NULL:
                        data = nil; // to be clear, we don't inflate to NSNULL
					break;
					
					case SQLITE_TEXT:
						data = [self textForColumn:i];
						FLAssertIsNotNil(data);
					break;
                    
                    default:
                        FLAssertFailed(@"Unknown data type from sqlite: %d", type);
                        break;
                }
			
				if(_columnDecoder) {
					_columnDecoder(colName, type, data, &data);
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
			FLAssertIsNotNil(_database);
			FLReleaseWithNil(_lastRow);
			
			_stepValue = sqlite3_step(_statement);
			switch(_stepValue) {
				case SQLITE_ROW:
					[self buildRow];
				break;

				case SQLITE_DONE:
					[self finalizeStatement];
				break;

				case SQLITE_BUSY:
				// start over. note we don't support transaction yet, but if we do it will need to be rolled back here
					[self resetStatement];
				break;

				case SQLITE_OK:
					FLAssertFailed(@"not expecting SQLITE_OK here");
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
@end

@implementation NSNumber (FLSqlite) 
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	switch(CFNumberGetType((__fl_bridge CFNumberRef) self)) {
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
+ (FLSqliteType) sqlType
{
//	switch(CFNumberGetType((CFNumberRef) self))
//	{
//		case kCFNumberCGFloatType: 
//		case kCFNumberDoubleType:
//		case kCFNumberFloatType:
//		case kCFNumberFloat32Type:
//		case kCFNumberFloat64Type:
//			return FLSqliteTypeFloat;
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
//			return FLSqliteTypeInteger;
//		break;
//	}
	
	return FLSqliteTypeFloat;
	
}
@end

@implementation NSString (FLSqlite) 
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindText:parameterIndex text:self];
}
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return string;
}
+ (FLSqliteType) sqlType {
	return FLSqliteTypeText;
}
@end

@implementation NSData (FLSqlite) 
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindBlob:parameterIndex data:self];
}
+ (FLSqliteType) sqlType {
	return FLSqliteTypeBlob;
}

@end

@implementation NSNull (FLSqlite)
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindNull:parameterIndex];
}
+ (FLSqliteType) sqlType {
	return FLSqliteTypeNull;
}

@end

@implementation NSDate (FLSqlite)
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindInt64:parameterIndex intValue:(sqlite3_int64)[self timeIntervalSinceReferenceDate]];
}
+ (FLSqliteType) sqlType {
	return FLSqliteTypeFloat;
}
@end

@implementation NSURL (SqlObjectDatabase) 
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return [NSURL URLWithString:string];
}
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindText:parameterIndex text:[self absoluteString]];
}
+ (FLSqliteType) sqlType {
	return FLSqliteTypeText;
}
@end

@implementation NSObject (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data {
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    FLAssertFailed(@"can't decode an object with a string");
    return nil;
}
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	if([self conformsToProtocol:@protocol(NSCoding)]) {
		[statement bindBlob:parameterIndex data:[NSKeyedArchiver archivedDataWithRootObject:self]];
	}
	else {
		// throw error?
	}
}
+ (FLSqliteType) sqlType {
	return [self conformsToProtocol:@protocol(NSCoding)] ? FLSqliteTypeBlob : FLSqliteTypeNone;
}
@end

//
//@implementation CocoaColor (FLSqlite) 
//- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex
//{
//	[statement bindText:parameterIndex text:[self toRgbString]];
//}
//+ (FLSqliteType) sqlType
//{
//	return FLSqliteTypeColor;
//}
//@end

#import "FLObjectDescriber.h"

FLSqliteColumnDecoder s_default_decoder = ^(NSString* columnName, 
                                            FLSqliteType sqlType, 
                                            id inObject, 
                                            id* outObject) {
    
	if(!inObject || !outObject) {
		return;
	}

    FLSqliteTable* table = [inObject sharedSqliteTable];
    if(!table) {
        return;
    }
	
	FLSqliteColumn* column = [table columnByName:columnName];
	if(!column) {
        return;
    }
    
    id newObject = inObject;
    
    switch(column.columnType) {
        case FLSqliteTypeNone:
        case FLSqliteTypeNull:
            newObject = nil;
            break;
            
        case FLSqliteTypeFloat:
        case FLSqliteTypeInteger: 
            FLCAssertIsNotNil(newObject);
            FLCAssert([newObject isKindOfClass:[NSNumber class]], @"expecting a number here");
        break;
        
        case FLSqliteTypeText:{
            FLCAssertIsType(inObject, NSString);
            FLObjectDescriber* objectDescriber = [[inObject class] sharedObjectDescriber];
            if(objectDescriber) {
                FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
                if(desc) {
                    newObject = [desc.propertyClass decodeObjectWithSqliteColumnString:inObject];
                }
            }
        }
        break;
			
        case FLSqliteTypeDate:
            switch(sqlType) {

                case FLSqliteTypeFloat:
                    FLCAssertIsType(inObject, NSNumber);
                    newObject = [NSDate dateWithTimeIntervalSinceReferenceDate:[inObject doubleValue]];
                    break;
                    
                case FLSqliteTypeInteger:
                    FLCAssertIsType(inObject, NSNumber);
                    newObject = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval) [inObject longLongValue]];
                    break;
                    
                default:
                    newObject = nil;
                    break;
            }
            
            FLCAssertIsNotNil(newObject);
            FLCAssert([newObject isKindOfClass:[NSDate class]], @"date deserialization failed");
        break;
			
        case FLSqliteTypeBlob:
            FLCAssertIsNotNil(newObject);
            FLCAssertIsType(newObject, NSData);
        break;
			           
        case FLSqliteTypeObject: {
            FLObjectDescriber* objectDescriber = [[inObject class] sharedObjectDescriber];
            if(objectDescriber) {
                FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
                if(desc) {
                    FLCAssertIsType(inObject, NSData);
                    newObject = [desc.propertyClass decodeObjectWithSqliteColumnData:inObject];
                }
            }
        }
        break;
    }
    
    *outObject = FLRetain(newObject);
};


