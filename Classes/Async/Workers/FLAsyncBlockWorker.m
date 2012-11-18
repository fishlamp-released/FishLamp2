//
//  FLBlockWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncBlockWorker.h"

@implementation FLAsyncBlockWorker

- (id) initWithAsyncTaskBlock:(FLAsyncTaskBlock) block {
    self = [super init];
    if(self) {
        _asyncBlock = [block copy];
    }
    return self;
}
+ (id) asyncBlockWorker:(FLAsyncTaskBlock) block {
    return autorelease_([[[self class] alloc] initWithAsyncTaskBlock:block]);
}

#if FL_MRC
- (void) dealloc {
    [_asyncBlock release];
    [super dealloc];
}
#endif

- (void) startWorking:(id) asyncTask {
    if(_asyncBlock) {
        _asyncBlock(asyncTask);
    }
    else {
        [asyncTask setFinished];
    }

}

@end