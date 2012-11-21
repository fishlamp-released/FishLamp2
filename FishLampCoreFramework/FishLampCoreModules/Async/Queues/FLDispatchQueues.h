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
+ (FLDispatchQueue*) instance;

+ (FLDispatchQueue*) currentQueue;

// conveience methods just class [[self instance] dispatch]

+ (FLFinisher*) dispatchBlock:(dispatch_block_t) block;

+ (FLFinisher*) dispatchBlock:(dispatch_block_t) block
                     finisher:(FLFinisher*) finisher;

+ (FLFinisher*) dispatch:(FLAsyncTaskBlock) block;

+ (FLFinisher*) dispatch:(FLAsyncTaskBlock) block
                finisher:(FLFinisher*) finisher;

// override point
- (dispatch_queue_t) dispatchQueue;

@end

@interface FLHighPriorityQueue : FLDispatchQueue 
FLSingletonProperty(FLHighPriorityQueue);
@end

@interface FLBackgroundQueue : FLDispatchQueue
FLSingletonProperty(FLBackgroundQueue);
@end

@interface FLLowPriorityQueue : FLDispatchQueue
FLSingletonProperty(FLLowPriorityQueue);
@end

@interface FLForegroundQueue : FLDispatchQueue
FLSingletonProperty(FLForegroundQueue);
@end


@interface FLFifoQueue : FLDispatchQueue {
@private
    dispatch_queue_t _fifo_queue;
}
FLSingletonProperty(FLFifoQueue);
@end

