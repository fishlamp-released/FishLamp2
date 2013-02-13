//
//  FLGcdDispatcher+Queues.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLGcdDispatcher+Queues.h"
#import "FLFifoGcdDispatcher.h"

@implementation FLGcdDispatcher (Queues)

+ (FLGcdDispatcher*) sharedLowPriorityQueue {
    FLReturnStaticObject( [[FLGcdDispatcher alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)]);
}
+ (FLGcdDispatcher*) sharedDefaultQueue {
    FLReturnStaticObject( [[FLGcdDispatcher alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)]);
}
+ (FLGcdDispatcher*) sharedHighPriorityQueue {
    FLReturnStaticObject([[FLGcdDispatcher alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)]);
}
+ (FLGcdDispatcher*) sharedBackgroundQueue {
    FLReturnStaticObject([[FLGcdDispatcher alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)]);
}
+ (FLGcdDispatcher*) sharedForegroundQueue {
    FLReturnStaticObject([[FLGcdDispatcher alloc] initWithDispatchQueue:dispatch_get_main_queue()]);
}

+ (FLGcdDispatcher*) sharedFifoQueue {
    FLReturnStaticObject([[FLFifoGcdDispatcher alloc] init]);
}

@end