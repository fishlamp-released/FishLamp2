//
//  FLBackgroundQueue.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLFifoQueue.h"

@implementation FLFifoQueue

FLSynthesizeSingleton(FLFifoQueue);

- (id) init {
    self = [super init];
    if(self) {
        _openOnce = 0; 
        _closeOnce = 0;
    }
    
    return self;
}

- (void) dealloc {
    [self closeBackgroundQueue];
    
    FLSuperDealloc();
}

- (void) openBackgroundQueue {
    
    dispatch_once(&_openOnce, ^{
        _queue = dispatch_queue_create("FLBackgroundQueue", DISPATCH_QUEUE_SERIAL);
        _open = YES;    
        _closeOnce = 0;
    });
}

- (void) closeBackgroundQueue {

    dispatch_once(&_closeOnce, ^{
        dispatch_release(_queue);
        _open = NO;
        _openOnce = 0; 
    });
}

- (void) queueBlock:(dispatch_block_t) block {
    if(!_open) {
        [self openBackgroundQueue];
    }
    dispatch_async(_queue, block);
}


@end
