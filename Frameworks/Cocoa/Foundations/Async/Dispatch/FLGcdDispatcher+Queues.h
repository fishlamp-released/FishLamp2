//
//  FLGcdDispatcher+Queues.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLGcdDispatcher.h"

@interface FLGcdDispatcher (Queues)
+ (FLGcdDispatcher*) sharedLowPriorityQueue;
+ (FLGcdDispatcher*) sharedDefaultQueue;
+ (FLGcdDispatcher*) sharedHighPriorityQueue;
+ (FLGcdDispatcher*) sharedBackgroundQueue;
+ (FLGcdDispatcher*) sharedForegroundQueue;
+ (FLGcdDispatcher*) sharedFifoQueue;
@end