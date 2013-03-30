//
//  FLSynchronousOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLOperation.h"
#import "FLObjectStorage.h"

typedef struct {
    __unsafe_unretained id delegate;
    SEL selector;
} FLDelegateEvent;

@interface FLSynchronousOperation : FLOperation {
@private
    id<FLObjectStorage> _objectStorage;
	id _operationID;
    BOOL _cancelled;

    SEL _finishedAction;
    __unsafe_unretained id _finishedDelegate;
}

@property (readwrite, strong, nonatomic) id<FLObjectStorage> objectStorage;
@property (readwrite, strong, nonatomic) id operationID;

- (void) setFinishedDelegate:(id) target action:(SEL) action;

- (id) init;
+ (id) operation;

/// @brief Required override point
- (FLResult) performSynchronously;

// this will raise an abort exception if runState has been signaled as finished.
// only for subclasses to call while executing operation.
- (void) abortIfNeeded;
- (BOOL) abortNeeded;

@end


@interface FLBatchSynchronousOperation : FLSynchronousOperation {
@private
    SEL _batchAction;
    __unsafe_unretained id _batchObserver;
}
- (void) setBatchObserver:(id) observer action:(SEL) action;


// for subclassses
- (void) sendIterationObservation:(FLResult) result;

@end