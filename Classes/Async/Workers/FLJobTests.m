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


#if TEST 
@interface FLTestBot : FLJob
@end

@implementation FLTestBot
- (void) startWorking:(id<FLFinisher>) finisher {
    [finisher setFinished];
}
@end

@interface FLJobTests : FLFrameworkUnitTest
@end

@implementation FLJobTests

- (void) testBasicCompletion {

    FLJob* job = [FLJob jobWithAsyncBlock:^(id<FLFinisher> finisher){
        [finisher setFinishedWithOutput:@"hello world"];
    }];

    id<FLPromisedResult> promisedResult = [[FLBackgroundQueue instance] dispatchWorker:job completion:^(FLResult result) {
        FLAssertObjectsAreEqual_(@"hello world", result.output);
    }];

    [promisedResult waitForResult];

    FLAssert_([promisedResult hasResult]);

    FLAssertObjectsAreEqual_(@"hello world", promisedResult.result.output);

}

- (void) testMainThreadCompletion {
 
    FLJob* job = [FLForegroundJob jobWithAsyncBlock:^(id<FLFinisher> finisher){
        FLAssert_([NSThread isMainThread]);
        [finisher setFinishedWithOutput:@"hello world"];
    }];

    id<FLPromisedResult> promisedResult = [[FLBackgroundQueue instance] dispatchWorker:job completion:^(FLResult result) {
        FLAssert_(![NSThread isMainThread]);
        FLAssertObjectsAreEqual_(@"hello world", result.output);
    }];

    [promisedResult waitForResult];

    FLAssert_([promisedResult hasResult]);

    FLAssertObjectsAreEqual_(@"hello world", promisedResult.result.output);
}

- (void) testMainThread {

//    FLJob* job = [FLForegroundJob job];
//    
//    [job addWorker:[FLWorkerBot workerBot:^(id<FLFinisher> completion) {
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
//    [job addWorker:[FLWorkerBot workerBot:^(id<FLFinisher> completion) {
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
//    [[job addWorker:[FLBackgroundJob job]] addWorker:[FLWorkerBot workerBot:^(id<FLFinisher> completion) {
//        UTLog(@"background job");
//        [completion setFinished];
//    }]];
//
//    [[job addWorker:[FLBackgroundJob job]] addWorker:[FLWorkerBot workerBot:^(id<FLFinisher> completion) {
//        UTLog(@"another background job");
//        [completion setFinished];
//    }]];
//
//    [[job addWorker:[FLForegroundJob job]] addWorker:[FLWorkerBot workerBot:^(id<FLFinisher> completion) {
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

