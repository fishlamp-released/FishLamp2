//
//  GtSqliteStatementIterator.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteStatement.h"
#import "GtGuid.h"
#import "NSError+Sqlite.h"
#import "GtSqliteDatabase.h"
#import "UIColor+More.h"

@implementation GtSqliteStatement

@synthesize database = m_database;
@synthesize statement = m_statement;
@synthesize stepValue = m_stepValue;
@synthesize lastRow = m_lastRow;
@synthesize columnDecoder = m_columnDecoder;

- (id) initWithSqliteDatabase:(GtSqliteDatabase*) database
{
	if((self = [super init]))
	{
		m_database = database;
	}
	return self;
}

+ (GtSqliteStatement*) sqliteStatement:(GtSqliteDatabase*) database
{
	return GtReturnAutoreleased([[GtSqliteStatement alloc] initWithSqliteDatabase:database]);
}

- (void) prepareStatement:(NSString*) sql
{
	GtAssertNotNil(m_database);
	if(m_database)
    {
        @synchronized(m_database) {
            const char* sql_c = [sql UTF8String];
            if(sqlite3_prepare_v2(m_database.sqlite3, sql_c, -1, &m_statement, nil))
            {
                [m_database throwSqliteError:sql_c];
            }
        }
    }
}

- (void) finalizeStatement
{
	if(m_statement)
	{
		sqlite3_finalize(m_statement);
		m_statement = nil;
	}
	
	GtReleaseWithNil(m_lastRow);
}

- (void) dealloc
{
	GtRelease(m_lastRow);
	GtAssertNil(m_statement);
	GtSuperDealloc();
}

- (void) buildRow
{
	int columnCount = sqlite3_column_count(m_statement);
	
	if(columnCount)
	{
		NSMutableDictionary* row = nil; 
		@try
		{
			for(int i = 0; i < columnCount; i++)
			{
                const char* c_colName = sqlite3_column_name(m_statement, i);
				NSString* colName = [NSString stringWithCString:c_colName encoding:NSUTF8StringEncoding];
				GtAssertIsValidString(colName);
                
                GtSqliteType type = sqlite3_column_type(m_statement, i);
				id data = nil;
				switch(type)
				{
					case SQLITE_INTEGER:
						data = [self integerForColumn:i];
						GtAssertNotNil(data);
					break;
					
					case SQLITE_FLOAT:
						data = [self doubleForColumn:i];
						GtAssertNotNil(data);
					break;
					
					case SQLITE_BLOB:
						data = [self blobForColumn:i];
						GtAssertNotNil(data);
					break;
					
					case SQLITE_NULL:
					break;
					
					case SQLITE_TEXT:
						data = [self textForColumn:i];
						GtAssertNotNil(data);
					break;
                    
                    default:
                        GtAssertFailed(@"Unknown data type from sqlite: %d", type);
                        break;
                }
			
				if(m_columnDecoder)
				{
					data = m_columnDecoder(colName, data, type);
				}
				
				if(data)
				{	
					if(!row)
					{
						row = [[NSMutableDictionary alloc] initWithCapacity:columnCount];
					}
				
					[row setObject:data forKey:colName];
				}
			}
			
			GtAssignObject(m_lastRow, row);
		}
		@finally
		{
			GtReleaseWithNil(row);
		}
	}
}

- (void) resetStatement
{
	sqlite3_reset(m_statement);
}

- (NSDictionary*) step
{
	@synchronized(m_database) {
		@try
		{
			GtAssertNotNil(m_database);
			GtReleaseWithNil(m_lastRow);
			
			m_stepValue = sqlite3_step(m_statement);
			switch(m_stepValue)
			{
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
					GtAssertFailed(@"not expecting SQLITE_OK here");
					break;
					
				default:
				case SQLITE_MISUSE:
				case SQLITE_ERROR:
					[m_database throwSqliteError:sqlite3_sql(m_statement)];
					break;
			} 
		}
		@catch(NSException* ex)
		{
			[self finalizeStatement];
			@throw;
		}
	}
	
	return m_lastRow;
}

- (BOOL) willStep
{
	return m_stepValue != SQLITE_DONE;
}

- (NSString*) textForColumn:(int) col
{
	NSString* outString = nil;
	const char* cstr = (const char*) sqlite3_column_text(m_statement, col);
	if(cstr)
	{
//#if GT_LEGACY_DB_ENCODING
//		NSString* originalString = GtReturnAutoreleased([[NSString alloc] initWithUTF8String:cstr]);
//		NSString* newString = [originalString stringByReplacingOccurrencesOfString:@"''" withString:@"'"];
//		
//		GtAssert(GtStringsAreEqual(originalString, newString), @"was decoded");
//		
//		outString = GtRetain(newString);
//		
//		GtRelease(originalString);
//#else
		outString = GtReturnAutoreleased([[NSString alloc] initWithUTF8String:cstr]);
//#endif 
	}
	
	return outString;
}

- (NSData*) blobForColumn:(int) col
{
	return [NSData dataWithBytes:sqlite3_column_blob(m_statement, col) 
													length:sqlite3_column_bytes(m_statement, col)];
}

- (NSNumber*) integerForColumn:(int) col
{
	long long intValue = sqlite3_column_int64(m_statement, col);
	if(intValue == 0)
	{
		return [NSNumber numberWithInt:(int)0];
	}
	else if(intValue >= INT32_MAX || intValue <= INT32_MIN)
	{
		return [NSNumber numberWithLongLong:intValue];
	}
	else if(intValue >= INT16_MAX || intValue <= INT16_MIN)
	{
		return [NSNumber numberWithLong:(long)intValue];
	}
	else if(intValue >= INT8_MAX || intValue <= INT8_MIN)
	{
		return [NSNumber numberWithShort:(short)intValue];
	}
	else
	{
		return [NSNumber numberWithChar:(char)intValue];
	}

	return nil;
}

