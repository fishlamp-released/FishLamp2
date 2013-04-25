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
- (void) performUntilFinished:(FLFinisher*) finisher;
- (void) operationDidFinishWithResult:(id<FLAsyncResult>) result;
- (void) requestCancel;

@end

@protocol FLOperationDelegate <NSObject>
@optional
- (void) operationDidFinish:(id) operation withResult:(id<FLAsyncResult>) result;
@end

@interface FLOperation : FLObservable<FLOperation> {
@private
    __unsafe_unretained FLOperationContext* _context;
    NSUInteger _contextID;
    id<FLAsyncQueue> _asyncQueue;
    id _storageService;
	id _identifier;
    BOOL _cancelled;
    __unsafe_unretained id _delegate;
//    SEL _finishedSelector;
    NSInteger _retryCount;
}
@property (readwrite, assign) NSInteger retryCount;

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

// run synchronously
- (id<FLAsyncResult>) runSynchronously;

- (id<FLAsyncResult>) runSynchronouslyInContext:(FLOperationContext*) context;

// start async. will run in asyncQueue. 
- (FLFinisher*) runAsynchronously;

- (FLFinisher*) runAsynchronously:(fl_completion_block_t) completionOrNil;

- (FLFinisher*) runAsynchronouslyInContext:(FLOperationContext*) context 
                                completion:(fl_completion_block_t) completionOrNil;

// these call willRunInParent on the child before operation
// is run or started.
- (id<FLAsyncResult>) runChildSynchronously:(FLOperation*) operation;

- (FLFinisher*) runChildAsynchronously:(FLOperation*) operation;

- (FLFinisher*) runChildAsynchronously:(FLOperation*) operation 
                            completion:(fl_completion_block_t) completionOrNil;


// optional overides
- (void) wasAddedToContext:(FLOperationContext*) context;
- (void) wasRemovedFromContext:(FLOperationContext*) context;
- (void) contextDidClose;
- (void) contextDidOpen;
- (void) contextDidCancel;

- (void) operationDidFinishWithResult:(id) result;

// if the child operation doesn't have a queue or a context,
// it will inherit it from it's parent.
- (void) willRunInParent:(id) parent;
- (void) didFinishInParent:(id) parent withResult:(id<FLAsyncResult>) result;

- (void) willStartChildOperation:(id) childOperation;
- (void) didFinishChildOperation:(id) childOperation withResult:(id<FLAsyncResult>) result;

- (void) abortIfCancelled; // throws cancelError


- (void) sendStartMessagesWithInitialData:(id) initialData;
- (void) sendFinishMessagesWithResult:(id<FLAsyncResult>) result;

@end


