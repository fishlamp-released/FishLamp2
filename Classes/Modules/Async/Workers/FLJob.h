//
//  FLJob.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLWorker.h"
#import "FLAsyncTask.h"

@interface FLJob : FLWorker {
@private
    id<FLWorker> _worker;
}
@property (readwrite, strong) id<FLWorker> worker;
- (void) setWorkerWithBlock:(dispatch_block_t) block;
- (void) setWorkerWithAsyncBlock:(FLAsyncTaskBlock) block;

+ (id) job;
+ (id) job:(id<FLWorker>) worker;
+ (id) jobWithBlock:(dispatch_block_t) block;
+ (id) jobWithAsyncBlock:(FLAsyncTaskBlock) block;

- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher;
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

