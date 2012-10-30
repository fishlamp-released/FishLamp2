//
//  FLJob.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if 0
//#import "FishLampCore.h"
//#import "FLWorker.h"
//#import "FLWorkFinisher.h"
//#import "FLCollectionIterator.h"
//#import "FLSimpleWorker.h"
//
//@class FLJob;
//@protocol FLDispatcher;
//
//@protocol FLJob <FLWorker, FLRunnable, FLFallible>
//@property (readonly, assign) id parentJob;
//@property (readwrite, assign) id<FLFallibleDelegate> fallibleDelegate;
//@end
//
//typedef void (^FLJobVisitor)(id job, BOOL* stop);
//
//@interface FLJob : FLSimpleWorker<FLJob> {
//@private
//    __unsafe_unretained id _parentJob;
//    __unsafe_unretained id _errorDelegate;
//    NSMutableArray* _workers;
//    id<FLDispatcher> _queue;
//}
//@property (readonly, strong) NSArray* workers;
//
//+ (id) job;
//
//- (BOOL) visitWorkers:(FLJobVisitor) visitor;
//- (BOOL) visitWorkersInReverse:(FLJobVisitor) visitor;
//
//- (void) addWorker:(id<FLWorker>) worker;
//- (void) addWorker:(id<FLWorker>) worker completion:(FLResultBlock) completion;
//
//- (void) addWorkerWithBlock:(dispatch_block_t) block;
//- (void) addWorkerWithBlock:(dispatch_block_t) block completion:(FLResultBlock) completion;
//
//- (void) addWorkerWithAsyncBlock:(FLAsyncBlock) block;
//- (void) addWorkerWithAsyncBlock:(FLAsyncBlock) block completion:(FLResultBlock) completion;
//
//
////- (void) addWorkers:(NSArray*) workers;
//
////- (void) removeWorker:(id<FLWorker>) worker;
////- (void) removeAllWorkers;
//
//@end
//
///**
//    work and completion always fire in background thread
// */
//@interface FLBackgroundJob : FLJob
//@end
//
//
///**
//    work and completion always fire in main thread
// */
//@interface FLForegroundJob : FLJob 
//@end
//
#endif