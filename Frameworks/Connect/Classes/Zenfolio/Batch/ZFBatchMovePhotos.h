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
#import "ZFPhotoSet.h"

@interface ZFBatchMovePhotos : FLBatchActionManager {
	ZFPhotoSet* _parentPhotoSet;
	ZFPhotoSet* _destPhotoSet;
}

@property (readwrite, retain, nonatomic) ZFPhotoSet* sourcePhotoSet;
@property (readwrite, retain, nonatomic) ZFPhotoSet* destPhotoSet;


@end

#endif