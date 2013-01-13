//
//  FLOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLObservable.h"
#import "FLDispatching.h"
#import "FLResult.h"

@class FLOperation;

typedef FLResult (^FLRunOperationBlock)(FLOperation* operation);

@protocol FLOperationDispatchingContext <NSObject>
- (id<FLDispatching>) operationDispatcher:(FLOperation*) operation;
- (void) operationDidStart:(FLOperation*) operation;
- (void) operationDidFinish:(FLOperation*) operation;
@end

@interface FLOperation : FLObservable<FLContextual, FLDispatchable> {
@private
	id _operationID;
	FLRunOperationBlock _runBlock;
    BOOL _cancelled;
    id _context;
    __unsafe_unretained id _parent;
}

@property (readonly, strong) id context;

// misc
@property (readwrite, strong, nonatomic) id operationID;

- (id) init;
- (id) initWithRunBlock:(FLRunOperationBlock) block;

+ (id) operation;
+ (id) operation:(FLRunOperationBlock) block;

/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (FLResult) runOperation;
@end

@interface FLOperation (Execution)

// running in current thread.
- (FLResult) runSynchronouslyInContext:(id) context; 

// async operations will run in:
// 1. dispatcher provided by context
// 2. global default dispatcher (FLDefaultDispatcher)
- (FLFinisher*) startOperationInContext:(id) context completion:(FLCompletionBlock) completion;

// can be called from other thread. dispatcher context may call this.
- (void) requestCancel;

@end

@interface FLOperation (SubclassUtils)

// this will raise an abort exception if runState has been signaled as finished.
// only for subclasses to call while executing operation.
- (void) abortIfNeeded;
- (BOOL) abortNeeded;

// optional overides
- (void) didMoveToContext:(id)context;

@end

@protocol FLOperationObserver <NSObject>

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;

- (void) operationDidFinish:(FLOperation*) operation 
                 withResult:(FLResult) withResult;

@end

