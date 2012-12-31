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
              
@end

NS_INLINE
BOOL FLPerformSelector(id target, SEL selector) {

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector];
        return YES;
    }

#pragma GCC diagnostic pop    
    return NO;
} 

NS_INLINE
BOOL FLPerformSelectorWithObject(id target, SEL selector, id withObject) {

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector withObject:withObject];
        return YES;
    }

#pragma GCC diagnostic pop    
    return NO;
} 

NS_INLINE
BOOL FLPerformSelectorWithTwoObjects(id target, SEL selector, id withObject1, id withObject2) {

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

    if(target && selector && [target respondsToSelector:selector]) {
        [target performSelector:selector withObject:withObject1 withObject:withObject2];
        return YES;
    }

#pragma GCC diagnostic pop    
    return NO;
} 

extern
BOOL FLPerformSelectorWithThreeObjects(id target, SEL selector, id withObject1, id withObject2, id withObject3);

#define FLPerformSelector0 FLPerformSelector
#define FLPerformSelector1 FLPerformSelectorWithObject
#define FLPerformSelector2 FLPerformSelectorWithTwoObjects
#define FLPerformSelector3 FLPerformSelectorWithThreeObjects


NS_INLINE
id FLReturnValueForOptionalProperty(id object, SEL property) {

    if(object && property && [object respondsToSelector:property]) {
        return [object valueForKey:NSStringFromSelector(property)];
    }
    
    return nil;
}