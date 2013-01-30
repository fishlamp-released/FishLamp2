//
//	FLBatchMovePhotos.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#if REFACTOR


#import "FLBatchActionManager.h"
#import "FLZenfolioPhotoSet.h"

@interface FLZenfolioBatchMovePhotos : FLBatchActionManager {
	FLZenfolioPhotoSet* _parentPhotoSet;
	FLZenfolioPhotoSet* _destPhotoSet;
}

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* sourcePhotoSet;
@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* destPhotoSet;


@end

#endif