/*
 *  FLObjcRuntime.h
 *  PackMule
 *
 *  Created by Mike Fullerton on 6/29/11.
 *  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
 *
 */
#import "FLRequired.h"
#import <objc/runtime.h>

#import "FLRuntimeInfo.h"

#define FLRuntimeGetSelectorName(__SEL__) sel_getName(__SEL__)
#define FLSelectorsAreEqual(LHS, RHS) sel_isEqual(LHS, RHS)

typedef void (^FLRuntimeClassVisitor)(FLRuntimeInfo info, BOOL* stop);
typedef void (^FLRuntimeSelectorVisitor)(FLRuntimeInfo info, BOOL* stop);
typedef void (^FLRuntimeFilterBlock)(FLRuntimeInfo info, BOOL* passed, BOOL* stop);

extern void FLSwizzleInstanceMethod(Class c, SEL originalSelector, SEL newSelector);
extern void FLSwizzleClassMethod(Class c, SEL originalSelector, SEL newSelector);

@interface NSObject (FLObjcRuntime)

+ (BOOL) visitEveryClass:(FLRuntimeClassVisitor) visitor;

+ (BOOL) visitEachSelectorInClass:(Class) aClass
                          visitor:(FLRuntimeSelectorVisitor) visitor;

+ (BOOL) classRespondsToSelector:(Class) aClass selector:(SEL) selector;

+ (NSArray*) methodsForClass:(Class) aClass
                      filter:(FLRuntimeFilterBlock) filterOrNil;


+ (NSArray*) classesImplementingInstanceMethod:(SEL) theMethod;

+ (BOOL) superclass:(Class) superclass hasSubclass:(Class) aClass;

+ (NSArray*) subclassesForClass:(Class) aClass;

+ (int) parameterCountForClassSelector:(Class) aClass selector: (SEL) selector;

+ (int) argumentCountForSelector:(SEL) sel;

#if DEBUG
+ (void) logMethodsForClass:(Class) aClass;
#endif


// http://www.cocoawithlove.com/2008/03/supersequent-implementation.html
// Lookup the next implementation of the given selector after the
// default one. Returns nil if no alternate implementation is found.
- (IMP)getImplementationOf:(SEL)lookup after:(IMP)skip;

@end

#define invokeSupersequent(...) \
    ([self getImplementationOf:_cmd \
        after:impOfCallingMethod(self, _cmd)]) \
            (self, _cmd, ##__VA_ARGS__)

#define invokeSupersequentNoParameters() \
    ([self getImplementationOf:_cmd \
        after:impOfCallingMethod(self, _cmd)]) \
            (self, _cmd)



