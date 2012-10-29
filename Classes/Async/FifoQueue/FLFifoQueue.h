//
//  FLBackgroundQueue.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLFinisher.h"
#import "FLWorker.h"

@interface FLAsyncQueue : NSObject

+ (id) addWorkerBlock:(FLWorkerBlock) block;

+ (id) addWorkerBlock:(FLWorkerBlock) block
     completion:(FLCompletionBlock) completion;

+ (id) addWorker:(id<FLWorker>) aWorker
      completion:(FLCompletionBlock) completion;
@end


@interface FLFifoQueue : FLAsyncQueue {
@private
    dispatch_queue_t _queue;
}
@end

@interface FLForegroundQueue : FLAsyncQueue
@end