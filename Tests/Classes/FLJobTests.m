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


@interface FLTestBot : FLJob
@end

@implementation FLTestBot
- (FLFinisher*) startWorking:(FLFinisher*) finisher {
    [finisher setFinished];
    return finisher;
}
@end

@implementation FLJobTests

- (void) testBasicCompletion {

    FLJob* job = [FLJob jobWithAsyncBlock:^(FLFinisher* finisher){
        [finisher setFinishedWithResult:@"hello world"];
    }];

    FLFinisher* finisher = [FLBackgroundQueue dispatch:job finisher:[FLFinisher finisherWithBlock:^(id result) {
        FLAssertObjectsAreEqual_(@"hello world", result);
    }]];

    id result = [finisher waitUntilFinished];

    FLAssert_(result == finisher.result);

    FLAssert_([finisher isFinished]);

    FLAssertObjectsAreEqual_(@"hello world", result);

}

- (void) testMainThreadCompletion {
 
    FLJob* job = [FLForegroundJob jobWithAsyncBlock:^(FLFinisher* finisher){
        FLAssert_([NSThread isMainThread]);
        [finisher setFinishedWithResult:@"hello world"];
    }];

    FLFinisher* finisher = [FLBackgroundQueue dispatch:job finisher:[FLFinisher finisherWithBlock:^(id result) {
        FLAssert_([NSThread isMainThread]);
        FLAssertObjectsAreEqual_(@"hello world", result);
    }]];

    id result = [finisher waitUntilFinished];

    FLAssert_(result == finisher.result);
    FLAssert_([finisher isFinished]);

    FLAssertObjectsAreEqual_(@"hello world", result);
}

- (void) testMainThread {

//    FLJob* job = [FLForegroundJob job];
//    
//    [job addWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        FLAssert_([NSThread isMainThread]);
//        FLLog(@"hi from main thread");
//        [completion setFinished];
//    }]];
//    
//    [[job runBot:^{
//        FLAssert_([NSThread isMainThread]);
//    }] waitUntilFinished];
}

- (void) testBackground {

//    FLJob* job = [FLBackgroundJob job];
//    
//    [job addWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        FLAssert_(![NSThread isMainThread]);
//        FLLog(@"hi from bg thread");
//        [completion setFinished];
//    }]];
//    
//    [[job runBot:^{
//        FLAssert_([NSThread isMainThread]);
//    }] waitUntilFinished];


}

//
//- (void) testBackgroundInForeground {
//    [[job addWorker:[FLBackgroundJob job]] addWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"background job");
//        [completion setFinished];
//    }]];
//
//    [[job addWorker:[FLBackgroundJob job]] addWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"another background job");
//        [completion setFinished];
//    }]];
//
//    [[job addWorker:[FLForegroundJob job]] addWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"foreground job");
//        
//        [completion setFinished];
//    }]];
//    
//    [[job runBot:^{
//        UTLog(@"finished in main thread");
//    }] waitUntilFinished];
//}

@end


