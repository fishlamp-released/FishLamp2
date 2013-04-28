//
//  FLPromise.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncResult.h"
#import "FLDispatchTypes.h"

//typedef enum {
//    FLPromiseStateUnfufilled,
//    FLPromiseStateResolved,
//    FLPromiseStateRejected
//} FLPromiseState;

@interface FLPromise : NSObject {
@private
    dispatch_semaphore_t _semaphore;
    FLPromisedResult _result;
    fl_completion_block_t _completion;
    BOOL _finished;
    BOOL _finishOnMainThread;
    FLPromise* _nextPromise;
    __unsafe_unretained id _target;
    SEL _action;
}
@property (readonly, strong) FLPromisedResult result;
@property (readonly, assign, getter=isFinished) BOOL finished;

@property (readwrite, assign) BOOL finishOnMainThread; 

- (id) initWithCompletion:(fl_completion_block_t) completion;
- (id) initWithTarget:(id) target action:(SEL) action;

+ (id) promise;
+ (id) promise:(fl_completion_block_t) completion;
+ (id) promise:(id) target action:(SEL) action;

// blocks in current thread. 
- (id) waitUntilFinished;


@end
