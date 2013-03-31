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


@end

extern BOOL FLPerformSelector0(id target, SEL selector);
extern BOOL FLPerformSelector1(id target, SEL selector, id object);
extern BOOL FLPerformSelector2(id target, SEL selector, id object1, id object2);
extern BOOL FLPerformSelector3(id target, SEL selector, id object1, id object2, id object3);

extern BOOL FLPerformSelectorOnMainThread0(id target, SEL selector);
extern BOOL FLPerformSelectorOnMainThread1(id target, SEL selector, id object);
extern BOOL FLPerformSelectorOnMainThread2(id target, SEL selector, id object1, id object2);
extern BOOL FLPerformSelectorOnMainThread3(id target, SEL selector, id object1, id object2, id object3);

//extern id FLPerformSelectorForPropertyGetter(id object, SEL property);

extern BOOL FLPerformSelectorWithArgCount(id target, 
                                          SEL selector, 
                                          int argCount, // 0-3 only
                                          id object1, 
                                          id object2, 
                                          id object3);

#define FLPerformSelector FLPerformSelector0
#define FLPerformSelectorOnMainThread FLPerformSelectorOnMainThread0
