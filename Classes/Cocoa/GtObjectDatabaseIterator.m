//
//  GtObjectDatabaseIterator.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectDatabaseIterator.h"
#import "GtObjectDatabase.h"
#import "GtSqliteColumn.h"
#import "GtCachedObjectHandler.h"
#import "GtObjectDescriber.h"
#import "GtBase64Encoding.h"
#import "UIColor+More.h"

@interface GtObjectDatabaseIterator ()

+ (id) _decodeColumnObject:(NSString*) columnName 
	object: (id) object 
	sqlType:(GtSqliteType) sqlType 
	objectDescriber:(GtObjectDescriber*) objectDescriber
	table:(GtSqliteTable*) table;
	
@end

@implementation GtObjectDatabaseIterator

@synthesize resultObjects = m_resultObjects;

- (id) initWithObjectDatabase:(GtObjectDatabase*) database
{
	if((self = [super initWithSqliteDatabase:database]))
	{
		m_objectDatabase = GtRetain(database);
	}
	
	return self;
}

+ (GtObjectDatabaseIterator*) objectDatabaseIterator:(GtObjectDatabase*) database
{
	return GtReturnAutoreleased([[GtObjectDatabaseIterator alloc] initWithObjectDatabase:database]);
}

- (void) dealloc
{
	GtRelease(m_resultObjects);
	GtRelease(m_objectDatabase);
	GtSuperDealloc();
}

- (BOOL) bindParametersForSql:(NSString*) inSql
	inputObject:(id) inputObject
	table:(GtSqliteTable*) table
{
	BOOL foundPrimaryKey = NO;
	
	NSMutableArray* dataToBind = [[NSMutableArray alloc] initWithCapacity:table.columns.count];
	
	NSMutableString* sql = GtReturnAutoreleased([inSql mutableCopy]);
	
	for(GtSqliteColumn* col in table.columns.objectEnumerator)
	{
		if(col.isPrimaryKey)
		{
			id data = [inputObject valueForKey:col.decodedColumnName];
			
			if(data)
			{	
				[dataToBind addObject:data];
				foundPrimaryKey = YES;
		
				if(dataToBind.count == 1) 
				{
					[sql appendFormat:@" %@=?", col.columnName];
				}
				else
				{
					[sql appendFormat:@" AND %@=?", col.columnName];
				}
			}
		}
	}
	
	if(!foundPrimaryKey)
	{
		for(GtSqliteColumn* col in table.columns.objectEnumerator)
		{
			id data = [inputObject valueForKey:col.decodedColumnName];
			
			if(data)
			{	
				[dataToBind addObject:data];
				
#if DEBUG		
				if(!col.isIndexed)
				{
					GtLog(@"WARNING!! Searching on non-indexed column for table: %@, column: %@", table.tableName, col.columnName);
				}
#endif			
				if(dataToBind.count == 1) 
				{
					[sql appendFormat:@" %@=?", col.columnName];
				}
				else
				{
					[sql appendFormat:@" AND %@=?", col.columnName];
				}
			
			}
		}
	}

	BOOL hasBoundData = dataToBind.count > 0;
	if(hasBoundData)
	{
		[self prepareStatement:sql];
	
		int parmIdx = 0;
		for(id data in dataToBind)
		{
			[data bindToStatement:self parameterIndex:++parmIdx];
		}
	}

	GtRelease(dataToBind);
	return hasBoundData;
}

- (void) updateObjectWithRowData:(id) object row:(NSDictionary*) row
{
	GtAssertNotNil(object);
	GtAssertNotNil(row);
	
	for(NSString* columnName in row)
	{
		id data = [row objectForKey:columnName];
		[object setValue:data forKey:GtSqliteNameDecode(columnName)];
	}
}

- (void) addResultObject:(id) object
{
	if(!m_resultObjects)
	{
		m_resultObjects = [[NSMutableArray alloc] init];
	}
	
	[m_resultObjects addObject:object];
}

