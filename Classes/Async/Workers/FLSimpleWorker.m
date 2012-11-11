//
//  FLSimpleWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimpleWorker.h"
#import "FLWorkFinisher.h"

@interface FLSimpleWorker ()
@property (readwrite, assign) id parentWorker;
@end

@implementation FLSimpleWorker
@synthesize parentWorker = _parentWorker;
@synthesize fallibleDelegate = _errorDelegate;

- (void) didMoveToParentWorker:(id<FLWorkerParent>) parent {
    
#if DEBUG
    if(parent) {
        FLAssertNil_v(self.parentWorker, @"job already has parentWorker");
    }
    else {
        FLAssertNotNil_v(self.parentWorker, @"job has no parent");
    }
#endif

    self.parentWorker = parent;
}

- (void) startWorking:(id<FLFinisher>) finisher {
}

- (id<FLPromisedResult>) start:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    
    @try {
        [finisher startWorker:self];;
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

- (BOOL) tryHandlingError:(NSError*) error  {

    id walker = self.parentWorker;
    while(walker) {

        if(FLTryHandlingErrorForObject(error, walker)) {
            return YES;
        }

        if([walker respondsToSelector:@selector(parentWorker)]) {
            walker = [walker parentWorker];
        }
        else {
            walker = nil;
        }
    }
    
    return NO;
}

- (void) willAddWorker:(id<FLWorker>) worker {
   if([worker respondsToSelector:@selector(didMoveToParentWorker:)]) {
        [worker didMoveToParentWorker:self];
    }
}

- (void) willRemoveWorker:(id<FLWorker>) worker {
   if([worker respondsToSelector:@selector(didMoveToParentWorker:)]) {
        [worker didMoveToParentWorker:nil];
    }
}

@end
