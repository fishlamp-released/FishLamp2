//
//	ZFZfPhotoSet+More.h
//	MyZen
//
//	Created by Mike Fullerton on 10/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFPhotoSet.h"

@interface ZFPhotoSet (More)
- (void) addPhoto:(ZFPhoto*) photo;

- (BOOL) removePhoto:(ZFPhoto*) photo 
	forceCountDecrement:(BOOL) forceCountDecrement;

- (ZFPhoto*) photoAtIndex:(NSUInteger) idx;

- (BOOL) allPhotosAreLoaded;

- (BOOL) isStaleComparedTo:(int) anotherTextCn 
               photoListCn:(int) anotherPhotoListCn
                photoCount:(int) photoCount; // send in -1 to skip photoCount Test

- (BOOL) isStaleComparedToPhotoSet:(ZFPhotoSet*) photoSet;
               
@end