//
//	GtCallback.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCallbackObject.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
   
@implementation GtCallbackObject

@synthesize action = _action;
@synthesize userInfo = _userInfo;

- (id) target {
	return _targetContainer ? _targetContainer.object : _target;
}

- (id) initWithTarget:(id) target action:(SEL) action {
	if((self = [super init])) {	
		if([target conformsToProtocol:@protocol(GtObjectContainer)]) {
			_targetContainer = target;
		}
		else {
			_target = target;
		}
		
		_action = action;
		GtAssert([self.target respondsToSelector:_action], @"target doesn't respond to selector");
	}
	return self;
}

- (id) initWithContainedTarget:(id<GtObjectContainer>) targetInContainer action:(SEL) action {
	if((self = [super init])) {	
		_targetContainer = targetInContainer;
		_action = action;
		GtAssert([self.target respondsToSelector:_action], @"target doesn't respond to selector");
	}
	return self;
}

+ (GtCallbackObject*) callback:(id) target action:(SEL) action {
	return GtReturnAutoreleased([[GtCallbackObject alloc] initWithTarget:target action:action]);
}

+ (GtCallbackObject*) callbackWithContainedTarget:(id<GtObjectContainer>) targetInContainer action:(SEL) action; {
	return GtReturnAutoreleased([[GtCallbackObject alloc] initWithContainedTarget:targetInContainer action:action]);
}

- (id) invoke:(id) sender {
//	GtAutorelease(self);
//	GtAutorelease(sender);
	return [self.target performSelector:_action withObject:sender];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"[%@ %@]", NSStringFromClass([self.target class]), NSStringFromSelector(_action)];
}

- (void) invokeOnMainThread:(BOOL) waitUntilDone {
	[self performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:waitUntilDone];
}

#pragma clang diagnostic pop


@end

