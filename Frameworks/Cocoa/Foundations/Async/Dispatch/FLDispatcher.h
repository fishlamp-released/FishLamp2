//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLResult.h"
#import "FLDispatchTypes.h"
#import "FLDispatchable.h"
#import "FLFinisher.h"
#import "FLDispatchTypes.h"

@protocol FLDispatcher <NSObject>
// 
// block dispatching
//
- (FLFinisher*) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLBlock) block;

- (FLFinisher*) dispatchBlock:(FLBlock) block;

- (FLFinisher*) dispatchBlock:(FLBlock) block
                   completion:(FLBlockWithResult) completion;

- (FLFinisher*) dispatchFinishableBlock:(FLBlockWithFinisher) block;

- (FLFinisher*) dispatchFinishableBlock:(FLBlockWithFinisher) block
                             completion:(FLBlockWithResult) completion;

// 
// FLAsyncDispatchable dispatching
// 

- (FLFinisher*) dispatchObject:(id /*FLAsyncWorker*/) dispatchableObject;

- (FLFinisher*) dispatchObject:(id /*FLAsyncWorker*/) dispatchableObject 
                    completion:(FLBlockWithResult) completion;

//
// Dispatching with finisher
//
- (void) dispatchBlock:(FLBlock) block 
          withFinisher:(FLFinisher*) finisher;

- (void) dispatchFinishableBlock:(FLBlockWithFinisher) block 
                    withFinisher:(FLFinisher*) finisher;

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                          block:(FLBlock) block 
                   withFinisher:(FLFinisher*) finisher;

@end                    

@interface FLDispatcher : NSObject<FLDispatcher> {
}

// required overrides. these are the bottlenecks
- (void) dispatchBlock:(FLBlock) block 
              withFinisher:(FLFinisher*) finisher;

- (void) dispatchFinishableBlock:(FLBlockWithFinisher) block 
              withFinisher:(FLFinisher*) finisher;

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLBlock) block 
                          withFinisher:(FLFinisher*) finisher;

// optional overrides
- (FLFinisher*) createFinisher:(FLBlockWithResult) completionBlock;

@end

