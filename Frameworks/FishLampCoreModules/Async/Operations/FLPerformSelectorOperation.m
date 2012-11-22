//
//	FLPerformSelectorOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLPerformSelectorOperation.h"

@implementation FLPerformSelectorOperation

- (id) initWithTarget:(id) target action:(SEL) action {
	if((self = [super init])) {
		[self setCallback:target action:action];
	}
	
	return self;
}

+ (id) performSelectorOperation:(id) target action:(SEL) action {
	return autorelease_([[[self class] alloc] initWithTarget:target action:action]);
}

- (void) runSelf {
    FLPerformSelector1(_target, _action, self);
}

- (void) setCallback:(id) target action:(SEL) action {
	
    _target = target;
    _action = action;
    
	FLAssert_v([_target respondsToSelector:_action], @"target doesn't respond to selector");
}
@end

