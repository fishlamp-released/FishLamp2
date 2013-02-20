
#ifdef __INLINES__

FL_SHIP_ONLY_INLINE
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

FL_SHIP_ONLY_INLINE
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

FL_SHIP_ONLY_INLINE
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


FL_SHIP_ONLY_INLINE
id FLPerformSelectorForPropertyGetter(id object, SEL property) {

    if(object && property && [object respondsToSelector:property]) {
        return [object valueForKey:NSStringFromSelector(property)];
    }
    
    return nil;
}

#endif