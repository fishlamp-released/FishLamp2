//
//  FLObjectRef.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectRef.h"

#import "FLTrace.h"

@implementation FLObjectRef

- (id) object {
    return _object;
}

- (id) init {	
	return [self initWithObject:nil];
}

- (id) initWithObject:(id) object {
    _object = object;
	return self;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@ holding a %@:\n%@",
        NSStringFromClass([self class]),
        NSStringFromClass([_object class]),
        [_object description]];
}

- (BOOL)isEqual:(id)object {
	return [_object isEqual:object];
}

- (NSUInteger)hash {
	return [_object hash];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if([_object respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:_object];
    }
    else {
        FLTrace(@"not responding to %@", NSStringFromSelector([anInvocation selector]));
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {

    NSMethodSignature* sig = [_object methodSignatureForSelector:selector];
    if(!sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
        FLTrace(@"returning fake method signature for selector %@", NSStringFromSelector(selector));
    }
    return sig;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return [_object respondsToSelector:aSelector];
}


@end
