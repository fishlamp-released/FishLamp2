//
//  FLZfCacheService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfCacheService.h"

#import "FLUserDataStorageService.h"
#import "FLZfSyncService.h"

@interface FLZfCacheService ()
- (void) deleteGroup:(FLZfGroup*) element;
- (void) deletePhotoSet:(FLZfPhotoSet*) element;
@end

@implementation FLZfCacheService

//- (id) init {
//	self = [super init];
//	if(self) {
//        
//	}
//	return self;
//}

#if FL_MRC
- (void) dealloc {
//    [_imageFolder release];
	[super dealloc];
}
#endif

+ (id) cacheService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLDatabase*) database {
//    return [self.context resourceForKey:FLUserDataCacheDatabaseKey];
    return [[self.context userStorageService] cacheDatabase];
}

- (FLImageFolder*) imageFolder {
//    return [self.context resourceForKey:FLUserDataImageCacheFolderKey];

    return [[self.context userStorageService] imageFolder];
}

- (void) saveObject:(id) object {
    [self.database saveObject:object];
}

- (void) _deletePhotoSet:(FLZfPhotoSet*) photoSet {
	for(FLZfPhoto* photo in photoSet.Photos) {
		if(photo.IdValue != 0) {
            [self deletePhoto:photo];
		}
	}
}

- (void) deletePhotoSet:(FLZfPhotoSet*) photoSet {
	FLZfPhotoSet* cached = [self loadPhotoSetWithID:photoSet.IdValue];
	if(cached){
		[self _deletePhotoSet:cached];
	}
	[self _deletePhotoSet:photoSet];
}

- (id) loadPhotoSetWithID:(int) groupID {
	FLZfPhotoSet* inputObject = FLAutorelease([[FLZfPhotoSet alloc] init]);
	inputObject.IdValue = groupID;
	return [self.database loadObject:inputObject];
}

- (void) savePhotoSet:(FLZfPhotoSet*) photoSet {
// TODO: I don't like this
    [[self.context syncService] elementWasUpdated:photoSet];

}

- (void) saveGroup:(FLZfGroup*) group {
// TODO: I don't like this
    [[self.context syncService] elementWasUpdated:group];
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

- (void) _deleteGroup:(FLZfGroup*) group {
	
    NSArray* array = group.Elements;
	for(FLZfGroupElement* element in array) {
        [self deleteGroupElement:element];
	}
}

- (void) deleteGroup:(FLZfGroup*) element {
	FLZfGroup* group = [self loadGroupWithID:[element IdValue]];
	if(group) {
		[self _deleteGroup:group];
	}

	[self _deleteGroup:element];
}

- (void) deleteGroupElement:(FLZfGroupElement*) groupElement {
    if(groupElement.isGroupElement) {
        [self deleteGroup:(FLZfGroup*)groupElement];
    }
    else {
        [self deletePhotoSet:(FLZfPhotoSet*)groupElement];
    }
    
  	[[self.context syncService] removeSyncStateForElement:groupElement];
    if(groupElement.TitlePhoto) {
        [self deletePhoto:groupElement.TitlePhoto];
    }
    
    [self.database deleteObject:groupElement];
}

- (id) loadGroupWithID:(int) groupID {
	FLZfGroup* inputObject = FLAutorelease([[FLZfGroup alloc] init]);
	inputObject.IdValue = groupID;
	return [self.database loadObject:inputObject];
}

- (void) savePhoto:(FLZfPhoto*) photo {
    [self.database saveObject:photo];
}

- (FLStorableImage*) loadCachedImageForPhoto:(FLZfPhoto*) photo 
                           imageSize:(FLZfImageSize*) imageSize {
                           
    return [self readImageWithURLKey:[photo urlForImageWithSize:imageSize]];
}

- (void) deleteCachedImagesForPhoto:(FLZfPhoto*) photo {
 	if(photo.IdValue != 0) {
        for(FLZfImageSize* size in [FLZfImageSize allImageSizes]) {
            FLStorableImage* image = [self loadCachedImageForPhoto:photo imageSize:size];
            if(image) {
                [self deleteImage:image];
            }
        }
    }
}

- (FLZfPhoto*) loadPhotoWithID:(int) photoId {
	if(photoId != 0) {
		FLZfPhoto* inputObject = [FLZfPhoto photo];
		inputObject.IdValue = photoId;
		return [self.database loadObject:inputObject];
	}
	
	return nil;
}

- (void) deletePhoto:(FLZfPhoto*) photo {
	if(photo.IdValue != 0) {
        [self deleteCachedImagesForPhoto:photo];
        [self.database deleteObject:photo];
	}
}

- (void) updateObject:(id) object {
    [self.database saveObject:object];
}

- (id) readObject:(id) inputObject {
    return [self.database loadObject:inputObject];
}

- (void) deleteObject:(id) object {
    [self deleteObject:object];
}


#if IOS

- (FLMasterPhotoExif*) exif
{
	FLMasterPhotoExif* exif = nil;
	if(self.IdValue != 0)
	{
		NSString* urlKeyForCachedImage = [self buildURLStringForDownloading:kImageDownloadSize];
		FLCachedImage* image = FLAutorelease([[FLCachedImage alloc] initWithUrlString:urlKeyForCachedImage]);
		FLCachedImage* cachedImage = [[[[self.context userStorageService] cacheDatabase] loadObject:image]; 
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
	for(FLZfExifTag* exifTag in self.ExifTagsArray)
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

		FLCachedImage* cachedImage = [[[[self.context userStorageService] cacheDatabase] loadObject:image]; 
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



//- (CLLocationCoordinate2D) gpsCoordinate
//{
//	if(self.IdValue != 0)
//	  {
//		  CLLocationCoordinate2D coordinate = kCLLocationCoordinate2DInvalid;
//		  
//		  NSString* urlKeyForCachedImage = [self buildPhotoUrl:kImageDownloadSize];
//		  FLCachedImage* image = [[FLCachedImage alloc] initWithUrl:urlKeyForCachedImage];
//		  FLCachedImage* cachedImage = nil;
//		  [[[[self.context userStorageService] cacheDatabase] loadObject:image outputObject:&cachedImage]; 
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



@end
