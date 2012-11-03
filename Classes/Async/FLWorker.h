//
//  FLWorker.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

#import "FLResult.h"
#import "FLPromisedResult.h"
#import "FLFinisher.h"
#import "FLFallible.h"
#import "FLRunnable.h"

@protocol FLWorkerParent;

@protocol FLWorker <FLFallible>
- (void) startWorking:(id<FLFinisher>) finisher;

@optional 
- (void) didMoveToParentWorker:(id<FLWorkerParent>) parent;

@end

@protocol FLWorkerParent <FLWorker>
@property (readonly, assign) id parentWorker;
- (void) willAddWorker:(id<FLWorker>) worker;
- (void) willRemoveWorker:(id<FLWorker>) worker;
@end