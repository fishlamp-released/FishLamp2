//
//  FLDispatcher.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import <dispatch/dispatch.h>

#import "FLFinisher.h"
#import "FLResult.h"

@protocol FLSynchronouslyDispatchable <NSObject>
- (FLResult) runSynchronously;
- (FLResult) runSynchronouslyWithInput:(id) input;
@end

@protocol FLAsyncDispatchable <NSObject>
- (void) startAsync:(FLFinisher*) finisher;
@end

typedef void (^FLFinishableBlock)(FLFinisher* finisher);

@protocol FLDispatcher <NSObject>

// 
// block dispatching
//

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block;

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block
                   completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block;

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block
                             completion:(FLCompletionBlock) completion;

// 
// FLAsyncDispatchable dispatching
// 

- (FLFinisher*) dispatchAsync:(id /*FLAsyncDispatchable*/) dispatchableObject;

- (FLFinisher*) dispatchAsync:(id /*FLAsyncDispatchable*/) dispatchableObject 
                   completion:(FLCompletionBlock) completion;

//
// FLSynchronouslyDispatchable object dispatching
//

- (FLFinisher*) dispatchSynchronousObject:(id /*FLSynchronouslyDispatchable*/) synchronouslyDispatchable;

- (FLFinisher*) dispatchSynchronousObject:(id /*FLSynchronouslyDispatchable*/) synchronouslyDispatchable
                    withInput:(id) input;

- (FLFinisher*) dispatchSynchronousObject:(id /*FLSynchronouslyDispatchable*/) synchronouslyDispatchable
                    withInput:(id) input
                   completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchSynchronousObject:(id /*FLSynchronouslyDispatchable*/) object
                   completion:(FLCompletionBlock) completion;


//
// target/selector dispatching
//

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3
                    completion:(FLCompletionBlock) completion;

@end


