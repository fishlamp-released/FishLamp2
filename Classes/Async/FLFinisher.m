//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"

@interface FLFinisher ()
@property (readwrite, copy) FLCompletionBlock completionBlock;
@property (readwrite, assign, getter=isFinished) BOOL finished;
@property (readonly, assign, nonatomic) NSUInteger finishCount;
// TODO: rid of this?
@property (readwrite, assign) NSUInteger expectedFinishCount;
@property (readwrite, strong) id asyncResult;
@property (readwrite, strong) NSError* error;

@end

@implementation FLFinisher

@synthesize completionBlock = _completionBlock;
@synthesize finished = _finished;
@synthesize expectedFinishCount = _expectedFinishCount;
@synthesize finishCount = _finishCount;
@synthesize didRunSynchronously = didRunSynchronously;
@synthesize asyncResult = _asyncResult;
@synthesize error = _error;

- (id) initWithCompletionBlock:(FLCompletionBlock) completion{
    
    self = [super init];
    if(self) {
        self.completionBlock = completion;
        _expectedFinishCount = 1;
     }
    return self;
}

+ (id) finisher:(FLCompletionBlock) completion {
    return FLReturnAutoreleased([[[self class] alloc] initWithCompletionBlock:completion]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_error release];
    [_asyncResult release];
    [_completionBlock release];
    [super dealloc];
}
#endif

+ (id) finisher {
    return FLReturnAutoreleased([[[self class] alloc] initWithCompletionBlock:nil]);
}

- (void) setFinished {
     @synchronized(self) {
        FLAssert_v(_finishCount < _expectedFinishCount, @"setFinished called too many times");
        if(++_finishCount == _expectedFinishCount) {
            [self sendNotification:self];
            
            if(self.completionBlock) {
                self.completionBlock(self);
                self.completionBlock = nil;
            }
            self.finished = YES;
        }
    }
}

- (void) setFinishedWithObject:(id) object {
    self.asyncResult = object;
}

- (void) setFinishedWithResult:(id) result {
    self.asyncResult = result;
    [self setFinished];
}

- (void) setFinishedWithError:(NSError*) error {
    self.error = error;
    [self setFinished];
}

- (void) waitUntilFinished {
    [self waitUntilFinishedWhileCondition:nil];
}

- (void) waitUntilFinishedWhileCondition:(FLConditionalBlock) checkCondition {
    
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
}

//+ (FLFinisher*) performBlockInBackground:(dispatch_block_t) block;
//+ (FLFinisher*) performBlockInBackground:(dispatch_block_t) block
//                              completion:(FLCompletionBlock) completion;

//+ (FLFinisher*) performBlockInBackground:(dispatch_block_t) block {
//    return [FLFinisher performBlockInBackground:block completion:nil];
//}
//
//+ (FLFinisher*) performBlockInBackground:(dispatch_block_t) block
//                          completion:(FLCompletionBlock) completion {
//    
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//
//    block = FLCopyBlock(block);
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        if(block) {
//            block();
//        }
//        
//        [finisher setFinished];
//    });
//
//    return finisher;
//}

@end

#if TEST
@interface FLNotifierSanityCheck : FLSanityCheck
@end

@implementation FLNotifierSanityCheck

- (void) testSingleCount {
    
    __block BOOL fired = NO;
    
    FLFinisher* notifier = [FLFinisher finisher:^(id<FLAsyncResult> result){ fired = YES; }];
    
    FLAssertIsNotNil_(notifier.completionBlock);
    FLAssert_(notifier.expectedFinishCount == 1);
    FLAssert_(notifier.finishCount == 0);
    
    [notifier setFinished];
    FLAssert_(notifier.finishCount == 1);
    FLAssert_(notifier.isFinished);
    FLAssert_(fired == YES);
    FLAssertIsNil_(notifier.completionBlock);
}

- (void) testDoubleCount {
    
    __block BOOL fired = NO;
    
    FLFinisher* notifier = [FLFinisher finisher:^(id<FLAsyncResult> result){ fired = YES; }];
    
    FLAssertIsNotNil_(notifier.completionBlock);
    FLAssert_(notifier.expectedFinishCount == 1);
    FLAssert_(notifier.finishCount == 0);
    
    notifier.expectedFinishCount = 2;
    FLAssert_(notifier.expectedFinishCount == 2);
    
    [notifier setFinished];
    FLAssert_(notifier.finishCount == 1);
    FLAssert_(fired == NO);
    FLAssert_(!notifier.isFinished);

    [notifier setFinished];
    FLAssert_(notifier.finishCount == 2);
    FLAssert_(notifier.isFinished);
    FLAssert_(fired == YES);
    FLAssertIsNil_(notifier.completionBlock);
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

#endif


