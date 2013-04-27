//
//  FLSelectorUtils.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSelectorPerforming.h"
#import "FLObjcRuntime.h"

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
           argumentCount:(NSInteger) argCount
                 objects:(id*) objects {

    FLConfirmIsNotNil(selector);
    
    if(argCount < 3) {
        switch(argCount) {
            case 0: 
                [self performSelector:selector];
            break;

            case 1: 
                [self performSelector:selector withObject:objects[0]];
            break;
            
            case 2: 
                [self performSelector:selector withObject:objects[0] withObject:objects[1]];
            break;
        }
        return;
    }
    
    NSMethodSignature *signature  = [self methodSignatureForSelector:selector];
    NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:self];                        // index 0 (hidden)
    [invocation setSelector:selector];                  // index 1 (hidden)
    
    for(int i = 0; i < argCount; i++) {
        [invocation setArgument:&objects[i] atIndex:i + 2];        // index 2
    }

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

- (void) performSelector:(SEL) selector
                argCount:(int) argCount
              withObject:(id) object1
              withObject:(id) object2
              withObject:(id) object3 {

    FLAssertWithComment(FLArgumentCountForClassSelector([self class], selector) == argCount, @"@selector(%@) arg count is %d, should be: %d", NSStringFromSelector(selector), argCount, FLArgumentCountForClassSelector([self class], selector));

    switch(argCount) {
        case 0: 
            [self performSelector:selector];
        break;

        case 1: 
            [self performSelector:selector withObject:object1];
        break;
        
        case 2: 
            [self performSelector:selector withObject:object1 withObject:object2];
        break;

        case 3: 
            [self performSelector:selector withObject:object1 withObject:object2 withObject:object3];
        break;
        
        default:
            FLAssertFailedWithComment(@"Unsupported arg count: %d", argCount);
            break;
    }
}

- (BOOL) receiveMessage:(SEL) selector {
    return FLPerformSelector(self, selector);
}

- (BOOL) receiveMessage:(SEL) selector  
             withObject:(id) object {
    return FLPerformSelector1(self, selector, object);
}             

- (BOOL) receiveMessage:(SEL) selector 
               withObject:(id) object1
               withObject:(id) object2 {
    return FLPerformSelector2(self, selector, object1, object2);
}             

- (BOOL) receiveMessage:(SEL) selector 
               withObject:(id) object1
               withObject:(id) object2
               withObject:(id) object3 {
    return FLPerformSelector3(self, selector, object1, object2, object3);
}             

- (BOOL) receiveObservation:(SEL) selector { 
    return FLPerformSelectorOnMainThread(self, selector);
}

- (BOOL) receiveObservation:(SEL) selector 
                 withObject:(id) object  {
    return FLPerformSelectorOnMainThread1(self, selector, object);
}

- (BOOL) receiveObservation:(SEL) selector 
                 withObject:(id) object1 
                 withObject:(id) object2  {
    return FLPerformSelectorOnMainThread2(self, selector, object1, object2);
}

- (BOOL) receiveObservation:(SEL) selector  
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3 {
    return FLPerformSelectorOnMainThread3(self, selector, object1, object2, object3);
}


@end

//NS_INLINE
//BOOL FLPerformSelectorWithArgCount(id target, SEL selector, int argCount, id object1, id object2, id object3) {
//    if([target respondsToSelector:selector]) {
//        [target performSelector:selector argCount:argCount withObject:object1 withObject:object2 withObject:object3];
//        return YES;
//    }
//    return NO;
//}

BOOL FLPerformSelectorOnMainThreadWithArgCount(id target, 
                                          SEL selector, 
                                          int argCount, // 0-3 only
                                          id object1, 
                                          id object2, 
                                          id object3) {
                                          
    if([target respondsToSelector:selector]) {
    
        FLAssertWithComment(FLArgumentCountForClassSelector([target class], selector) == argCount, @"@selector(%@) arg count is %d, should be: %d", NSStringFromSelector(selector), argCount, FLArgumentCountForClassSelector([target class], selector));
    
        if([NSThread currentThread] == [NSThread mainThread]) {
            [target performSelector:selector argCount:argCount withObject:object1 withObject:object2 withObject:object3];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [target performSelector:selector argCount:argCount withObject:object1 withObject:object2 withObject:object3];
            });
        }
        
        return YES;
    }
    return NO;
                                          
}                                          

