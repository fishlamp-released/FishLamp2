//
//  FLBot.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBot.h"
#import "NSObject+Blocks.h"
#import "FLCollectionIterator.h"
#import "FLBotError.h"
#import "FLWorkerBot.h"

@interface FLBot ()
// optional overrides
// 
//- (FLFinisher*) runBotWithFinisher:(FLFinisher*) finisher;

- (void) runWorkers:(id<FLCollectionIterator>) iterator
       withFinisher:(FLFinisher*) finisher;

@property (readwrite, assign) id superbot;
@end

@implementation FLBot

@synthesize superbot = _superbot;
@synthesize errorDelegate = _errorDelegate;
@synthesize workers = _workers;

- (id) init {
    self = [super init];
    if(self) {
        self.errorDelegate = self;
    }
    return self;
}

- (FLFinisher*) runBot:(FLCompletionBlock) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    @try {
        [self startWorking:finisher];
    }
    @catch(NSException* ex) {
        FLTryHandlingWorkerException(ex);
    }
    
    return finisher;
}

+ (id<FLAsyncResult>) startWorker:(id<FLAsyncWorker>) worker
                           completion:(FLCompletionBlock) completion {
    FLBot* host = [[self class] bot];
    [host addAsyncWorker:worker];
    return [host runBot:completion];
}


- (void) asyncWorker:(id<FLAsyncWorker>) worker
        encounteredError:(NSError*) error
            finisher:(id<FLAsyncFinisher>) finisher {
   
    if(!finisher.isFinished) {
   
        if(self.errorDelegate) {
            [self.errorDelegate asyncWorker:worker encounteredError:error finisher:finisher];
        }
        
        if(!finisher.isFinished) {
            id walker = self.superbot;
            while(walker) {
                
                if( [walker respondsToSelector:@selector(asyncWorker:encounteredError:finisher:)]) {
                
                    [walker asyncWorker:worker encounteredError:error finisher:finisher];
                    
                    if(finisher.isFinished) {
                        break;
                    }
                }

                if([walker respondsToSelector:@selector(superbot)]) {
                    walker = [walker superbot];
                }
                else {
                    walker = nil;
                }
            }
        }
    
    }
}

// perculate

- (BOOL) handleAsyncWorkerError:(NSError*) error {
    
    __block BOOL handledError = NO;
    [self asyncWorker:self encounteredError:error finisher:[FLFinisher finisher:^(id<FLAsyncResult> result){
        handledError = YES;
    }]];
    return handledError;
}


+ (id) bot {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) runNextWorker:(id<FLCollectionIterator>) iterator
           inThread:(NSThread*) thread
       withFinisher:(FLFinisher*) finisher {

    id bot = iterator.nextObject;
    if(bot) {
        [bot runBot:^(id<FLAsyncResult> result){
            if([NSThread currentThread] == thread) {
                [self runNextWorker:iterator inThread:thread withFinisher:finisher];
            }
            else {
                [self performBlockOnThread:thread block:^{
                    [self runNextWorker:iterator inThread:thread withFinisher:finisher];
                }];
            }
        }];
    }
    else {
        [finisher setFinished];
    }
}

- (void) runWorkers:(id<FLCollectionIterator>) iterator
    withFinisher:(FLFinisher*) finisher {

    if(!iterator) {
        [finisher setFinished];
        return;
    }
    
    [self runNextWorker:iterator inThread:[NSThread currentThread] withFinisher:finisher];
}

- (void) startWorking:(FLFinisher*) finisher {
    [self runWorkers:[_workers forwardIterator] withFinisher:finisher];
}

- (void) dealloc {
    for(id worker in _workers) {
        if([worker respondsToSelector:@selector(setSuperbot:)]) {
            [worker setSuperbot:nil];
        }
    }
#if FL_NO_ARC
    [_workers release];
    [super dealloc];
#endif
}

