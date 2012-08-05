//
//  FLBackgroundQueue.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

// FIFO queue

@interface FLFifoQueue : NSObject {
    BOOL _open;
    dispatch_queue_t _queue;
    dispatch_once_t _openOnce; 
    dispatch_once_t _closeOnce; 
    
}

FLSingletonProperty(FLFifoQueue);

- (void) openBackgroundQueue;
- (void) closeBackgroundQueue;

- (void) queueBlock:(dispatch_block_t) block;

@end
