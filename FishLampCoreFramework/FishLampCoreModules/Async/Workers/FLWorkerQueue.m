//
//  FLWorkerQueue.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorkerQueue.h"
#import "FLCollectionIterator.h"
#import "FLFinisher.h"

//@implementation FLWorkerQueue
//
//@synthesize workers = _workers;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _workers = [[NSMutableArray alloc] init];
//    }
//    return self;
//}
//
//- (void) addWorker:(id<FLWorker>) worker {
//    [self willAddWorker:worker];
//    [_workers addObject:worker];
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_workers release];
//    [super dealloc];
//}
//#endif
//
//- (void) runNextWorker:(id<FLCollectionIterator>) iterator
//          withFinisher:(FLFinisher*) queueFinisher {
//
//    id<FLWorker> worker = iterator.nextObject;
//    if(worker) {
//        FLFinisher* finisher = [FLFinisher finisherWithResultBlock:^(id result) {
//            if([result isError]) {
//                [queueFinisher setFinishedWithResult:result];
//            }
//            else {
//                [self runNextWorker:iterator withFinisher:queueFinisher];
//            }
//        }];
//        [worker startWorking:finisher];
//    }
//    else {
//        [queueFinisher setFinished];
//    }
//}
//
//- (void) startWorking:(id) asyncTask {
//    [self runNextWorker:[_workers forwardIterator] withFinisher:asyncTask];
//
//}

//- (void) removeWorker:(id<FLWorker>) worker {
//    [self setParentJob:worker parent:nil];
//    [_workers removeObject:worker];
//}

//- (void) removeAllWorkers {
//    for(id worker in _workers) {
//        [self setParentJob:worker parent:nil];
//    }
//    [_workers removeAllObjects];
//}

//- (void) addWorkers:(NSArray*) workers {
//    for(FLJob* worker in workers) {
//        [self addWorker:worker];
//    }
//}


//@end
//
//
