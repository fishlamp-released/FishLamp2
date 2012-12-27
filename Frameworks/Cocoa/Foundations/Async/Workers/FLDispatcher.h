//
//  FLDispatcher.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatchable.h"

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

- (FLFinisher*) dispatchObject:(id /*FLDispatchable*/) dispatchableObject;

- (FLFinisher*) dispatchObject:(id /*FLDispatchable*/) dispatchableObject 
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


@interface FLDispatcher : NSObject<FLDispatcher>

// implement these two, the rest bottlenect through these.

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block 
                             completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block 
                   completion:(FLCompletionBlock) completion;
    
                
@end

@interface FLDispatcherDelegate <NSObject>
@optional
- (void) willDispatchObject:(id) object;
- (void) didDispatchObject:(id) object;                                        
@end