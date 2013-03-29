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
	return FLAutorelease([[[self class] alloc] initWithTarget:target action:action]);
}

- (FLResult) performSynchronously {
    FLPerformSelector1(_target, _action, self);

    return FLSuccessfullResult;
}

- (void) setCallback:(id) target action:(SEL) action {
	
    _target = target;
    _action = action;
    
	FLAssertWithComment([_target respondsToSelector:_action], @"target doesn't respond to selector");
}
@end

