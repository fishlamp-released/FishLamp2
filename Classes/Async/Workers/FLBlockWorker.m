//
//  FLBlockWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBlockWorker.h"

@interface FLBlockWorker ()
@property (readwrite, copy) FLAsyncBlock asyncWorkerBlock;
@end

@implementation FLBlockWorker

@synthesize asyncWorkerBlock = _workerBlock;

- (id) initWithWorkerBlock:(FLAsyncBlock) block {
    self = [super init];
    if(self) {
        self.asyncWorkerBlock = block;
    }
    return self;
}
+ (id) blockWorker:(FLAsyncBlock) block {
    return autorelease_([[[self class] alloc] initWithWorkerBlock:block]);
}

#if FL_MRC
- (void) dealloc {
    [_workerBlock release];
    [super dealloc];
}
#endif

- (void) startWorking:(id<FLFinisher>) finisher {
    if(_workerBlock) {
        _workerBlock(finisher);
    }
    else {
        [finisher setFinished];
    }
}

@end

