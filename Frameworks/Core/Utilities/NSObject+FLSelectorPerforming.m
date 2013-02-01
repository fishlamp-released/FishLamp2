//
//  FLSelectorUtils.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSObject+FLSelectorPerforming.h"
//#import "FLObjcRuntime.h"

#if DEBUG
#define __INLINES__
#import "NSObject+FLSelectorPerforming_Inlines.h"
#undef __INLINES__
#endif

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

//NS_INLINE
void FLConfirmNoReturnObject_(id obj) {
    FLConfirmIsNil_v(obj, @"selector must return nil (or ARC will leak the object). Selector returned: %@", [obj description]); \
}


#define FLAssertNotMetaClass_(c) FLAssert_v(!class_isMetaClass(c), @"attempting to execute selector on a meta class");

@implementation NSObject (FLSelectorPerforming)


- (void) performSelector:(SEL) selector
              withObject:(id) object1
              withObject:(id) object2 
              withObject:(id) object3 {
    
    FLConfirmIsNotNil_(selector);
    NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
    NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:self];                        // index 0 (hidden)
    [invocation setSelector:selector];                  // index 1 (hidden)
    [invocation setArgument:&object1 atIndex:2];        // index 2
    [invocation setArgument:&object2 atIndex:3];        // index 3
    [invocation setArgument:&object3 atIndex:4];        // index 4
    [invocation retainArguments];
    [invocation invoke];

    FLAssert_v([[invocation methodSignature] methodReturnLength] == 0, @"returned objects will leak so it's not supported (blame ARC)." );
}              

//
//+ (BOOL) performIfRespondsToSelector:(SEL) selector {
//    
//    FLConfirmIsNotNil_(selector);
//    if([self respondsToSelector:selector]) {
//        [self performSelector:selector];
//        return YES;
//    }
//    
//    return NO;
//}
//
//+ (BOOL) performIfRespondsToSelector:(SEL) selector
//              withObject:(id) object{
//    
//    FLConfirmIsNotNil_(selector);
//    if([self respondsToSelector:selector]) {
//        [self performSelector:selector withObject:object];
//        return YES;
//    }
//    
//    return NO;
//}
//
//+ (BOOL) performIfRespondsToSelector:(SEL) selector
//                          withObject:(id) object1
//                          withObject:(id) object2
//                          withObject:(id) object3  {
//    
//    FLConfirmIsNotNil_(selector);
//    if([self respondsToSelector:selector]) {
//        FLConfirmIsNotNil_(selector);
//        NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
//        NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];
//
//        [invocation setTarget:self];                        // index 0 (hidden)
//        [invocation setSelector:selector];                  // index 1 (hidden)
//        [invocation setArgument:&object1 atIndex:2];        // index 2
//        [invocation setArgument:&object2 atIndex:3];        // index 3
//        [invocation setArgument:&object3 atIndex:4];        // index 4
//        [invocation retainArguments];
//        [invocation invoke];
//        return YES;
//    }
//    
//    return NO;
//}

//+ (BOOL) performIfRespondsToSelector:(SEL) selector
//                      withObject:(id) object1
//                      withObject:(id) object2 {
//    
//    FLConfirmIsNotNil_(selector);
//    if([self respondsToSelector:selector]) {
//        [self performSelectorSafely:selector withObject:object1 withObject:object2];
//        return YES;
//    }
//    
//    return NO;
//}
//
//// would someone please tell me what the hell these are returning in the case
//// of - (void) foo; ???
//- (void) performSelectorSafely:(SEL)selector {
//    FLConfirmIsNotNil_(selector);
//    [self performSelector:selector];
////    FLConfirmNoReturnObject_(obj);
//}
//
//- (void) performSelectorSafely:(SEL)selector withObject:(id)object  {
//    FLConfirmIsNotNil_(selector);
////    id obj =
//    [self performSelector:selector withObject:object];
////    FLConfirmNoReturnObject_(obj);
//}
//
//- (void) performSelectorSafely:(SEL)selector withObject:(id)object1 withObject:(id)object2 {
//    FLConfirmIsNotNil_(selector);
////    FLConfirmNoReturnObject_(
//        [self performSelector:selector withObject:object1 withObject:object2];
////        );
//}
//
//- (void) performSelectorSafely:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id) object3 {
//    FLConfirmIsNotNil_(selector);
//    NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
//    NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];
//
//    [invocation setTarget:self];                        // index 0 (hidden)
//    [invocation setSelector:selector];                  // index 1 (hidden)
//    [invocation setArgument:&object1 atIndex:2];        // index 2
//    [invocation setArgument:&object2 atIndex:3];        // index 3
//    [invocation setArgument:&object3 atIndex:4];        // index 4
//    [invocation retainArguments];
//    [invocation invoke];
//}

@end

BOOL FLPerformSelectorWithThreeObjects(id target, SEL selector, id withObject1, id withObject2, id withObject3) {

    if(target && selector && [target respondsToSelector:selector]) {

        NSMethodSignature *signature  = [target methodSignatureForSelector:selector];
        NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];

        [invocation setTarget:target];                      // index 0 (hidden)
        [invocation setSelector:selector];                  // index 1 (hidden)
        [invocation setArgument:&withObject1 atIndex:2];        // index 2
        [invocation setArgument:&withObject2 atIndex:3];        // index 3
        [invocation setArgument:&withObject3 atIndex:4];        // index 4
        [invocation retainArguments];
        [invocation invoke];

        return YES;
    }

    return NO;
} 

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
            FLAssertFailed_v(@"Unsupported arg count: %d", argCount);
            break;
    }
    
    return NO;
}

#pragma GCC diagnostic pop
