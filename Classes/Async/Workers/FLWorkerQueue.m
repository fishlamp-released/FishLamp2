//
//  FLWorkerQueue.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorkerQueue.h"
#import "FLCollectionIterator.h"
#import "FLWorkFinisher.h"

@implementation FLWorkerQueue

@synthesize workers = _workers;

- (id) init {
    self = [super init];
    if(self) {
        _workers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addWorker:(id<FLWorker>) worker {
    [self willAddWorker:worker];
    [_workers addObject:worker];
}

#if FL_MRC
- (void) dealloc {
    [_workers release];
    [super dealloc];
}
#endif

- (void) runNextWorker:(id<FLCollectionIterator>) iterator
          withFinisher:(id<FLFinisher>) queueFinisher {

    id<FLWorker> worker = iterator.nextObject;
    if(worker) {
        FLWorkFinisher* workerFinisher = [FLWorkFinisher finisher:^(id<FLResult> result) {
            if(result.didSucceed) {
                [self runNextWorker:iterator withFinisher:queueFinisher];
            }
            else {
                [queueFinisher setFinishedWithResult:result];
            }
        }];
        [worker startWorking:workerFinisher];
    }
    else {
        [queueFinisher setFinished];
    }
}

- (void) startWorking:(id<FLFinisher>) finisher {
    [self runNextWorker:[_workers forwardIterator] withFinisher:finisher];
}

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


@end


