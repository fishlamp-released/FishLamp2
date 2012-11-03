//
//  FLJob.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLWorker.h"
#import "FLSimpleWorker.h"

@interface FLJob : FLSimpleWorker {
@private
    id<FLWorker> _worker;
}
@property (readwrite, strong) id<FLWorker> worker;
- (void) setWorkerWithBlock:(dispatch_block_t) block;
- (void) setWorkerWithAsyncBlock:(FLAsyncBlock) block;

+ (id) job;
+ (id) job:(id<FLWorker>) worker;
+ (id) jobWithBlock:(dispatch_block_t) block;
+ (id) jobWithAsyncBlock:(FLAsyncBlock) block;

- (void) scheduleWorker:(id<FLWorker>) worker finisher:(id<FLFinisher>) finisher;
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

