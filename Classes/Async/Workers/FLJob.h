//
//  FLJob.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLWorker.h"
#import "FLWorkFinisher.h"
#import "FLCollectionIterator.h"
#import "FLSimpleWorker.h"

@class FLJob;
@protocol FLDispatcher;

@protocol FLJob <FLWorker, FLRunnable, FLFallible>
@property (readonly, assign) id parentJob;
@property (readwrite, assign) id<FLFallibleDelegate> fallibleDelegate;
@end

typedef void (^FLJobVisitor)(id job, BOOL* stop);

@interface FLJob : FLSimpleWorker<FLJob> {
@private
    __unsafe_unretained id _parentJob;
    __unsafe_unretained id _errorDelegate;
    id<FLWorker> _worker;
    id<FLDispatcher> _queue;
}
@property (readonly, strong) id<FLWorker> worker;

+ (id) job;
+ (id) job:(id<FLWorker>) worker;
+ (id) jobWithBlock:(dispatch_block_t) block;
+ (id) jobWithAsyncBlock:(FLAsyncBlock) block;

- (void) setWorker:(id<FLWorker>) worker;
- (void) setWorkerWithBlock:(dispatch_block_t) block;
- (void) setWorkerWithAsyncBlock:(FLAsyncBlock) block;

@end

/**
    work and completion always fire in background thread
 */
@interface FLBackgroundJob : FLJob
@end


/**
    work and completion always fire in main thread
 */
@interface FLForegroundJob : FLJob 
@end

