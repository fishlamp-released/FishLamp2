/*
 *  FLObjcRuntime.c
 *  PackMule
 *
 *  Created by Mike Fullerton on 6/29/11.
 *  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
 *
 */

#import "FLObjcRuntime.h"
#import <stdlib.h>
#import <string.h>
#import <stdio.h>
// experimental

//id objc_getProperty(id self, SEL _cmd, ptrdiff_t offset, BOOL atomic);
//
//void objc_setProperty(id self, SEL _cmd, ptrdiff_t offset, id newValue, BOOL atomic, BOOL shouldCopy);
//
//void objc_copyStruct(void *dest, const void *src, ptrdiff_t size, BOOL atomic, BOOL hasStrong);
//extern NSArray* FLRuntimeFindSubclassesForClass(Class aClass);

//extern BOOL FLRuntimeClassIsSubclassOfClass(Class subclass, Class superclass);
//extern void FLRuntimeVisitEachInstanceMethodInClass(Class aClass, Class toSuperclassOrNil, FLRuntimeSelectorVisitor visitor);


char* copyTypeNameFromProperty(objc_property_t property)
{
	const char* attr = property_getAttributes(property);
	
//	printf("%s", attr);
	
	for(int i = 0; attr[i] != 0; i++)
	{
		if(attr[i] == '@')
		{
			if(attr[i + 1] == '\"')
			{
				i += 2;
				
				for(int j = i; attr[j] != 0; j++)
				{
					if(attr[j] == '\"')
					{
						int len = j - i;
                        char* str = malloc(len + 1);
                        memcpy(str, attr+i, len);
						str[len] = 0;
						return str;
					}
				}
			}
		}
	
	}

	return nil;
	
/*
objc_property_attribute_t* attrList = property_copyAttributeList(properties[i], &attrCount);
		for(unsigned int j = 0; j < attrCount; j++)
		{
			const char* value = attrList[j].value;
			const char* name = attrList[j].name;

			if(name[0] == 'T' && value[0] == '@')
			{
				int len = strlen(value);
				char* className = malloc(len);
				strncpy(className, value + 2, len - 3);
				className[len-3] = 0;
				
				Class c = objc_getClass(className);
					free(attrList);
	
*/
}

const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}

