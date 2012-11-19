//
//  FLSelectorQueue.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSelectorQueue.h"

@interface FLSelectorQueue ()
@end

@implementation FLSelectorQueue

- (id) init {
    self = [super init];
    if(self) {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id) initWithCapacity:(uint32_t) capacity {
    self = [super init];
    if(self) {
        _array = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    
    return self;
}

dealloc_ (
    [_array release];
)

- (SEL) nextSelector {
    SEL selector = nil;
    @synchronized(self) {
        if(_array.count) {
            selector = (SEL) [[_array objectAtIndex:0] pointerValue];
            [_array removeObjectAtIndex:0];
        }
    }
    return selector;
}


- (void) addSelector:(SEL) selector {
    @synchronized(self) {
        [_array addObject:[NSValue valueWithPointer:selector]];
    }
}

@end
