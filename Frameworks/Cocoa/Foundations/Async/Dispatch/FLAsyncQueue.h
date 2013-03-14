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
#import "FLFinisher.h"
#import "FLDispatchTypes.h"

@protocol FLAsyncQueue <NSObject>
// 
// block dispatching
//
- (FLFinisher*) queueBlockWithDelay:(NSTimeInterval) delay 
                              block:(FLBlock) block;

- (void) queueBlockWithDelay:(NSTimeInterval) delay
                          block:(FLBlock) block 
                   withFinisher:(FLFinisher*) finisher;

- (FLFinisher*) queueBlock:(FLBlock) block;

- (FLFinisher*) queueBlock:(FLBlock) block
                   completion:(FLBlockWithResult) completion;

- (void) queueBlock:(FLBlock) block 
          withFinisher:(FLFinisher*) finisher;

// blocks with Finisher parameter

- (FLFinisher*) queueFinishableBlock:(FLBlockWithFinisher) block;

- (FLFinisher*) queueFinishableBlock:(FLBlockWithFinisher) block
                             completion:(FLBlockWithResult) completion;

- (void) queueFinishableBlock:(FLBlockWithFinisher) block 
                    withFinisher:(FLFinisher*) finisher;

@end                    

@interface FLAsyncQueue : NSObject<FLAsyncQueue> {
}

// required overrides. these are the bottlenecks
- (void) queueBlock:(FLBlock) block 
          withFinisher:(FLFinisher*) finisher;

- (void) queueFinishableBlock:(FLBlockWithFinisher) block 
                    withFinisher:(FLFinisher*) finisher;

- (void) queueBlockWithDelay:(NSTimeInterval) delay
                          block:(FLBlock) block 
                   withFinisher:(FLFinisher*) finisher;

@end

