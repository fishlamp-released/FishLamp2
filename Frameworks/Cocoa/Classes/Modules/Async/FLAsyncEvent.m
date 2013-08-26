//
//  FLAsyncEvent.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 8/25/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncEvent.h"
#import "FLFinisher.h"

@implementation FLAsyncEvent

@synthesize delay = _delay;

- (FLFinisher*) finisher {
    return nil;
}

- (id) initWithDelay:(NSTimeInterval) delay {
	self = [super init];
	if(self) {
        _delay = delay;
	}
	return self;
}

@end

@implementation FLBlockEvent

@synthesize block =_block;
@synthesize finisher = _finisher;

- (id) initWithBlock:(fl_block_t) block {
    return [self initWithDelay:0 block:block];
}

- (id) initWithDelay:(NSTimeInterval) delay block:(fl_block_t) block {
	self = [super initWithDelay:delay];
	if(self) {
        _finisher = [[FLFinisher alloc] init];
		_block = block;
	}
	return self;
}

+ (id) blockEvent:(fl_block_t) block {
    return FLAutorelease([[[self class] alloc] initWithDelay:0 block:block]);
}

+ (id) blockEventWithDelay:(NSTimeInterval) delay block:(fl_block_t) block {
    return FLAutorelease([[[self class] alloc] initWithDelay:0 block:block]);
}

#if FL_MRC
- (void)dealloc {
    [_finisher release];
	[_block release];
	[super dealloc];
}
#endif

@end

@implementation FLFinisherBlockEvent

@synthesize block =_block;
@synthesize finisher = _finisher;

- (id) initWithFinisherBlock:(fl_finisher_block_t) block {
    return [self initWithDelay:0 finisherBlock:block];
}

- (id) initWithDelay:(NSTimeInterval) delay finisherBlock:(fl_finisher_block_t) block {
	self = [super initWithDelay:delay];
	if(self) {
        _finisher = [[FLFinisher alloc] init];
		_block = block;
	}
	return self;
}

+ (id) finisherBlockEvent:(fl_finisher_block_t) block {
    return FLAutorelease([[[self class] alloc] initWithDelay:0 finisherBlock:block]);
}

+ (id) finisherBlockEventWithDelay:(NSTimeInterval) delay finisherBlock:(fl_finisher_block_t) block {
    return FLAutorelease([[[self class] alloc] initWithDelay:delay finisherBlock:block]);
}

#if FL_MRC
- (void)dealloc {
    [_finisher release];
	[_block release];
	[super dealloc];
}
#endif

@end
