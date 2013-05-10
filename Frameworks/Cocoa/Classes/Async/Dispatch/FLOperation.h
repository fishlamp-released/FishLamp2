//
//  FLOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#import "FLDispatchTypes.h"
#import "FLFinisher.h"
#import "FLOperationContext.h"
#import "FLAsyncQueue.h"
#import "FLCallback.h"
#import "FLObservable.h"

@protocol FLOperation <NSObject>
@property (readonly, strong) id identifier;

- (void) startOperation;
- (FLPromisedResult) runSynchronously;

- (void) requestCancel;

@property (readonly, strong) FLFinisher* finisher; 

@end

@protocol FLOperationDelegate <NSObject>
@optional
- (void) operationDidFinish:(id) operation withResult:(FLPromisedResult) result;
@end

@interface FLOperation : FLObservable<FLOperation, FLFinisherDelegate> {
@private
    __unsafe_unretained FLOperationContext* _context;
	id _identifier;
    NSUInteger _contextID;
    id<FLAsyncQueue> _asyncQueue;
    id _storageService;
    BOOL _cancelled;
    FLFinisher* _finisher;
    __unsafe_unretained id _delegate;
}


// finished delegate
@property (readwrite, nonatomic, assign) id delegate;
//@property (readwrite, nonatomic, assign) SEL finishedSelector; // default = FLOperationDefaultFinishedSelector

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

- (void) setFinished;

- (void) setFinishedWithResult:(FLPromisedResult) result;

// run synchronously
- (FLPromisedResult) runSynchronously;

- (FLPromisedResult) runSynchronouslyInContext:(FLOperationContext*) context;

// start async. will run in asyncQueue. 
- (FLPromise*) runAsynchronously;

- (FLPromise*) runAsynchronously:(fl_completion_block_t) completionOrNil;

- (FLPromise*) runAsynchronouslyInContext:(FLOperationContext*) context 
                                completion:(fl_completion_block_t) completionOrNil;

// these call willRunInParent on the child before operation
// is run or started.
- (FLPromisedResult) runChildSynchronously:(FLOperation*) operation;

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation;

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation 
                            completion:(fl_completion_block_t) completionOrNil;


// optional overides
- (id) startAsyncOperation;

- (void) wasAddedToContext:(FLOperationContext*) context;
- (void) wasRemovedFromContext:(FLOperationContext*) context;
- (void) contextDidClose;
- (void) contextDidOpen;
- (void) contextDidCancel;

//// if the child operation doesn't have a queue or a context,
//// it will inherit it from it's parent.
//- (void) willRunInParent:(id) parent;
//
//- (void) willStartChildOperation:(id) childOperation;
//- (void) didFinishChildOperation:(id) childOperation withResult:(FLPromisedResult) result;

- (void) abortIfCancelled; // throws cancelError


- (void) sendStartMessagesWithInitialData:(id) initialData;
- (void) sendFinishMessagesWithResult:(FLPromisedResult) result;

@end


