//
//  FLFifoGcdDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFifoGcdDispatcher.h"

@implementation FLFifoGcdDispatcher  

+ (id) fifoDispatchQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    static int s_count = 0;
    return [super initWithLabel:[NSString stringWithFormat:@"com.fishlamp.queue.fifo%d", s_count++] attr:DISPATCH_QUEUE_SERIAL];
}

+ (FLObjectPool*) pool {
    static FLObjectPoolFactory s_factory = ^{
        return [FLFifoGcdDispatcher fifoDispatchQueue];
    };

    FLReturnStaticObject([[FLObjectPool alloc] initWithObjectFactory:s_factory]); 
}


@end
