//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"
#import "FLAsyncQueue.h"
#import "FLOperation.h"

@interface FLFinisher ()
@property (readwrite, strong) FLResult result;
@property (readwrite, assign, getter=isFinished) BOOL finished;
@property (readwrite, copy) fl_completion_block_t didFinish;
@property (readwrite, assign, nonatomic) id<FLOperation> operation;

#if DEBUG
@property (readwrite, strong) FLStackTrace* createdStackTrace;
@property (readwrite, strong) FLStackTrace* finishedStackTrace;
#endif

@end

@implementation FLFinisher
@synthesize didFinish = _didFinish;
@synthesize result = _result;
@synthesize finished = _finished;
@synthesize operation = _operation;

#if DEBUG
@synthesize createdStackTrace = _createdStackTrace;
@synthesize finishedStackTrace = _finishedStackTrace;
#endif

- (id) initWithCompletion:(fl_completion_block_t) completion {
    
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

- (id) initWithOperation:(FLOperation*) operation completion:(fl_completion_block_t) completion {
    self = [self initWithCompletion:completion];
    if(self) {
        self.operation = operation;
    }
    return self;
}

- (id) init {
    return [self initWithCompletion:nil];
}

- (void) dealloc {
    if(_semaphore) {
        dispatch_release(_semaphore);
    }
    
#if FL_MRC
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

+ (id) finisherForOperation:(FLOperation*) operation 
                 completion:(fl_completion_block_t) completion {
    return FLAutorelease([[[self class] alloc] initWithOperation:operation completion:completion]);
}

+ (id) finisher:(fl_completion_block_t) completion {
    return FLAutorelease([[[self class] alloc] initWithCompletion:completion]);
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

- (void) setFinishedWithResult:(id) result {
    
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
    
//    if(self.finishOnMainThread && ![NSThread isMainThread]) {
//       completion = FLCopyWithAutorelease(completion);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self finishFinishing:completion];
//        });
//    }
//    else {
//        [self finishFinishing:completion];
//    } 

    dispatch_async(dispatch_get_main_queue(), ^{
    
        if(_didFinish) {
            _didFinish(self.result);
        }

        if(_operation) {
            [_operation operationDidFinish];
            _operation = nil;
        }

        self.finished = YES;

        if(_semaphore) {
     //       FLLog(@"releasing semaphor for %X, ont thread %@", (void*) _semaphore, [NSThread currentThread]);
            dispatch_semaphore_signal(_semaphore);
        }
    });

}                    

- (void) setFinished {
    [self setFinishedWithResult:FLSuccessfullResult];
}

//- (FLResult) executeFinishableBlock:(fl_finisher_block_t) block {
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


@end
//
//@implementation FLMainThreadFinisher 
//- (id) initWithCompletion:(fl_completion_block_t) completion {
//    self = [super initWithCompletion:completion];
//    if(self) {
//        if([NSThread isMainThread]) {
//            self.scheduleNotificationBlock = [FLFinisher scheduleNotificationInMainThreadBlock];
//        }
//    }
//    return self;
//}
//
//@end



