//
//	FLObjectDatabase.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLObjectDatabase.h"
#import "NSFileManager+FLExtras.h"
#import "FLDatabaseTable.h"
#import "FLLowMemoryHandler.h"
#import "FLCacheBehavior.h"
#import "FLCancellable.h"
#import "FLCacheManager.h"
#import "FLBase64Encoding.h"
#import "NSArray+FLExtras.h"
#import "NSString+Lists.h"
#import "FLSqlBuilder.h"
#import "FLDatabase_Internal.h"
#import "FLAppInfo.h"

@implementation FLObjectDatabase
  
- (id) initWithName:(NSString*) fileName directory:(NSString*) directory {
	return [self initWithFilePath:[directory stringByAppendingPathComponent: fileName]];
}

- (id) initWithDefaultName:(NSString*) directory {
	NSString* name = [[NSString alloc] initWithFormat:@"%@.sqlite", [FLAppInfo appName]];
	if((self = [self initWithName:name directory:directory])) {
	}
	FLReleaseWithNil(name);
	return self;
}

- (void) _saveOneObject:(id) object {
    id<FLCacheBehavior> behavior = [object cacheBehavior];
    if(!behavior || [behavior willSaveObjectToDatabaseCache:object]) {
        [super _saveOneObject:object];
        if(behavior) {
            [behavior didSaveObjectToDatabaseCache:object];
        }
    }
}

- (void) deleteObject:(id) inputObject
{
    [super deleteObject:inputObject];
    id<FLCacheBehavior> behavior = [inputObject cacheBehavior];
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

- (id) loadObjectFromMemoryCache:(id) inputObject {
	return [[inputObject cacheBehavior] loadObjectFromMemoryCache:inputObject];
}

- (void) loadObject:(id) inputObject 
		outputObject:(id*) outputObject {
	
    if(!inputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	
    if(!outputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}

	id<FLCacheBehavior> behavior = [inputObject cacheBehavior];
	if(behavior) {
		id newObject = [behavior loadObjectFromMemoryCache:inputObject];
	
#if DEBUG
		if(behavior.warnOnMainThreadLoad && [NSThread isMainThread])
		{
			FLDebugLog(@"Warning: loading from cache on main thread");
//			FLLogStackTrace();
		}
#endif
		if(newObject) {
			if(outputObject) {
				*outputObject = FLRetain(newObject);
			}
		
			return;
		}
	}

    [super loadObject:inputObject outputObject:outputObject];
}



- (void) selectObjectsMatchingInputObject:(id) inputObject 
						resultColumnNames:(NSArray*) resultColumnNames
						resultObjects:(NSArray**) outObjects {
	if(!inputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}
	id<FLCacheBehavior> behavior = [inputObject cacheBehavior];

	FLDatabaseTable* table = [[inputObject class] sharedDatabaseTable];

    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    NSMutableArray* results = [NSMutableArray array];

    NSString* resultColumns = [FLSqlBuilder sqlListFromArray:resultColumnNames delimiter:@"," withinParens:NO prefixDelimiterWithSpace:NO emptyString:SQL_ALL];

    [statement appendString:SQL_SELECT andString:resultColumns];
    [statement appendString:SQL_FROM andString:table.tableName];
    
    FLAssert_([statement appendWhereClauseForSelectingObject:inputObject] != NO);
    
    statement.objectResultBlock = ^(id object, BOOL* stop) {
        if(behavior && [behavior didLoadObjectFromDatabaseCache:object]) {
            [results addObject:object];
        }
        else {
            [self deleteObject:object];
        }
    };
    
    statement.finished = ^{
        if(outObjects) {
            *outObjects = FLRetain(results);
        }
    };
    
    [self executeStatement:statement];
}

- (void) loadAllObjectsForTypeWithTable:(FLDatabaseTable*) table outObjects:(NSArray**) outObjects
{
	if(!table) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}
	
	id<FLCacheBehavior> behavior = [[table classRepresentedByTable] sharedCacheBehavior];
    
    NSMutableArray* results = [NSMutableArray array];
    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    [statement appendString:SQL_SELECT andString:SQL_ALL];
    [statement appendString:SQL_FROM andString:table.tableName];
    
    statement.objectResultBlock = ^(id object, BOOL* stop) {
        if(behavior && [behavior didLoadObjectFromDatabaseCache:object]) {
            [results addObject:object];
        }
        else {
            [self deleteObject:object];
        }
    };
        
    statement.finished = ^{
        if(outObjects) {
            *outObjects = FLRetain(results);
        }
    };

    [self executeStatement:statement];
}

@end

//@implementation FLObjectDatabase (FLAsyncJob) 
//
//- (void) loadObject:(id) inputObject 
//   withEventHandler:(FLAsyncJob*) handler
//{
//
//// TODO("async loadObject is commented out");
//
////    [self performBlockInBackground: ^(id from, FLAsyncJob* job, FLAsyncEventResult* asyncEventResult) {
////
////        asyncEventResult.eventHint = FLObjectDatabaseEventHintLoaded;
////        asyncEventResult.eventInput = inputObject;
////        asyncEventResult.eventContext = from;
////        
////        id output = nil;
////        @try {
////            [from loadObject:inputObject outputObject:&output];
////            
////            if(output) {
////                asyncEventResult.eventOutput = output;
////            } else { 
////                asyncEventResult.error = [NSError errorWithDomain:FLObjectDatabaseErrorDomain 
////                                                       code:FLDatabaseErrorObjectNotFound 
////                                                  localizedDescription:@"object not found in database"];
////            }
////        }
////        @finally {
////            FLRelease(output);
////        }
////    }
////    withEventHandler:handler
////    ];
//}
//
//- (void) saveObject:(id) object 
//   withEventHandler:(FLAsyncJob*) handler
//{
//// TODO("async save object is commented out");
//
////    [self performBlockInBackground: ^(id from, FLAsyncJob* job, FLAsyncEventResult* asyncEventResult) {
////            asyncEventResult.eventHint = FLObjectDatabaseEventHintSaved;
////            asyncEventResult.eventInput = object;
////            asyncEventResult.eventContext = from;
////            
////            [from saveObject:object];
////            asyncEventResult.eventOutput = object;
////        }
////        withEventHandler:handler
////        ];
//}
//
//@end
