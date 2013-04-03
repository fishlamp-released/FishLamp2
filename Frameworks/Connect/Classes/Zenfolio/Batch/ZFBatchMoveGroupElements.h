//
//	ZFBatchMoveGroupElements.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR
#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "ZFGroup.h"

@interface ZFBatchMoveGroupElements : FLBatchActionManager {
	ZFGroup* _parentGroup;
	ZFGroup* _destGroup;
}

@property (readwrite, retain, nonatomic) ZFGroup* parentGroup;
@property (readwrite, retain, nonatomic) ZFGroup* destinationGroup;

@end
#endif