//
//  FLSimpleWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimpleWorker.h"

@implementation FLSimpleWorker

- (void) startWorking:(FLFinisher) finisher {
}

- (FLPromisedResult) start:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    [self startWorking:finisher];
    return finisher;
}

- (FLResult) runSynchronously {
    return [[self start:nil] waitForResult];
}


@end
