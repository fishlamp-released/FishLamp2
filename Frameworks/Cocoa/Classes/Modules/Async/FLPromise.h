//
//  FLPromise.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/27/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"
#import "FLAsyncBlockTypes.h"
#import "FLPromisedResult.h"

@interface FLPromise : NSObject {
@private
    dispatch_semaphore_t _semaphore;
    fl_completion_block_t _completion;
    BOOL _finished;
    FLPromise* _nextPromise;
    __unsafe_unretained id _target;
    id _result;
    SEL _action;
}
@property (readonly, assign, getter=isFinished) BOOL finished;

- (id) initWithCompletion:(fl_completion_block_t) completion;
- (id) initWithTarget:(id) target action:(SEL) action; // @selector(FLPromisedResult result)

+ (id) promise;
+ (id) promise:(fl_completion_block_t) completion;
+ (id) promise:(id) target action:(SEL) action;

// blocks in current thread. 
- (FLPromisedResult) waitUntilFinished;
@end


//typedef enum {
//    FLPromiseStateUnfufilled,
//    FLPromiseStateResolved,
//    FLPromiseStateRejected
//} FLPromiseState;

// TODO:
// 1. add better state
// 2. add ability to chain promises after "begin" is called