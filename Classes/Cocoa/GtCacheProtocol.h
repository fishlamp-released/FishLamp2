//
//	GtCacheProtocol.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/21/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@protocol GtCacheProtocol <NSObject>

- (void) cacheObject:(id) object forKey:(id) key;
- (id) objectForKey:(id)key;
- (void) removeObjectForKey:(id) forKey;
- (void)removeAllObjects;

@end
