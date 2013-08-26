//
//  FLEventForwarder.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/25/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLEventForwarder.h"
#import "FLNotifier.h"

@implementation FLEventForwarder

@synthesize targetObject = _targetObject;

- (id) initWithTargetObject:(id) targetObject {
    _targetObject = FLRetain(targetObject);
}

#if FL_MRC
- (void)dealloc {
	[_targetObject release];
	[super dealloc];
}
#endif

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id object = [self targetObject];
    if([object respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:object];
    }
    else {
        [anInvocation invokeWithTarget:object.observers.notify]
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {

    id object = [self targetObject];

    NSMethodSignature* sig = [object methodSignatureForSelector:selector];
    if(!sig) {
        sig = [object.observers methodSignatureForSelector:selector];
    }
    if(!sig) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return YES; // [[self representedObject] respondsToSelector:aSelector];
}


@end
