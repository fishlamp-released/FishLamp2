//
//  ZFCacheService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFCacheService.h"
#import "ZFWebApi.h"

@interface ZFCacheService ()
- (void) deleteObjectFromCache:(id) object;
- (void) deletePhotoFromCache:(ZFPhoto*) photo;
- (void) deletePhotoSetFromCache:(ZFPhotoSet*) photoSet;
- (void) deleteGroupFromCache:(ZFGroup*) element;
@end

@implementation NSObject (ZFCacheService)
- (SEL) deleteSelectorForCache {    
    return @selector(deleteObjectFromCache:);
}
@end

@implementation ZFPhotoSet (ZFCacheService)
- (SEL) deleteSelectorForCache {    
    return @selector(deletePhotoSetFromCache:);
}
@end
@implementation ZFPhoto (ZFCacheService)

- (SEL) deleteSelectorForCache {    
    return @selector(deletePhotoFromCache:);
}
@end
@implementation ZFGroup (ZFCacheService)

- (SEL) deleteSelectorForCache {    
    return @selector(deleteGroupFromCache:);
}
@end


@implementation ZFCacheService

- (id) init {
	self = [super init];
	if(self) {
	}
	return self;
}

+ (id) cacheService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) deletePhotosInPhotoSet:(ZFPhotoSet*) photoSet {
  	if(photoSet.TitlePhoto) {
        [self deleteObject:photoSet.TitlePhoto];
    }
	
    for(ZFPhoto* photo in photoSet.Photos) {
		if(photo.IdValue != 0) {
            [self deleteObject:photo];
		}
	}
}

- (id) loadPhotoSetWithID:(int) groupID {
	ZFPhotoSet* inputObject = FLAutorelease([[ZFPhotoSet alloc] init]);
	inputObject.IdValue = groupID;
	return [self readObject:inputObject];
}

// FIXME(@"another obsolete fishlamp hook")
//- (BOOL) canSavePhotoSetToDatabase:(FLDatabase*) database
//{
//    if(self.PhotoCountValue != (int) self.Photos.count)
//    {
//        FLLog(@"saving invalid photo set");
//    }
//
//
//    return self.PhotoCountValue == (int) self.Photos.count;
//}

- (void) deleteGroupChildren:(ZFGroup*) group {
	
  	if(group.TitlePhoto) {
        [self deleteObject:group.TitlePhoto];
    }

    NSArray* array = group.Elements;
	for(ZFGroupElement* element in array) {
    
// TODO: not sure this is correct. Should it be deleting galleries?
        [self deleteObject:element];
	}
}

- (id) loadGroupWithID:(int) groupID {
	ZFGroup* inputObject = FLAutorelease([[ZFGroup alloc] init]);
	inputObject.IdValue = groupID;
	return [self readObject:inputObject];
}

- (FLStorableImage*) loadCachedImageForPhoto:(ZFPhoto*) photo 
                           imageSize:(ZFMediaType*) imageSize {
                           
    return [self readImageWithURLKey:[photo urlForImageWithSize:imageSize]];
}

- (void) writeCachedImage:(FLStorableImage*) image 
                 forPhoto:(ZFPhoto*) photo 
                imageSize:(ZFMediaType*) size {
                
}                

- (void) deleteCachedImagesForPhoto:(ZFPhoto*) photo {
 	if(photo.IdValue != 0) {
        for(ZFMediaType* size in [ZFMediaType allMediaTypes]) {
            FLStorableImage* image = [self loadCachedImageForPhoto:photo imageSize:size];
            if(image) {
                [self deleteObject:image];
            }
        }
    }
}

- (ZFPhoto*) loadPhotoWithID:(int) photoId {
	if(photoId != 0) {
		ZFPhoto* inputObject = [ZFPhoto photo];
		inputObject.IdValue = photoId;
		return [self readObject:inputObject];
	}
	
	return nil;
}

// these are special methods set by selector above for object's deleteSelectorForCache.
// TODO: abstract this functionality into Database?

- (void) deleteObjectFromCache:(id) object {
    [self.dataStore deleteObject:object];
}

- (void) deletePhotoFromCache:(ZFPhoto*) photo {
	if(photo.IdValue != 0) {
        [self deleteCachedImagesForPhoto:photo];
        [self.dataStore deleteObject:photo];
	}
}

- (void) deletePhotoSetFromCache:(ZFPhotoSet*) photoSet {
	ZFPhotoSet* cached = [self loadPhotoSetWithID:photoSet.IdValue];
	if(cached){
		[self deletePhotosInPhotoSet:cached];
	}
	[self deletePhotosInPhotoSet:photoSet];
    [self.dataStore deleteObject:photoSet];
}

- (void) deleteGroupFromCache:(ZFGroup*) element {
	ZFGroup* group = [self loadGroupWithID:[element IdValue]];
	if(group) {
		[self deleteGroupChildren:group];
	}

    [self deleteGroupChildren:element];
	[self.dataStore deleteObject:element];
}

