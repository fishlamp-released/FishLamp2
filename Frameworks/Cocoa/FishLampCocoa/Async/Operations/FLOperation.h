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
#import "FLContextual.h"
#import "FLWorker.h"
#import "FLDispatcher.h"
#import "FLResult.h"

@class FLOperation;

typedef FLResult (^FLRunOperationBlock)(FLOperation* operation);

@interface FLOperation : FLObservable<FLCancellable, FLContextual> {
@private
    __unsafe_unretained id _context;
    id _result;
	NSInteger _tag;
	id _operationID;
    NSError* _error;

// optional run block (or override runSelf)
	FLRunOperationBlock _runBlock;

// deciders
    BOOL _disabled;

// state
    int32_t _busy;

// run state (reset with each run)
    BOOL _wasStarted;
    BOOL _isFinished;
    FLFinisher* _cancelFinisher;
}

//@property (readwrite, strong) id operationInput;
//@property (readwrite, strong) id operationOutput;

// input/output
// Note: we're not using properties here to give us some flexibily with subclasses.
//- (id) output;
//- (void) setOutput:(id) output;

//- (id) input;
//- (void) setInput:(id) input;

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

- (id) init;
- (id) initWithRunBlock:(FLRunOperationBlock) block;

+ (id) operation;
+ (id) operation:(FLRunOperationBlock) block;

- (FLFinisher*) startOperationInDispatcher:(id<FLDispatcher>) inDispatcher 
                                completion:(FLCompletionBlock) completion;
                                
- (FLFinisher*) startOperation:(FLCompletionBlock) completion;;

/// This will not throw.
- (id) runSynchronously;

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
- (FLResult) runSelf;
- (void) finishSelf:(FLResult*) withResult;

/// @brief this is called for you to respond to if requestCancel is called
- (void) cancelSelf;

- (void) abortIfNeeded;

@end

@protocol FLOperationObserver <NSObject>
@optional

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;
- (void) operationDidFinish:(FLOperation*) operation;
- (void) operationWasCancelled:(FLOperation*) operation;

- (void) operationBusyStateDidChange:(FLOperation*) operation;

@end

#define FLRunOperation_(__OPERATION__) FLThrowError([__OPERATION__ runSynchronously])

#define FLRunSelfForResponse(__TYPE__) FLAssertIsType([__TYPE__ class], FLThrowError([super runSelf]))







