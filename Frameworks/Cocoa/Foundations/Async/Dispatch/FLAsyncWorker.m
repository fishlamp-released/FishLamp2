//
//  FLAsyncWorker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncWorker.h"
#import "FLDispatch.h"

@implementation FLAsyncWorker

@synthesize context = _context;

- (void) startWorking:(FLFinisher*) finisher {
    [finisher setFinished];
}

- (void) didMoveToAsyncWorkerContext:(FLAsyncWorkerContext*) context {
    self.context = context;
}

@end
