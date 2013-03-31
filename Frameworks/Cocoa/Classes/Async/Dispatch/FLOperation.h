//
//  FLOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#import "FLDispatchTypes.h"
#import "FLFinisher.h"
#import "FLObservable.h"
#import "FLOperationContext.h"
#import "FLAsyncQueue.h"

@protocol FLOperation <NSObject>
- (void) performUntilFinished:(FLFinisher*) finisher;
- (void) operationDidFinish;
@end

@interface FLOperation : FLObservable<FLOperation> {
@private
    __unsafe_unretained FLOperationContext* _context;
    NSUInteger _contextID;
}

// id of context. 
@property (readonly, assign) NSUInteger contextID;

// if you want control over your executing operation, run it in a context.
@property (readwrite, assign, nonatomic) FLOperationContext* context;

// note that if you start an operation directly in a queue (e.g. you don't call start or run) the asyncQueue is ignored 
@property (readwrite, assign, nonatomic) id<FLAsyncQueue> asyncQueue;

// cancel yourself, and be quick about it.
- (void) requestCancel;

// run synchronously
- (FLResult) runSynchronously;

- (FLResult) runSynchronouslyInContext:(FLOperationContext*) context;


// start async. will run in asyncQueue. 
- (FLFinisher*) runAsynchronously;

- (FLFinisher*) runAsynchronously:(fl_completion_block_t) completionOrNil;

- (FLFinisher*) runAsynchronouslyInContext:(FLOperationContext*) context 
                                completion:(fl_completion_block_t) completionOrNil;

// these call wasStartedByParent on the child before operation
// is run or started.
- (FLResult) runChildSynchronously:(FLOperation*) operation;

- (FLFinisher*) runChildAsynchronously:(FLOperation*) operation 
                     completion:(fl_completion_block_t) completionOrNil;


// optional overides
- (void) wasAddedToContext:(FLOperationContext*) context;
- (void) wasRemovedFromContext:(FLOperationContext*) context;
- (void) contextDidClose;
- (void) contextDidOpen;
- (void) contextDidCancel;
- (void) operationDidFinish;

// if the child operation doesn't have a queue or a context,
// it will inherit it from it's parent.
- (void) wasStartedByParent:(id<FLOperation>) parent;

@end
