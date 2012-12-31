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
@class FLServiceManagingContext;

typedef FLResult (^FLRunOperationBlock)(FLOperation* operation);

@interface FLOperation : FLObservable<FLCancellable, FLDispatchable> {
@private
	id _operationID;
	FLRunOperationBlock _runBlock;
    BOOL _cancelled;
    id _context;
    id _authenticator;
}

@property (readonly, strong) id context;
@property (readwrite, strong) id<FLObjectAuthenticator> authenticator;

// TODO: abstract this better;
//@property (readonly, assign) FLOperationType operationType;

// misc
@property (readwrite, strong, nonatomic) id operationID;

- (id) init;
- (id) initWithRunBlock:(FLRunOperationBlock) block;

+ (id) operation;
+ (id) operation:(FLRunOperationBlock) block;

// this will raise an abort exception if runState has been signaled as finished.
- (void) abortIfNeeded;

@end

@interface FLOperation (OptionalOverrides)
/// @brief Required override point (or use runBlock).
/// Either override run or set the operation's run block.
- (FLResult) runOperation;
@end

@protocol FLOperationObserver <NSObject>

// these always happen in the thread the operation is running on
- (void) operationWillRun:(FLOperation*) operation;

- (void) operationDidFinish:(FLOperation*) operation 
                 withResult:(FLResult) withResult;

@end

