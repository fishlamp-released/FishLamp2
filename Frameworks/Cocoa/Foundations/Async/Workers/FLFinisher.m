//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"
#import "FLDispatchQueue.h"

@interface FLFinisher ()
@property (readwrite, strong) FLResult result;
@property (readwrite, copy) dispatch_block_t notificationCompletionBlock;
@property (readwrite, copy) FLResultBlock resultBlock;
@property (readwrite, assign, getter=isFinished) BOOL finished;
- (void) finishFinishing;
@end

@implementation FLFinisher
@synthesize result = _result;
@synthesize scheduleNotificationBlock = _scheduleNotificationBlock;
@synthesize notificationCompletionBlock = _notificationCompletionBlock;
@synthesize resultBlock = _resultBlock;
@synthesize finished = _finished;


- (id) initWithResultBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _resultBlock = [completion copy];
        }
        
        _semaphore = dispatch_semaphore_create(0);
        FLLog(@"created semaphor for %X, thread %@", (void*) _semaphore, [NSThread currentThread]);
           
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
    if(_resultBlock) {
        [_resultBlock release];
    }
    if(_scheduleNotificationBlock) {
        [_scheduleNotificationBlock release];
    }
    if(_notificationCompletionBlock) {
        [_notificationCompletionBlock release];
    }
    [_result release];
    [super dealloc];
#endif
}

+ (id) finisher {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) finisherWithResultBlock:(FLResultBlock) completion {
    return FLAutorelease([[[self class] alloc] initWithResultBlock:completion]);
}
+ (id) finisher:(FLResultBlock) completion {
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
            FLLog(@"waiting for semaphor for %X, thread %@", (void*) _semaphore, [NSThread currentThread]);
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
            FLLog(@"finished waiting for %X", (void*) _semaphore);
        } 
        
        FLThrowError(self.result);
    }
    @finally {
        FLAutoreleaseObject(self);
    }   

    return self.result;
}

- (void) finishFinishing {

    if(_resultBlock) {
        _resultBlock(self.result);
        self.resultBlock = nil;
    }

    if(_notificationCompletionBlock) { 
        _notificationCompletionBlock();
        self.notificationCompletionBlock = nil;
    }

    self.finished = YES;

    if(_semaphore) {
        FLLog(@"releasing semaphor for %X, ont thread %@", (void*) _semaphore, [NSThread currentThread]);
        dispatch_semaphore_signal(_semaphore);
    }
}

- (void) setFinishedWithResult:(id) result 
                    completion:(dispatch_block_t) completion {
    
    FLAssertIsNil_v(self.result, @"already finished");

    if(result == nil) {
        self.result = FLFailedResult;
    }
    else {
        self.result = result;
    }
    
    self.notificationCompletionBlock = completion;
    
    if(_scheduleNotificationBlock) {
        _scheduleNotificationBlock(^{
            [self finishFinishing];
        });
        self.scheduleNotificationBlock = nil;
    }
    else {
        [self finishFinishing];
    } 
}                    

- (void) setFinishedWithResult:(id) result {
    [self setFinishedWithResult:result completion:nil];
}

- (void) setFinished {
    [self setFinishedWithResult:FLSuccessfullResult completion:nil];
}

+ (FLFinisherNotificationSchedulerBlock) scheduleNotificationInMainThreadBlock {
    static FLFinisherNotificationSchedulerBlock s_block = ^(dispatch_block_t notifier) {
        if(![NSThread isMainThread]) {
            
            notifier = FLAutoreleasedCopy(notifier);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                notifier();
            });    
        }
        else {
            notifier();
        }
    }; 

    return s_block;
}

@end

@implementation FLScheduledFinisher 
- (id) initWithResultBlock:(FLResultBlock) completion {
    self = [super initWithResultBlock:completion];
    if(self) {
        if([NSThread isMainThread]) {
            self.scheduleNotificationBlock = [FLFinisher scheduleNotificationInMainThreadBlock];
        }
    }
    return self;
}

@end




