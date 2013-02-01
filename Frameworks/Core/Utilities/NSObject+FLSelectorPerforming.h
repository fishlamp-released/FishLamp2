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

#if DEBUG

extern BOOL FLPerformSelector(id target, SEL selector);
extern BOOL FLPerformSelectorWithObject(id target, SEL selector, id withObject);
extern BOOL FLPerformSelectorWithTwoObjects(id target, SEL selector, id withObject1, id withObject2);
extern BOOL FLPerformSelectorWithThreeObjects(id target, SEL selector, id withObject1, id withObject2, id withObject3);
extern id FLReturnValueForOptionalProperty(id object, SEL property);

#else
#define __INLINES__
#import "NSObject+FLSelectorPerforming_Inlines.h"
#undef __INLINES__
#endif 

#define FLPerformSelector0 FLPerformSelector
#define FLPerformSelector1 FLPerformSelectorWithObject
#define FLPerformSelector2 FLPerformSelectorWithTwoObjects
#define FLPerformSelector3 FLPerformSelectorWithThreeObjects

extern BOOL FLPerformSelectorWithArgCount(id target, 
                                          SEL selector, 
                                          int argCount, // 0-3 only
                                          id object1, 
                                          id object2, 
                                          id object3);