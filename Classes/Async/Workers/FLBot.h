//
//  FLBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLAsyncWorker.h"
#import "FLFinisher.h"
#import "FLCollectionIterator.h"

@class FLBot;

@protocol FLBot <FLAsyncWorkerErrorDelegate, FLAsyncWorker>
@property (readonly, assign) id superbot;

// by default set to self.
@property (readwrite, assign) id<FLAsyncWorkerErrorDelegate> errorDelegate;
@end

typedef void (^FLBotVisitor)(id bot, BOOL* stop);

@interface FLBot : NSObject<FLBot> {
@private
    __unsafe_unretained id _superbot;
    __unsafe_unretained id _errorDelegate;
    NSMutableArray* _workers;
}
@property (readonly, strong) NSArray* workers;

+ (id) bot;

- (id<FLAsyncResult>) runBot:(FLCompletionBlock) completion;

+ (id<FLAsyncResult>) startWorker:(id<FLAsyncWorker>) worker
                           completion:(FLCompletionBlock) completion;

- (BOOL) visitWorkers:(FLBotVisitor) visitor;
- (BOOL) visitWorkersInReverse:(FLBotVisitor) visitor;

- (void) addAsyncWorker:(id<FLAsyncWorker>) worker;
- (void) addAsyncWorkerWithBlock:(dispatch_block_t) block;
- (void) addAsyncWorkers:(NSArray*) workers;

- (void) removeWorker:(id<FLAsyncWorker>) worker;
- (void) removeAllworkers;

@end

@interface FLBot (Yuck)
- (void) runBlockWithFinisher:(FLFinisher*) finisher
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

