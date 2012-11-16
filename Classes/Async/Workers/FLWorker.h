//
//  FLWorker.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

#import "FLFinisher.h"
#import "FLFallible.h"

@protocol FLWorkerParent;

@protocol FLWorker <FLFallible>
- (FLFinisher*) startWorking:(FLFinisher*) finisher;

@optional 
- (void) didMoveToParentWorker:(id<FLWorkerParent>) parent;

@end

@protocol FLRunnable <NSObject>
- (id) runSynchronously;
- (id) runSynchronously:(FLFinisher*) finisher;
@end

@protocol FLWorkerParent <FLWorker>
@property (readonly, assign) id parentWorker;
- (void) willAddWorker:(id<FLWorker>) worker;
- (void) willRemoveWorker:(id<FLWorker>) worker;
@end

@interface FLWorker : NSObject<FLWorkerParent, FLRunnable, FLWorker> {
@private
    __unsafe_unretained id _parentWorker;
    __unsafe_unretained id _errorDelegate;
}

@end