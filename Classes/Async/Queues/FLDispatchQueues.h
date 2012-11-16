//
//  FLDispatchQueue.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLDispatcher.h"
#import "FLSingletonProperty.h"

@interface FLDispatchQueue: NSObject<FLDispatcher> {
@private
}

FLSingletonProperty(FLDispatchQueue);

+ (FLDispatchQueue*) currentQueue;

// conveience methods just class [[self instance] dispatch]

+ (FLFinisher*) dispatch:(id<FLWorker>) dispatchable;

+ (FLFinisher*) dispatch:(id<FLWorker>) dispatchable
                finisher:(FLFinisher*) finisher;

+ (FLFinisher*) dispatchBlock:(dispatch_block_t) block;

+ (FLFinisher*) dispatchAsyncBlock:(FLAsyncBlock) block;

+ (FLFinisher*) dispatchAsyncBlock:(FLAsyncBlock) block
                          finisher:(FLFinisher*) finisher;

// override point
- (dispatch_queue_t) dispatchQueue;

@end

@interface FLHighPriorityQueue : FLDispatchQueue 
@end


@interface FLBackgroundQueue : FLDispatchQueue
@end

@interface FLLowPriorityQueue : FLDispatchQueue
@end

@interface FLActionQueue : FLDispatchQueue
@end

@interface FLForegroundQueue : FLActionQueue
@end


@interface FLFifoQueue : FLDispatchQueue {
@private
    dispatch_queue_t _fifo_queue;
}
@end

