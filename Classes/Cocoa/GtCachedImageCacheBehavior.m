//
//	GtCacheableImageBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCachedImageCacheBehavior.h"
#import "GtCacheManager.h"
#import "NSString+Guid.h"
#import "GtUserSession.h" // TODO: remove this coupling
#import "NSFileManager+GtExtras.h"

@implementation GtCachedImageCacheBehavior

@synthesize maxLongSideForInMemoryCache = m_maxLongSideForInMemoryCache;

#if DEBUG
@synthesize warnOnMainThreadLoad = m_warnOnMainThreadLoad;
@synthesize warnOnMainThreadWrite = m_warnOnMainThreadWrite;
@synthesize warnOnMainThreadDelete = m_warnOnMainThreadDelete;
#endif


- (void) _doClearCache:(NSNotification*) notification
{
	[[GtUserSession instance].photoCacheFolder deleteAllFiles:notification.cancellableOperation];
}

- (id) initWithCapacity:(NSUInteger) capacity
{
	if((self = [super init]))
	{
		m_memoryCache = [[GtInMemoryDataCache alloc] initWithCapacity:capacity];

		[[NSNotificationCenter defaultCenter] addObserver:self 
				selector:@selector(_doClearCache:) 
				name:GtUserSessionEmptyCacheNotification
				object:[GtCacheManager instance]];

#if DEBUG
		m_warnOnMainThreadLoad = YES;
		m_warnOnMainThreadWrite = YES;
		m_warnOnMainThreadDelete = YES;
#endif	 
	}
	return self;
}

+ (GtCachedImageCacheBehavior*) cachedImageCacheBehavior:(NSUInteger) capacity;
{
	return GtReturnAutoreleased([[GtCachedImageCacheBehavior alloc] initWithCapacity:capacity]);
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	GtRelease(m_memoryCache);
	GtSuperDealloc();
}

- (BOOL) willSaveObjectToDatabaseCache:(GtCachedImage*) cachedImage
{
	GtAssertNotNil(cachedImage);
	GtAssert([cachedImage isKindOfClass:[GtCachedImage class]], @"wrong type of class for image cache");
	
	if(!cachedImage.imageFile || !cachedImage.imageFile.hasImage)
	{
		GtLog(@"trying to save image to cache with no image data, bailing.");
		return NO;
	}
	
	if(!cachedImage.imageFile.folder)
	{
		cachedImage.imageFile.folder = [GtUserSession instance].photoCacheFolder;
	}
	
	if(GtStringIsEmpty(cachedImage.imageFile.fileName))
	{	
		if(GtStringIsNotEmpty(cachedImage.fileName))
		{
			cachedImage.imageFile.fileName = cachedImage.fileName;
		}
		else
		{
			cachedImage.imageFile.fileName = [NSString guidString];
		}
	}
	
	cachedImage.fileName = cachedImage.imageFile.fileName;

	return YES;
}

- (void) updateOrAddToMemoryCache:(GtCachedImage*) cachedImage
{
	if(cachedImage.imageFile.hasImage)
	{
		CGSize size = cachedImage.imageFile.imageDimensions;
	
		if(MIN(size.width, size.height) <= m_maxLongSideForInMemoryCache)
		{
			[m_memoryCache updateOrAddObject:cachedImage forKey:cachedImage.imageId];
		}
	}
	else
	{
		GtLog(@"trying to save image to image cache with no image!");
	}
}

- (BOOL) didSaveObjectToDatabaseCache:(GtCachedImage*) cachedImage
{
	GtAssertNotNil(cachedImage);
	GtAssert([cachedImage isKindOfClass:[GtCachedImage class]], @"wrong type of class for image cache");
	
	if(!cachedImage.imageFile || !cachedImage.imageFile.hasImage)
	{
		GtLog(@"trying to save image to cache with no image data, bailing.");
		return NO;
	}
	
	[cachedImage.imageFile writeToStorage];
    [NSFileManager addSkipBackupAttributeToFile:cachedImage.imageFile.filePath];
	[self updateOrAddToMemoryCache:cachedImage];
	return YES;
}

- (id) loadObjectFromMemoryCache:(GtCachedImage*) inputObject
{
	GtAssertNotNil(inputObject);
	GtAssert([inputObject isKindOfClass:[GtCachedImage class]], @"wrong type of class for image cache");

	GtCachedImage* cachedImage = [m_memoryCache objectForKey:inputObject.imageId];
	if(cachedImage)
	{
		if(!cachedImage.imageFile || !cachedImage.imageFile.hasImage)
		{
			GtLog(@"Warning: empty photo in memory cache, dumping it");
			
			[m_memoryCache removeObjectForKey:inputObject.imageId];
			
			cachedImage = nil;
		}
	}
	
	return cachedImage;
}

- (void) didRemoveObjectFromCache:(GtCachedImage*) cachedImage
{
	GtAssertNotNil(cachedImage);
	GtAssert([cachedImage isKindOfClass:[GtCachedImage class]], @"wrong type of class for image cache");

	[m_memoryCache removeObjectForKey:cachedImage.imageId];

	cachedImage.imageFile.folder = [GtUserSession instance].photoCacheFolder;
	cachedImage.imageFile.fileName = cachedImage.fileName;
	if([cachedImage.imageFile existsInStorage])
	{
		[cachedImage.imageFile deleteFromStorage];
	}
}

- (BOOL) didLoadObjectFromDatabaseCache:(GtCachedImage*) cachedImage
{
	GtAssertNotNil(cachedImage);
	GtAssert([cachedImage isKindOfClass:[GtCachedImage class]], @"wrong class in image cache");
   
	// need to set this in the cached object and load the image from disk.
	GtJpegFile* imageFile = [[GtJpegFile alloc] initWithJpegData:nil folder:[GtUserSession instance].photoCacheFolder fileName:cachedImage.fileName];
	@try
	{
		if([imageFile existsInStorage])
		{
			[imageFile readFromStorage];
		}
		else
		{
			return NO;
		}

		if(!imageFile.hasImage)
		{
			GtLog(@"Warning: failed to load image from cache: %@, removing it from cache", imageFile.filePath);
			return NO;
		}
		
		cachedImage.imageFile = imageFile;
		[self updateOrAddToMemoryCache:cachedImage];
	}
	@catch(NSException* ex)
	{
		return NO;
	}
	@finally
	{
		GtReleaseWithNil(imageFile);
	}
	return YES;
}

- (id) createNewObjectForOutput:(GtCachedImage*) inputObject
{
	GtAssert([inputObject isKindOfClass:[GtCachedImage class]], @"wrong class in image cache");
	return GtReturnAutoreleased([[GtCachedImage alloc] init]);
}

//+ (void) clearImageCache:(id<GtCancellableOperation>) operation
//{
//	[m_memoryCache removeAllObjects];
//    [[GtUserSession instance].photoCacheFolder deleteAllFiles:operation];
//}

- (void) clearMemoryCache
{
	[m_memoryCache removeAllObjects];
}

@end

