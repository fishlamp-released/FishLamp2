//
//	FLCacheProtocol.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"


@protocol FLCacheProtocol <NSObject>

- (void) cacheObject:(id) object forKey:(id) key;
- (id) objectForKey:(id)key;
- (void) removeObjectForKey:(id) forKey;
- (void)removeAllObjects;

@end
