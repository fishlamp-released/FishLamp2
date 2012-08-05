//
//	FLDatabaseCache.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
//
//#import "FLDatabaseCache.h"
//#import "FLSqlDatabaseOperation.h"
//#import "FLCachedObjectHandler.h"
//#import "FLDatabaseObject.h"
//#import "FLLowMemoryHandler.h"
//#import "FLCacheManager.h"
//
//@implementation FLDatabaseCache
//
//@synthesize database = _database;
//
//- (void) handleLowMemory:(id) sender
//{
//}
//
//- (void) _doClearCache:(NSNotification*) notification
//{
//	[self clearCache:notification.cancellableOperation];
//}
//
//- (id) init
//{
//	if((self = [super init]))
//	{
//		[[FLLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemory:)];
//
//		[[NSNotificationCenter defaultCenter] addObserver:self 
//				selector:@selector(_doClearCache:) 
//				name:FLUserSessionEmptyCacheNotification
//				object:[FLCacheManager instance]];
//	
//	}
//	
//	return self;
//}
//
//- (void) dealloc
//{
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
//	[[FLLowMemoryHandler defaultHandler] removeObserver:self];
//	FLRelease(_database);
//	FLSuperDealloc();
//}
//
//- (void) loadObjectFromMemoryCache:(id) inputObject outputObject:(id*) outputObject
//{
//	[[[inputObject class] cachedObjectHandler] loadObjectFromMemoryCache:inputObject output:outputObject];
//}
//
//- (id) loadObjectFromMemoryCache:(id) inputObject
//{
//	return [[[inputObject class] cachedObjectHandler] loadObjectFromMemoryCache:inputObject];
//}
//
//- (id) - (id) loadObjectFromMemoryCache:(id) inputObject
//{
//	return [[[inputObject class] cachedObjectHandler] loadObjectFromMemoryCache:inputObject];
//}
//loadObject:(id) inputObject
//{
//	FLAssertIsNotNil(inputObject);
//	
//	FLSqlDatabaseOperation* sqlOperation = FLReturnAutoreleased([[FLSqlDatabaseOperation alloc] init]);
//	FLSqlQuery* query = FLReturnAutoreleased([[FLSqlSelectQuery alloc] init]);
//
//	id<FLCachedObjectHandler> behavior = [[inputObject class] cachedObjectHandler];
//	FLLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([inputObject class]));
//
//	id newObject = [behavior loadObjectFromMemoryCache:inputObject];
//	
//#if DEBUG
//	  if(behavior.warnOnMainThreadLoad && [NSThread isMainThread])
//	  {
//		  FLDebugLog(@"Warning: loading from cache on main thread");
//		  FLLogStackTrace();
//	  }
//#endif
//	
//	if(!newObject)
//	{
//		[self.database prepareQuery:query forObject:inputObject operation:sqlOperation];
//		[self.database performQuery:[query buildString] operation:sqlOperation];
//
//#if DEBUG
//		FLAssert(sqlOperation.rows.count <= 1, @"loaded too many objects for single cached object");
//#endif
//		if(sqlOperation.rows.count == 1)
//		{
//			NSDictionary* row = [sqlOperation.rows objectAtIndex:0];
//			newObject = [behavior createNewObjectForOutput:inputObject];
//			[self.database updateObjectWithRowData:newObject row:row];
//			if(![behavior didLoadObjectFromDatabaseCache:newObject])
//			{
//				[self deleteObject:newObject];
//				FLReleaseWithNil(&newObject);
//			}
//		}
//	}
//
//	return newObject;
//}
//
//- (id) - (id) loadObjectFromMemoryCache:(id) inputObject
//{
//	return [[[inputObject class] cachedObjectHandler] loadObjectFromMemoryCache:inputObject];
//}
//loadObject:(id) inputObject
//{
//	id output = nil;
//	[self - (id) loadObjectFromMemoryCache:(id) inputObject
//{
//	return [[[inputObject class] cachedObjectHandler] loadObjectFromMemoryCache:inputObject];
//}
//loadObject:inputObject outputObject:&output];
//	return FLAutorelease(output);
//}
//
//- (void) saveObjectToCache:(id) object
//{
//	if(object)
//	{
//		id<FLCachedObjectHandler> behavior = [[object class] cachedObjectHandler];
//
//#if DEBUG
//		FLLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([object class]));
//
//		if(behavior.warnOnMainThreadWrite && [NSThread isMainThread])
//		{
//			FLDebugLog(@"Warning: saving to cache on main thread");
//			FLLogStackTrace();
//		}
//	#endif
//
//		if([behavior willSaveObjectToDatabaseCache:object])
//		{	
//			[self.database saveObject:object];
//			[behavior didSaveObjectToDatabaseCache:object];
//		}
//	}
//}
//
//- (void) deleteObject:(id) object
//{
//	FLAssertIsNotNil(object);
//	FLRetain(object);
//		
//	@try
//	{	
//		[self.database deleteObject:object];
//		id<FLCachedObjectHandler> behavior = [[object class] cachedObjectHandler];
//#if DEBUG
//		FLLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([object class]));
//
//		if(behavior.warnOnMainThreadDelete && [NSThread isMainThread])
//		{
//			FLDebugLog(@"Warning: deleting object cache on main thread");
//			FLLogStackTrace();
//		}
//#endif
//		
//		[behavior didRemoveObjectFromCache:object];
//	}
//	@finally
//	{
//		FLReleaseWithNil(&object);
//	}
//}
//
//- (void) clearCache:(id<FLCancellableOperation>) operation
//{
//	[[FLLowMemoryHandler defaultHandler] broadcastReleaseMessage];
//	[_database closeDatabase];
//	[_database deleteOnDisk];
//	[_database openDatabase];
//}
//
//@end
//
