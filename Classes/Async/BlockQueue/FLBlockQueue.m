//
//  FLBlockQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/13/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLBlockQueue.h"

@implementation FLBlockQueue

- (id) init {
    if((self = [super init])) {
    }
    
    return self;
}

#if FL_NO_ARC
- (void) dealloc {
    FLRelease(_queue);
	FLSuperDealloc();
}
#endif

- (void) addBlock:(FLQueuedBlock) block {
    if(!_queue) {
        _queue = [[NSMutableArray alloc] init];
    }

    [_queue addObject:FLReturnAutoreleased([block copy])];
}

- (void) executeBlocks:(id) sender {
    for(FLQueuedBlock block in _queue) {
        block(sender);
    }
}

- (void) removeAllBlocks {
    _queue = nil;
}

+ (FLBlockQueue*) blockQueue {
    return FLReturnAutoreleased([[FLBlockQueue alloc] init]);
}

@end
