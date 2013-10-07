//
//  FLObjectProxy.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectProxy.h"
//#import "FLLog.h"
//#import "FLTrace.h"
#import "FLAssertions.h"

@implementation NSObject (FLObjectProxy)

- (id) representedObjectForObjectReference {
    return self;
}

- (id) representedObject {
    return self;
}

@end

@implementation FLObjectProxy

- (id) representedObjectForObjectReference {
    FLAssertNotNil(_unretainedRepresentedObject);
    id object = [_unretainedRepresentedObject representedObjectForObjectReference];
    FLAssertNotNil(object);
    return object;
}

- (id) representedObject {

// NOTE: for some reason this returns nil if we call NSObject's version of representedObject
// some quirk in the objc runtime??

    FLAssertNotNil(_unretainedRepresentedObject);
    id object = [_unretainedRepresentedObject representedObjectForObjectReference];
    FLAssertNotNil(object);
    return object;
}

- (id) init {	
	return [self initWithRepresentedObject:nil];
}

- (id) initWithRepresentedObject:(id) representedObject {
    FLAssertNotNil(representedObject);

    _unretainedRepresentedObject = representedObject;
	return self;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@ holding a %@:\n%@",
        NSStringFromClass([self class]),
        NSStringFromClass([_unretainedRepresentedObject class]),
        [_unretainedRepresentedObject description]];
}

- (BOOL)isEqual:(id)representedObject {
	return [[self representedObject] isEqual:representedObject];
}

- (NSUInteger)hash {
	return [[self representedObject] hash];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id object = [self representedObject];
    if([object respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:object];
    }
#if TRACE
    else {
        FLTrace(@"not responding to %@", NSStringFromSelector([anInvocation selector]));
    }
#endif
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {

    NSMethodSignature* sig = [[self representedObject] methodSignatureForSelector:selector];
    if(!sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
//        FLTrace(@"returning fake method signature for selector %@", NSStringFromSelector(selector));
    }
    return sig;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return [[self representedObject] respondsToSelector:aSelector];
}


@end