void FLSelectorSwizzle(Class c, SEL originalSelector, SEL newSelector) {
    Method origMethod = class_getInstanceMethod(c, originalSelector);
    Method newMethod = class_getInstanceMethod(c, newSelector);
    
    if(class_addMethod(c, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}


//void FLRuntimeVisitEveryMetaClass(void (^visitor)(Class aClass, BOOL* stop)) {
//
////    NSMutableSet* processed = [NSMutableSet set];
////    __block int i = 0;
//    
//    FLRuntimeVisitEveryClass(^(Class inClass, BOOL* stop) {
//        
////        if(!class_isMetaClass(inClass)) {
////            inClass = object_getClass(inClass);
////        }
//        
//        if(!inClass) {
//            return;
//        }
//        
//        visitor(inClass, stop);
//        
////        NSString* name = NSStringFromClass(inClass);
////        if(FLStringIsNotEmpty(name)) {
////            if(![processed containsObject:name]) {
////                [processed addObject:name];
////                visitor(inClass, stop );
////            }
////            else {
////                i++;
////            }
////        }
//    });
//}

//void FLRuntimeVisitEveryInstanceClass(void (^visitor)(Class aClass, BOOL* stop)) {
//
//    FLRuntimeVisitEveryClass(^(Class inClass, BOOL* stop) {
//        if(!class_isMetaClass(inClass)) {
//            visitor(inClass, stop );
//        }
//    });
//}





//NSArray* FLRuntimeFindSubclassesForClass(Class theClass) {
//
//	int count = objc_getClassList(NULL, 0);
//
//    NSMutableArray* theClassNames = [NSMutableArray array];
//
//    Class* classList = (__unsafe_unretained Class*) malloc(sizeof(Class) * count);
//	
//	objc_getClassList(classList, count);
// 
//    const char* theClassName = class_getName(theClass);
//    
//	for(int i = 0; i < count; i++) {
//
//        Class aClass = classList[i];
//
//        // some things in the returned don't have classes - e.g. object_getClass returns nil
////        aClass = object_getClass(aClass);
////        if(!aClass) {
////            continue;
////        }
//    
//        // some objects don't have super classes - whatever Apple, whatever.
//        Class superClass = class_getSuperclass(aClass);
//        if(!superClass) {
//            continue;
//        }
//        
//        // okay now we have a class name for the current classes superclass - or do we?
//        const char* superClassName = class_getName(superClass);
//        if(!superClassName) {
//            continue;
//        }
//    
//        // okay fine, we do, see if the superclass is a the class we want, if so Yay. If not, whatever.
//        if(strcmp(superClassName, theClassName) == 0) {
//            [theClassNames addObject:aClass];
//        }
//	}
//	
//	free(classList);
//    
//    return theClassNames;
//}

//NSArray* FLRuntimeInstanceMethods(Class aClass, Class toSuperclassOrNil) {
//    
//    NSMutableArray* array = [NSMutableArray array];
//    Class walker = aClass;
//
//    while(walker) {
//       
//        FLRuntimeVisitEachSelectorInClass(walker, ^(SEL selector, BOOL *stop) {
//            [array addObject:[FLCallback callback:aClass action:selector]];
//        });
//       
//        if(!toSuperclassOrNil) {
//            walker = nil;
//        }
//        else {
//            walker = [walker superclass];
//            
//            if( walker == toSuperclassOrNil ||
//                walker == [NSObject class]) {
//                walker = nil;
//            }
//        }
//    }
// 
//    return array;
//}

//@implementation NSObject
//- (NSArray*) findInstanceMethodsByName:(BOOL (^)(NSString* name, BOOL* stop)) nameMatcher {
//    return [self findInstanceMethodsByNameStopAtSuperclass:nil
//                                               nameMatcher:nameMatcher];
//}
//
//- (NSArray*) findInstanceMethodsByNameStopAtSuperclass:(Class) superclass
//                                           nameMatcher:(BOOL (^)(NSString* name, BOOL* stop)) nameMatcher {
//
//    NSMutableArray* array = [NSMutableArray array];
//
//    NSArray* methods = FLRuntimeInstanceMethodNamesForClass([self class], superclass);
//
//    for(FLCallback* callback in methods) {
//        if(nameMatcher(NSStringFromSelector(callback.action)) {
//           [list addObject:[FLCallback callback:self action:NSSelectorFromString(methodName)]];
//        }
//    }
//    return array;
//}
//
//
//@end

@implementation NSObject (FLObjcRuntime)

+ (BOOL) visitEveryClass:(FLRuntimeClassVisitor) visitor {

    FLRuntimeInfo info = { nil, nil, 0, 0, NO };
    
    info.total = objc_getClassList(NULL, 0);
    
    Class *classes = (__unsafe_unretained Class*) malloc(sizeof(Class) * info.total);
    
    objc_getClassList(classes, info.total);
    
    BOOL stop = NO;
    for (info.index = 0; info.index < info.total; info.index++) {
        info.class = classes[info.index];
        info.isMetaClass = NO;
        visitor(info, &stop );
        if(stop) {
            break;
        }

        info.class = object_getClass(classes[info.index]);
        info.isMetaClass = YES;
        visitor(info, &stop );
        if(stop) {
            break;
        }
    }

    free(classes);
    
    return stop;
}


+ (BOOL) visitEachSelectorInClass:(Class) aClass
                          visitor:(FLRuntimeSelectorVisitor) visitor {

    BOOL stop = NO;
    FLRuntimeInfo info = { aClass, nil, 0, 0, class_isMetaClass(aClass) };
    
    Method* methods = class_copyMethodList(aClass, &info.total);

    for (info.index = 0; info.index < info.total; info.index++) {
        
        info.selector = method_getName(methods[info.index]);
        visitor(info, &stop);
        
        if(stop) {
            break;
        }
    }

    free(methods);
    
    return stop;
}

+ (NSArray*) methodsForClass:(Class) inClass
                      filter:(FLRuntimeFilterBlock) filterOrNil {

    __block NSMutableArray* array = nil;
    
    FLRuntimeSelectorVisitor selectorVisitor = ^(FLRuntimeInfo info, BOOL *stop) {
            
        BOOL passed = YES;
        if(filterOrNil) {
            passed = NO;
            filterOrNil(info, &passed, stop);
        }
        
        if(passed) {
            if(!array) {
                 array = [NSMutableArray array];
            }
        
            [array addObject:[FLSelectorInfo selectorInfoWithClass:info.class selector:info.selector]];
        }
    };

    Class walker = inClass;
    while(walker) {
       
        __block BOOL stop = NO;
        [NSObject visitEachSelectorInClass:walker visitor:selectorVisitor];
        
        if(stop) {
            walker = nil;
        }
        else {
            walker = [walker superclass];
            
            if( walker == [NSObject class]) {
                walker = nil;
            }
        }
    }
 
    return array;
}


//+ (NSArray*) findInstanceMethodNamesForClass:(Class) aClass
//                                  superclass:(Class) recursivelySearchToSuperclassOrNil
//                                      filter:(FLRuntimeFilterBlock) filterOrNil {
//
//}


//- (NSArray*) findInstanceMethodsByName:(BOOL (^)(NSString* name, BOOL* stop)) nameMatcher {
//    NSMutableArray* array = [NSMutableArray array];
//
//    [self visitEachSelectorInClass:[self class] visitor:]
//
//    NSSet* methods = FLRuntimeInstanceMethodNamesForClass([self class], [FLUnitTest class]);
//
//    for(NSString* methodName in methods) {
//        if(nameMatcher(methodName)) {
//           [list addObject:[FLCallback callback:self action:NSSelectorFromString(methodName)]];
//        }
//    }
//    return array;
//}


+ (NSArray*) allClassesMatchingFilter:(FLRuntimeFilterBlock) filter {
    NSMutableArray* array = [NSMutableArray array];
    
    FLRuntimeSelectorVisitor selectorVisitor = ^(FLRuntimeInfo info, BOOL* stop) {
        BOOL match = NO;
        if(filter) {
            filter(info, &match, stop);
            
            if(match) {
                [array addObject:[FLSelectorInfo selectorInfoWithClass:info.class selector:info.selector]];
            }
        }
    };
    
    FLRuntimeClassVisitor classVisitor = ^(FLRuntimeInfo info, BOOL* stop) {
        *stop = [NSObject visitEachSelectorInClass:info.class visitor:selectorVisitor];
        };
    
    [NSObject visitEveryClass:classVisitor];
    return array;
}

+ (BOOL) superclass:(Class) aSuperclass hasSubclass:(Class) aClass {
    if(!aSuperclass || !aClass || aSuperclass == aClass) {
        return NO;
    }
    
    Class walker = aClass;
    while(walker) {
        walker = class_getSuperclass(walker);
        if(walker == aSuperclass) {
            return YES;
        }
    }
    return NO;
    
    
//    const char* theClassName = class_getName(aClass);
//    
//	for(int i = 0; i < count; i++) {
//
//        // some things in the returned don't have classes - e.g. object_getClass returns nil
////        aClass = object_getClass(aClass);
////        if(!aClass) {
////            continue;
////        }
//    
//        // some objects don't have super classes - whatever Apple, whatever.
//        Class superClass = class_getSuperclass(aClass);
//        if(!superClass) {
//            continue;
//        }
//        
//        // okay now we have a class name for the current classes superclass - or do we?
//        const char* superClassName = class_getName(superClass);
//        if(!superClassName) {
//            continue;
//        }
//    
//        // okay fine, we do, see if the superclass is a the class we want, if so Yay. If not, whatever.
//        if(strcmp(superClassName, theClassName) == 0) {
//            [theClassNames addObject:aClass];
//        }
//	}
//	
//	free(classList);

    
//    return [aClass isSubclassOfClass:aSuperclass];
}

+ (NSArray*) subclassesForClass:(Class) theClass {
	int count = objc_getClassList(NULL, 0);

    NSMutableArray* theClassNames = [NSMutableArray array];

    Class* classList = (__unsafe_unretained Class*) malloc(sizeof(Class) * count);
	
	objc_getClassList(classList, count);
 
//    const char* theClassName = class_getName(theClass);
    
	for(int i = 0; i < count; i++) {

        Class aClass = classList[i];

        if([NSObject superclass:theClass hasSubclass:aClass]) {
            [theClassNames addObject:aClass];
        }

//        // some things in the returned don't have classes - e.g. object_getClass returns nil
////        aClass = object_getClass(aClass);
////        if(!aClass) {
////            continue;
////        }
//    
//        // some objects don't have super classes - whatever Apple, whatever.
//        Class superClass = class_getSuperclass(aClass);
//        if(!superClass) {
//            continue;
//        }
//        
//        // okay now we have a class name for the current classes superclass - or do we?
//        const char* superClassName = class_getName(superClass);
//        if(!superClassName) {
//            continue;
//        }
//    
//        // okay fine, we do, see if the superclass is a the class we want, if so Yay. If not, whatever.
//        if(strcmp(superClassName, theClassName) == 0) {
//            [theClassNames addObject:aClass];
//        }
	}
	
	free(classList);
    
    return theClassNames;
}

+ (BOOL) classRespondsToSelector:(Class) theClass selector:(SEL) inSelector {

    FLRuntimeSelectorVisitor visitor = ^(FLRuntimeInfo info, BOOL* stop) {
        if( FLSelectorsAreEqual(inSelector, info.selector)) {
            *stop = YES;
        }
    };

    Class walker = theClass;
    while(walker) {
        if([self visitEachSelectorInClass:walker visitor:visitor]) {
            return YES;
        }
        walker = class_getSuperclass(walker);
    }
  
    return NO;
}


+ (NSArray*) classesImplementingInstanceMethod:(SEL) theMethod {
    
    NSMutableArray* result = [NSMutableArray array];

    FLRuntimeClassVisitor visitor = ^(FLRuntimeInfo info, BOOL* stop) {
        if(info.isMetaClass) {
            if([NSObject classRespondsToSelector:info.class selector:theMethod]) {
                [result addObject:[FLSelectorInfo selectorInfoWithClass:info.class selector:theMethod]];
            }
        }
    };
    
    [self visitEveryClass:visitor];

    return result;
}


+ (int) parameterCountForClassSelector:(Class) aClass selector: (SEL) selector {

    Method method = class_getInstanceMethod(aClass, selector);
    if(!method) {
        method = class_getInstanceMethod(object_getClass(aClass), selector);
    }
    
    if(method) {
        return method_getNumberOfArguments(method);
    }
    
    FLAssertFailed_v(@"couldn't get argument count");
    
    return -1;
}

+ (int) argumentCountForSelector:(SEL) sel {

    if(!sel) return 0;

    const char* name = sel_getName(sel);
    int count = 0;
    while(*name) {
        if(*name++ == ':') {
            ++count;
        }
    }
    
    return count;
}

#if DEBUG
+ (void) logMethodsForClass:(Class) aClass {
    unsigned int count = 0;
    Method* methods = class_copyMethodList(aClass, &count);
    for(NSUInteger i = 0; i < count; i++) {
        NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
    }
    NSLog(@"--- done: %@ (isMeta=%d)", NSStringFromClass(aClass), class_isMetaClass(aClass) ? 1 : 0);
    free(methods);
}
#endif


@end

@implementation NSObject (FLCreateInstance)
+ (id) create {
    return autorelease_([[[self class] alloc] init]);
}
@end


