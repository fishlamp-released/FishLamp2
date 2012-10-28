//
//  FLAsyncWorker.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncWorker.h"

@interface FLAsyncWorker ()
@property (readwrite, copy) FLAsyncWorkerBlock asyncWorkerBlock;
@end

@implementation FLAsyncWorker

@synthesize asyncWorkerBlock = _asyncWorkerBlock;

- (id) initWithAsyncWorkerBlock:(FLAsyncWorkerBlock) block {
    self = [super init];
    if(self) {
        self.asyncWorkerBlock = block;
    }
    return self;
}
+ (id) asyncWorker:(FLAsyncWorkerBlock) block {
    return FLReturnAutoreleased([[[self class] alloc] initWithAsyncWorkerBlock:block]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_asyncWorkerBlock release];
    [super dealloc];
}
#endif

- (void) startWorking:(id<FLAsyncFinisher>) finisher {
    if(_asyncWorkerBlock) {
        _asyncWorkerBlock(finisher);
    }
    else {
        [finisher setFinished];
    }
}

@end