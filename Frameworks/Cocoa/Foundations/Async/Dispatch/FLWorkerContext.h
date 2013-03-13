//
//  FLWorkerContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLFinisher.h"
#import "FLDispatcher.h"
#import "FLObserver.h"
#import "FLAsyncWorker.h"
#import "FLService.h"

typedef void (^FLDispatchableObjectVisitor)(id object, BOOL* stop);

extern NSString* const FLWorkerContextStarting;
extern NSString* const FLWorkerContextFinished;
extern NSString* const FLWorkerContextClosed;
extern NSString* const FLWorkerContextOpened;

@protocol FLWorkerContext <NSObject>

@property (readonly, assign, getter=isContextOpen) BOOL contextOpen; 
- (void) openContext;
- (void) closeContext;

- (FLResult) runWorker:(id<FLAsyncWorker>) worker 
          withObserver:(id) observer;
                 
//- (FLFinisher*) startWorker:(id<FLAsyncWorker>) worker
//                  inDispatcher:(id<FLDispatcher>) dispatcher
//                  withObserver:(id) observer 
//                    completion:(FLBlockWithResult) completion;

//- (FLFinisher*) startWorker:(id<FLAsyncWorker>) worker withObserver:(id) observer;
- (void) startWorker:(id<FLAsyncWorker>) worker withFinisher:(FLFinisher*) finisher;
- (void) startWorker:(id<FLAsyncWorker>) worker withObserver:(id) observer completion:(FLBlockWithResult) completion;

//- (void) startWorker:(id<FLAsyncWorker>) worker withObserver:(id) observer withFinisher:(FLFinisher*) finisher;
//- (void) startWorker:(id<FLAsyncWorker>) worker withObserver:(id) observer completion:(FLBlockWithResult) completion;

@end

@interface FLWorkerContext : FLService<FLWorkerContext> {
@private
    NSMutableSet* _objects;
    FLDispatcher* _dispatcher;
    BOOL _contextOpen;
}

// shared FIFO queue by default.
@property (readwrite, strong, nonatomic) FLDispatcher* dispatcher;

+ (id) workerContext;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLBlockWithResult) completion;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor;

- (void) didStartWorking;
- (void) didStopWorking;

- (void) didAddWorker:(id) object;
- (void) didRemoveWorker:(id) object;
@end

