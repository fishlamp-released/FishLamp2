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

//@protocol FLOperation;
//
//@protocol FLFinishable <NSObject>
//
//@end
//
//
//@interface FLOldFinisher : NSObject<FLFinishable> {
//@private
//    dispatch_semaphore_t _semaphore;
//    FLPromisedResult _result;
//    BOOL _finished;
//    BOOL _finishOnMainThread;
//    fl_completion_block_t _didFinish;
//#if DEBUG
//    FLStackTrace* _createdStackTrace;
//    FLStackTrace* _finishedStackTrace;
//#endif    
//}
//
//// NO by default.
//@property (readwrite, assign) BOOL finishOnMainThread; 
//
//@property (readonly, strong) FLPromisedResult result;
//@property (readonly, assign, getter=isFinished) BOOL finished;
//
//// designated initializer
//- (id) initWithCompletion:(fl_completion_block_t) completion;
//
//// class instantiators
//+ (id) finisher;
//
//+ (id) finisher:(fl_completion_block_t) completion;
//
//
//// blocks in current thread. 
//- (id) waitUntilFinished;
//@end

#import "FLPromise.h"

@protocol FLFinisherDelegate;

@interface FLFinisher : NSObject {
@private
    FLPromise* _firstPromise;
    __unsafe_unretained id<FLFinisherDelegate> _delegate;
}

@property (readwrite, assign) id<FLFinisherDelegate> delegate;
@property (readonly, assign) BOOL willFinish;

+ (id) finisher;
+ (id) finisher:(FLPromise*) promise;

- (void) addPromise:(FLPromise*) promise;

// notify finish with one of these
- (void) setFinished;
- (void) setFinishedWithResult:(FLPromisedResult) result; 

- (void) setFinishedWithCancel;

@end

@protocol FLFinisherDelegate <NSObject>
- (void) finisher:(FLFinisher*) finisher didFinishWithResult:(id) result; 
@end