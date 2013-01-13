//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLDispatching.h"

@protocol FLDispatcherDelegate;

@interface FLDispatcher : NSObject<FLDispatching> {
@private
    __unsafe_unretained id<FLDispatcherDelegate> _delegate;
}

@property (readwrite, assign) id<FLDispatcherDelegate> delegate;

// required overrides. these are the bottlenecks
- (void) dispatchBlock:(dispatch_block_t) block 
              withFinisher:(FLFinisher*) finisher;

- (void) dispatchFinishableBlock:(FLFinishableBlock) block 
              withFinisher:(FLFinisher*) finisher;

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(dispatch_block_t) block 
                          withFinisher:(FLFinisher*) finisher;

// optional overrides
- (FLFinisher*) createFinisher:(FLCompletionBlock) completionBlock;

@end

@protocol FLDispatcherDelegate <NSObject> 
@optional

- (void) dispatcher:(FLDispatcher*) dispatcher 
 willDispatchObject:(id) object;

- (void) dispatcher:(FLDispatcher*) dispatcher 
  didDispatchObject:(id) object;                                        

- (void) dispatcher:(FLDispatcher*) dispatcher 
dispatchFinishableBlock:(FLFinishableBlock) block 
         withFinisher:(FLFinisher*) finisher;
         
- (void) dispatcher:(FLDispatcher*) dispatcher
      dispatchBlock:(dispatch_block_t) block 
       withFinisher:(FLFinisher*) finisher;         

@end

