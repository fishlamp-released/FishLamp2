//
//	FLBatchDeletePhotos.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "FLZfPhotoSet.h"

@interface FLZfBatchDeletePhotos : FLBatchActionManager {
	FLZfPhotoSet* _photoSet;
}
@property (readwrite, retain, nonatomic) FLZfPhotoSet* photoSet;

@end
#endif