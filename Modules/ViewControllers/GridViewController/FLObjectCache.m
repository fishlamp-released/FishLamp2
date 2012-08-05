//
//  FLObjectCache.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/25/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectCache.h"
#import "NSArray+FLExtras.h"

@implementation FLObjectCache

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
    FLSuperDealloc();
}

- (void) cacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier
{
    if(object && *object)
    {
        FLAssert([NSThread isMainThread], @"not main thread");

        if(!_cache)
        {
            _cache = [[NSMutableDictionary alloc] init];
        }

        [*object objectCacheWillCacheObject:self];

        NSMutableArray* cache = [_cache objectForKey:reuseIdentifier];
        if(cache)
        {
            [cache addObject:*object];
        }
        else
        {
            [_cache setObject:[NSMutableArray arrayWithObject:*object] forKey:reuseIdentifier];
        }
        FLRelease(*object);
        *object = nil;
    }
}

- (void) uncacheObject:(id*) object 
       reuseIdentifier:(id)reuseIdentifier
       createBlock:(FLCreateCachedObject) createBlock
{
    FLAssert([NSThread isMainThread], @"not main thread");
    if(object)
    {
        *object = nil;
        NSMutableArray* cache = [_cache objectForKey:reuseIdentifier];
        if(cache && cache.count)
        {
            *object = FLReturnRetained([cache lastObject]);

            FLAssertIsNotNil(*object);
            [*object objectCacheWillUncacheObject:self];
            [cache removeLastObject];
        }
    
        if(*object == nil && createBlock)
        {
            *object = FLReturnRetained(createBlock());
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
    for(NSArray* list in _cache.objectEnumerator)
    {
        for(id object in list)
        {
            [object objectCacheWillPurgeObject:self];
        }
    }
    
    FLReleaseWithNil(_cache);
}

@end

@implementation NSObject (FLObjectCache)

- (void) objectCacheWillCacheObject:(FLObjectCache*) cache
{
}

- (void) objectCacheWillUncacheObject:(FLObjectCache*) cache
{
}

- (void) objectCacheWillPurgeObject:(FLObjectCache*) cache
{
}

@end

