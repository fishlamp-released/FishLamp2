//
//  FLOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDispatch.h"

@class FLOperation;

typedef FLResult (^FLBlockWithOperation)(FLOperation* operation);

@class FLOperationObserver;

@interface FLOperation : FLAsyncWorker {
@private
	id _operationID;
	FLBlockWithOperation _runBlock;
    BOOL _cancelled;
}

// misc
@property (readwrite, strong, nonatomic) id operationID;

- (id) init;
- (id) initWithRunBlock:(FLBlockWithOperation) block;

+ (id) operation;
+ (id) operation:(FLBlockWithOperation) block;

/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (FLResult) runOperation;
@end

@interface FLOperation (Execution)

// runs in current thread.
- (FLResult) runSynchronously; 
- (FLResult) runSynchronouslyWithObserver:(FLOperationObserver*) observer; 

// to run async, run it async use FLDispatch.

// can be called from other thread. dispatcher context may call this.
- (void) requestCancel;

@end

@interface FLOperation (SubclassUtils)

// this will raise an abort exception if runState has been signaled as finished.
// only for subclasses to call while executing operation.
- (void) abortIfNeeded;
- (BOOL) abortNeeded;

// sub operation inherit context, etc.
- (FLResult) runSubOperation:(FLOperation*) operation;

@end

@protocol FLOperationObserver <NSObject>
@optional

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;

- (void) operationDidFinish:(FLOperation*) operation 
                 withResult:(FLResult) withResult;

@end

typedef void (^FLOperationResultBlock)(FLResult result);

@interface FLOperationObserver : FLFinisher<FLOperationObserver> {
@private
    dispatch_block_t _willRun;
}
@property (readwrite, copy, nonatomic) dispatch_block_t willRun;
//@property (readwrite, copy, nonatomic) FLOperationResultBlock didFinish;

@end