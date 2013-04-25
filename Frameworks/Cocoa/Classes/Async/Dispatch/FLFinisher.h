//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLAsyncResult.h"
#import "FLDispatchTypes.h"

#if DEBUG
#import "FLStackTrace.h"
#endif

@protocol FLOperation;

@protocol FLFinishable <NSObject>
// notify finish with one of these
- (void) setFinished;

// result can be anything - will be packaged into an asyncResult if it's
// not already a result.
- (void) setFinishedWithResult:(id<FLAsyncResult>) result; 

- (void) setFinishedWithError:(NSError*) error;
- (void) setFinishedWithReturnedObject:(id) returnedObject;
- (void) setFinishedWithReturnedObject:(id) returnedObject hint:(NSInteger) hint;

- (void) setFinishedWithCancel;

@end


@interface FLFinisher : NSObject<FLFinishable> {
@private
    dispatch_semaphore_t _semaphore;
    id<FLAsyncResult> _result;
    BOOL _finished;
    BOOL _finishOnMainThread;
    
    fl_completion_block_t _didFinish;
#if DEBUG
    FLStackTrace* _createdStackTrace;
    FLStackTrace* _finishedStackTrace;
#endif    
}

// NO by default.
@property (readwrite, assign) BOOL finishOnMainThread; 

@property (readonly, strong) id<FLAsyncResult> result;
@property (readonly, assign, getter=isFinished) BOOL finished;

// designated initializer
- (id) initWithCompletion:(fl_completion_block_t) completion;

// class instantiators
+ (id) finisher;

+ (id) finisher:(fl_completion_block_t) completion;


// blocks in current thread. Will @throw error if [self.result error] 
- (id) waitUntilFinished;
@end

