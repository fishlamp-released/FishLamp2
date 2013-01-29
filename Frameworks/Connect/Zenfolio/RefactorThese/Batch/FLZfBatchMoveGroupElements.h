//
//	FLZfBatchMoveGroupElements.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR
#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "FLZfGroup.h"

@interface FLZfBatchMoveGroupElements : FLBatchActionManager {
	FLZfGroup* _parentGroup;
	FLZfGroup* _destGroup;
}

@property (readwrite, retain, nonatomic) FLZfGroup* parentGroup;
@property (readwrite, retain, nonatomic) FLZfGroup* destinationGroup;

@end
#endif