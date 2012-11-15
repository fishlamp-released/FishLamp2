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
//- (id) initWithCompletionBlock:(FLCompletionBlock) completionBlock;
//+ (id) completion:(FLCompletionBlock) completion;
@property (readwrite, strong) FLResult result;
@property (readwrite, assign) BOOL isFinished;
@property (readwrite, strong) FLTimeoutTimer* timer;
@end

@implementation FLWorkFinisher
@synthesize timer = _timer;
@synthesize isFinished = _finished;
@synthesize result = _result;

//- (id) initWithCompletionBlock:(FLCompletionBlock) completion {
//    
//    self = [super init];
//    if(self) {
//        if(completion) {
//            _completionBlock = [completion copy];
//        }
//    }
//    return self;
//}


- (id) initWithResultBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _finishBlock = [completion copy];
        }
    }
    return self;
}

+ (id) finisher:(FLResultBlock) completion {
    return autorelease_([[[self class] alloc] initWithResultBlock:completion]);
}

//+ (id) completion:(FLCompletionBlock) completion {
//    return autorelease_([[[self class] alloc] initWithCompletionBlock:completion]);
//}


- (void) dealloc {
    if(_timer) {
        [_timer requestCancel];
    }
    
#if FL_MRC
    [_timer release];
    [_result release];

//    if(_completionBlock) {
//        [_completionBlock release];
//    }
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
}

- (FLResult) waitForResult {
// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    mrc_retain_(self);
    @try {
        while(!self.isFinished) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
    }
    @catch(NSException* ex) {
        self.result = [FLErrorResult errorResult:ex.error];
    }
    mrc_autorelease_(self);

    return self.result;
}

- (FLResult) waitForResultWithCondition:(FLConditionalBlock) checkCondition {
    
    mrc_retain_(self);
    BOOL stop = NO;
    if(checkCondition) {
        checkCondition(&stop);
    }

    @try {
    // this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
    // and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
        while(!self.isFinished || !stop) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];

            if(checkCondition) {
                checkCondition(&stop);
            }
        }
    }
    @catch(NSException* ex) {
        self.result = [FLErrorResult errorResult:ex.error];
    }
    mrc_autorelease_(self);

    return self.result;
}

- (FLResult) waitForResultWithTimeout:(NSTimeInterval) timeout {
    NSTimeInterval doneTime = [NSDate timeIntervalSinceReferenceDate] + timeout;
    return [self waitForResultWithCondition:^(BOOL* stop) {
        if(doneTime < [NSDate timeIntervalSinceReferenceDate]) {
            FLThrowError_([NSError timeoutError]);
        }
    }];
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


