//
//  FLAsyncWorker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncWorker.h"


@implementation FLAsyncWorker

@synthesize workerContext = _workerContext;

- (void) startWorking:(FLFinisher*) finisher {
                      
}                      

- (void) requestCancel {

}

- (id<FLDispatcher>) dispatcher {
    return nil;
}

- (void) didMoveToContext:(id<FLWorkerContext>) context {
    _workerContext = context;
}

@end