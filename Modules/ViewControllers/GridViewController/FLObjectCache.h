//
//  FLViewCache.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/25/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^FLCreateCachedObject)();

@interface FLObjectCache : NSObject {
@private    
    NSMutableDictionary* _cache;
}

- (void) cacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier;
- (void) uncacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier;
- (void) uncacheObject:(id*) object reuseIdentifier:(id)reuseIdentifier createBlock:(FLCreateCachedObject) createBlock;

- (void) purgeCache; // delete unused objects.

@end

@interface NSObject (FLObjectCache)
- (void) objectCacheWillCacheObject:(FLObjectCache*) cache;
- (void) objectCacheWillUncacheObject:(FLObjectCache*) cache;
- (void) objectCacheWillPurgeObject:(FLObjectCache*) cache;
@end

