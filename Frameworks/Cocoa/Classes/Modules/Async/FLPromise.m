//
//  FLPromise.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/27/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPromise.h"
#import "FishLampAsync.h"

@interface FLPromise ()
@property (readwrite, strong) NSError* error;
@property (readwrite, strong) id result;
@property (readwrite, strong) FLPromise* nextPromise;
@property (readwrite, assign, getter=isFinished) BOOL finished;
@property (readwrite, copy) fl_completion_block_t completion;
@end

@implementation FLPromise

@synthesize nextPromise = _nextPromise;
@synthesize result = _result;
@synthesize finished = _finished;
@synthesize finishOnMainThread = _finishOnMainThread;
@synthesize completion = _completion;
@synthesize error =_error;

- (id) initWithCompletion:(fl_completion_block_t) completion {
    
    self = [super init];
    if(self) {
        self.completion = completion;
        _semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (id) initWithTarget:(id) target action:(SEL) action {
    self = [self initWithCompletion:nil];
    if(self) {
        _target = target;
        _action = action;
    }
    return self;
}

+ (id) promise:(id) target action:(SEL) action {
    return FLAutorelease([[[self class] alloc] initWithTarget:target action:action]);
}

- (id) init {
    return [self initWithCompletion:nil];
}

- (void) dealloc {
    if(_semaphore) {
        dispatch_release(_semaphore);
    }
    
#if FL_MRC
    [_error release];
    [_nextPromise release];
    [_completion release];
    [_result release];
    [super dealloc];
#endif
}

+ (id) promise {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) promise:(fl_completion_block_t) completion {
    return FLAutorelease([[[self class] alloc] initWithCompletion:completion]);
}

- (FLPromisedResult*) waitUntilFinished {
    
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

    return [FLPromisedResult promisedResult:self.result error:self.error];
}

- (void) notifyFinished {
    if(_completion) {
        _completion(self.result, self.error);
    }
    FLPerformSelector2(_target, _action, self.result, self.error);

    self.finished = YES;

    if(_semaphore) {
    //       FLLog(@"releasing semaphor for %X, ont thread %@", (void*) _semaphore, [NSThread currentThread]);
        dispatch_semaphore_signal(_semaphore);
    }
}

- (void) setFinishedWithResult:(id) result error:(id) error {
    
    FLAssertIsNilWithComment(self.result, @"already finished");

    self.result = result;
    self.error = error;

    if(self.result == nil && self.error == nil) {
        self.error = [NSError failedResultError];
    }

    if(!self.finishOnMainThread || 
        [NSThread currentThread] == [NSThread mainThread] ) {
        [self notifyFinished];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self notifyFinished];
        });
    }
}      



@end