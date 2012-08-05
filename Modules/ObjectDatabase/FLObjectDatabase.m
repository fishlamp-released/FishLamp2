//
//	FLObjectDatabase.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLObjectDatabase.h"
#import "NSFileManager+FLExtras.h"
#import "FLSqliteTable.h"
#import "FLLowMemoryHandler.h"
#import "FLCachedObjectHandler.h"
#import "FLCancellableOperation.h"
#import "FLCacheManager.h"
#import "FLBase64Encoding.h"
#import "FLObjectDatabaseIterator.h"
#import "NSArray+FLExtras.h"
#import "NSString+Lists.h"

@implementation FLObjectDatabase
  
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
	FLReleaseWithNil(name);
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
		[[FLLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemory:)];
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
		if(!_dbFlags.disableCancel && self.isOpen)
		{
			[super cancelCurrentOperation];
		}
	}
}

- (void) dealloc
{
	[[FLLowMemoryHandler defaultHandler] removeObserver:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	FLSuperDealloc();
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
		
        id<FLCachedObjectHandler> behavior = [[firstObject class] cachedObjectHandler];
		FLSqliteTable* table = [[firstObject class] sharedSqliteTable];
		
		NSMutableString* sql = [NSMutableString stringWithFormat:@"INSERT OR REPLACE INTO %@ (", table.tableName];
		
		NSMutableString* values = [NSMutableString string];
		int itemCount = 0;
		for(FLSqliteColumn* column in table.columns.objectEnumerator)
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
                            FLObjectDatabaseIterator* statement = [[FLObjectDatabaseIterator alloc] initWithObjectDatabase:self];
                            @try {
                                [statement prepareStatement:sql];
                                
                                int idx = 1;
                                for(FLSqliteColumn* column in table.columns.objectEnumerator)
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
                                FLRelease(statement);
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
	FLAssertIsNotNil(inputObject);
		
	FLSqliteTable* table = [[inputObject class] sharedSqliteTable];
	FLObjectDatabaseIterator* statement = [[FLObjectDatabaseIterator alloc] initWithObjectDatabase:self];
									
//	@synchronized(self) 
	{
		@try {
			[self createTableIfNeeded:table];
		
			if(![statement bindParametersForSql:[NSMutableString stringWithFormat:@"DELETE FROM %@ WHERE", table.tableName]  
				inputObject:inputObject
				table:table])
			{
				FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorNoParametersSpecified, @"No parameters specified");
			}
			
			while(statement.willStep)
			{
				[statement step];
			}
		}
		@finally {
			[statement finalizeStatement];
			FLRelease(statement);
		}
	
	}

	id<FLCachedObjectHandler> behavior = [[inputObject class] cachedObjectHandler];
	if(behavior)
	{
	
//#if DEBUG
//		FLLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([object class]));
//
//		if(behavior.warnOnMainThreadDelete && [NSThread isMainThread])
//		{
//			FLDebugLog(@"Warning: deleting object cache on main thread");
//			FLLogStackTrace();
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
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outputObject)
	{
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}

	id<FLCachedObjectHandler> behavior = [[inputObject class] cachedObjectHandler];
	if(behavior)
	{
		id newObject = [behavior loadObjectFromMemoryCache:inputObject];
	
#if DEBUG
		if(behavior.warnOnMainThreadLoad && [NSThread isMainThread])
		{
			FLDebugLog(@"Warning: loading from cache on main thread");
			FLLogStackTrace(FLLoggerLevelLow);
		}
#endif
		if(newObject)
		{
			if(outputObject)
			{
				*outputObject = FLReturnRetained(newObject);
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
			*outputObject = FLReturnRetained([array objectAtIndex:0]);
		}
		else if(array.count > 1)
		{
			FLRelease(array);
			FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorTooManyObjectsReturned, ([NSString stringWithFormat:@"Too many objects returned for input object of type: %@", NSStringFromClass([inputObject class])]));
		}
		FLRelease(array);
	}
}

- (id) loadObject:(id) inputObject
{
	id output = nil;
	[self loadObject:inputObject outputObject:&output];
	return FLReturnAutoreleased(output);
}

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject
{
	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:nil resultObjects:&array];

	return FLReturnAutoreleased(array);
}

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject  resultColumnNames:(NSArray*) resultColumnNames
						
{
	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:resultColumnNames resultObjects:&array];

	return FLReturnAutoreleased(array);
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
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects)
	{
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}

	FLSqliteTable* table = [[inputObject class] sharedSqliteTable];

	FLObjectDatabaseIterator* iterator = [FLObjectDatabaseIterator objectDatabaseIterator:self];

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
				*outObjects = FLReturnRetained([iterator resultObjects]);
			}
		}
		];
}

- (BOOL) objectExistsInDatabase:(id) inputObject
{
	if(!inputObject)
	{
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}

	FLSqliteTable* table = [[inputObject class] sharedSqliteTable];

	FLObjectDatabaseIterator* iterator = [FLObjectDatabaseIterator objectDatabaseIterator:self];
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

- (void) loadAllObjectsForTypeWithTable:(FLSqliteTable*) table outObjects:(NSArray**) outObjects
{
	if(!table)
	{
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects)
	{
		FLThrowErrorCode(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}
	
	FLObjectDatabaseIterator* iterator = [FLObjectDatabaseIterator objectDatabaseIterator:self];

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
				*outObjects = FLReturnRetained([iterator resultObjects]);
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

@implementation NSObject (FLObjectDatabase)

- (void) wasSavedToDatabase:(FLObjectDatabase*) database
{
}

- (BOOL) canSaveToDatabase:(FLObjectDatabase*) database
{
    return YES;
}
@end

@implementation FLObjectDatabase (FLAsyncEventHandler) 

- (void) loadObject:(id) inputObject 
   withEventHandler:(FLAsyncEventHandler*) handler
{

// TODO("async loadObject is commented out");

//    [self performBlockInBackground: ^(id from, FLAsyncEventHandler* theHandler, FLAsyncEventResult* asyncEventResult) {
//
//        asyncEventResult.eventHint = FLObjectDatabaseEventHintLoaded;
//        asyncEventResult.eventInput = inputObject;
//        asyncEventResult.eventContext = from;
//        
//        id output = nil;
//        @try {
//            [from loadObject:inputObject outputObject:&output];
//            
//            if(output) {
//                asyncEventResult.eventOutput = output;
//            } else { 
//                asyncEventResult.error = [NSError errorWithDomain:FLObjectDatabaseErrorDomain 
//                                                       code:FLDatabaseErrorObjectNotFound 
//                                                  localizedDescription:@"object not found in database"];
//            }
//        }
//        @finally {
//            FLRelease(output);
//        }
//    }
//    withEventHandler:handler
//    ];
}

- (void) saveObject:(id) object 
   withEventHandler:(FLAsyncEventHandler*) handler
{
// TODO("async save object is commented out");

//    [self performBlockInBackground: ^(id from, FLAsyncEventHandler* theHandler, FLAsyncEventResult* asyncEventResult) {
//            asyncEventResult.eventHint = FLObjectDatabaseEventHintSaved;
//            asyncEventResult.eventInput = object;
//            asyncEventResult.eventContext = from;
//            
//            [from saveObject:object];
//            asyncEventResult.eventOutput = object;
//        }
//        withEventHandler:handler
//        ];
}

@end