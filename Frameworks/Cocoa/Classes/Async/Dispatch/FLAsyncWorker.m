//
//  FLAsyncWorker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncWorker.h"
#import "FLWorkerContext.h"

@implementation FLContextWorker

@synthesize workerContext = _workerContext;
@synthesize contextID = _contextID;

- (void) startWorking:(FLFinisher*) finisher {
    FLLog(@"Context worker did nothing.");
    [finisher setFinished];
}                      

- (void) requestCancel {

}

- (id<FLAsyncQueue>) asyncQueue {
    return nil;
}

- (void) didMoveToContext:(id<FLWorkerContext>) context {
    _workerContext = context;
    _contextID = [context contextID];
}

- (void) contextDidChange:(id<FLWorkerContext>) context {
    
}

@end