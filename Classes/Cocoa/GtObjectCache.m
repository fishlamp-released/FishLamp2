//
//  GtObjectCache.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectCache.h"
#import "NSArray+GtExtras.h"

@implementation GtObjectCache

- (void) _handleLowMemoryWarning:(id) sender
{
    [self purgeCache];
}

- (id) init
{
    if((self = [super init]))
    {
    	[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_handleLowMemoryWarning:) 
                                                     name: UIApplicationDidReceiveMemoryWarningNotification
                                                   object: [UIApplication sharedApplication]];
    }
    
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self purgeCache];
    GtSuperDealloc();
}

- (void) cacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier
{
    if(object && *object)
    {
        GtAssert([NSThread isMainThread], @"not main thread");

        if(!m_cache)
        {
            m_cache = [[NSMutableDictionary alloc] init];
        }

        [*object objectCacheWillCacheObject:self];

        NSMutableArray* cache = [m_cache objectForKey:reuseIdentifier];
        if(cache)
        {
            [cache addObject:*object];
        }
        else
        {
            [m_cache setObject:[NSMutableArray arrayWithObject:*object] forKey:reuseIdentifier];
        }
        GtRelease(*object);
        *object = nil;
    }
}

- (void) uncacheObject:(id*) object 
       reuseIdentifier:(id)reuseIdentifier
       createBlock:(GtCreateCachedObject) createBlock
{
    GtAssert([NSThread isMainThread], @"not main thread");
    if(object)
    {
        *object = nil;
        NSMutableArray* cache = [m_cache objectForKey:reuseIdentifier];
        if(cache && cache.count)
        {
            *object = GtRetain([cache lastObject]);

            GtAssertNotNil(*object);
            [*object objectCacheWillUncacheObject:self];
            [cache removeLastObject];
        }
    
        if(*object == nil && createBlock)
        {
            *object = GtRetain(createBlock());
        }
    }
}

- (void) uncacheObject:(id*) object 
       reuseIdentifier:(id)reuseIdentifier
{
    [self uncacheObject:object reuseIdentifier:reuseIdentifier createBlock:nil];
}       


- (void) purgeCache
{
    for(NSArray* list in m_cache.objectEnumerator)
    {
        for(id object in list)
        {
            [object objectCacheWillPurgeObject:self];
        }
    }
    
    GtReleaseWithNil(m_cache);
}

@end

@implementation NSObject (GtObjectCache)

- (void) objectCacheWillCacheObject:(GtObjectCache*) cache
{
}

- (void) objectCacheWillUncacheObject:(GtObjectCache*) cache
{
}

- (void) objectCacheWillPurgeObject:(GtObjectCache*) cache
{
}

@end