- (void) deleteObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.dataStore);
    FLPerformSelector1(self, [object deleteSelectorForCache], object);
}

#if REFACTOR
#if IOS

- (FLMasterPhotoExif*) exif
{
	FLMasterPhotoExif* exif = nil;
	if(self.IdValue != 0)
	{
		NSString* urlKeyForCachedImage = [self buildURLStringForDownloading:kImageDownloadSize];
		FLCachedImage* image = FLAutorelease([[FLCachedImage alloc] initWithUrlString:urlKeyForCachedImage]);
		FLCachedImage* cachedImage = [[[[self.context userStorageService] cacheDatabase] readObject:image]; 
		if(cachedImage)
		{
			exif = FLAutorelease([[FLMasterPhotoExif alloc] initWithDictionary:cachedImage.imageFile.properties]);
		}
	}
	return exif;
}


- (FLGpsExif*) gpsExif
{
	if(!self.isFullVersion)
	{
		return nil;
	}

	int count = 0;
	FLGpsExif* exif = [FLGpsExif gpsExif];
	for(ZFExifTag* exifTag in self.ExifTagsArray)
	{
		switch(exifTag.IdValue)
		{
			case EXIF_GPSLatitudeRef:
				count++;
				[exif.exifDictionary setObject:exifTag.Value forKey:(NSString*) kCGImagePropertyGPSLatitudeRef];
			break;	   
			case EXIF_GPSLatitude:	
				count++;
				[exif.exifDictionary setObject:[NSNumber numberWithDouble:[exifTag.Value doubleValue]] forKey:(NSString*) kCGImagePropertyGPSLatitude];
			break;	   
			case EXIF_GPSLongitudeRef:
				count++;
				[exif.exifDictionary setObject:exifTag.Value forKey:(NSString*) kCGImagePropertyGPSLongitudeRef];
			break;	   
			case EXIF_GPSLongitude:		
				count++;
				[exif.exifDictionary setObject:[NSNumber numberWithDouble:[exifTag.Value doubleValue]] forKey:(NSString*) kCGImagePropertyGPSLongitude];
			break;	   
		}
	}
	
	return count == 4 ? exif : nil;
}

- (FLMasterPhotoExif*) exifOnlyIfHasGpsCoordinates
{
	__block FLMasterPhotoExif* masterExif = nil;
		
#if FL_MRC
	FLPerformBlockInAutoreleasePool(^{
#endif    
		NSString* urlKeyForCachedImage = [self buildURLStringForDownloading:kImageDownloadSize];
		FLCachedImage* image = FLAutorelease([[FLCachedImage alloc] initWithUrlString:urlKeyForCachedImage]);

		FLCachedImage* cachedImage = [[[[self.context userStorageService] cacheDatabase] readObject:image]; 
		if(cachedImage)
		{
			NSDictionary* exif = cachedImage.imageFile.properties;
			if([FLMasterPhotoExif gpsExifOnlyIfHasGpsCoordinates:exif])
			{
				masterExif = FLAutorelease([[FLMasterPhotoExif alloc] initWithDictionary:exif]);
			}
		}
#if FL_MRC
	});
#endif    

    return masterExif;
}

- (void) openService:(id) opener {
    FLPerformSelector1(opener, @selector(openZenfolioCache:), self);
    [super openService];
}

- (void) closeService:(id) opener {
    FLPerformSelector1(opener, @selector(closeZenfolioCache:), self);
    [super openService];
}


//- (CLLocationCoordinate2D) gpsCoordinate
//{
//	if(self.IdValue != 0)
//	  {
//		  CLLocationCoordinate2D coordinate = kCLLocationCoordinate2DInvalid;
//		  
//		  NSString* urlKeyForCachedImage = [self buildPhotoUrl:kImageDownloadSize];
//		  FLCachedImage* image = [[FLCachedImage alloc] initWithUrl:urlKeyForCachedImage];
//		  FLCachedImage* cachedImage = nil;
//		  [[[[self.context userStorageService] cacheDatabase] readObject:image outputObject:&cachedImage]; 
//		  if(cachedImage)
//		  {
//			  NSDictionary* exif = cachedImage.imageFile.properties;
//			  NSDictionary* gps = [exif objectForKey:(NSString*)kCGImagePropertyGPSDictionary];
//			  
//			  coordinate.latitude = [[gps objectForKey:(NSString*)kCGImagePropertyGPSLatitude] doubleValue];
//			  coordinate.longitude = [[gps objectForKey:(NSString*)kCGImagePropertyGPSLongitude] doubleValue];
//		  }
//		  
//		  FLRelease(cachedImage);
//		  FLRelease(image);
//		  
//		  return coordinate;
//	  }
//	  
//	  return kCLLocationCoordinate2DInvalid;
//}

#endif // if IOS

#endif // REFACTOR

@end
