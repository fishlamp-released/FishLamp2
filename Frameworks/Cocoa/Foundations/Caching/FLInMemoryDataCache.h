//
//	FLInMemoryDataCache.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

#import "FLLinkedList.h"

@interface FLInMemoryDataCache : NSObject {
@private
	NSUInteger _maxCount;
	FLLinkedList* _list;
	NSMutableDictionary* _objects;
	BOOL _removeAllOnLowMemoryWarning;
}

@property (readwrite, assign, nonatomic) NSUInteger cacheSize; 
@property (readwrite, assign, nonatomic) BOOL removeAllOnLowMemoryWarning; // defaults to YES

- (id) initWithCapacity:(NSUInteger) max;

// these are thread safe

- (void) updateOrAddObject:(id) object forKey:(id) key;
- (id) objectForKey:(id)key;
- (BOOL) objectInCache:(id) key;

- (void) removeObjectForKey:(id) forKey;
- (void) removeAllObjects;

- (id) keyForOldestObjectInCache;
- (id) oldestObjectInCache;
- (id) expireOldestObjectInCache;

@end