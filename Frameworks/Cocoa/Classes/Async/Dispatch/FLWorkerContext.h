//
//  FLWorkerContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLFinisher.h"
#import "FLAsyncQueue.h"
#import "FLMessageBroadcaster.h"
#import "FLAsyncWorker.h"
#import "FLService.h"
#import "FLObservable.h"

typedef void (^FLDispatchableObjectVisitor)(id object, BOOL* stop);

extern NSString* const FLWorkerContextStarting;
extern NSString* const FLWorkerContextFinished;
extern NSString* const FLWorkerContextClosed;
extern NSString* const FLWorkerContextOpened;

@protocol FLContextWorker;

@protocol FLWorkerContext <NSObject>

@property (readonly, assign) NSUInteger contextID;

@property (readonly, assign, getter=isContextOpen) BOOL contextOpen; 
- (void) openContext;
- (void) closeContext;

- (FLResult) runWorker:(id<FLContextWorker>) worker;
                 
- (void) queueWorker:(id<FLContextWorker>) worker 
        withFinisher:(FLFinisher*) finisher;

- (FLFinisher*) queueWorker:(id<FLContextWorker>) worker 
                 completion:(FLBlockWithResult) completion;
          
- (void) requestCancel;          
          
@end

@interface FLWorkerContext : FLService<FLWorkerContext> {
@private
    NSMutableSet* _objects;
    FLAsyncQueue* _asyncQueue;
    BOOL _contextOpen;
    NSUInteger _contextID;
}

// shared FIFO queue by default.
@property (readwrite, strong, nonatomic) FLAsyncQueue* asyncQueue;

+ (id) workerContext;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLBlockWithResult) completion;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor;

- (void) didStartWorking;
- (void) didStopWorking;

- (void) didAddWorker:(id) object;
- (void) didRemoveWorker:(id) object;
@end

@protocol FLContextWorker <FLAsyncWorker>
@property (readonly, assign) id<FLWorkerContext> workerContext;
@property (readonly, assign) NSUInteger contextID;
- (void) requestCancel;
- (id<FLAsyncQueue>) asyncQueue;
- (void) didMoveToContext:(id<FLWorkerContext>) context;
- (void) contextDidChange:(id<FLWorkerContext>) context;

- (FLFinisher*) startInContext:(id<FLWorkerContext>) context 
                    completion:(FLBlockWithResult) completion;

- (FLResult) runInContext:(id<FLWorkerContext>) context;

@end

@interface FLContextWorker : FLObservable<FLContextWorker> {
@private
    __unsafe_unretained id<FLWorkerContext> _workerContext;
    NSUInteger _contextID;
}
- (FLResult) runWorker:(FLContextWorker*) worker;

@end
