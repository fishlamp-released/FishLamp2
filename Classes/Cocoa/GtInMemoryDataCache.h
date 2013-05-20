//
//	GtInMemoryDataCache.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/21/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLinkedList.h"

@interface GtInMemoryDataCache : NSObject {
@private
	NSUInteger m_maxCount;
	GtLinkedList* m_list;
	NSMutableDictionary* m_objects;
	BOOL m_removeAllOnLowMemoryWarning;
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