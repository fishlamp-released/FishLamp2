//
//  FLObjectDatabaseIterator.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLObjectDatabaseIterator.h"
#import "FLObjectDatabase.h"
#import "FLSqliteColumn.h"
#import "FLCachedObjectHandler.h"
#import "FLObjectDescriber.h"
#import "FLBase64Encoding.h"
#import "CocoaColor+FLExtras.h"
#import "FLObjectDatabaseEncoding.h"

@implementation FLObjectDatabaseIterator

@synthesize resultObjects = _resultObjects;

- (id) initWithObjectDatabase:(FLObjectDatabase*) database
{
	if((self = [super initWithSqliteDatabase:database]))
	{
		_objectDatabase = FLReturnRetained(database);
	}
	
	return self;
}

+ (FLObjectDatabaseIterator*) objectDatabaseIterator:(FLObjectDatabase*) database
{
	return FLReturnAutoreleased([[FLObjectDatabaseIterator alloc] initWithObjectDatabase:database]);
}

- (void) dealloc
{
	FLRelease(_resultObjects);
	FLRelease(_objectDatabase);
	FLSuperDealloc();
}

- (BOOL) bindParametersForSql:(NSString*) inSql
	inputObject:(id) inputObject
	table:(FLSqliteTable*) table
{
	BOOL foundPrimaryKey = NO;
	
	NSMutableArray* dataToBind = [[NSMutableArray alloc] initWithCapacity:table.columns.count];
	
	NSMutableString* sql = FLReturnAutoreleased([inSql mutableCopy]);
	
	for(FLSqliteColumn* col in table.columns.objectEnumerator)
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
		for(FLSqliteColumn* col in table.columns.objectEnumerator)
		{
			id data = [inputObject valueForKey:col.decodedColumnName];
			
			if(data)
			{	
				[dataToBind addObject:data];
				
#if DEBUG		
				if(!col.isIndexed)
				{
					FLDebugLog(@"WARNING!! Searching on non-indexed column for table: %@, column: %@", table.tableName, col.columnName);
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

	FLRelease(dataToBind);
	return hasBoundData;
}

- (void) updateObjectWithRowData:(id) object row:(NSDictionary*) row
{
	FLAssertIsNotNil(object);
	FLAssertIsNotNil(row);
	
	for(NSString* columnName in row)
	{
		id data = [row objectForKey:columnName];
		[object setValue:data forKey:FLSqliteNameDecode(columnName)];
	}
}

- (void) addResultObject:(id) object
{
	if(!_resultObjects)
	{
		_resultObjects = [[NSMutableArray alloc] init];
	}
	
	[_resultObjects addObject:object];
}

- (void) selectRowsInTable:(FLSqliteTable*) table
	willPrepareBlock:(FLObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectRowBlock:(FLObjectDatabaseIteratorDidSelectRow) didSelectRow
	didFinishBlock:(FLEventCallback) didFinishBlock
{
	FLAssertIsNotNil(table);
	FLAssertIsNotNil(prepare);

	@try {
        @synchronized(_objectDatabase) {
			[_objectDatabase createTableIfNeeded:table];
			
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

- (void) selectObjectsInTable:(FLSqliteTable*) table
	willPrepareBlock:(FLObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectObjectBlock:(FLObjectDatabaseIteratorDidSelectObject) didSelectObject
	didFinishBlock:(FLEventCallback) didFinishBlock {
	FLAssertIsNotNil(table);
	FLAssertIsNotNil(prepare);

	Class objectClass = table.classRepresentedByTable;
	
	id<FLCachedObjectHandler> behavior = [objectClass cachedObjectHandler];
	FLObjectDescriber* describer = [objectClass sharedObjectDescriber];

	self.columnDecoder = ^(NSString* columnName, FLSqliteType sqlType, id object, id* outObject) {
		*outObject = [FLObjectDatabaseIterator decodeColumnObject:columnName object:object sqlType:sqlType objectDescriber:describer table:table];
	};

    [self selectRowsInTable:table 
        willPrepareBlock:prepare 
        didSelectRowBlock:^(NSDictionary* row)  {
            id newObject = nil;
            @try {
                newObject = [[objectClass alloc] init];
                FLAssertIsNotNil(newObject);
                
                [self updateObjectWithRowData:newObject row:row];

                if(behavior && ![behavior didLoadObjectFromDatabaseCache:newObject]) {
                    [_objectDatabase deleteObject:newObject];
                    FLReleaseWithNil(newObject);
                }
                
                if(newObject && didSelectObject && !didSelectObject(newObject)) {	
                    return NO;
                }
            }
            @finally
            {
                FLRelease(newObject);
            }
            
            return YES;
        }
        didFinishBlock:didFinishBlock];
}


@end




