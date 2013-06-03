//
//	FLCallback_t.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCallbackObject.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
   
@implementation FLCallbackObject

@synthesize action = _action;
@synthesize userInfo = _userInfo;

- (id) target {
	return _targetContainer ? _targetContainer.object : _target;
}

- (id) initWithTarget:(id) target action:(SEL) action {
	if((self = [super init])) {	
		if([target conformsToProtocol:@protocol(FLObjectContainer)]) {
			_targetContainer = target;
		}
		else {
			_target = target;
		}
		
		_action = action;
		FLAssertWithComment([self.target respondsToSelector:_action], @"target doesn't respond to selector");
	}
	return self;
}

- (id) initWithContainedTarget:(id<FLObjectContainer>) targetInContainer action:(SEL) action {
	if((self = [super init])) {	
		_targetContainer = targetInContainer;
		_action = action;
		FLAssertWithComment([self.target respondsToSelector:_action], @"target doesn't respond to selector");
	}
	return self;
}

+ (FLCallbackObject*) callback:(id) target action:(SEL) action {
	return FLAutorelease([[FLCallbackObject alloc] initWithTarget:target action:action]);
}

+ (FLCallbackObject*) callbackWithContainedTarget:(id<FLObjectContainer>) targetInContainer action:(SEL) action {
	return FLAutorelease([[FLCallbackObject alloc] initWithContainedTarget:targetInContainer action:action]);
}

- (id) invoke:(id) sender {
//	FLAutoreleaseObject(self);
//	FLAutoreleaseObject(sender);
	return [self.target performSelector:_action withObject:sender];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"[%@ %@]", NSStringFromClass([self.target class]), NSStringFromSelector(_action)];
}

- (void) invokeOnMainThread:(BOOL) waitUntilDone {
	[self performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:waitUntilDone];
}


@end

