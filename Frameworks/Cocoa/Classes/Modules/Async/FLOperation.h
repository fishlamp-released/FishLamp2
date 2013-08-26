//
//  FLOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"
#import "FLAsyncBlockTypes.h"
#import "FLFinisher.h"
#import "FLDispatchable.h"
#import "FLPromisedResult.h"
#import "FLNotifier.h"
#import "FLAsyncEvent.h"
#import "FLAsyncQueue.h"

@class FLOperationContext;
@class FLFinisher;
@class FLPromise;
@protocol FLAsyncQueue;
@protocol FLOperationEvents;

@interface FLOperation : FLNotifier<FLFinisherDelegate, FLDispatchable, FLAsyncObject> {
@private
	id _identifier;
    __unsafe_unretained id<FLAsyncQueue> _asyncQueue;
    id _storageService;
    FLFinisher* _finisher;
    NSUInteger _contextID;
    BOOL _cancelled;

    NSMutableArray* _children;
}

// object storage - this can be anything as appropriate for subclass

// THIS IS DEPRECATED
@property (readwrite, strong, nonatomic) id storageService;

// unique id. by default an incrementing integer number
@property (readwrite, strong) id identifier;
@property (readonly, assign) id<FLAsyncQueue> asyncQueue;

// cancel yourself, and be quick about it.
@property (readonly, assign, getter=wasCancelled) BOOL cancelled;
- (void) requestCancel;

// overide point
- (void) startOperation;

// optional override
- (void) didFinishWithResult:(FLPromisedResult) result;

@end

@interface FLOperation (Finishing)

- (FLFinisher*) finisher;

- (void) setFinished;
- (void) setFinishedWithResult:(id) result;

- (void) abortIfCancelled; // throws cancelError
@end

//@interface FLOperation (Synchronous)
//// run synchronously
//- (FLPromisedResult) runSynchronously;
//
//- (FLPromisedResult) runSynchronouslyInContext:(FLOperationContext*) context;
//@end
//
//@interface FLOperation (Async)
//// start async. will run in asyncQueue. 
//- (FLPromise*) runAsynchronously;
//
//- (FLPromise*) runAsynchronously:(fl_completion_block_t) completionOrNil;
//
//- (FLPromise*) runAsynchronouslyInContext:(FLOperationContext*) context
//                               completion:(fl_completion_block_t) completionOrNil;
//
//@end

@interface FLOperation (ChildOperations)
// these call willRunInParent on the child before operation
// is run or started.
- (FLPromisedResult) runChildSynchronously:(FLOperation*) operation;

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation;

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation 
                            completion:(fl_completion_block_t) completionOrNil;
@end

//@interface FLOperation (OperationContext)
//- (void) wasAddedToContext:(FLOperationContext*) context;
//- (void) wasRemovedFromContext:(FLOperationContext*) context;
//- (void) contextDidClose;
//- (void) contextDidOpen;
//- (void) contextDidCancel;
//@end

@protocol FLOperationEvents <NSObject>
@optional
- (void) operationWillBegin:(id) operation;
- (void) operationDidFinish:(id) operation withResult:(FLPromisedResult) result;
@end

@interface FLFinisherBlockOperation : FLOperation {
@private
    fl_finisher_block_t _finisherBlock;
}
+ (id) finisherBlockOperation:(fl_finisher_block_t) block;
@end

@interface FLOperationEvent : FLAsyncEvent
- (FLOperation*) operation;

+ (id) operationEventWithDelay:(NSTimeInterval) timeInterval operation:(FLOperation*) operation;
@end