- (void) selectRowsInTable:(GtSqliteTable*) table
	willPrepareBlock:(GtObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectRowBlock:(GtObjectDatabaseIteratorDidSelectRow) didSelectRow
	didFinishBlock:(GtBlock) didFinishBlock
{
	GtAssertNotNil(table);
	GtAssertNotNil(prepare);

	@try {
        @synchronized(m_objectDatabase) {
			[m_objectDatabase createTableIfNeeded:table];
			
			if(prepare())
			{
				while(self.willStep)
				{
					NSDictionary* row = [self step];
					if(row && didSelectRow && !didSelectRow(row))
                    {
                        break;
                    }
                }
			}
		}

        // must be outside of @synchronized lock.
        if(didFinishBlock)
        {
            didFinishBlock();
        }
    }
    @finally 
    {
        [self finalizeStatement];
    }
}

- (void) selectObjectsInTable:(GtSqliteTable*) table
	willPrepareBlock:(GtObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectObjectBlock:(GtObjectDatabaseIteratorDidSelectObject) didSelectObject
	didFinishBlock:(GtBlock) didFinishBlock
{
	GtAssertNotNil(table);
	GtAssertNotNil(prepare);

	Class objectClass = table.classRepresentedByTable;
	
	id<GtCachedObjectHandler> behavior = [objectClass cachedObjectHandler];
	GtObjectDescriber* describer = [objectClass sharedObjectDescriber];

	self.columnDecoder = ^(NSString* columnName, id object, GtSqliteType sqlType)
	{
		return [GtObjectDatabaseIterator _decodeColumnObject:columnName object:object sqlType:sqlType objectDescriber:describer table:table];
	};

    [self selectRowsInTable:table 
        willPrepareBlock:prepare 
        didSelectRowBlock:^(NSDictionary* row) 
        {
            id newObject = nil;
            @try
            {
                newObject = [[objectClass alloc] init];
                GtAssertNotNil(newObject);
                
                [self updateObjectWithRowData:newObject row:row];

                if(behavior && ![behavior didLoadObjectFromDatabaseCache:newObject])
                {
                    [m_objectDatabase deleteObject:newObject];
                    GtReleaseWithNil(newObject);
                }
                
                if(newObject && didSelectObject && !didSelectObject(newObject))
                {	
                    return NO;
                }
            }
            @finally
            {
                GtRelease(newObject);
            }
            
            return YES;
        }
        didFinishBlock:didFinishBlock];
}

+ (id) _decodeColumnObject:(NSString*) columnName 
	object: (id) object 
	sqlType:(GtSqliteType) sqlType 
	objectDescriber:(GtObjectDescriber*) objectDescriber
	table:(GtSqliteTable*) table
{
	GtAssertNotNil(table);
	
	if(!object)
	{
		return nil;
	}
	
	GtSqliteColumn* column = [table columnByName:columnName];
	if(column)
	{
		switch(column.columnType)
		{
            case GtSqliteTypeNone:
            case GtSqliteTypeNull:
                return nil;
                break;
                
			case GtSqliteTypeFloat:
			case GtSqliteTypeInteger:
            {
                static NSNumberFormatter* s_numberFormatter = nil;
                if(!s_numberFormatter)
                {
                    s_numberFormatter = [[NSNumberFormatter alloc] init];
                }			
				switch(sqlType)
				{
#if GT_LEGACY_DB_ENCODING
					case GtSqliteTypeText:
						GtAssertIsExpectedType(object, NSString);
						object = [s_numberFormatter numberFromString:object];
						break;
#endif					
					case GtSqliteTypeInteger:
					case GtSqliteTypeFloat:
						// already what we expect.
						GtAssertIsExpectedType(object, NSNumber);
						break;
						
					default:
						GtAssertFailed(@"unexpected type: %d", sqlType);
						break;
				}
				GtAssertNotNil(object);
				GtAssert([object isKindOfClass:[NSNumber class]], @"expecting a number here");
            }
			break;
			
			case GtSqliteTypeText:
				GtAssertIsExpectedType(object, NSString);
				// already what we expect.
			break;
			
			case GtSqliteTypeDate:
				switch(sqlType)
				{
#if GT_LEGACY_DB_ENCODING
					case GtSqliteTypeText:
						GtAssertIsExpectedType(object, NSString);
						object = [NSDate dateWithTimeIntervalSinceReferenceDate:[object doubleValue]];
						break;
#endif						
					case GtSqliteTypeFloat:
						GtAssertIsExpectedType(object, NSNumber);
						object = [NSDate dateWithTimeIntervalSinceReferenceDate:[object doubleValue]];
						break;
						
					case GtSqliteTypeInteger:
						GtAssertIsExpectedType(object, NSNumber);
						object = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval) [object longLongValue]];
						break;
						
					default:
						//GtAssertFailed(@"unexpected type: %d", sqlType);
						object = nil;
						break;
				}
				
				GtAssertNotNil(object);
				GtAssert([object isKindOfClass:[NSDate class]], @"date deserialization failed");
			break;
			
			case GtSqliteTypeBlob:
				GtAssert([object isKindOfClass:[NSObject class]], @"expecting NSData");
				switch(sqlType)
				{
#if GT_LEGACY_DB_ENCODING
					case GtSqliteTypeText:
						GtAssertIsExpectedType(object, NSString);
						[NSData base64DecodeString:object outData:&object];
						GtAutorelease(object);
						
#if TRACE
						GtLog(@"converted base64encoded object");
#endif                        

						break;
#endif					
					case GtSqliteTypeBlob:
						GtAssertIsExpectedType(object, NSData);
						// already what we expected.
						break;
						
					default:
						GtAssertFailed(@"unexpected type: %d", sqlType);
						break;
					
				}
				GtAssertNotNil(object);
			break;
			
//			case GtDataTypePoint:
//			case GtDataTypeRect:
//			case GtDataTypeSize:
//			case GtDataTypeValue:
			case GtSqliteTypeObject:
			{
				GtPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
				switch(sqlType)
				{

#if GT_LEGACY_DB_ENCODING
					case GtSqliteTypeText:
					{
						NSData* decodedData = nil;
						GtAssertIsExpectedType(object, NSString);
					
						@try
						{
							if([object length] > 0)
							{
								[NSData base64DecodeString:object outData:&decodedData];
								
								object = [desc.propertyClass decodeObjectWithSqliteColumnData:decodedData];
//								
//								object = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
								
#if TRACE
								GtLog(@"converted base64encoded object");
#endif                                
							}
							else 
							{
								object = nil;
							}
						}
						@finally
						{
							 GtRelease(decodedData);
						}
					}
					
					break;
#endif					
					case GtSqliteTypeBlob:
						GtAssertIsExpectedType(object, NSData);
//							object = [NSKeyedUnarchiver unarchiveObjectWithData:object];
						object = [desc.propertyClass decodeObjectWithSqliteColumnData:object];

					break;
			
					default:
						GtAssertFailed(@"unexpected type: %d", sqlType);
					break;
			
				}
			}
			break;
			

				
		}
	}
	return object;
}


@end

@implementation NSObject (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data
{
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end

#if IOS
@implementation UIImage (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data
{
	return [UIImage imageWithData:data];
}
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex
{
	NSData* data = UIImageJPEGRepresentation(self, 1.0f);
	[data bindToStatement:statement parameterIndex:parameterIndex];
}
+ (GtSqliteType) sqlType
{
	return GtSqliteTypeObject;
}
@end
#endif