//extern BOOL FLPerformSelector0(id target, SEL selector);
//extern BOOL FLPerformSelector1(id target, SEL selector, id object);
//extern BOOL FLPerformSelector2(id target, SEL selector, id object1, id object2);
//extern BOOL FLPerformSelector3(id target, SEL selector, id object1, id object2, id object3);
//extern id FLPerformSelectorForPropertyGetter(id object, SEL property);

//extern BOOL FLPerformSelectorWithArgCount(id target, 
//                                          SEL selector, 
//                                          int argCount, // 0-3 only
//                                          id object1, 
//                                          id object2, 
//                                          id object3);

//BOOL FLPerformSelector0(id target, SEL selector) {
//    if(target && selector && [target respondsToSelector:selector]) {
//        [target performSelector:selector];
//        return YES;
//    }
//    return NO;
//} 
//
//BOOL FLPerformSelector1(id target, SEL selector, id object) {
//    if(target && selector && [target respondsToSelector:selector]) {
//        [target performSelector:selector withObject:object];
//        return YES;
//    }
//    return NO;
//} 
//
//BOOL FLPerformSelector2(id target, SEL selector, id object1, id object2) {
//    if(target && selector && [target respondsToSelector:selector]) {
//        [target performSelector:selector withObject:object1 withObject:object2];
//        return YES;
//    }
//
//    return NO;
//} 
//
//BOOL FLPerformSelector3(id target, SEL selector, id object1, id object2, id object3) {
//    if(target && selector && [target respondsToSelector:selector]) {
//        [target performSelector:selector withObject:object1 withObject:object2 withObject:object3];
//        return YES;
//    }
//
//    return NO;
//} 

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
//
//@interface FLSelectorRedirect : NSObject {
//@private
//    SEL _originalSelector;
//    SEL _newSelector;
//    id _selectorKey;
//}
//@property (readonly, strong, nonatomic) id selectorKey;
//
//@property (readwrite, assign, nonatomic) SEL originalSelector;
//@property (readwrite, assign, nonatomic) SEL selector;
//
//- (id) initWithOriginalSelector:(SEL) selector;
//
//@end
//
//@implementation FLSelectorRedirect 
//
//- (id) initWithOriginalSelector:(SEL) selector {
//	self = [super init];
//	if(self) {
//		_originalSelector = selector;
//        _selectorKey = FLRetain([NSValue valueWithPointer:_originalSelector]);
//    }
//	return self;
//}
//
//@synthesize selector = _redirectSelector;
//
//
//
//
//@end


//
//@interface FLSelectorDispatcher : NSObject {
//@private
//    NSMutableDictionary* _selectors;
//    const char* _selectorPrefix;
//    
//    const char _buffer[1024]
//}
//
////@property (readwrite, assign, nonatomic) SEL selectorPrefix;
//
//- (BOOL) performSelector:(SEL) sel onTarget:(id) target argumentCount:(NSInteger) argCount args:(id*) args;
//@end
//
//@implementation FLSelectorDispatcher 
////@synthesize selectorPrefix = _selectorPrefix;
//
//- (BOOL) performSelector:(SEL) sel onTarget:(id) target argumentCount:(NSInteger) argCount args:(id*) args {
//    if(_selectorPrefix) {
//        const char *sel = sel_getName(sel);
//        SEL newSelector = sel_registerName(sprintf(_buffer, @"%s%s", _selectorPrefix, sel));
//    }
//
//    [target performSelector:sel argumentCount:<#(NSInteger)#> objects:<#(id *)#> 
//}
//
//#if FL_MRC
//- (void) dealloc {
//	[_selectorPrefix release];
//	[super dealloc];
//}
//#endif
//
//
//@end
