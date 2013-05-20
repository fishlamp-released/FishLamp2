//
//	GtInMemoryDataCache.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/21/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtInMemoryDataCache.h"
#import "GtLowMemoryHandler.h"
#import "GtLinkedList.h"

#import "GtCacheManager.h"

//#define TRACE 0

@interface GtCacheListElement : GtLinkedListElement {
@private 
    id _data;
    id _key;
}
@property (readwrite, retain, nonatomic) id data;
@property (readwrite, retain, nonatomic) id key;

+ (id) cacheListElement:(id) data key:(id) key;
@end

@implementation GtCacheListElement
@synthesize data = _data;
@synthesize key = _key;
- (id) initWithData:(id) data key:(id) key {	
	self = [super init];
	if(self) {
		self.data = data;
        self.key = key;
	}
	return self;
}
+ (id) cacheListElement:(id) data key:(id) key {
    return [[[[self class] alloc] init] autorelease];
}

- (void) dealloc {
	[_data release];
	[_key release];
	[super dealloc];
}
@end

@implementation GtInMemoryDataCache

@synthesize removeAllOnLowMemoryWarning = m_removeAllOnLowMemoryWarning;
@synthesize cacheSize = m_maxCount;

- (void) handleLowMemoryWarning:(id)sender
{
	if(m_removeAllOnLowMemoryWarning)
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
		m_maxCount = max;
		
		m_list = [[GtLinkedList alloc] init];
		m_objects = [[NSMutableDictionary alloc] initWithCapacity:max];
		m_removeAllOnLowMemoryWarning = YES;
		
		[[GtLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemoryWarning:)];

		[[NSNotificationCenter defaultCenter] addObserver:self 
				selector:@selector(_doClearCache:) 
				name:GtUserSessionEmptyCacheNotification
				object:[GtCacheManager instance]];

	}
	return self;
}

- (id) oldestObjectInCache
{
	return ((GtCacheListElement*)m_list.lastObject).data;
}

- (id) keyForOldestObjectInCache
{
	return ((GtCacheListElement*)m_list.lastObject).key;
}

- (void) expireLastNode
{
	GtCacheListElement* last = m_list.lastObject;
	if(last)
	{	
		[m_objects removeObjectForKey:last.key];
		[m_list removeObject:last];
	}
}

- (id) expireOldestObjectInCache
{
	id object = GtReturnAutoreleased([((GtCacheListElement*)m_list.lastObject).data retain]);
	[self expireLastNode];
	return object;
}

- (void) updateOrAddObject:(id) object forKey:(id) key
{
	@synchronized(self)
	{
		GtCacheListElement* node = [m_objects objectForKey:key];
		if(node)
		{
			if(node.data != object)
			{
				node.data = object; // refresh data if needed
			}
			[m_list moveObjectToHead:node];
		}
		else if(m_maxCount > 0)
		{
			while(m_list.count >= m_maxCount)
			{
				[self expireLastNode];
			}
			
			GtCacheListElement* newNode = [[GtCacheListElement alloc] init];
			newNode.key = key;
			newNode.data = object;
			
			[m_list pushObject:newNode];
			[m_objects setObject:newNode forKey:key];
			GtRelease(newNode);
		}

#if TRACE		
		GtLog(@"Updated %@:%@", key, object);
#endif

		
#if OUTPUT_ON_CHANGE
		GtLog([m_list description]);
#endif		
	}
}

- (id) objectForKey:(id)key
{
	@synchronized(self)
	{
		GtCacheListElement* node = [m_objects objectForKey:key];
		if(node)
		{
#if TRACE		
			GtLog(@"Cache Hit %@:%@", node.key, node.data);
#endif		  

			[m_list moveObjectToHead:node];
			return GtReturnAutoreleased(GtRetain(node.data));
		}
#if TRACE
		else
		{
			GtLog(@"Cache miss %@", key);
		}
#endif		  
	}
	return nil;
}

- (BOOL) objectInCache:(id) key
{
	@synchronized(self)
	{
		return [m_objects objectForKey:key] != nil;
	}
	
	return NO; // stooopid compiler
}


- (void) removeObjectForKey:(id) forKey
{
	@synchronized(self)
	{
		GtCacheListElement* node = [m_objects objectForKey:forKey];
		if(node)
		{
#if TRACE		
			GtLog(@"Removed %@:%@", node.key, node.data);
#endif

			[m_objects removeObjectForKey:forKey];
			[m_list removeObject:node];
		}
	}
}


- (void)removeAllObjects
{
	@synchronized(self)
	{
		[m_list removeAllObjects];
		[m_objects removeAllObjects];
	}
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[[GtLowMemoryHandler defaultHandler] removeObserver:self];
	GtRelease(m_objects);
	GtRelease(m_list);
	GtSuperDealloc();
}


@end
