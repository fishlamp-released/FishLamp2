//
//  FLOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLObservable.h"
#import "FLCancellable.h"
#import "FLDispatcher.h"
#import "FLResult.h"

@class FLOperation;

typedef FLResult (^FLRunOperationBlock)(FLOperation* operation, id inputOrNil);

@interface FLOperation : FLObservable<FLCancellable, FLSynchronouslyDispatchable> {
@private
	id _operationID;
	FLRunOperationBlock _runBlock;
	NSInteger _tag;
    BOOL _cancelled;
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

// this will raise an abort exception if runState has been signaled as finished.
- (void) abortIfNeeded;

/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (FLResult) runOperationWithInput:(id) input;

@end

@interface FLOperation (Dispatching)

// To run async, use a FLDispatchQueue.

/// This will not throw.
- (FLResult) runSynchronously;
- (FLResult) runSynchronouslyWithInput:(id) input;
@end


@protocol FLOperationObserver <NSObject>

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;

- (void) operationDidFinish:(FLOperation*) operation 
                 withResult:(FLResult) withResult;

@end

