//
//	FLCacheableImageBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCachedImageCacheBehavior.h"
#import "FLCacheManager.h"
#import "NSString+Guid.h"
#import "NSFileManager+FLExtras.h"

#if REFACTOR

@implementation FLCachedImageCacheBehavior

@synthesize maxLongSideForInMemoryCache = _maxLongSideForInMemoryCache;

#if DEBUG
@synthesize warnOnMainThreadLoad = _warnOnMainThreadLoad;
@synthesize warnOnMainThreadWrite = _warnOnMainThreadWrite;
@synthesize warnOnMainThreadDelete = _warnOnMainThreadDelete;
#endif

- (FLFolder*) _imageCacheFolder {

// TODO: Finish decoupling this
// [FLUserLoginService instance].imageCacheFolder

    return nil;
}
- (void) _doClearCache:(NSNotification*) notification {
    [[self _imageCacheFolder] deleteAllFiles:^(NSString* file, BOOL* stop) {
        if(notification.cancellableOperation.wasCancelled) {
            *stop = YES;
        }
    }];
}


- (id) initWithCapacity:(NSUInteger) capacity {
	if((self = [super init])) {
		_memoryCache = [[FLInMemoryDataCache alloc] initWithCapacity:capacity];


FIXME("attach to user sessions....");
//		[[NSNotificationCenter defaultCenter] addObserver:self 
//				selector:@selector(_doClearCache:) 
//				name:FLCacheManagerEmptyCacheNotification
//				object:[FLCacheManager instance]];

#if DEBUG
		_warnOnMainThreadLoad = YES;
		_warnOnMainThreadWrite = YES;
		_warnOnMainThreadDelete = YES;
#endif	 
	}
	return self;
}

+ (FLCachedImageCacheBehavior*) cachedImageCacheBehavior:(NSUInteger) capacity 
{
	return autorelease_([[FLCachedImageCacheBehavior alloc] initWithCapacity:capacity]);
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	release_(_memoryCache);
	super_dealloc_();
}

- (BOOL) willSaveObjectToDatabaseCache:(FLImageProperties*) cachedImage
{
	FLAssertIsNotNil_v(cachedImage, nil);
	FLAssert_v([cachedImage isKindOfClass:[FLImageProperties class]], @"wrong type of class for image cache");
	
	if(!cachedImage.imageFile || !cachedImage.imageFile.hasImage)
	{
		FLDebugLog(@"trying to save image to cache with no image data, bailing.");
		return NO;
	}
	
	if(!cachedImage.imageFile.folder)
	{
		cachedImage.imageFile.folder = [self _imageCacheFolder];
	}
	
	if(FLStringIsEmpty(cachedImage.imageFile.fileName))
	{	
		if(FLStringIsNotEmpty(cachedImage.fileName))
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

- (void) updateOrAddToMemoryCache:(FLImageProperties*) cachedImage
{
	if(cachedImage.imageFile.hasImage)
	{
		SDKSize size = cachedImage.imageFile.imageDimensions;
	
		if(MIN(size.width, size.height) <= _maxLongSideForInMemoryCache)
		{
			[_memoryCache updateOrAddObject:cachedImage forKey:cachedImage.imageId];
		}
	}
	else
	{
		FLDebugLog(@"trying to save image to image cache with no image!");
	}
}

- (BOOL) didSaveObjectToDatabaseCache:(FLImageProperties*) cachedImage
{
	FLAssertIsNotNil_v(cachedImage, nil);
	FLAssert_v([cachedImage isKindOfClass:[FLImageProperties class]], @"wrong type of class for image cache");
	
	if(!cachedImage.imageFile || !cachedImage.imageFile.hasImage)
	{
		FLDebugLog(@"trying to save image to cache with no image data, bailing.");
		return NO;
	}
	
	[cachedImage.imageFile writeToStorage];
#if IOS
    [NSFileManager addSkipBackupAttributeToFile:cachedImage.imageFile.filePath];
#endif    
	[self updateOrAddToMemoryCache:cachedImage];
	return YES;
}

- (id) loadObjectFromMemoryCache:(FLImageProperties*) inputObject
{
	FLAssertIsNotNil_v(inputObject, nil);
	FLAssert_v([inputObject isKindOfClass:[FLImageProperties class]], @"wrong type of class for image cache");

	FLImageProperties* cachedImage = [_memoryCache objectForKey:inputObject.imageId];
	if(cachedImage)
	{
		if(!cachedImage.imageFile || !cachedImage.imageFile.hasImage)
		{
			FLDebugLog(@"Warning: empty photo in memory cache, dumping it");
			
			[_memoryCache removeObjectForKey:inputObject.imageId];
			
			cachedImage = nil;
		}
	}
	
	return cachedImage;
}

- (void) didRemoveObjectFromCache:(FLImageProperties*) cachedImage
{
	FLAssertIsNotNil_v(cachedImage, nil);
	FLAssert_v([cachedImage isKindOfClass:[FLImageProperties class]], @"wrong type of class for image cache");

	[_memoryCache removeObjectForKey:cachedImage.imageId];

	cachedImage.imageFile.folder = [self _imageCacheFolder];
	cachedImage.imageFile.fileName = cachedImage.fileName;
	if([cachedImage.imageFile existsInStorage])
	{
		[cachedImage.imageFile deleteFromStorage];
	}
}

- (BOOL) didLoadObjectFromDatabaseCache:(FLImageProperties*) cachedImage
{
	FLAssertIsNotNil_v(cachedImage, nil);
	FLAssert_v([cachedImage isKindOfClass:[FLImageProperties class]], @"wrong class in image cache");
   
	// need to set this in the cached object and load the image from disk.
	FLJpegFile* imageFile = [[FLJpegFile alloc] initWithJpegData:nil folder:[self _imageCacheFolder] fileName:cachedImage.fileName];
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
			FLDebugLog(@"Warning: failed to load image from cache: %@, removing it from cache", imageFile.filePath);
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
		FLReleaseWithNil_(imageFile);
	}
	return YES;
}


//+ (void) clearImageCache:(id<FLCancellable>) operation
//{
//	[_memoryCache removeAllObjects];
//    [[FLUserLoginService instance].imageCacheFolder deleteAllFiles:operation];
//}

- (void) clearMemoryCache
{
	[_memoryCache removeAllObjects];
}

@end

#endif