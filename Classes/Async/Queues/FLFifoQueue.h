//
//  FLBackgroundQueue.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLWorkFinisher.h"
#import "FLWorker.h"
#import "FLResult.h"
#import "FLPromisedResult.h"
#import "FLBlockWorker.h"

@interface FLAsyncQueue : NSObject

+ (FLPromisedResult) addWorkerBlock:(FLWorkerBlock) completion;

+ (FLPromisedResult) addWorkerBlock:(FLWorkerBlock) block
           completion:(FLResultBlock) completion;

+ (FLPromisedResult) addWorker:(id<FLWorker>) aWorker
      completion:(FLResultBlock) completion;
@end


@interface FLFifoQueue : FLAsyncQueue {
@private
    dispatch_queue_t _queue;
}
@end

@interface FLForegroundQueue : FLAsyncQueue
@end