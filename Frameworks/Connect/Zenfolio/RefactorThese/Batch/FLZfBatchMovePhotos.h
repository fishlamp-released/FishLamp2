//
//	FLBatchMovePhotos.h
//	MyZen
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#if REFACTOR


#import "FLBatchActionManager.h"
#import "FLZfPhotoSet.h"

@interface FLZfBatchMovePhotos : FLBatchActionManager {
	FLZfPhotoSet* _parentPhotoSet;
	FLZfPhotoSet* _destPhotoSet;
}

@property (readwrite, retain, nonatomic) FLZfPhotoSet* sourcePhotoSet;
@property (readwrite, retain, nonatomic) FLZfPhotoSet* destPhotoSet;


@end

#endif