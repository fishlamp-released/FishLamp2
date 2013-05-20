//
//	GtObjectDatabase.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectDatabase.h"
#import "NSFileManager+GtExtras.h"
#import "GtSqliteTable.h"
#import "GtLowMemoryHandler.h"
#import "GtCachedObjectHandler.h"
#import "GtCancellableOperation.h"
#import "GtCacheManager.h"
#import "GtBase64Encoding.h"
#import "GtObjectDatabaseIterator.h"

@implementation GtObjectDatabase

- (id) init
{
	if((self = [self initWithDefaultName:nil]))
	{
	}
	return self;
}

- (id) initWithDefaultName:(NSString*) directory
{
	NSString* name = [[NSString alloc] initWithFormat:@"%@.sqlite", [NSFileManager appName]];
	if((self = [self initWithName:name directory:directory]))
	{
	}
	GtReleaseWithNil(name);
	return self;
}

- (void) handleLowMemory:(id)sender
{
	@synchronized(self) {
		[self purgeMemoryIfPossible];
	}
}

- (id) initWithFilePath:(NSString*) filePath
{
	if((self = [super initWithFilePath:filePath]))
	{
		[[GtLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemory:)];
	}

	return self;
}

- (id) initWithName:(NSString*) fileName directory:(NSString*) directory
{
	return [self initWithFilePath:[directory stringByAppendingPathComponent: fileName]];
}

- (void) cancelCurrentOperation
{
	@synchronized(self) {
		if(!m_dbFlags.disableCancel && self.isOpen)
		{
			[super cancelCurrentOperation];
		}
	}
}

- (void) dealloc
{
	[[GtLowMemoryHandler defaultHandler] removeObserver:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	GtSuperDealloc();
}	

- (NSDate*) saveObject:(id) object
{
	return [self batchSaveObjects:[NSArray arrayWithObject:object]];
}

- (NSDate*) batchSaveObjects:(NSArray*) array
{
	NSDate* writeDate = [NSDate date];
	
	if(array && array.count)
	{
		id firstObject = [array firstObject];
		
        id<GtCachedObjectHandler> behavior = [[firstObject class] cachedObjectHandler];
		GtSqliteTable* table = [[firstObject class] sharedSqliteTable];
		
		NSMutableString* sql = [NSMutableString stringWithFormat:@"INSERT OR REPLACE INTO %@ (", table.tableName];
		
		NSMutableString* values = [NSMutableString string];
		int itemCount = 0;
		for(GtSqliteColumn* column in table.columns.objectEnumerator)
		{
			if(itemCount++ == 0)
			{	
				[values appendString:@"?"];
				[sql appendString:column.columnName];
			}
			else
			{
				[values appendString:@", ?"];
				[sql appendFormat:@", %@", column.columnName]; 
			}
		}

		[sql appendFormat:@") VALUES (%@);", values];
		
		@synchronized(self) 
		{
		
			@try {
				[self exec:@"BEGIN TRANSACTION;"];
				[self createTableIfNeeded:table];
				
				for(id object in array)
				{
                    if([object canSaveToDatabase:self])
                    {
                        if(!behavior || [behavior willSaveObjectToDatabaseCache:object])
                        {
                            GtObjectDatabaseIterator* statement = [[GtObjectDatabaseIterator alloc] initWithObjectDatabase:self];
                            @try {
                                [statement prepareStatement:sql];
                                
                                int idx = 1;
                                for(GtSqliteColumn* column in table.columns.objectEnumerator)
                                {
                                    id dataToSave = [object valueForKey:column.decodedColumnName];
                                                                    
                                    if(dataToSave)
                                    {
                                        [dataToSave bindToStatement:statement parameterIndex:idx];
                                    }
                                    else
                                    {
                                        [statement bindNull:idx];
                                    }
                                    
                                    ++idx;
                                }

                                while(statement.willStep)
                                {
                                    [statement step];
                                }
                            }
                            @finally {
                                [statement finalizeStatement];
                                GtRelease(statement);
                            }
                        }
                    }
				}
			
				[self exec:@"COMMIT;"];

                for(id object in array)
                {
                    if([object canSaveToDatabase:self])
                    {
                        if(behavior)
                        {
                            [behavior didSaveObjectToDatabaseCache:object];
                        }
                        
                        [object wasSavedToDatabase:self];
                    }
                }
			}
			@catch(NSException* ex) {
				[self exec:@"ROLLBACK;"];
				@throw;
			} 
			
		}
	}
	
	return writeDate;
}

- (void) deleteObject:(id) inputObject
{
	GtAssertNotNil(inputObject);
		
	GtSqliteTable* table = [[inputObject class] sharedSqliteTable];
	GtObjectDatabaseIterator* statement = [[GtObjectDatabaseIterator alloc] initWithObjectDatabase:self];
									
//	@synchronized(self) 
	{
		@try {
			[self createTableIfNeeded:table];
		
			if(![statement bindParametersForSql:[NSMutableString stringWithFormat:@"DELETE FROM %@ WHERE", table.tableName]  
				inputObject:inputObject
				table:table])
			{
				GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorNoParametersSpecified, @"No parameters specified");
			}
			
			while(statement.willStep)
			{
				[statement step];
			}
		}
		@finally {
			[statement finalizeStatement];
			GtRelease(statement);
		}
	
	}

	id<GtCachedObjectHandler> behavior = [[inputObject class] cachedObjectHandler];
	if(behavior)
	{
	
//#if DEBUG
//		GtLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([object class]));
//
//		if(behavior.warnOnMainThreadDelete && [NSThread isMainThread])
//		{
//			GtLog(@"Warning: deleting object cache on main thread");
//			GtLogStackTrace();
//		}
//#endif
	
		[behavior didRemoveObjectFromCache:inputObject];
	}
}

