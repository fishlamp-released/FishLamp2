//
//  FLSimpleWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimpleWorker.h"

@implementation FLSimpleWorker

- (void) startWorking:(id<FLFinisher>) finisher {
}

- (id<FLPromisedResult>) start:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    @try {
        [self startWorking:finisher];
    }
    @catch(NSException* ex) {
        if(!FLTryHandlingErrorForObject(ex.error, self)) {
            @throw;
        }
    }
    return finisher;
}

- (FLResult) runSynchronously {
    return [[self start:nil] waitForResult];
}


@end
