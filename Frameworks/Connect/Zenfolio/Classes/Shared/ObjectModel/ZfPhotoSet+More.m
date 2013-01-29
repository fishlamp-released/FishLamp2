//
//	ZFZfPhotoSet+More.m
//	MyZen
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFPhotoSet+More.h"
#import "FLObjectCacheBehavior.h"

@implementation ZFPhotoSet (More)

FLSynthesizeCachedObjectHandlerProperty(ZFPhotoSet);

- (void) addPhoto:(ZFPhoto*) photo {
	if(photo.IdValue != 0) {
		if(!self.Photos) {
			self.Photos = [NSMutableArray array];
		}
	
		[self.Photos addObject:photo];
		
		self.PhotoCountValue = self.PhotoCountValue + 1;
	}
}

- (BOOL) removePhoto:(ZFPhoto*) photoToRemove
 forceCountDecrement:(BOOL) forceCountDecrement {
	if(photoToRemove.IdValue == 0) {
		return NO;
	}

	BOOL foundIt = NO;
	if(self.Photos) {
		NSMutableArray* array = self.Photos;
		for(NSUInteger i = 0; i < array.count; i++) {
			ZFPhoto* photo = [array objectAtIndex:i];
		
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


- (ZFPhoto*) photoAtIndex:(NSUInteger) idx {
	return (self.Photos && idx < (NSUInteger) self.Photos.count) ? [self.Photos objectAtIndex:idx] : nil;
}

- (NSUInteger) countLoadedPhotos {
 
	NSUInteger loadedCount = 0;
	for(ZFPhoto* photo in self.Photos) {
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

- (BOOL) isStaleComparedToPhotoSet:(ZFPhotoSet*) photoSet {
    FLAssert_v(photoSet.IdValue == self.IdValue, @"different photoSets");
    return [self isStaleComparedTo:photoSet.TextCnValue photoListCn:photoSet.PhotoListCnValue photoCount:photoSet.PhotoCountValue];
}

- (NSArray*) elements {
    return self.Photos;
}

- (unsigned long long) photoBytes {
    return self.PhotoBytesValue;
}

- (int) videoCount {
    return self.VideoCountValue;
}

//- (long long)photoBytes
//{
//	//	NOTE: we can't expect 0 for [nil longLongValue] on ppc
//	NSArray *elem = [self elements];
//	switch ( _type ) {
//		case kZFGroupType:
//			//	for groups return sum from contained entry sizes
//			return elem ? [[elem valueForKeyPath:@"@sum.photoBytes"] longLongValue] : 0;
//		case kZFCollectionType:
//			//	for collections return the size of owned photos
//			return elem ? [[elem valueForKeyPath:@"@sum.size"] longLongValue] : 0;
//		default:
//			//	this is a gallery: return reported size
//			return _photoBytes;
//	}
//}


@end
