//
//  FLViewCache.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/25/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLObjectCache : NSObject {
@private    
    NSMutableDictionary* _cache;
}

- (void) cacheObject:(id) object;

- (id) uncacheObjectForClass:(Class) aClass;

- (void) purgeCache; // delete unused objects.

@end

@interface NSObject (FLObjectCache)
- (void) wasCachedInCache:(FLObjectCache*) cache;
- (void) wasUncachedFromCache:(FLObjectCache*) cache;
- (void) willBePurgedFromCache:(FLObjectCache*) cache;
@end