- (id) loadObjectFromMemoryCache:(id) inputObject
{
	return [[[inputObject class] cachedObjectHandler] loadObjectFromMemoryCache:inputObject];
}

- (void) loadObject:(id) inputObject 
		outputObject:(id*) outputObject
{
	if(!inputObject)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outputObject)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidOutputObject, @"null output object");
	}

	id<GtCachedObjectHandler> behavior = [[inputObject class] cachedObjectHandler];
	if(behavior)
	{
		id newObject = [behavior loadObjectFromMemoryCache:inputObject];
	
#if DEBUG
		if(behavior.warnOnMainThreadLoad && [NSThread isMainThread])
		{
			GtLog(@"Warning: loading from cache on main thread");
		}
#endif
		if(newObject)
		{
			if(outputObject)
			{
				*outputObject = GtRetain(newObject);
			}
		
			return;
		}
	}

	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultObjects:&array];
	
	if(array)
	{
		if(outputObject && array.count == 1)
		{
			*outputObject = [[array objectAtIndex:0] retain];
		}
		else if(array.count > 1)
		{
			GtRelease(array);
			GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorTooManyObjectsReturned, ([NSString stringWithFormat:@"Too many objects returned for input object of type: %@", NSStringFromClass([inputObject class])]));
		}
		GtRelease(array);
	}
}

- (id) loadObject:(id) inputObject
{
	id output = nil;
	[self loadObject:inputObject outputObject:&output];
	return GtAutorelease(output);
}

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject
{
	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:nil resultObjects:&array];

	return GtAutorelease(array);
}

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject  resultColumnNames:(NSArray*) resultColumnNames
						
{
	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:resultColumnNames resultObjects:&array];

	return GtAutorelease(array);
}

- (void) selectObjectsMatchingInputObject:(id) inputObject 
				 resultObjects:(NSArray**) outObjects
{
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:nil resultObjects:outObjects];
}

