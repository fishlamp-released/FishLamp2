//
//  FLWorkFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorkFinisher.h"
#import "FLTimeoutTimer.h"
#import "FLResultObjects.h"

@interface FLWorkFinisher ()
@property (readwrite, strong) FLResult result;
@property (readwrite, assign) BOOL isFinished;
@property (readwrite, strong) FLTimeoutTimer* timer;
@end

@implementation FLWorkFinisher
@synthesize timer = _timer;
@synthesize isFinished = _finished;
@synthesize result = _result;

- (id) initWithCompletionBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        _completionBlock = FLCopyBlock(completion);
     }
    return self;
}

+ (id) finisher:(FLResultBlock) completion {
    return autorelease_([[[self class] alloc] initWithCompletionBlock:completion]);
}

- (void) dealloc {
    if(_timer) {
        [_timer requestCancel];
    }
    
#if FL_MRC
    [_timer release];
    [_result release];
    if(_completionBlock) {
        [_completionBlock release];
    }
    [super dealloc];
#endif
}

+ (id) finisher {
    return autorelease_([[[self class] alloc] initWithCompletionBlock:nil]);
}

- (BOOL) hasResult {
    return self.isFinished;
}

- (void) setFinishedWithSuccess:(BOOL) success {
    if(success) {
        [self setFinishedWithResult:[FLSuccessfullResult instance]];
    }
    else {
        [self setFinishedWithResult:[FLFailedResult instance]];
    }
}

- (void) setFinished {
    [self setFinishedWithResult:[FLSuccessfullResult instance]];
}

- (void) setFinishedWithError:(NSError*) error {
    if(error) {
        [self setFinishedWithResult:[FLErrorResult errorResult:error]];
    }
    else {
        [self setFinishedWithResult:[FLFailedResult instance]];
    }
}

- (void) setFinishedWithOutput:(id) output {
    if(output) {
        [self setFinishedWithResult:[FLOutputResult outputResult:output]];
    }
    else {
        [self setFinishedWithResult:[FLSuccessfullResult instance]];
    }
}

- (void) setFinishedWithResult:(FLResult) result {
    FLAssert_v(_finished == NO, @"already finished");

    if(self.timer) {
        [self.timer requestCancel];
    }

    self.result = result;
    if(_completionBlock) {
        _completionBlock(_result);
    }
    self.isFinished = YES;
}

- (FLResult) waitForResult {
// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    while(!self.isFinished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    }

    return self.result;
}

- (FLResult) waitForResultWithCondition:(FLConditionalBlock) checkCondition {
    
    BOOL condition = NO;
    if(checkCondition) {
        condition = YES;
        checkCondition(&condition);
    }
    
// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    while(!self.isFinished || condition) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];

        if(checkCondition) {
            checkCondition(&condition);
        }
    }
    return self.result;
}

- (FLResult) waitForResultWithTimeout:(NSTimeInterval) timeout {
    self.timer = [FLTimeoutTimer timeoutTimer:timeout];
    [self.timer start:^(FLResult result) {
        [self setFinishedWithResult:result];
    }];
    return [self waitForResult];
}

@end

#if TEST
@interface FLNotifierSanityCheck : FLSanityCheck
@end

@implementation FLNotifierSanityCheck

- (void) testSingleCount {
    
    __block BOOL fired = NO;
    
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:^(FLResult result) { 
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
    
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:^(FLResult result){ fired = YES; }];
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
    
    FLWorkFinisher* finisher = [FLWorkFinisher finisher];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [NSThread sleepForTimeInterval:0.25];
        FLLog(@"done in thread");
        [finisher setFinished];
        });
    
    [finisher waitForResult];
    FLAssert_(finisher.isFinished);
}


@end

#endif


