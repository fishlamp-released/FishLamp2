//
//  FLZenfolioCacheService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioCacheService.h"
#import "FLZenfolioWebApi.h"

@interface FLZenfolioCacheService ()
- (void) deleteObjectFromCache:(id) object;
- (void) deletePhotoFromCache:(FLZenfolioPhoto*) photo;
- (void) deletePhotoSetFromCache:(FLZenfolioPhotoSet*) photoSet;
- (void) deleteGroupFromCache:(FLZenfolioGroup*) element;
@end

@implementation NSObject (FLZenfolioCacheService)
- (SEL) deleteSelectorForCache {    
    return @selector(deleteObjectFromCache:);
}
@end

@implementation FLZenfolioPhotoSet (FLZenfolioCacheService)
- (SEL) deleteSelectorForCache {    
    return @selector(deletePhotoSetFromCache:);
}
@end
@implementation FLZenfolioPhoto (FLZenfolioCacheService)

- (SEL) deleteSelectorForCache {    
    return @selector(deletePhotoFromCache:);
}
@end
@implementation FLZenfolioGroup (FLZenfolioCacheService)

- (SEL) deleteSelectorForCache {    
    return @selector(deleteGroupFromCache:);
}
@end


@implementation FLZenfolioCacheService

- (id) init {
	self = [super init];
	if(self) {
	}
	return self;
}

+ (id) cacheService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) deletePhotosInPhotoSet:(FLZenfolioPhotoSet*) photoSet {
  	if(photoSet.TitlePhoto) {
        [self deleteObject:photoSet.TitlePhoto];
    }
	
    for(FLZenfolioPhoto* photo in photoSet.Photos) {
		if(photo.IdValue != 0) {
            [self deleteObject:photo];
		}
	}
}

- (id) loadPhotoSetWithID:(int) groupID {
	FLZenfolioPhotoSet* inputObject = FLAutorelease([[FLZenfolioPhotoSet alloc] init]);
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

- (void) deleteGroupChildren:(FLZenfolioGroup*) group {
	
  	if(group.TitlePhoto) {
        [self deleteObject:group.TitlePhoto];
    }

    NSArray* array = group.Elements;
	for(FLZenfolioGroupElement* element in array) {
    
// TODO: not sure this is correct. Should it be deleting galleries?
        [self deleteObject:element];
	}
}

- (id) loadGroupWithID:(int) groupID {
	FLZenfolioGroup* inputObject = FLAutorelease([[FLZenfolioGroup alloc] init]);
	inputObject.IdValue = groupID;
	return [self readObject:inputObject];
}

- (FLStorableImage*) loadCachedImageForPhoto:(FLZenfolioPhoto*) photo 
                           imageSize:(FLZenfolioImageSize*) imageSize {
                           
    return [self readImageWithURLKey:[photo urlForImageWithSize:imageSize]];
}

- (void) writeCachedImage:(FLStorableImage*) image 
                 forPhoto:(FLZenfolioPhoto*) photo 
                imageSize:(FLZenfolioImageSize*) size {
                
}                

- (void) deleteCachedImagesForPhoto:(FLZenfolioPhoto*) photo {
 	if(photo.IdValue != 0) {
        for(FLZenfolioImageSize* size in [FLZenfolioImageSize allImageSizes]) {
            FLStorableImage* image = [self loadCachedImageForPhoto:photo imageSize:size];
            if(image) {
                [self deleteObject:image];
            }
        }
    }
}

- (FLZenfolioPhoto*) loadPhotoWithID:(int) photoId {
	if(photoId != 0) {
		FLZenfolioPhoto* inputObject = [FLZenfolioPhoto photo];
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

- (void) deletePhotoFromCache:(FLZenfolioPhoto*) photo {
	if(photo.IdValue != 0) {
        [self deleteCachedImagesForPhoto:photo];
        [self.dataStore deleteObject:photo];
	}
}

- (void) deletePhotoSetFromCache:(FLZenfolioPhotoSet*) photoSet {
	FLZenfolioPhotoSet* cached = [self loadPhotoSetWithID:photoSet.IdValue];
	if(cached){
		[self deletePhotosInPhotoSet:cached];
	}
	[self deletePhotosInPhotoSet:photoSet];
    [self.dataStore deleteObject:photoSet];
}

- (void) deleteGroupFromCache:(FLZenfolioGroup*) element {
	FLZenfolioGroup* group = [self loadGroupWithID:[element IdValue]];
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
	for(FLZenfolioExifTag* exifTag in self.ExifTagsArray)
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
