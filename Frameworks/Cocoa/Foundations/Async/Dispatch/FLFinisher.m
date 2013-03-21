//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"
#import "FLAsyncQueue.h"

@interface FLFinisher ()
@property (readwrite, strong) FLResult result;
@property (readwrite, assign, getter=isFinished) BOOL finished;
- (void) finishFinishing:(FLBlock) completion;
@property (readwrite, copy) FLBlockWithResult didFinish;

#if DEBUG
@property (readwrite, strong) FLStackTrace* createdStackTrace;
@property (readwrite, strong) FLStackTrace* finishedStackTrace;
#endif

@end

@implementation FLFinisher
@synthesize didFinish = _didFinish;
@synthesize result = _result;
@synthesize finished = _finished;
@synthesize finishOnMainThread = _finishOnMainThread;
@synthesize observer = _observer;

#if DEBUG
@synthesize createdStackTrace = _createdStackTrace;
@synthesize finishedStackTrace = _finishedStackTrace;
#endif

- (id) initWithResultBlock:(FLBlockWithResult) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _didFinish = [completion copy];
        }
        
        _semaphore = dispatch_semaphore_create(0);
//        FLLog(@"created semaphor for %X, thread %@", (void*) _semaphore, [NSThread currentThread]);

#if DEBUG
        self.createdStackTrace = FLCreateStackTrace(YES);
#endif

           
    }
    return self;
}

- (id) init {
    return [self initWithResultBlock:nil];
}

- (void) dealloc {
    if(_semaphore) {
        dispatch_release(_semaphore);
    }
    
#if FL_MRC
    [_observer release];
    
#if DEBUG
    [_createdStackTrace release];
    [_finishedStackTrace release];
#endif    
    [_didFinish release];
    [_result release];
    [super dealloc];
#endif
}

+ (id) finisher {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) finisherWithResultBlock:(FLBlockWithResult) completion {
    return FLAutorelease([[[self class] alloc] initWithResultBlock:completion]);
}
+ (id) finisher:(FLBlockWithResult) completion {
    return FLAutorelease([[[self class] alloc] initWithResultBlock:completion]);
}

- (id) waitUntilFinished {
    
    FLRetainObject(self);
    
    @try {
        if([NSThread isMainThread]) {
        // this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
        // and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
            while(!self.isFinished) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
            }
        } 
        else {
//            FLLog(@"waiting for semaphor for %X, thread %@", (void*) _semaphore, [NSThread currentThread]);
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
//            FLLog(@"finished waiting for %X", (void*) _semaphore);
        } 
    }
    @finally {
        FLAutoreleaseObject(self);
    }   

    FLAssertNotNilWithComment(self.result, @"result should not be nil!!");

    return self.result;
}

- (void) finishFinishing:(FLBlock) finishedBlock {

    if(_didFinish) {
        _didFinish(self.result);
    }

    if(finishedBlock) { 
        finishedBlock();
    }

    self.finished = YES;

//    [self sendMessage:@"finisher:didFinishWithResult:" withObject:self withObject:self.result];

    if(_semaphore) {
 //       FLLog(@"releasing semaphor for %X, ont thread %@", (void*) _semaphore, [NSThread currentThread]);
        dispatch_semaphore_signal(_semaphore);
    }
    
    
}

- (void) setFinishedWithResult:(id) result 
                    completion:(FLBlock) completion {
    
    FLAssertIsNilWithComment(self.result, @"already finished");

    if(result == nil) {
        self.result = FLFailedResult;
    }
    else {
        self.result = result;
    }
    
#if DEBUG
    self.finishedStackTrace = FLCreateStackTrace(YES);
#endif
    
    if(self.finishOnMainThread && ![NSThread isMainThread]) {
       completion = FLCopyWithAutorelease(completion);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self finishFinishing:completion];
        });
    }
    else {
        [self finishFinishing:completion];
    } 
}                    

- (void) setFinishedWithResult:(id) result {
    [self setFinishedWithResult:result completion:nil];
}

- (void) setFinished {
    [self setFinishedWithResult:FLSuccessfullResult completion:nil];
}

//- (FLResult) executeFinishableBlock:(FLBlockWithFinisher) block {
//    @try {
//        [self setWillStartInDispatcher:self];
//            
//        if(block) {
//            block(self);
//        }
//    }
//    @catch(NSException* ex) {
//        [self setFinishedWithResult:ex.error];
//    }
//    
//    return self.result;
//}
//
//- (FLResult) executeBlock:(FLBlock) block {
//    @try {
//        [self setWillStartInDispatcher:self];
//        
//        if(block) {
//            block();
//        }
//        [self setFinished];
//    }
//    @catch(NSException* ex) {
//        [self setFinishedWithResult:ex.error];
//    }
//
//    return self.result;
//}

//+ (FLFinisherNotificationSchedulerBlock) scheduleNotificationInMainThreadBlock {
//    static FLFinisherNotificationSchedulerBlock s_block = ^(FLBlock notifier) {
//        if(![NSThread isMainThread]) {
//            
//            FLSafeguardBlock(notifier);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                notifier();
//            });    
//        }
//        else {
//            notifier();
//        }
//    }; 
//
//    return s_block;
//}

#if DEBUG    
- (NSString*) description {
    FLPrettyString* string = [FLPrettyString prettyString];
    [string appendLine:[super description]];
    [string appendLine:@"created stack trace:"];
    [string indent:^{
        [string appendLine:[_createdStackTrace description]];
    }];
    if(_finishedStackTrace) {
        [string appendLine:@"finished stack trace:"];
        [string indent:^{
            [string appendLine:[_finishedStackTrace description]];
        }];
    }
    return string.string;
}
#endif              

- (void) receiveObjectMessage:(FLObjectMessage *)message {
    [self.observer receiveObjectMessage:message];
}

@end
//
//@implementation FLMainThreadFinisher 
//- (id) initWithResultBlock:(FLBlockWithResult) completion {
//    self = [super initWithResultBlock:completion];
//    if(self) {
//        if([NSThread isMainThread]) {
//            self.scheduleNotificationBlock = [FLFinisher scheduleNotificationInMainThreadBlock];
//        }
//    }
//    return self;
//}
//
//@end

@implementation FLFinisher (FLAsyncQueue)

- (void) setWillStartInDispatcher:(id<FLAsyncQueue>) asyncQueue {    
//    [self sendMessage:@"finisher:willStartInDispatcher:" withObject:self withObject:asyncQueue];
}

- (void) setWillBeDispatchedByDispatcher:(id<FLAsyncQueue>) asyncQueue {

    if([NSThread isMainThread]) {
        self.finishOnMainThread = YES;
    }

//    [self sendMessage:@"finisher:wasDispatchedInDispatcher:" withObject:self withObject:asyncQueue];
}

@end



