//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLResult.h"

@class FLFinisher;

typedef void (^FLDispatcherBlock)();
typedef void (^FLDispatcherFinisherBlock)(FLFinisher* finisher);
typedef void (^FLDispatcherResultBlock)(FLResult result);

@protocol FLDispatcher <NSObject>
// 
// block dispatching
//
- (FLFinisher*) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLDispatcherBlock) block;

- (FLFinisher*) dispatchBlock:(FLDispatcherBlock) block;

- (FLFinisher*) dispatchBlock:(FLDispatcherBlock) block
                   completion:(FLDispatcherResultBlock) completion;

- (FLFinisher*) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block;

- (FLFinisher*) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block
                             completion:(FLDispatcherResultBlock) completion;

// 
// FLAsyncDispatchable dispatching
// 

- (FLFinisher*) dispatchObject:(id /*FLAsyncWorker*/) dispatchableObject;

- (FLFinisher*) dispatchObject:(id /*FLAsyncWorker*/) dispatchableObject 
                    completion:(FLDispatcherResultBlock) completion;
                    
@end                    

@interface FLDispatcher : NSObject<FLDispatcher> {
}

// required overrides. these are the bottlenecks
- (void) dispatchBlock:(FLDispatcherBlock) block 
              withFinisher:(FLFinisher*) finisher;

- (void) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block 
              withFinisher:(FLFinisher*) finisher;

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLDispatcherBlock) block 
                          withFinisher:(FLFinisher*) finisher;

// optional overrides
- (FLFinisher*) createFinisher:(FLDispatcherResultBlock) completionBlock;

@end

