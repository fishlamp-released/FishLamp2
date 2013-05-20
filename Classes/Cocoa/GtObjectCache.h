//
//  GtViewCache.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

typedef id (^GtCreateCachedObject)();

@interface GtObjectCache : NSObject {
@private    
    NSMutableDictionary* m_cache;
}

- (void) cacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier;
- (void) uncacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier;
- (void) uncacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier createBlock:(GtCreateCachedObject) createBlock;

- (void) purgeCache; // delete unused objects.

@end

@interface NSObject (GtObjectCache)
- (void) objectCacheWillCacheObject:(GtObjectCache*) cache;
- (void) objectCacheWillUncacheObject:(GtObjectCache*) cache;
- (void) objectCacheWillPurgeObject:(GtObjectCache*) cache;
@end

