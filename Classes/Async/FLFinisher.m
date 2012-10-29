//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"
#import "FLTimeoutTimer.h"

@interface FLFinisher ()
@property (readwrite, strong) id<FLResult> result;
@property (readwrite, assign) BOOL isFinished;
@property (readwrite, strong) FLTimeoutTimer* timer;
@end

@implementation FLFinisher
@synthesize timer = _timer;
@synthesize isFinished = _finished;
@synthesize result = _result;

- (id) initWithCompletionBlock:(FLCompletionBlock) completion{
    
    self = [super init];
    if(self) {
        _completionBlock = FLCopyBlock(completion);
     }
    return self;
}

+ (id) finisher:(FLCompletionBlock) completion {
    return FLReturnAutoreleased([[[self class] alloc] initWithCompletionBlock:completion]);
}

- (void) dealloc {
    if(_timer) {
        [_timer requestCancel];
    }
    
#if FL_NO_ARC
    [_timer release];
    [_result release];
    if(_completionBlock) {
        [_completionBlock release];
    }
    [super dealloc];
#endif
}

+ (id) finisher {
    return FLReturnAutoreleased([[[self class] alloc] initWithCompletionBlock:nil]);
}

- (BOOL) hasResult {
    return self.isFinished;
}

- (void) setFinished {
    [self setFinishedWithResult:nil];
}

- (void) setFinishedWithResult:(id<FLResult>) result {
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

- (id<FLResult>) waitForResult {
// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    while(!self.isFinished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    }

    return self.result;
}

- (id<FLResult>) waitForResultWithCondition:(FLConditionalBlock) checkCondition {
    
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

- (id<FLResult>) waitForResultWithTimeout:(NSTimeInterval) timeout {
    self.timer = [FLTimeoutTimer timeoutTimer:timeout];
    [self.timer start:^(id<FLResult> result) {
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
    
    FLFinisher* finisher = [FLFinisher finisher:^(id<FLResult> result){ fired = YES; }];
    FLAssert_(!finisher.isFinished);
    FLAssert_(fired == NO);
    [finisher setFinished];
    FLAssert_(finisher.isFinished);
    FLAssert_(fired == YES);
}

- (void) testDoubleCount {
    
    __block BOOL fired = NO;
    
    FLFinisher* finisher = [FLFinisher finisher:^(id<FLResult> result){ fired = YES; }];
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
    
    [finisher waitForResult];
    FLAssert_(finisher.isFinished);
}


@end

#endif