- (void) selectObjectsMatchingInputObject:(id) inputObject 
						resultColumnNames:(NSArray*) resultColumnNames
						resultObjects:(NSArray**) outObjects
{
	if(!inputObject)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidOutputObject, @"null output object");
	}

	GtSqliteTable* table = [[inputObject class] sharedSqliteTable];

	GtObjectDatabaseIterator* iterator = [GtObjectDatabaseIterator objectDatabaseIterator:self];

	[iterator selectObjectsInTable:table 
		willPrepareBlock:^{
			NSString* selectWhat = resultColumnNames && resultColumnNames.count ? [NSString stringWithFormat:@"(%@)", [NSString concatStringArray:resultColumnNames]] : @"*";
			
			return [iterator bindParametersForSql:[NSMutableString stringWithFormat:@"SELECT %@ FROM %@ WHERE", selectWhat, table.tableName]  
									  inputObject:inputObject
											table:table];
		} 
		didSelectObjectBlock:^(id object) {
			[iterator addResultObject:object];
			return YES;
		}
		didFinishBlock:^{
			if(outObjects)
			{
				*outObjects = GtRetain([iterator resultObjects]);
			}
		}
		];
}

- (BOOL) objectExistsInDatabase:(id) inputObject
{
	if(!inputObject)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidInputObject, @"null input object");
	}

	GtSqliteTable* table = [[inputObject class] sharedSqliteTable];

	GtObjectDatabaseIterator* iterator = [GtObjectDatabaseIterator objectDatabaseIterator:self];
    __block BOOL foundIt = NO;
    
	[iterator selectRowsInTable:table 
		willPrepareBlock:^{

            // TODO: it'd be faster to just load a single column we know can't be NULL, for now just load all the columns.    
			NSString* selectWhat = @"*"; // resultColumnNames && resultColumnNames.count ? [NSString stringWithFormat:@"(%@)", [NSString concatStringArray:resultColumnNames]] : @"*";
			
			return [iterator bindParametersForSql:[NSMutableString stringWithFormat:@"SELECT %@ FROM %@ WHERE", selectWhat, table.tableName]  
									  inputObject:inputObject
											table:table];
		} 
		didSelectRowBlock:^(NSDictionary* row) {
            foundIt = YES;
			return YES;
		}
		didFinishBlock:^{
		}
		];

    return foundIt;
}

- (void) loadAllObjectsForTypeWithClass:(Class) class 
								outObjects:(NSArray**) outObjects
{
	[self loadAllObjectsForTypeWithTable:[class sharedSqliteTable] outObjects:outObjects];
}

- (void) loadAllObjectsForTypeWithTable:(GtSqliteTable*) table outObjects:(NSArray**) outObjects
{
	if(!table)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects)
	{
		GtThrowErrorCode(GtDatabaseDomain, GtDatabaseErrorInvalidOutputObject, @"null output object");
	}
	
	GtObjectDatabaseIterator* iterator = [GtObjectDatabaseIterator objectDatabaseIterator:self];

	[iterator selectObjectsInTable:table 
		willPrepareBlock:^{
			[iterator prepareStatement:[NSString stringWithFormat:@"SELECT * FROM %@", table.tableName]];
			return YES;
		} 
		didSelectObjectBlock:^(id object) {
			[iterator addResultObject:object];
			return YES;
		}
		didFinishBlock:^{
			if(outObjects)
			{
				*outObjects = GtRetain([iterator resultObjects]);
			}
		}
		];

}

- (void) loadAllObjectsForType:(id) object 
					  outObjects:(NSArray**) outObjects
{
	[self loadAllObjectsForTypeWithTable:[[object class] sharedSqliteTable] outObjects:outObjects];
}
@end

@implementation NSObject (GtObjectDatabase)

- (void) wasSavedToDatabase:(GtObjectDatabase*) database
{
}

- (BOOL) canSaveToDatabase:(GtObjectDatabase*) database
{
    return YES;
}
@end


