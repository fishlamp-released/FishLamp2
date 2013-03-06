//
//	FLZenfolioZenfolioPhotoSet+More.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioPhotoSet+More.h"
#import "FLObjectCacheBehavior.h"

@implementation FLZenfolioPhotoSet (More)

FLSynthesizeCachedObjectHandlerProperty(FLZenfolioPhotoSet);

- (void) addPhoto:(FLZenfolioPhoto*) photo {
	if(photo.IdValue != 0) {
		if(!self.Photos) {
			self.Photos = [NSMutableArray array];
		}
	
		[self.Photos addObject:photo];
		
		self.PhotoCountValue = self.PhotoCountValue + 1;
	}
}

- (BOOL) removePhoto:(FLZenfolioPhoto*) photoToRemove
 forceCountDecrement:(BOOL) forceCountDecrement {
	if(photoToRemove.IdValue == 0) {
		return NO;
	}

	BOOL foundIt = NO;
	if(self.Photos) {
		NSMutableArray* array = self.Photos;
		for(NSUInteger i = 0; i < array.count; i++) {
			FLZenfolioPhoto* photo = [array objectAtIndex:i];
		
			if(photo.IdValue == photoToRemove.IdValue) {
				[array removeObjectAtIndex:i];
				foundIt = YES;
				break;
			}
		}
	}
	
	if(forceCountDecrement || foundIt) {
		self.PhotoCountValue = self.PhotoCountValue - 1;
	}
	
	return foundIt;
}


- (FLZenfolioPhoto*) photoAtIndex:(NSUInteger) idx {
	return (self.Photos && idx < (NSUInteger) self.Photos.count) ? [self.Photos objectAtIndex:idx] : nil;
}

- (NSUInteger) countLoadedPhotos {
 
	NSUInteger loadedCount = 0;
	for(FLZenfolioPhoto* photo in self.Photos) {
		if(photo.IdValue == 0){
			break;
		}
		++loadedCount;
	}

	return loadedCount;
}

- (BOOL) allPhotosAreLoaded {
	return self.Photos.count == (NSUInteger) self.PhotoCountValue;
}

- (BOOL) isStaleComparedTo:(int) anotherTextCn 
               photoListCn:(int) anotherPhotoListCn
                photoCount:(int) photoCount {
                
    return  (self.TextCnValue < anotherTextCn) ||
            (self.PhotoListCnValue < anotherPhotoListCn) ||
            ![self allPhotosAreLoaded] || 
            (photoCount >=0 && self.PhotoCountValue != photoCount);
}

- (BOOL) isStaleComparedToPhotoSet:(FLZenfolioPhotoSet*) photoSet {
    FLAssert_v(photoSet.IdValue == self.IdValue, @"different photoSets");
    return [self isStaleComparedTo:photoSet.TextCnValue photoListCn:photoSet.PhotoListCnValue photoCount:photoSet.PhotoCountValue];
}

- (NSArray*) Elements {
    return self.Photos;
}

- (BOOL) isGalleryElement {
	return self.TypeValue == FLZenfolioPhotoSetTypeGallery;
}

- (BOOL) isCollectionElement {
	return self.TypeValue == FLZenfolioPhotoSetTypeCollection;
}
@end
