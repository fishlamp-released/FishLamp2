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
#import "FLZenfolioPhotoSet.h"

@interface FLZenfolioBatchDeletePhotos : FLBatchActionManager {
	FLZenfolioPhotoSet* _photoSet;
}
@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* photoSet;

@end
#endif