//
//  FLOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLObservable.h"
#import "FLCancellable.h"
#import "FLPredicate.h"
#import "FLAbortException.h"
#import "FLWorker.h"

@class FLOperation;

typedef void (^FLRunOperationBlock)(FLOperation* operation);

@interface FLOperation : FLObservable<FLWorker, FLRunnable, FLCancellable> {
@private
	id _operationInput;
    id _operationOutput;

// id
	NSInteger _tag;
	id _operationId;

// optional run block (or override runSelf)
	FLRunOperationBlock _runBlock;

// deciders
    id<FLPredicate> _predicate;
    BOOL _disabled;

// state
    int32_t _busy;
    BOOL _wasCancelled;

// run state (reset with each run)
    NSError* _error;
    BOOL _didStart;
    BOOL _didFinish;
    BOOL _didFail;
}

@property (readwrite, strong) id operationInput;
@property (readwrite, strong) id operationOutput;

// TODO: abstract this better;
//@property (readonly, assign) FLOperationType operationType;

// misc
@property (readwrite, strong, nonatomic) id operationID;
@property (readwrite, assign, nonatomic) NSInteger tag;

// state
@property (readwrite, assign, getter=isDisabled) BOOL disabled;
@property (readonly, assign, getter=isBusy) BOOL busy;

@property (readonly, assign) BOOL wasStarted;
@property (readonly, assign) BOOL isFinished;

@property (readonly, assign) BOOL didFail;      // self.error != nil
@property (readonly, assign) BOOL didSucceed;   // didRun && error = nil && !wasCancelled
@property (readonly, assign) BOOL didRun;
@property (readwrite, strong) NSError* error;

/// a nil predicate is the same as a YES predicate
@property (readwrite, strong) id<FLPredicate> predicate;

- (id) init;
- (id) initWithRunBlock:(FLRunOperationBlock) block;
- (id) initWithInput:(id) input;

+ (id) operation;
+ (id) operationWithInput:(id) input;
+ (id) operation:(FLRunOperationBlock) block;

/// @brief run a suboperation
/// parent inherits results, e.g. errors.
- (void) runSubOperation:(FLOperation*) operation;

// utils
- (void) throwAbortIfFailed;
- (void) resetRunState;
- (void) resetRunStateIfNeeded;
- (void) setMoreBusy;
- (void) setLessBusy;

/*
    optional overrides
 */

/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (void) prepareSelf;
- (void) runSelf;
- (void) finishSelf;

/// @brief this is called for you to respond to if requestCancel is called
- (void) cancelSelf;


@end

@protocol FLOperationObserver <NSObject>
@optional

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;
- (void) operationDidFinish:(FLOperation*) operation;
- (void) operationDidFail:(FLOperation*) operation;
- (void) operationWasCancelled:(FLOperation*) operation;

- (void) operationBusyStateDidChange:(FLOperation*) operation;

@end

/// TODO remove these
//typedef void (^FLOperationObserverBlock)(FLOperation* operation);
//
//@interface FLOperation (Observing)
///// Observing. Also see superclass FLObservableObject.
////- (void) observeStart:(FLOperationObserverBlock) block;
////- (void) observeFinish:(FLOperationObserverBlock) block;
//@end
//
//@interface FLOperationObserver : NSObject <FLOperationObserver> {
//@private
//    FLOperationBlock _block;
//}
//- (id) initWithBlock:(FLOperationObserverBlock) block;
//+ (id) operationObserver:(FLOperationObserverBlock) block;
//- (void) invokeBlockWithOperation:(FLOperation*) operation;
//@end
//
//@interface FLOperationWillStartObserver : FLOperationObserver
//@end
//
//@interface FLOperationDidFinishObserver : FLOperationObserver
//@end


@interface FLOperation ()

// deprecated

// input/output
// Note: we're not using properties here to give us some flexibily with subclasses.
- (id) output;
- (void) setOutput:(id) output;

- (id) input;
- (void) setInput:(id) input;
@end
