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
#import "FLDispatchQueues.h"

@interface FLWorkFinisher ()
@property (readwrite, strong) FLResult result;
@property (readwrite, assign) BOOL isFinished;
@property (readwrite, strong) FLTimeoutTimer* timer;
@end

@implementation FLWorkFinisher
@synthesize timer = _timer;
@synthesize isFinished = _finished;
@synthesize result = _result;

- (id) initWithCompletionBlock:(FLCompletionBlock) completion {
    
    self = [super init];
    if(self) {
        _completionBlock = FLCopyBlock(completion);
    }
    return self;
}


- (id) initWithResultBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        _finishBlock = FLCopyBlock(completion);
    }
    return self;
}

+ (id) finisher:(FLResultBlock) completion {
    return autorelease_([[[self class] alloc] initWithResultBlock:completion]);
}

+ (id) completion:(FLCompletionBlock) completion {
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
    if(_finishBlock) {
        [_finishBlock release];
    }
    [super dealloc];
#endif
}

+ (id) finisher {
    return autorelease_([[[self class] alloc] initWithResultBlock:nil]);
}

- (BOOL) hasResult {
    return self.isFinished;
}

- (void) startWorker:(id<FLWorker>) worker {
    [worker startWorking:self];
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
    self.isFinished = YES;

    if(_finishBlock) {
        _finishBlock(_result);
    }
    else if(_completionBlock) {
        _completionBlock();
    }
}

- (FLResult) waitForResult {
// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    @try {
        while(!self.isFinished) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
    }
    @catch(NSException* ex) {
        self.result = [FLErrorResult errorResult:ex.error];
    }

    return self.result;
}

- (FLResult) waitForResultWithCondition:(FLConditionalBlock) checkCondition {
    
    BOOL condition = NO;
    if(checkCondition) {
        condition = YES;
        checkCondition(&condition);
    }

    @try {
    // this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
    // and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
        while(!self.isFinished || condition) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];

            if(checkCondition) {
                checkCondition(&condition);
            }
        }
    }
    @catch(NSException* ex) {
        self.result = [FLErrorResult errorResult:ex.error];
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

@implementation FLMainThreadFinisher

- (void) setFinishedWithResult:(FLResult) result {
    if(![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(setFinishedWithResult:) withObject:result waitUntilDone:NO];
    }
    else {
        [super setFinishedWithResult:result];
    }
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


