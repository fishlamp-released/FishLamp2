//
//  FLObjectRef.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectRef.h"

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
    if([[self object] respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self.object];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [self.object methodSignatureForSelector:selector];
    }
    return signature;
}

//- (id) forwardingTargetForSelector:(SEL)aSelector {
//    if(![self respondsToSelector:aSelector] && [_object respondsToSelector:aSelector]) {
//        return _object;
//    }
//
//    return self;
//}

- (BOOL) respondsToSelector:(SEL)aSelector {
    if(![super respondsToSelector:aSelector]) {
        return [_object respondsToSelector:aSelector];
    }

    return NO;
}


@end
