//
//  FLBotTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBotTests.h"

#import "FLBot.h"
#import "FLWorkerBot.h"

#if TEST 
@interface FLTestBot : FLBot
@end

@implementation FLTestBot
- (void) startWorking:(FLFinisher*) finisher {
    [finisher setFinished];
}
@end

@interface FLBotTests : FLUnitTest
@end

@implementation FLBotTests

- (void) testBasicCompletion {

    __block BOOL passed = NO;

    FLFinisher* finisher = [FLBot startWorker:[FLTestBot bot] completion:^(id<FLAsyncResult> result){
        passed = YES;
    }];

    [finisher waitUntilFinished];

    FLAssert_(finisher.isFinished);

    FLAssert_(passed == YES);
}

- (void) testMainThreadCompletion {
    
//    FLWorkerBot* worker = [FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"main thread bot");
//        FLAssert_([NSThread isMainThread]);
//        [completion setFinished];
//    }];
//    
//    id<FLAsyncResult> result = [FLForegroundBot startWorker:worker completion: ^(id<FLAsyncResult> result) {
//        FLAssert_([NSThread isMainThread]);
//    }];
//    
//    [result waitUntilFinished];
//
//    FLAssert_(result.isFinished);
//    
//    [finisher setFinished];
}

- (void) testMainThread {

//    FLBot* bot = [FLForegroundBot bot];
//    
//    [bot addAsyncWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        FLAssert_([NSThread isMainThread]);
//        FLLog(@"hi from main thread");
//        [completion setFinished];
//    }]];
//    
//    [[bot runBot:^{
//        FLAssert_([NSThread isMainThread]);
//    }] waitUntilFinished];
}

- (void) testBackground {

//    FLBot* bot = [FLBackgroundBot bot];
//    
//    [bot addAsyncWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        FLAssert_(![NSThread isMainThread]);
//        FLLog(@"hi from bg thread");
//        [completion setFinished];
//    }]];
//    
//    [[bot runBot:^{
//        FLAssert_([NSThread isMainThread]);
//    }] waitUntilFinished];


}

//
//- (void) testBackgroundInForeground {
//    [[bot addAsyncWorker:[FLBackgroundBot bot]] addAsyncWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"background bot");
//        [completion setFinished];
//    }]];
//
//    [[bot addAsyncWorker:[FLBackgroundBot bot]] addAsyncWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"another background bot");
//        [completion setFinished];
//    }]];
//
//    [[bot addAsyncWorker:[FLForegroundBot bot]] addAsyncWorker:[FLWorkerBot workerBot:^(FLFinisher* completion) {
//        UTLog(@"foreground bot");
//        
//        [completion setFinished];
//    }]];
//    
//    [[bot runBot:^{
//        UTLog(@"finished in main thread");
//    }] waitUntilFinished];
//}

@end
#endif

