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

typedef void (^FLDispatchableObjectVisitor)(id object, BOOL* stop);

extern NSString* const FLWorkerContextStarting;
extern NSString* const FLWorkerContextFinished;
extern NSString* const FLWorkerContextClosed;
extern NSString* const FLWorkerContextOpened;

@protocol FLWorkerContext <NSObject>

@property (readonly, assign) NSUInteger contextID;

@property (readonly, assign, getter=isContextOpen) BOOL contextOpen; 
- (void) openContext;
- (void) closeContext;

- (FLResult) runWorker:(id<FLContextWorker>) worker 
          withObserver:(id) observer;
                 
- (void) startWorker:(id<FLContextWorker>) worker 
        withFinisher:(FLFinisher*) finisher;

- (void) startWorker:(id<FLContextWorker>) worker 
        withObserver:(id) observer 
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