- (NSNumber*) doubleForColumn:(int) col
{
	return [NSNumber numberWithDouble:sqlite3_column_double(m_statement, col)] ;
}

- (void) bindBlob:(NSUInteger) parameterIndex data:(NSData*) data
{
	if(!data || data.length == 0)
	{
		[self bindNull:parameterIndex];
	}
	else
	{
		if(sqlite3_bind_blob(m_statement, parameterIndex, data.bytes, data.length, SQLITE_TRANSIENT))
		{
			[m_database throwSqliteError:nil];
		}	
	}
}

- (void) bindZeroBlob:(NSUInteger) parameterIndex size:(int) size
{
	if(sqlite3_bind_zeroblob(m_statement, parameterIndex, size))
	{
		[m_database throwSqliteError:nil];
	}	
}

- (void) bindDouble:(NSUInteger) parameterIndex doubleValue:(double) aDouble
{
	if(sqlite3_bind_double(m_statement, parameterIndex, aDouble))
	{
		[m_database throwSqliteError:nil];
	}	
}

- (void) bindInt:(NSUInteger) parameterIndex intValue:(int) aInt
{
	if(sqlite3_bind_int(m_statement, parameterIndex, aInt))
	{
		[m_database throwSqliteError:nil];
	}	
}

- (void) bindInt64:(NSUInteger) parameterIndex intValue:(sqlite3_int64) aInt
{
	if(sqlite3_bind_int64(m_statement, parameterIndex, aInt))
	{
		[m_database throwSqliteError:nil];
	}	
}

- (void) bindNull:(NSUInteger) parameterIndex
{
	int result = sqlite3_bind_null(m_statement, parameterIndex);
	if(result)
	{
		[m_database throwSqliteError:nil];
	}	
}

- (void) bindText:(NSUInteger) parameterIndex text:(NSString*) text
{
	if(!text || text.length == 0)
	{
		[self bindNull:parameterIndex];
	}
	else
	{
		const char* utf8String = [text UTF8String];
		if(sqlite3_bind_text(m_statement, parameterIndex, utf8String, strlen(utf8String), SQLITE_TRANSIENT))
		{
			[m_database throwSqliteError:nil];
		}	
	}
}

- (int) bindParameterCount
{
	return sqlite3_bind_parameter_count(m_statement);
}

- (const char *) bindParameterName:(int) idx
{
	return sqlite3_bind_parameter_name(m_statement, idx);
}

- (int) bindParameterIndex:(const char*) zName
{
	return sqlite3_bind_parameter_index(m_statement, zName);
}

- (void) clearBindings
{
	if(sqlite3_clear_bindings(m_statement))
	{
		[m_database throwSqliteError:nil];
	}	
}

@end

@implementation NSObject (GtSqlite)

- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	if([self conformsToProtocol:@protocol(NSCoding)])
	{
		[statement bindBlob:parameterIndex data:[NSKeyedArchiver archivedDataWithRootObject:self]];
	}
	else
	{
		// throw error?
	}
}

+ (GtSqliteType) sqlType
{
	return [self conformsToProtocol:@protocol(NSCoding)] ? GtSqliteTypeBlob : GtSqliteTypeNone;
}

@end

@implementation NSNumber (GtSqlite) 
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	switch(CFNumberGetType((CFNumberRef) self))
	{
		case kCFNumberCGFloatType: 
		case kCFNumberDoubleType:
		case kCFNumberFloatType:
		case kCFNumberFloat32Type:
		case kCFNumberFloat64Type:
			[statement bindDouble:parameterIndex doubleValue:[self doubleValue]];
		break;
		
        case kCFNumberNSIntegerType:
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
			[statement bindInt:parameterIndex intValue:[self longValue]];
		break;
	}
}
+ (GtSqliteType) sqlType
{
//	switch(CFNumberGetType((CFNumberRef) self))
//	{
//		case kCFNumberCGFloatType: 
//		case kCFNumberDoubleType:
//		case kCFNumberFloatType:
//		case kCFNumberFloat32Type:
//		case kCFNumberFloat64Type:
//			return GtSqliteTypeFloat;
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
//			return GtSqliteTypeInteger;
//		break;
//	}
	
	return GtSqliteTypeFloat;
	
}
@end

@implementation NSString (GtSqlite) 
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	[statement bindText:parameterIndex text:self];
}
+ (GtSqliteType) sqlType
{
	return GtSqliteTypeText;
}
@end

@implementation NSData (GtSqlite) 
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	[statement bindBlob:parameterIndex data:self];
}
+ (GtSqliteType) sqlType
{
	return GtSqliteTypeBlob;
}

@end

@implementation NSNull (GtSqlite)
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	[statement bindNull:parameterIndex];
}
+ (GtSqliteType) sqlType
{
	return GtSqliteTypeNull;
}

@end

@implementation NSDate (GtSqlite)
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	[statement bindInt64:parameterIndex intValue:[self timeIntervalSinceReferenceDate]];
}
+ (GtSqliteType) sqlType
{
	return GtSqliteTypeFloat;
}
@end
//
//@implementation UIColor (GtSqlite) 
//- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
//{
//	[statement bindText:parameterIndex text:[self toRgbString]];
//}
//+ (GtSqliteType) sqlType
//{
//	return GtSqliteTypeColor;
//}
//@end



