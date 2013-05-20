//
//	GtDatabaseCache.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
//
//#import "GtDatabaseCache.h"
//#import "GtSqlDatabaseOperation.h"
//#import "GtCachedObjectHandler.h"
//#import "GtDatabaseObject.h"
//#import "GtLowMemoryHandler.h"
//#import "GtCacheManager.h"
//
//@implementation GtDatabaseCache
//
//@synthesize database = m_database;
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
//		[[GtLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemory:)];
//
//		[[NSNotificationCenter defaultCenter] addObserver:self 
//				selector:@selector(_doClearCache:) 
//				name:GtUserSessionEmptyCacheNotification
//				object:[GtCacheManager instance]];
//	
//	}
//	
//	return self;
//}
//
//- (void) dealloc
//{
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
//	[[GtLowMemoryHandler defaultHandler] removeObserver:self];
//	GtRelease(m_database);
//	GtSuperDealloc();
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
//	GtAssertNotNil(inputObject);
//	
//	GtSqlDatabaseOperation* sqlOperation = GtReturnAutoreleased([[GtSqlDatabaseOperation alloc] init]);
//	GtSqlQuery* query = GtReturnAutoreleased([[GtSqlSelectQuery alloc] init]);
//
//	id<GtCachedObjectHandler> behavior = [[inputObject class] cachedObjectHandler];
//	GtLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([inputObject class]));
//
//	id newObject = [behavior loadObjectFromMemoryCache:inputObject];
//	
//#if DEBUG
//	  if(behavior.warnOnMainThreadLoad && [NSThread isMainThread])
//	  {
//		  GtLog(@"Warning: loading from cache on main thread");
//		  GtLogStackTrace();
//	  }
//#endif
//	
//	if(!newObject)
//	{
//		[self.database prepareQuery:query forObject:inputObject operation:sqlOperation];
//		[self.database performQuery:[query buildString] operation:sqlOperation];
//
//#if DEBUG
//		GtAssert(sqlOperation.rows.count <= 1, @"loaded too many objects for single cached object");
//#endif
//		if(sqlOperation.rows.count == 1)
//		{
//			NSDictionary* row = [sqlOperation.rows objectAtIndex:0];
//			newObject = [behavior createNewObjectForOutput:inputObject];
//			[self.database updateObjectWithRowData:newObject row:row];
//			if(![behavior didLoadObjectFromDatabaseCache:newObject])
//			{
//				[self deleteObject:newObject];
//				GtReleaseWithNil(&newObject);
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
//	return GtAutorelease(output);
//}
//
//- (void) saveObjectToCache:(id) object
//{
//	if(object)
//	{
//		id<GtCachedObjectHandler> behavior = [[object class] cachedObjectHandler];
//
//#if DEBUG
//		GtLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([object class]));
//
//		if(behavior.warnOnMainThreadWrite && [NSThread isMainThread])
//		{
//			GtLog(@"Warning: saving to cache on main thread");
//			GtLogStackTrace();
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
//	GtAssertNotNil(object);
//	GtRetain(object);
//		
//	@try
//	{	
//		[self.database deleteObject:object];
//		id<GtCachedObjectHandler> behavior = [[object class] cachedObjectHandler];
//#if DEBUG
//		GtLogAssert(behavior != nil, @"%@ has no cache behavior", NSStringFromClass([object class]));
//
//		if(behavior.warnOnMainThreadDelete && [NSThread isMainThread])
//		{
//			GtLog(@"Warning: deleting object cache on main thread");
//			GtLogStackTrace();
//		}
//#endif
//		
//		[behavior didRemoveObjectFromCache:object];
//	}
//	@finally
//	{
//		GtReleaseWithNil(&object);
//	}
//}
//
//- (void) clearCache:(id<GtCancellableOperation>) operation
//{
//	[[GtLowMemoryHandler defaultHandler] broadcastReleaseMessage];
//	[m_database closeDatabase];
//	[m_database deleteOnDisk];
//	[m_database openDatabase];
//}
//
//@end
//
