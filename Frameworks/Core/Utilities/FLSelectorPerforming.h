//
//  FLSelectorUtils.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

@interface NSObject (FLSelectorPerforming)

- (void) performSelector:(SEL) selector
              withObject:(id) object1
              withObject:(id) object2 
              withObject:(id) object3;
              
- (void) performSelector:(SEL) selector
               outObject:(id*) outObject;

- (void) performSelector:(SEL) selector
              withObject:(id) object
               outObject:(id*) outObject;

- (void) performSelector:(SEL) selector
                argCount:(int) argCount
              withObject:(id) object1
              withObject:(id) object2
              withObject:(id) object3;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

// the functions are here to accept target and selectors that are nil. also
// if the target doesn't respond to the selector, the functions return NO 
// and do nothing. 
// if you know for sure the target responds to the selector, use the NSObject methods instead.

NS_INLINE
BOOL FLPerformSelectorWithArgCount(id target, SEL selector, int argCount, id object1, id object2, id object3) {
    if([target respondsToSelector:selector]) {
        [target performSelector:selector argCount:argCount withObject:object1 withObject:object2 withObject:object3];
        return YES;
    }
    return NO;
}

NS_INLINE
BOOL FLPerformSelector0(id target, SEL selector) {
    if([target respondsToSelector:selector]) {
        [target performSelector:selector];
        return YES;
    }
    return NO;
} 

NS_INLINE
BOOL FLPerformSelector1(id target, SEL selector, id object) {
    if([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object];
        return YES;
    }
    return NO;
} 

NS_INLINE
BOOL FLPerformSelector2(id target, SEL selector, id object1, id object2) {
    if([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object1 withObject:object2];
        return YES;
    }

    return NO;
} 

NS_INLINE
BOOL FLPerformSelector3(id target, SEL selector, id object1, id object2, id object3) {
    if([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:object1 withObject:object2 withObject:object3];
        return YES;
    }

    return NO;
} 

#pragma GCC diagnostic pop


#define FLPerformSelector FLPerformSelector0
#define FLPerformSelectorOnMainThread FLPerformSelectorOnMainThread0


extern BOOL FLPerformSelectorOnMainThread0(id target, SEL selector);
extern BOOL FLPerformSelectorOnMainThread1(id target, SEL selector, id object);
extern BOOL FLPerformSelectorOnMainThread2(id target, SEL selector, id object1, id object2);
extern BOOL FLPerformSelectorOnMainThread3(id target, SEL selector, id object1, id object2, id object3);


extern BOOL FLPerformSelectorOnMainThreadWithArgCount(id target, 
                                          SEL selector, 
                                          int argCount, // 0-3 only
                                          id object1, 
                                          id object2, 
                                          id object3);
