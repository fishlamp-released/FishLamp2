//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLResult.h"
#import "FLDispatchTypes.h"

#if DEBUG
#import "FLStackTrace.h"
#endif

@protocol FLOperation;

@interface FLFinisher : NSObject {
@private
    dispatch_semaphore_t _semaphore;
    id _result;
    BOOL _finished;
    BOOL _finishOnMainThread;
    
    fl_completion_block_t _didFinish;
#if DEBUG
    FLStackTrace* _createdStackTrace;
    FLStackTrace* _finishedStackTrace;
#endif    
}

// True by default.
@property (readwrite, assign) BOOL finishOnMainThread; 

@property (readonly, strong) FLResult result;
@property (readonly, assign, getter=isFinished) BOOL finished;

// designated initializer
- (id) initWithCompletion:(fl_completion_block_t) completion;

// class instantiators
+ (id) finisher;

+ (id) finisher:(fl_completion_block_t) completion;

// notify finish with one of these
- (void) setFinished;

- (void) setFinishedWithResult:(id) result;

// blocks in current thread. Will @throw error if [self.result error] 
- (id) waitUntilFinished;
@end

