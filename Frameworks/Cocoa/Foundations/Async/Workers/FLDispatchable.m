//
//  FLDispatchable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatchable.h"

@implementation FLDispatchable
@synthesize block = _block;
@synthesize finisher = _finisher;
@synthesize finishableBlock = _finishableBlock;
@synthesize object = _object;

- (id) initWithFinisher:(FLFinisher*) finisher {
    self = [super init];
    if(self) {
        self.finisher = finisher;
    }
    return self;
}

+ (id) dispatchable:(FLFinisher*) finisher {
    return FLAutorelease([[[self class] alloc] initWithFinisher:finisher]);
}

+ (id) dispatchable {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_block release];
    [_finisher release];
    [_finishableBlock release];
    [_object release];
    [super dealloc];
}
#endif

- (void) dispatch:(id<FLDispatcher>) dispatcher {
    
    if(!_finisher) {
        self.finisher = [FLFinisher finisher];
    }
    
    if(_block) {
        [dispatcher dispatchBlock:_block withFinisher:self.finisher];
    }
    else if(_finishableBlock) {
        [dispatcher dispatchFinishableBlock:_finishableBlock withFinisher:self.finisher];
    }
    else if(_object) {
        [dispatcher dispatchBlock:_object withFinisher:self.finisher];
    }
}

- (id) waitUntilFinished {
    return [self.finisher waitUntilFinished];
}


@end
