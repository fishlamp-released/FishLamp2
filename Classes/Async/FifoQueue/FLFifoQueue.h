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
#import "FLAsyncWorker.h"

@interface FLAsyncQueue : NSObject

+ (FLFinisher*) addBlock:(dispatch_block_t) block;

+ (FLFinisher*) addBlock:(dispatch_block_t) block
                completion:(FLCompletionBlock) completion;

+ (FLFinisher*) addWorker:(id<FLAsyncWorker>) aWorker
                 completion:(FLCompletionBlock) completion;
@end


@interface FLFifoQueue : FLAsyncQueue {
@private
    dispatch_queue_t _queue;
}
@end

@interface FLForegroundQueue : FLAsyncQueue
@end