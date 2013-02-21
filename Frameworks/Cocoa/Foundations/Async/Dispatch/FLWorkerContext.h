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

@protocol FLWorkerContext <NSObject>

- (void) requestCancel;

- (FLResult) runWorker:(id<FLAsyncWorker>) worker 
          withObserver:(id) observer;
                 
- (FLFinisher*) scheduleWorker:(id<FLAsyncWorker>) worker
                  inDispatcher:(id<FLDispatcher>) dispatcher
                  withObserver:(id) observer 
                    completion:(FLBlockWithResult) completion;
@end

@interface FLWorkerContext : FLService<FLWorkerContext> {
@private
    NSMutableSet* _objects;
    FLDispatcher* _dispatcher;
}

// shared FIFO queue by default.
@property (readwrite, strong, nonatomic) FLDispatcher* dispatcher;

+ (id) workerContext;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLBlockWithResult) completion;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor;

@end

