//
//  FLDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFinisher.h"
#import "FLResult.h"

@protocol FLDispatcher;

@protocol FLDispatchable <NSObject>
- (FLResult) runSynchronously;
- (void) startAsync:(FLFinisher*) finisher;
@end

@protocol FLDispatchableSpecial <NSObject>

/// default is: - (void) startAsync:(FLFinisher*) finisher
- (SEL) asyncSelectorForDispatch:(id<FLDispatcher>) dispatcher;

/// default is: - (FLResult) runSynchronously;
- (SEL) synchronousSelectorForDispatch:(id<FLDispatcher>) dispatcher;

@end