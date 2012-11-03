//
//	FLInMemoryDataCache.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLInMemoryDataCache.h"
#import "FLLowMemoryHandler.h"
#import "FLCacheManager.h"
#import "FLLinkedListObjectContainer.h"

//#define TRACE 0

@implementation FLInMemoryDataCache

@synthesize removeAllOnLowMemoryWarning = _removeAllOnLowMemoryWarning;
@synthesize cacheSize = _maxCount;

- (void) handleLowMemoryWarning:(id)sender
{
	if(_removeAllOnLowMemoryWarning)
	{
		[self removeAllObjects];
	}
}

- (id) init
{
	if((self = [self initWithCapacity:0]))
	{
	}
	
	return self;
}

- (void) _doClearCache:(NSNotification*) notification
{
	[self removeAllObjects];
}

- (id) initWithCapacity:(NSUInteger) max
{
	if((self = [super init]))
	{
		_maxCount = max;
		
		_list = [[FLLinkedList alloc] init];
		_objects = [[NSMutableDictionary alloc] initWithCapacity:max];
		_removeAllOnLowMemoryWarning = YES;
		
		[[FLLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemoryWarning:)];

		[[NSNotificationCenter defaultCenter] addObserver:self 
				selector:@selector(_doClearCache:) 
				name:FLUserSessionEmptyCacheNotification
				object:[FLCacheManager instance]];

	}
	return self;
}

- (id) oldestObjectInCache
{
	return [_list.lastObject object];
}

- (id) keyForOldestObjectInCache
{
	return [_list.lastObject key]; 
}

- (void) expireLastObject
{
	id last = _list.lastObject;
	if(last)
	{	
		[_objects removeObjectForKey:[last key]];
        [_list removeObject:last];
	}
}

- (id) expireOldestObjectInCache
{
	id object = autorelease_(retain_([_list.lastObject object]));
	[self expireLastObject];
	return object;
}

- (void) updateOrAddObject:(id) object forKey:(id) key
{
	@synchronized(self)
	{
		id node = [_objects objectForKey:key];
		if(node)
		{
			if([node object] != object)
			{
				[node setObject:object]; // refresh object if needed
			}
			[_list moveObjectToHead:node];
		}
		else if(_maxCount > 0)
		{
			while(_list.count >= _maxCount)
			{
				[self expireLastObject];
			}
			
			FLLinkedListObjectContainer* newObject = [[FLLinkedListObjectContainer alloc] init];
			newObject.key = key;
			newObject.object = object;
			
			[_list pushObject:newObject];
			[_objects setObject:newObject forKey:key];
			mrc_release_(newObject);
		}

#if TRACE		
		FLDebugLog(@"Updated %@:%@", key, object);
#endif

		
#if OUTPUT_ON_CHANGE
		FLDebugLog([_list description]);
#endif		
	}
}

- (id) objectForKey:(id)key
{
	@synchronized(self)
	{
		FLLinkedListObjectContainer* node = [_objects objectForKey:key];
		if(node)
		{
#if TRACE		
			FLDebugLog(@"Cache Hit %@:%@", node.key, node.object);
#endif		  

			[_list moveObjectToHead:node];
			return autorelease_(retain_(node.object));
		}
#if TRACE
		else
		{
			FLDebugLog(@"Cache miss %@", key);
		}
#endif		  
	}
	return nil;
}

- (BOOL) objectInCache:(id) key
{
	@synchronized(self)
	{
		return [_objects objectForKey:key] != nil;
	}
	
	return NO; // stooopid compiler
}


- (void) removeObjectForKey:(id) forKey
{
	@synchronized(self)
	{
		FLLinkedListObjectContainer* node = [_objects objectForKey:forKey];
		if(node)
		{
#if TRACE		
			FLDebugLog(@"Removed %@:%@", node.key, node.object);
#endif

			[_objects removeObjectForKey:forKey];
			[_list removeObject:node];
		}
	}
}


- (void)removeAllObjects
{
	@synchronized(self)
	{
		[_list removeAllObjects];
		[_objects removeAllObjects];
	}
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[[FLLowMemoryHandler defaultHandler] removeObserver:self];
	mrc_release_(_objects);
	mrc_release_(_list);
	super_dealloc_();
}


@end
