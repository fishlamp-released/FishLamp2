//
//  FLOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLamp.h"
#import "FLAsyncBlockTypes.h"
#import "FLFinisher.h"
#import "FLDispatchable.h"
#import "FLObservable.h"

@class FLOperationContext;
@class FLPromisedResult;
@class FLFinisher;
@class FLPromise;
@protocol FLAsyncQueue;
@protocol FLOperationDelegate;

@interface FLOperation : FLObservable<FLFinisherDelegate, FLDispatchable> {
@private
	id _identifier;
    id<FLAsyncQueue> _asyncQueue;
    id _storageService;
    FLFinisher* _finisher;
    NSUInteger _contextID;
    BOOL _cancelled;
    __unsafe_unretained FLOperationContext* _context;
}

// object storage - this can be anything as appropriate for subclass
@property (readwrite, strong, nonatomic) id storageService;

// unique id. by default an incrementing integer number
@property (readwrite, strong) id identifier;

// id of context. 
@property (readonly, assign) NSUInteger contextID;

// if you want control over your executing operation, run it in a context.
@property (readwrite, assign, nonatomic) FLOperationContext* context;

// note that if you start an operation directly in a queue (e.g. you don't call start or run) the asyncQueue is ignored 
@property (readwrite, strong, nonatomic) id<FLAsyncQueue> asyncQueue;

// cancel yourself, and be quick about it.
@property (readonly, assign, getter=wasCancelled) BOOL cancelled;
- (void) requestCancel;

// overide point
- (void) startOperation;

// optional override
- (void) didFinishWithResult:(id) result error:(NSError*) error;

@end

@interface FLOperation (Finishing)

- (FLFinisher*) finisher;

- (void) setFinished;
- (void) setFinishedWithResult:(id) result;
- (void) setFinishedWithError:(NSError*) error;
- (void) setFinishedWithResult:(id) result error:(NSError*) error;

- (void) abortIfCancelled; // throws cancelError
@end

@interface FLOperation (Synchronous)
// run synchronously
- (FLPromisedResult*) runSynchronously;

- (FLPromisedResult*) runSynchronouslyInContext:(FLOperationContext*) context;
@end

@interface FLOperation (Async)
// start async. will run in asyncQueue. 
- (FLPromise*) runAsynchronously;

- (FLPromise*) runAsynchronously:(fl_completion_block_t) completionOrNil;

- (FLPromise*) runAsynchronouslyInContext:(FLOperationContext*) context
                               completion:(fl_completion_block_t) completionOrNil;

@end

@interface FLOperation (ChildOperations)
// these call willRunInParent on the child before operation
// is run or started.
- (FLPromisedResult*) runChildSynchronously:(FLOperation*) operation;

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation;

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation 
                            completion:(fl_completion_block_t) completionOrNil;
@end

@interface FLOperation (OperationContext)
- (void) wasAddedToContext:(FLOperationContext*) context;
- (void) wasRemovedFromContext:(FLOperationContext*) context;
- (void) contextDidClose;
- (void) contextDidOpen;
- (void) contextDidCancel;
@end

@protocol FLOperationDelegate <NSObject>
@optional
- (void) operationWillBegin:(id) operation;
- (void) operationDidFinish:(id) operation withResult:(id) result error:(NSError*) error;
@end


