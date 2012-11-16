//
//  FLWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"
#import "FLFinisher.h"

@interface FLWorker ()
@property (readwrite, assign) id parentWorker;
@end

@implementation FLWorker
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

- (FLFinisher*) startWorking:(FLFinisher*) finisher {
    return finisher;
}

//- (id<FLPromisedResult>) start:(FLFinisher*) finisher {
////    FLFinisher* finisher = [FLFinisher finisher:completion];
//    
//    @try {
//        [finisher startWorker:self];;
//    }
//    @catch(NSException* ex) {
//        if(!FLTryHandlingErrorForObject(ex.error, self)) {
//            @throw;
//        }
//    }
//    return finisher;
//}

//- (FLFinisher*) runSynchronously {
//    return [[self start:nil] waitUntilFinished];
//}

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

- (id) runSynchronously {
    return [self runSynchronously:[FLFinisher finisher]];
}

- (id) runSynchronously:(FLFinisher*) finisher {
    return [[self startWorking:finisher] waitUntilFinished];
}

@end
