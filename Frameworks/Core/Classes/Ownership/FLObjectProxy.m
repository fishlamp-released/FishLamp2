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

- (id) nextRepresentedObject {
    return nil;
}

@end

@implementation FLObjectProxy

- (id) nextRepresentedObject {
    return self.representedObject;
}

- (id) representedObject {
    return nil;
}

- (id) findRepresentedObject {
    id walker = [self nextRepresentedObject];
    while(walker) {
        id next = [walker nextRepresentedObject];
        if(next) {
            walker = next;
        }
        else {
            break;
        }
    }
    return walker;
}

- (NSString*) description {

    id object = [self findRepresentedObject];

	return [NSString stringWithFormat:@"%@ holding a %@:\n%@",
        NSStringFromClass([self class]),
        NSStringFromClass([object class]),
        [object description]];
}

- (BOOL)isEqual:(id)representedObject {
	return [[self findRepresentedObject] isEqual:representedObject];
}

- (NSUInteger)hash {
	return [[self findRepresentedObject] hash];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id object = [self findRepresentedObject];
    if([object respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:object];
    }
    else {
//        FLTrace(@"not responding to %@", NSStringFromSelector([anInvocation selector]));
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {

    NSMethodSignature* sig = [[self findRepresentedObject] methodSignatureForSelector:selector];
    if(!sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
//        FLTrace(@"returning fake method signature for selector %@", NSStringFromSelector(selector));
    }
    return sig;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return [[self findRepresentedObject] respondsToSelector:aSelector];
}


@end
