//
//  FLSelectorUtils.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FLSelectorPerforming)

/** 
    the "Safely" performs will throw exception if selector returns an object.
    This is because ARC thinks these are a leak.
    Selector cannot be nil.
 **/


- (void) performSelectorSafely:(SEL)aSelector;

- (void) performSelectorSafely:(SEL)aSelector withObject:(id)object;

- (void) performSelectorSafely:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;

/**
    these perform "Safely" and in addition return false if the object doesn't respond to the Selector.
    Selector cannot be nil.
 */

- (BOOL) performIfRespondsToSelector:(SEL) selector;

- (BOOL) performIfRespondsToSelector:(SEL) selector
              withObject:(id) object;

- (BOOL) performIfRespondsToSelector:(SEL) selector
              withObject:(id) object1
              withObject:(id) object2;

+ (BOOL) performIfRespondsToSelector:(SEL) selector;

+ (BOOL) performIfRespondsToSelector:(SEL) selector
              withObject:(id) object;

+ (BOOL) performIfRespondsToSelector:(SEL) selector
              withObject:(id) object1
              withObject:(id) object2;


// class methods

// these use the default requirement
//+ (BOOL) performSelector:(SEL) selector
//                onTarget:(id) target;
//
//+ (BOOL) performSelector:(SEL) selector
//                onTarget:(id) target
//              withObject:(id) object;
//
//+ (BOOL) performSelector:(SEL) selector
//                onTarget:(id) target
//              withObject:(id) object1
//              withObject:(id) object2;

// your own requirement.

//+ (BOOL) performSelector:(SEL) selector
//                onTarget:(id) target
//        withRequirements:(FLPerformSelectorRequirement) requirement;
//
//+ (BOOL) performSelector:(SEL) selector
//                onTarget:(id) target
//         withRequirements:(FLPerformSelectorRequirement) requirement
//              withObject:(id) object;
//
//+ (BOOL) performSelector:(SEL) selector
//                onTarget:(id) target
//         withRequirements:(FLPerformSelectorRequirement) requirement
//              withObject:(id) object1
//              withObject:(id) object2;

@end



