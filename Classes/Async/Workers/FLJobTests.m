//
//  FLJobTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLJobTests.h"
#import "FLJob.h"
#import "FLBlockWorker.h"
#import "FLDispatchQueues.h"

#if 0

#if TEST 
@interface FLTestBot : FLJob
@end

@implementation FLTestBot
- (void) startWorking:(FLFinisher) finisher {
    [finisher setFinished];
}
@end

@interface FLJobTests : FLUnitTest
@end

@implementation FLJobTests

- (void) testBasicCompletion {

    FLJob* job = [FLJob job];
    [job addWorker:[FLBlockWorker blockWorker:^(FLFinisher finisher){
        [finisher setFinishedWithOutput:@"hello world"];
    }]];

    FLPromisedResult promisedResult = [[FLBackgroundQueue instance] dispatchWorker:job completion:^(FLResult result) {
        FLAssertObjectsAreEqual_(@"hello world", result.output);
    }];

    [promisedResult waitForResult];

    FLAssert_([promisedResult hasResult]);

    FLAssertObjectsAreEqual_(@"hello world", promisedResult.result.output);

}

- (void) testMainThreadCompletion {
    
//    FLWorkerBot* worker = [FLWorkerBot workerBot:^(FLFinisher completion) {
//        UTLog(@"main thread job");
//        FLAssert_([NSThread isMainThread]);
//        [completion setFinished];
//    }];
//    
//    FLResult result = [FLForegroundJob start:worker completion: ^(FLResult result) {
//        FLAssert_([NSThread isMainThread]);
//    }];
//    
//    [result waitForResult];
//
//    FLAssert_(result.isFinished);
//    
//    [finisher setFinished];
}

- (void) testMainThread {

//    FLJob* job = [FLForegroundJob job];
//    
//    [job addWorker:[FLWorkerBot workerBot:^(FLFinisher completion) {
//        FLAssert_([NSThread isMainThread]);
//        FLLog(@"hi from main thread");
//        [completion setFinished];
//    }]];
//    
//    [[job runBot:^{
//        FLAssert_([NSThread isMainThread]);
//    }] waitForResult];
}

- (void) testBackground {

//    FLJob* job = [FLBackgroundJob job];
//    
//    [job addWorker:[FLWorkerBot workerBot:^(FLFinisher completion) {
//        FLAssert_(![NSThread isMainThread]);
//        FLLog(@"hi from bg thread");
//        [completion setFinished];
//    }]];
//    
//    [[job runBot:^{
//        FLAssert_([NSThread isMainThread]);
//    }] waitForResult];


}

//
//- (void) testBackgroundInForeground {
//    [[job addWorker:[FLBackgroundJob job]] addWorker:[FLWorkerBot workerBot:^(FLFinisher completion) {
//        UTLog(@"background job");
//        [completion setFinished];
//    }]];
//
//    [[job addWorker:[FLBackgroundJob job]] addWorker:[FLWorkerBot workerBot:^(FLFinisher completion) {
//        UTLog(@"another background job");
//        [completion setFinished];
//    }]];
//
//    [[job addWorker:[FLForegroundJob job]] addWorker:[FLWorkerBot workerBot:^(FLFinisher completion) {
//        UTLog(@"foreground job");
//        
//        [completion setFinished];
//    }]];
//    
//    [[job runBot:^{
//        UTLog(@"finished in main thread");
//    }] waitForResult];
//}

@end
#endif

#endif