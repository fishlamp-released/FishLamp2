//
//  FLAsyncQueue+AsyncWorker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncQueue+AsyncWorker.h"

@implementation FLAsyncQueue (AsyncWorker)

- (FLFinisher*) queueAsyncWorker:(id<FLAsyncWorker>) worker {
    return [self queueAsyncWorker:worker completion:nil];
}

- (FLFinisher*) queueAsyncWorker:(id<FLAsyncWorker>) worker 
                  completion:(FLBlockWithResult) completion {
                  
    return [self queueFinishableBlock:^(FLFinisher* finisher) {
        [worker startWorking:finisher];
    }
    completion:completion];
}                  


@end
