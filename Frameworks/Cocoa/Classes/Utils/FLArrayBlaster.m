//
//  FLArrayBlaster.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLArrayBlaster.h"

@implementation FLArrayBlaster

+ (id) arrayBlaster:(NSArray*) array {
    return FLAutorelease([[[self class] alloc] initWithRepresentedObject:array]);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

    NSArray* array = [self representedObject];
    for(NSInteger i = array.count - 1; i >= 0; i--) {
        id listener = [array objectAtIndex:i];
        if([listener respondsToSelector:[anInvocation selector]]) {
            [anInvocation invokeWithTarget:listener];
        }
    }
}

- (BOOL) respondsToSelector:(SEL) selector {
    if([super respondsToSelector:selector]) {
        return YES;
    }
    for(id listener in [self representedObject]) {
        if([listener respondsToSelector:selector]) {
            return YES;
        }
    }

    return NO;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if(signature) {
        return signature;
    }

    for(id listener in [self representedObject]) {
        signature = [listener methodSignatureForSelector:selector];
        if(signature) {
            return signature;
        }
    }

    return [super methodSignatureForSelector:selector];
}

@end
