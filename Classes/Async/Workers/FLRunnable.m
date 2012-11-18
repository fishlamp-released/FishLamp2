//
//  FLRunnable.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRunnable.h"
#import "FLWorker.h"

@implementation FLRunner 

+ (id) runWorkerSynchronously:(id<FLWorker>) worker {
    return [FLRunner runWorkerSynchronously:worker withAsyncTask:[FLFinisher finisher]];
}

+ (id) runWorkerSynchronously:(id<FLWorker>) worker withAsyncTask:(id) asyncTask {
    [worker startWorking:asyncTask];
    [asyncTask waitUntilFinished];
    return [asyncTask result];
}

@end
