/*
 *  FLObjcRuntime.h
 *  PackMule
 *
 *  Created by Mike Fullerton on 6/29/11.
 *  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
 *
 */
#import "FishLampCore.h"
#import <objc/runtime.h>

#import "FLRuntimeInfo.h"

extern const char *getPropertyType(objc_property_t property);

/**
    @brief Copies type name from @encoded string
    for example NT@"NSMutableArray" results in NSMutableArray
    if this returns a string, call free on it.
 */
extern char* copyTypeNameFromProperty(objc_property_t property);

#define FLRuntimeGetSelectorName(__SEL__) sel_getName(__SEL__)
#define FLSelectorsAreEqual(LHS, RHS) sel_isEqual(LHS, RHS)




typedef void (^FLRuntimeClassVisitor)(FLRuntimeInfo info, BOOL* stop);
typedef void (^FLRuntimeSelectorVisitor)(FLRuntimeInfo info, BOOL* stop);
typedef void (^FLRuntimeFilterBlock)(FLRuntimeInfo info, BOOL* passed, BOOL* stop);

extern
void FLSelectorSwizzle(Class c, SEL originalSelector, SEL newSelector);

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

@end




