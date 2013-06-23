//
//  FLPromise.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/27/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"
#import "FLDispatchTypes.h"

@class FLPromisedResult;

@interface FLPromise : NSObject {
@private
    dispatch_semaphore_t _semaphore;
    id _result;
    NSError* _error;

    fl_completion_block_t _completion;
    BOOL _finished;
    BOOL _finishOnMainThread;
    FLPromise* _nextPromise;
    __unsafe_unretained id _target;
    SEL _action;
}
@property (readonly, strong) id result;
@property (readonly, strong) NSError* error;

@property (readonly, assign, getter=isFinished) BOOL finished;

@property (readwrite, assign) BOOL finishOnMainThread; 

- (id) initWithCompletion:(fl_completion_block_t) completion;
- (id) initWithTarget:(id) target action:(SEL) action; // @selector(id result, NSError* error)

+ (id) promise;
+ (id) promise:(fl_completion_block_t) completion;
+ (id) promise:(id) target action:(SEL) action;

// blocks in current thread. 
- (FLPromisedResult*) waitUntilFinished;
@end


//typedef enum {
//    FLPromiseStateUnfufilled,
//    FLPromiseStateResolved,
//    FLPromiseStateRejected
//} FLPromiseState;
