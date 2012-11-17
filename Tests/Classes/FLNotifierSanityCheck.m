//
//  FLNotifierSanityCheck.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNotifierSanityCheck.h"
#import "FLTimeoutTests.h"

@implementation FLNotifierSanityCheck

+ (NSArray*) unitTestDependencies {
    return [NSArray arrayWithObject:[FLTimeoutTests class]];
}

- (void) testSingleCount {
    
    __block BOOL fired = NO;
    
    FLFinisher* finisher = [FLFinisher finisherWithBlock:^(id result) { 
        fired = YES; 
    }];
    
    FLAssert_(!finisher.isFinished);
    FLAssert_(fired == NO);
    [finisher setFinished];
    FLAssert_(finisher.isFinished);
    FLAssert_(fired == YES);
}

- (void) testDoubleCount {
    
    __block BOOL fired = NO;
    
    FLFinisher* finisher = [FLFinisher finisherWithBlock:^(id result){ fired = YES; }];
    FLAssert_(!finisher.isFinished);
    FLAssert_(fired == NO);
    [finisher setFinished];
    FLAssert_(finisher.isFinished);

    BOOL gotError = NO;
    @try {
        [finisher setFinished];
        
    }
    @catch(NSException* expected) {
        gotError = YES;
    }
    
    FLAssert_v(gotError == YES, @"expecting an error");
}

- (void) testBasicAsyncTest {

    FLLog(@"async self test");
    
    FLFinisher* finisher = [FLFinisher finisher];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [NSThread sleepForTimeInterval:0.25];
        FLLog(@"done in thread");
        [finisher setFinished];
        });
    
    [finisher waitUntilFinished];
    FLAssert_(finisher.isFinished);
}


@end

