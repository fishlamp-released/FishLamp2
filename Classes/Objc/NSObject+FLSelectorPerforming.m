//
//  FLSelectorUtils.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSObject+FLSelectorPerforming.h"
#import "FLObjcRuntime.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

//NS_INLINE
void FLConfirmNoReturnObject_(id obj) {
    FLCConfirmIsNil_v(obj, @"selector must return nil (or ARC will leak the object). Selector returned: %@", [obj description]); \
}


#define FLAssertNotMetaClass_(c) FLAssert_v(!class_isMetaClass(c), @"attempting to execute selector on a meta class");

@implementation NSObject (FLSelectorPerforming)

- (BOOL) performIfRespondsToSelector:(SEL) selector {
    FLConfirmIsNotNil_(selector);
    if([self respondsToSelector:selector]) {
        [self performSelectorSafely:selector];
        return YES;
    }
    
    return NO;
}

- (BOOL) performIfRespondsToSelector:(SEL) selector
              withObject:(id) object{

    FLConfirmIsNotNil_(selector);
    if([self respondsToSelector:selector]) {
        [self performSelectorSafely:selector withObject:object];
        return YES;
    }
    
    return NO;
}

- (BOOL) performIfRespondsToSelector:(SEL) selector
                      withObject:(id) object1
                      withObject:(id) object2 {
    
    FLConfirmIsNotNil_(selector);
    if([self respondsToSelector:selector]) {
        [self performSelectorSafely:selector withObject:object1 withObject:object2];
        return YES;
    }
    
    return NO;
}

+ (BOOL) performIfRespondsToSelector:(SEL) selector {
    
    FLConfirmIsNotNil_(selector);
    if([self respondsToSelector:selector]) {
        [self performSelectorSafely:selector];
        return YES;
    }
    
    return NO;
}

+ (BOOL) performIfRespondsToSelector:(SEL) selector
              withObject:(id) object{
    
    FLConfirmIsNotNil_(selector);
    if([self respondsToSelector:selector]) {
        [self performSelectorSafely:selector withObject:object];
        return YES;
    }
    
    return NO;
}

+ (BOOL) performIfRespondsToSelector:(SEL) selector
                      withObject:(id) object1
                      withObject:(id) object2 {
    
    FLConfirmIsNotNil_(selector);
    if([self respondsToSelector:selector]) {
        [self performSelectorSafely:selector withObject:object1 withObject:object2];
        return YES;
    }
    
    return NO;
}

// would someone please tell me what the hell these are returning in the case
// of - (void) foo; ???
- (void) performSelectorSafely:(SEL)selector {
    FLConfirmIsNotNil_(selector);
    [self performSelector:selector];
//    FLConfirmNoReturnObject_(obj);
}

- (void) performSelectorSafely:(SEL)selector withObject:(id)object  {
    FLConfirmIsNotNil_(selector);
//    id obj =
    [self performSelector:selector withObject:object];
//    FLConfirmNoReturnObject_(obj);
}

- (void) performSelectorSafely:(SEL)selector withObject:(id)object1 withObject:(id)object2 {
    FLConfirmIsNotNil_(selector);
//    FLConfirmNoReturnObject_(
        [self performSelector:selector withObject:object1 withObject:object2];
//        );
}

@end

#pragma GCC diagnostic pop
