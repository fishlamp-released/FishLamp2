//
//  GtCachedAuthenticationToken.m
//  MyZen
//
//  Created by Mike Fullerton on 2/5/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtCachedAuthenticationToken.h"
#import "GtDatabaseCache.h"
#import "GtUserSession.h"

@implementation GtCachedAuthenticationToken

- (void) onInit
{
    self.id = 1;
}

- (void) saveToCache
{
}

+ (void) deleteFromCache
{
    GtCachedAuthenticationToken* token = [GtAlloc(GtCachedAuthenticationToken) init];
    [[GtUserSession instance].objectCache removeObjectFromCache:token];
    GtRelease(token);
}

+ (BOOL) loadFromCache:(NSString**) outToken
{
    GtCachedAuthenticationToken* inputToken = [GtAlloc(GtCachedAuthenticationToken) init];
    GtCachedAuthenticationToken* outputToken = nil;
    
    if([[GtUserSession instance].objectCache loadObjectFromCache:inputToken
                                              outputObject:&outputToken])
    {
        *outToken = [outputToken.token retain];
    }
    
    GtRelease(inputToken);
    GtRelease(outputToken);
    
    return *outToken != nil;
}

+ (void) saveToCache:(NSString*) inToken
{
    GtCachedAuthenticationToken* token = [GtAlloc(GtCachedAuthenticationToken) init];
    token.token = inToken;
    [[GtUserSession instance].objectCache saveObjectToCache:token];
    GtRelease(token);
}

- (void) onConfigureDataDescriptors:(NSMutableDictionary *)dataDescriptors
{
	[super onConfigureDataDescriptors:dataDescriptors];

	GtDataDescriptor* elements = [dataDescriptors objectForKey:[GtCachedAuthenticationToken idKey]];
	elements.primaryKey = YES;
}

- (void) onSetCacheKey
{
	self.cacheKey = self.idObject;
}

@end
