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

typedef void (^FLFinishableBlock)(FLFinisher* finisher);

@protocol FLBlockDispatcher <NSObject>

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block;

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block
                   completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block;

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block
                             completion:(FLCompletionBlock) completion;

@end

@protocol FLDispatchable <NSObject>
- (FLResult) runSynchronously;
- (FLResult) runSynchronouslyWithInput:(id) input;
@end

@protocol FLObjectDispatcher <NSObject>

// object must implement the methods in FLDispatchable, 
// but not necessarily the dispatchable protocol.

- (FLFinisher*) dispatchObject:(id) object;

- (FLFinisher*) dispatchObject:(id) object
                    withInput:(id) input;

- (FLFinisher*) dispatchObject:(id) object
                    withInput:(id) input
                   completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchObject:(id) object
                   completion:(FLCompletionBlock) completion;


@end


@protocol FLSelectorDispatcher <NSObject>

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

@protocol FLDispatcher <FLBlockDispatcher, FLObjectDispatcher, FLSelectorDispatcher>
@end
