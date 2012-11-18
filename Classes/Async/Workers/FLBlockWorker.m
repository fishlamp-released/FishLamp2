//
//  FLBlockWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBlockWorker.h"

@implementation FLBlockWorker

- (id) initWithBlock:(dispatch_block_t) block {
    self = [super init];
    if(self) {
        _block = [block copy];
    }
    return self;
}
+ (id) blockWorker:(dispatch_block_t) block {
    return autorelease_([[[self class] alloc] initWithBlock:block]);
}

#if FL_MRC
- (void) dealloc {
    [_block release];
    [super dealloc];
}
#endif

- (void) startWorking:(id) asyncTask {
    if(_block) {
        _block();
    }
    [asyncTask setFinished];

}

@end
