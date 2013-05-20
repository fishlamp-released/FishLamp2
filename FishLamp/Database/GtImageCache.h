//
//  GtImageCache.h
//  MyZen
//
//  Created by Mike Fullerton on 10/29/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDatabaseCache.h"

#define GtDefaultImageCacheCachableSize 25600 // 25k

@interface GtImageCache : GtDatabaseCache {
	NSUInteger m_maxSizeInMemory;
	GtInMemoryDatabaseObjectCache* m_memoryCache;
}

@property (readwrite, assign) NSUInteger maxSizeInMemory;

@end
