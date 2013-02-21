//
//  FLOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDispatch.h"
#import "FLWorkerContext.h"
#import "FLAsyncWorker.h"

@class FLOperation;

typedef FLResult (^FLBlockWithOperation)(FLOperation* operation, id context, id observer);

@class FLOperationObserver;

@interface FLOperation : NSObject<FLAsyncWorker> {
@private
	id _operationID;
	FLBlockWithOperation _runBlock;
    BOOL _cancelled;
}

@property (readwrite, strong, nonatomic) id operationID;

- (id) init;
- (id) initWithRunBlock:(FLBlockWithOperation) block;

+ (id) operation;
+ (id) operation:(FLBlockWithOperation) block;

/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (FLResult) runOperationInContext:(id) context withObserver:(id) observer;
@end

@interface FLOperation (SubclassUtils)

// this will raise an abort exception if runState has been signaled as finished.
// only for subclasses to call while executing operation.
- (void) abortIfNeeded;
- (BOOL) abortNeeded;

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