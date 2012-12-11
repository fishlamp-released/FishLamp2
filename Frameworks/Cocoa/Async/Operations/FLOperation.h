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

typedef FLResult (^FLRunOperationBlock)(FLOperation* operation, id inputOrNil);

@interface FLOperation : FLObservable<FLCancellable, FLContextual> {
@private
    __unsafe_unretained id _context;
    __unsafe_unretained FLCancellable* _cancelHandler;
	id _operationID;
	FLRunOperationBlock _runBlock;
	NSInteger _tag;
}

// TODO: abstract this better;
//@property (readonly, assign) FLOperationType operationType;

// misc
@property (readwrite, strong, nonatomic) id operationID;
@property (readwrite, assign, nonatomic) NSInteger tag;

- (id) init;
- (id) initWithRunBlock:(FLRunOperationBlock) block;

+ (id) operation;
+ (id) operation:(FLRunOperationBlock) block;

- (FLFinisher*) startOperationInDispatcher:(id<FLDispatcher>) inDispatcher 
                                completion:(FLCompletionBlock) completion;
                                
- (FLFinisher*) startOperation:(FLCompletionBlock) completion;;

/// This will not throw.
- (id) runSynchronously;
- (id) runSynchronously:(id) input;

//
// for subclasses
//

// this will raise an abort exception if runState has been signaled as finished.
- (void) abortIfNeeded;

//    optional overrides

/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (FLResult) runSelf:(id) input;

/// @brief this is called for you to respond to if requestCancel is called
- (void) cancelSelf;

@end

@protocol FLOperationObserver <NSObject>
@optional

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;
- (void) operationDidFinish:(FLOperation*) operation withResult:(FLResult) withResult;

@end

//#define FLRunOperation_(__OPERATION__) FLThrowError([__OPERATION__ runSynchronously])

//#define FLrunSelf:(id) inputForResponse(__TYPE__) )







