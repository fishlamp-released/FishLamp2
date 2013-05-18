//
//  GtImageCache.m
//  MyZen
//
//  Created by Mike Fullerton on 10/29/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtImageCache.h"
#import "GtPhotoData.h"
#import "GtCachedPhotoData.h"
#import "GtPhoto.h"
#import "GtFileUtilities.h"
#import "GtUserSession.h"

@implementation GtImageCache

@synthesize maxSizeInMemory = m_maxSizeInMemory;

- (id) init
{
	if(self = [super init])
	{
		self.maxSizeInMemory = GtDefaultImageCacheCachableSize;
		
		m_memoryCache = [GtAlloc(GtInMemoryDatabaseObjectCache) init];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_memoryCache);
	[super dealloc];
}

- (void) onRemoveObjectFromCache:(id) object
{
	GtCachedPhotoData* cachedPhoto = (GtCachedPhotoData*) object;

	GtPhotoData* data = [object photoData];
	data.path = cachedPhoto.filePath;
	[data deleteFile];
}

- (BOOL) onCanSaveObjectToMemoryCache:(id) object
{
	GtPhotoData* data = [object photoData];
	
	return(	data.size <= m_maxSizeInMemory);
}

#if DEBUG
// for setting breakpoint in debug build
- (BOOL) loadObjectFromCache:(id<GtDatabaseObject>) object 
                outputObject:(id*) outputObject
{
	return [super loadObjectFromCache:object outputObject:outputObject];
}
#endif

- (void) saveObjectToCache:(id<GtDatabaseObject>) object
{
	GtCachedPhotoData* cachedPhoto = (GtCachedPhotoData*) object;
    
    NSString* fileName = [NSString stringWithGuid];
    cachedPhoto.photoData.path = [[GtUserSession instance].photoCacheFolder pathForFile:fileName];
    cachedPhoto.filePath = fileName; 
	
	[super saveObjectToCache:object]; // this will, in turn, call onSaveObjectToCacheBelow
}

- (BOOL) onSaveObjectToCache:(id) object
{
	if(!self.disableCache)
	{
		GtCachedPhotoData* cachedPhoto = (GtCachedPhotoData*) object;
#if DEBUG
        if(cachedPhoto.photoData.existsOnDisk)
        {
            GtLog(@"Warning: Cached photo already exists on disk: %@", cachedPhoto.filePath);
        }
#endif
    
		if(![cachedPhoto.photoData saveToFile])
        {
            GtFail(@"Failed to save image to cache: %@", cachedPhoto.filePath);
        }
        
	
#if DEBUG
		GtTrace(GtTraceDatabaseCache, @"Saved image to cache on disk: %@", [object filePath]);
#endif

	}
	return YES;
}

- (BOOL) onLoadObjectFromCache:(id) object
{
	if(!self.disableCache)
	{
		GtCachedPhotoData* cachedPhoto = (GtCachedPhotoData*) object;
	
		GtPhotoData* data = [GtAlloc(GtPhotoData) init];
		data.path = [[GtUserSession instance].photoCacheFolder pathForFile:cachedPhoto.filePath];
        
        BOOL didLoadData = [data readFromFile];

#if DEBUG
        if(!didLoadData)
        {

            GtLog(@"Warning: failed to load image from cache: %@", data.path);
        }
#endif
        
		cachedPhoto.photoData = data;
		GtRelease(data);
		
		
#if DEBUG
    	GtTrace(GtTraceDatabaseCache, @"Loaded image from cache: %@", [object filePath]);
#endif
		
        return didLoadData;
	}
	
	return NO;
}

- (void) clearCache
{
	[super clearCache];	
	[[GtUserSession instance].photoCacheFolder deleteAllFiles];
}



@end
