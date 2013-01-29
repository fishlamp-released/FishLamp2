//
//	FLBatchDeletePhotos.h
//	MyZen
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "ZFPhotoSet.h"

@interface ZFBatchDeletePhotos : FLBatchActionManager {
	ZFPhotoSet* _photoSet;
}
@property (readwrite, retain, nonatomic) ZFPhotoSet* photoSet;

@end
#endif