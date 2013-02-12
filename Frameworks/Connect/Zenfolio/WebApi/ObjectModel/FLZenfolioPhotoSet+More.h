//
//	FLZenfolioZenfolioPhotoSet+More.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioPhotoSet.h"

@interface FLZenfolioPhotoSet (More)
- (void) addPhoto:(FLZenfolioPhoto*) photo;

- (BOOL) removePhoto:(FLZenfolioPhoto*) photo 
	forceCountDecrement:(BOOL) forceCountDecrement;

- (FLZenfolioPhoto*) photoAtIndex:(NSUInteger) idx;

- (BOOL) allPhotosAreLoaded;

- (BOOL) isStaleComparedTo:(int) anotherTextCn 
               photoListCn:(int) anotherPhotoListCn
                photoCount:(int) photoCount; // send in -1 to skip photoCount Test

- (BOOL) isStaleComparedToPhotoSet:(FLZenfolioPhotoSet*) photoSet;
               
@end