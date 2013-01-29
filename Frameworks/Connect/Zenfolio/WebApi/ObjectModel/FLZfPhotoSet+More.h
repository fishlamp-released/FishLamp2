//
//	FLZfZfPhotoSet+More.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfPhotoSet.h"

@interface FLZfPhotoSet (More)
- (void) addPhoto:(FLZfPhoto*) photo;

- (BOOL) removePhoto:(FLZfPhoto*) photo 
	forceCountDecrement:(BOOL) forceCountDecrement;

- (FLZfPhoto*) photoAtIndex:(NSUInteger) idx;

- (BOOL) allPhotosAreLoaded;

- (BOOL) isStaleComparedTo:(int) anotherTextCn 
               photoListCn:(int) anotherPhotoListCn
                photoCount:(int) photoCount; // send in -1 to skip photoCount Test

- (BOOL) isStaleComparedToPhotoSet:(FLZfPhotoSet*) photoSet;
               
@end