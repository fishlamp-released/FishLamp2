//
//  FLDispatchQueue.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FishLampCore.h"
#import "FLDispatcher.h"
#import "FLSingletonProperty.h"

@interface FLDispatchQueue: NSObject<FLDispatcher> {
@private
}
- (dispatch_queue_t) dispatchQueue;
FLSingletonProperty(FLDispatchQueue);

+ (FLDispatchQueue*) currentQueue;

@end

@interface FLHighPriorityQueue : FLDispatchQueue 
@end

@interface FLForegroundQueue : FLDispatchQueue
@end

@interface FLBackgroundQueue : FLDispatchQueue
@end

@interface FLLowPriorityQueue : FLDispatchQueue
@end

@interface FLFifoQueue : FLDispatchQueue {
@private
    dispatch_queue_t _fifo_queue;
}
@end

