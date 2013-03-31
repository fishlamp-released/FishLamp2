//
//  FLSelectorUtils.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSelectorPerforming.h"
//#import "FLObjcRuntime.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

//NS_INLINE
void FLConfirmNoReturnObject(id obj) {
    FLConfirmIsNilWithComment(obj, @"selector must return nil (or ARC will leak the object). Selector returned: %@", [obj description]); \
}


#define FLAssertNotMetaClass(c) FLAssertWithComment(!class_isMetaClass(c), @"attempting to execute selector on a meta class");

@implementation NSObject (FLSelectorPerforming)

- (void) performSelector:(SEL) selector
              withObject:(id) object1
              withObject:(id) object2 
              withObject:(id) object3 {
    
    FLConfirmIsNotNil(selector);
    NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
    NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:self];                        // index 0 (hidden)
    [invocation setSelector:selector];                  // index 1 (hidden)
    [invocation setArgument:&object1 atIndex:2];        // index 2
    [invocation setArgument:&object2 atIndex:3];        // index 3
    [invocation setArgument:&object3 atIndex:4];        // index 4
    [invocation retainArguments];
    [invocation invoke];

    FLAssertWithComment([[invocation methodSignature] methodReturnLength] == 0, @"returned objects will leak so it's not supported (blame ARC)." );
}              

- (void) performSelector:(SEL) selector
               outObject:(id*) outObject {

    FLConfirmIsNotNil(selector);
    NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
    NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:self];                        // index 0 (hidden)
    [invocation setSelector:selector];                  // index 1 (hidden)
    [invocation setArgument:&outObject atIndex:2];        // index 2
    [invocation retainArguments];
    [invocation invoke];
}

- (void) performSelector:(SEL) selector
              withObject:(id) object
               outObject:(id*) outObject {

    FLConfirmIsNotNil(selector);
    NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
    NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:self];                        // index 0 (hidden)
    [invocation setSelector:selector];                  // index 1 (hidden)
    [invocation setArgument:&object atIndex:2];        // index 2
    [invocation setArgument:&outObject atIndex:3];        // index 2
    [invocation retainArguments];
    [invocation invoke];
}
@end


BOOL FLPerformSelectorWithArgCount(id target, SEL selector, int argCount, id object1, id object2, id object3) {

    switch(argCount) {
        case 0: 
            return FLPerformSelector(target, selector);
        break;

        case 1: 
            return FLPerformSelector1(target, selector, object1);
        break;
        
        case 2: 
            return FLPerformSelector2(target, selector, object1, object2);
        break;

        case 3: 
            return FLPerformSelector3(target, selector, object1, object2, object3);
        break;
        
        default:
            FLAssertFailedWithComment(@"Unsupported arg count: %d", argCount);
            break;
    }
    
    return NO;
}

BOOL FLPerformSelector0(id target, SEL selector) {
    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector];
        return YES;
    }
    return NO;
} 

BOOL FLPerformSelector1(id target, SEL selector, id object) {
    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object];
        return YES;
    }
    return NO;
} 

BOOL FLPerformSelector2(id target, SEL selector, id object1, id object2) {
    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object1 withObject:object2];
        return YES;
    }

    return NO;
} 

BOOL FLPerformSelector3(id target, SEL selector, id object1, id object2, id object3) {
    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object1 withObject:object2 withObject:object3];
        return YES;
    }

    return NO;
} 

FL_SHIP_ONLY_INLINE
id FLPerformSelectorForPropertyGetter(id object, SEL property) {

    if(object && property && [object respondsToSelector:property]) {
        return [object valueForKey:NSStringFromSelector(property)];
    }
    
    return nil;
}

BOOL FLPerformSelectorOnMainThread(id target, SEL selector) {
    if([target respondsToSelector:selector]) {
        if([NSThread currentThread] == [NSThread mainThread]) {
            [target performSelector:selector];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [target performSelector:selector];
            });
        }
        
        return YES;
    }
    return NO;
}

BOOL FLPerformSelectorOnMainThread1(id target, SEL selector, id object) {
    if([target respondsToSelector:selector]) {
        if([NSThread currentThread] == [NSThread mainThread]) {
            [target performSelector:selector withObject:object];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [target performSelector:selector withObject:object];
            });
        }
        return YES;
    }
    return NO;
}

BOOL FLPerformSelectorOnMainThread2(id target, SEL selector, id object1, id object2) {
    if([target respondsToSelector:selector]) {
        if([NSThread currentThread] == [NSThread mainThread]) {
            [target performSelector:selector withObject:object1 withObject:object2];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [target performSelector:selector withObject:object1 withObject:object2];
            });
        }
        return YES;
    }
    return NO;
}

BOOL FLPerformSelectorOnMainThread3(id target, SEL selector, id object1, id object2, id object3) {
    if([target respondsToSelector:selector]) {
        if([NSThread currentThread] == [NSThread mainThread]) {
            [target performSelector:selector withObject:object1 withObject:object2 withObject:object3];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [target performSelector:selector withObject:object1 withObject:object2 withObject:object3];
            });
        }
        return YES;
    }
    return NO;
}


#pragma GCC diagnostic pop
