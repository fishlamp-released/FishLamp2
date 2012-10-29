//
//  FLBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLWorker.h"
#import "FLWorkFinisher.h"
#import "FLCollectionIterator.h"
#import "FLSimpleWorker.h"

@class FLBot;

@protocol FLBot <FLWorker, FLRunnable, FLFallible>
@property (readonly, assign) id superbot;

@property (readwrite, assign) id<FLFallibleDelegate> fallibleDelegate;
@end

typedef void (^FLBotVisitor)(id bot, BOOL* stop);

@interface FLBot : FLSimpleWorker<FLBot> {
@private
    __unsafe_unretained id _superbot;
    __unsafe_unretained id _errorDelegate;
    NSMutableArray* _workers;
}
@property (readonly, strong) NSArray* workers;

+ (id) bot;

- (FLResult) runBot:(FLResultBlock) completion;

+ (FLResult) start:(id<FLWorker>) worker
                           completion:(FLResultBlock) completion;

- (BOOL) visitWorkers:(FLBotVisitor) visitor;
- (BOOL) visitWorkersInReverse:(FLBotVisitor) visitor;

- (void) addAsyncWorker:(id<FLWorker>) worker;
- (void) addAsyncWorkerWithBlock:(dispatch_block_t) block;
- (void) addAsyncWorkers:(NSArray*) workers;

- (void) removeWorker:(id<FLWorker>) worker;
- (void) removeAllworkers;

@end

@interface FLBot (Yuck)
- (void) runBlockWithFinisher:(FLFinisher) finisher
                        block:(void (^)()) block;
@end



/**
    work and completion always fire in background thread
 */
@interface FLBackgroundBot : FLBot
@end


/**
    work and completion always fire in main thread
 */
@interface FLForegroundBot : FLBot 
@end

