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

#if FL_MRC
- (void) dealloc {
    FLRelease(_queue);
	super_dealloc_();
}
#endif

- (void) addBlock:(FLQueuedBlock) block {
    if(!_queue) {
        _queue = [[NSMutableArray alloc] init];
    }

    [_queue addObject:FLAutorelease([block copy])];
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
    return FLAutorelease([[FLBlockQueue alloc] init]);
}

@end