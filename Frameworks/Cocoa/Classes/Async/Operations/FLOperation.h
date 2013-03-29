//
//  FLOperation.h
//  FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLWorkerContext.h"
#import "FLObjectStorage.h"

typedef struct {
    __unsafe_unretained id delegate;
    SEL selector;
} FLDelegateEvent;

@interface FLOperation : FLContextWorker {
@private
	id _operationID;
    BOOL _cancelled;
    SEL _finishSelectorForDelegate;
    SEL _finishSelectorForObserver;
    __unsafe_unretained id _delegate;
}

@property (readwrite, assign, nonatomic) id delegate;
@property (readwrite, assign, nonatomic) SEL finishSelectorForDelegate;
@property (readwrite, assign, nonatomic) SEL finishSelectorForObserver;

@property (readonly, strong, nonatomic) id<FLObjectStorage> objectStorage;
@property (readwrite, strong, nonatomic) id operationID;

- (id) init;
+ (id) operation;

/// @brief Required override point
- (FLResult) runOperation;

// deprecated
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
- (void) operationDidFinish:(FLOperation*) operation withResult:(FLResult) result;
@end

@protocol FLOperationDelegate <NSObject>
@optional
- (id<FLObjectStorage>) operationGetObjectStorage:(FLOperation*) operation;
- (void) operationDidFinish:(FLOperation*) operation withResult:(FLResult) result;
@end

