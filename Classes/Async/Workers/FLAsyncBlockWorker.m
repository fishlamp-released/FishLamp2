//
//  FLBlockWorker.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncBlockWorker.h"

@implementation FLAsyncBlockWorker

- (id) initWithAsyncBlock:(FLAsyncBlock) block {
    self = [super init];
    if(self) {
        _asyncBlock = [block copy];
    }
    return self;
}
+ (id) asyncBlockWorker:(FLAsyncBlock) block {
    return autorelease_([[[self class] alloc] initWithAsyncBlock:block]);
}

#if FL_MRC
- (void) dealloc {
    [_asyncBlock release];
    [super dealloc];
}
#endif

- (FLFinisher*) startWorking:(FLFinisher*) finisher {
    if(_asyncBlock) {
        _asyncBlock(finisher);
    }
    else {
        [finisher setFinished];
    }
    return finisher;
}

@end