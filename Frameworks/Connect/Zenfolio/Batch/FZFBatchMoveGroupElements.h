//
//	FLZenfolioBatchMoveGroupElements.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR
#import <Foundation/Foundation.h>

#import "FLBatchActionManager.h"
#import "FLZenfolioGroup.h"

@interface FLZenfolioBatchMoveGroupElements : FLBatchActionManager {
	FLZenfolioGroup* _parentGroup;
	FLZenfolioGroup* _destGroup;
}

@property (readwrite, retain, nonatomic) FLZenfolioGroup* parentGroup;
@property (readwrite, retain, nonatomic) FLZenfolioGroup* destinationGroup;

@end
#endif