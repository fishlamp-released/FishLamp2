//
//  FLAsyncWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLFinisher;
@protocol FLDispatcher;
@protocol FLWorkerContext;

@protocol FLAsyncWorker <NSObject>

- (void) startWorking:(FLFinisher*) finisher;

- (void) requestCancel;

- (id<FLDispatcher>) dispatcher;

@property (readonly, assign) id<FLWorkerContext> workerContext;

- (void) didMoveToContext:(id<FLWorkerContext>) context;

@end


@interface FLAsyncWorker : NSObject<FLAsyncWorker> {
@private
    __unsafe_unretained id<FLWorkerContext> _workerContext;
}

@end

@interface FLAsyncWorkerQueue : NSObject<FLAsyncWorker> 

+ (id) asyncWorkerQueue;

- (void) addWorker:(id<FLAsyncWorker>) worker;

@end