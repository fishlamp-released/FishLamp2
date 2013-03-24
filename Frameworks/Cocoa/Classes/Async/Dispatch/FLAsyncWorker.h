//
//  FLAsyncWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"

@class FLFinisher;
@protocol FLAsyncQueue;
@protocol FLWorkerContext;

@protocol FLAsyncWorker <NSObject>
- (void) startWorking:(FLFinisher*) finisher;
@end

@protocol FLContextWorker <FLAsyncWorker>
@property (readonly, assign) id<FLWorkerContext> workerContext;
@property (readonly, assign) NSUInteger contextID;
- (void) requestCancel;
- (id<FLAsyncQueue>) asyncQueue;
- (void) didMoveToContext:(id<FLWorkerContext>) context;
- (void) contextDidChange:(id<FLWorkerContext>) context;
@end

@interface FLContextWorker : FLObservable<FLContextWorker> {
@private
    __unsafe_unretained id<FLWorkerContext> _workerContext;
    NSUInteger _contextID;
}

@end



//@interface FLContextWorkerQueue : NSObject<FLAsyncWorker> 
//
//+ (id) asyncWorkerQueue;
//
//- (void) addWorker:(id<FLAsyncWorker>) worker;
//
//@end