- (void) addAsyncWorker:(id<FLAsyncWorker>) worker {
    if(!_workers) {
        _workers = [[NSMutableArray alloc] init];
    }
    
    if([worker respondsToSelector:@selector(setSuperbot:)]) {
        FLAssert_v([((id)worker) superbot] == nil, @"bot already has superbot");
        [((id)worker) setSuperbot:self];
    }
    
    [_workers addObject:worker];
}

- (void) removeWorker:(id<FLAsyncWorker>) worker {
    if([worker respondsToSelector:@selector(setSuperbot:)]) {
        FLAssert_v([((id)worker) superbot] == self, @"removing from wrong bot");
        [((id)worker) setSuperbot:nil];
    }
    [_workers removeObject:worker];
}

- (void) removeAllworkers {
    for(id worker in _workers) {
        if([worker respondsToSelector:@selector(setSuperbot:)]) {
            FLAssert_v([worker superbot] == self, @"removing from wrong bot");
            [worker setSuperbot:nil];
        }
    }
    [_workers removeAllObjects];
}

- (void) addAsyncWorkers:(NSArray*) workers {
    for(FLBot* worker in workers) {
        [self addAsyncWorker:worker];
    }
}

- (BOOL) visitWorkers:(FLBotVisitor) visitor {
    BOOL stop = NO;
    for(FLBot* operation in _workers) {
        visitor(operation, &stop);
        
        if(stop) {
            return YES;
        }
    }
    return stop;
}

- (BOOL) visitWorkersInReverse:(FLBotVisitor) visitor {

    BOOL stop = NO;
    for(FLBot* operation in _workers.reverseObjectEnumerator) {
        visitor(operation, &stop);
        
        if(stop) {
            return YES;
        }
    }
    return stop;
    
}

//- (void) addAsyncWorkerWithFactoryBlock:(FLCreateBotBlock) block {
//    if(block) {
//        [self addAsyncWorker:block()];
//    }
//}

//
//- (void) addAsyncWorkerWithTarget:(id) target action:(SEL) action {
//    [self addAsyncWorker:[FLPerformSelectorBot performSelectorBot:target action:action ]];
//}

- (void) addAsyncWorkerWithBlock:(dispatch_block_t) operationBlock {
    // [self addAsyncWorker:[FLWorkerBot workerBot:operationBlock]];
}

@end

@implementation FLBackgroundBot

- (void) finishRunning:(FLFinisher*) finisher onThread:(NSThread*) thread {
    if([NSThread currentThread] == thread) {
        [finisher setFinished];
    }
    else {
        [self performBlockOnThread:thread
            block:^{
                [self finishRunning:finisher onThread:thread];
            }];
    }
}

- (void) _startWorking:(FLFinisher*) finisher onThread:(NSThread*) onThread {
    
    FLFinisher* newFinisher = [FLFinisher finisher:^(id<FLAsyncResult> result){
        [self finishRunning:finisher onThread:onThread];
    }];
    
    @try {
        [super startWorking:newFinisher];
    }
    @catch(NSException* ex) {
        FLTryHandlingWorkerException(ex);
    }
}

- (void) startWorking:(FLFinisher*) finisher {

    NSThread* startThread = [NSThread currentThread];

    if([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self _startWorking:finisher onThread:startThread];
        });
    }
    else {
        [self _startWorking:finisher onThread:startThread];
    }
}

@end

@implementation FLForegroundBot

- (void) finishRunning:(FLFinisher*) completion {
    if([NSThread isMainThread]) {
        [completion setFinished];
    }
    else {
        [self performSelectorOnMainThread:@selector(finishRunning:) withObject:completion waitUntilDone:NO];
    }
}

- (void) _startWorking:(FLFinisher*) finisher {
   
    FLFinisher* foregroundFinisher = [FLFinisher finisher:^(id<FLAsyncResult> result){
            [self finishRunning:finisher]; }];
    @try {
        [super startWorking:foregroundFinisher];
    }
    @catch(NSException* ex) {
        FLTryHandlingWorkerException(ex);
    }
}

- (void) startWorking:(FLFinisher*) finisher {
    [self performSelectorOnMainThread:@selector(_startWorking:) withObject:finisher waitUntilDone:NO];
}

@end





