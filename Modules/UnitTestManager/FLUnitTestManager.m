//
//	FLUnitTestManager.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUnitTestManager.h"
#import "FLUnitTestGroup.h"
#import "FLUnitTest.h"
#import "_FLUnitTest.h"
#import "_FLUnitTestManager.h"
#import "_FLUnitTestLogger.h"
#import "_FLUnitTestGroup.h"

#import <objc/runtime.h>

@implementation FLUnitTestManager

@synthesize delegate = _delegate;

- (id) init {
	if((self = [super init])) {
	}
	
	return self;
}

+ (FLUnitTestManager*) unitTestManager {
    return FLReturnAutoreleased([[FLUnitTestManager alloc] init]);
}

- (void) dealloc {
    FLSuperDealloc();
}

//- (void) addTest:(FLUnitTest*) unitTest {
//	[_tests addObject:unitTest];
//}

//- (void) scanForInstanceMethods {
//
//    unsigned int count = 0;
//    Method* methods = class_copyMethodList(object_getClass(aClass), &count);
//    
//    FLUnitTestGroup* group = nil;
//
//    for(NSUInteger i = 0; i < count; i++) {
//        SEL sel = method_getName(methods[i]); 
//        
//        if([NSStringFromSelector(sel) hasPrefix:@"_test"]) {
//            
//            unsigned int argCount = method_getNumberOfArguments(methods[i]);
//            if(argCount == 3) {// two objc params, no others.
//                if(!group) {
//                    group = [FLUnitTestGroup unitTestGroup:aClass];
//                    
//                    if(![_delegate unitTestManager:self shouldDiscoverTestsInGroup:group]) {
//                        goto done;
//                    }
//                }
//                
//                FLUnitTest* unitTest = [FLUnitTest unitTest:[FLUnitTestCase unitTestCase:aClass selector:sel]];
//                
//                if([_delegate unitTestManager:self shouldDiscoverTest:unitTest inGroup:group]) {
//                    [group addUnitTest:unitTest];
//                }
//            }
//        }
//    }
//
//}

//#import "FLSqliteStatement.h"

#define kPrefix @"_unitTest"
#define kSuffix @"Test:"
#define kArgCount 3

BOOL IsOurMethod(SEL sel) {
    NSString* name = NSStringFromSelector(sel);
    if([name hasPrefix:kPrefix]  ) {
//        NSRange range = [name rangeOfString:kSuffix];
//        return range.length == kSuffix.length && (range.location == (name.length - kSuffix.length));
        return YES;
    }
    
    return NO;

}

- (void) _checkInstanceMethodsForClass:(Class) aClass {

    unsigned int count = 0;
    // object_getClass(aClass)
    Method* methods = class_copyMethodList(aClass, &count);

    for(NSUInteger i = 0; i < count; i++) {

        if(kArgCount == method_getNumberOfArguments(methods[i]) && 
            IsOurMethod(method_getName(methods[i]))) {

            FLLog(@"Warning [%@ %@] is an instance (-) and not a class (+) method and will be ignored", NSStringFromClass(aClass), NSStringFromSelector(method_getName(methods[i])));
        }
    
    }

    free(methods);
}

- (FLUnitTestGroup*) _createUnitTestsForClass:(Class) aClass {

    [self _checkInstanceMethodsForClass:aClass];

    unsigned int count = 0;
    // object_getClass(aClass)
    Method* methods = class_copyMethodList(object_getClass(aClass), &count);
    FLUnitTestGroup* group = nil;

    for(NSUInteger i = 0; i < count; i++) {

        if( method_getNumberOfArguments(methods[i]) == kArgCount && 
            IsOurMethod(method_getName(methods[i]))) {

            if(!group) {
                group = [FLUnitTestGroup unitTestGroup:aClass];
                
                if(![_delegate unitTestManager:self shouldDiscoverTestsInGroup:group]) {
                    goto done;
                }
            }
            
            FLUnitTest* unitTest = [FLUnitTest unitTest:[FLUnitTestCase unitTestCase:aClass selector:method_getName(methods[i])]];
            
            if([_delegate unitTestManager:self shouldDiscoverTest:unitTest inGroup:group]) {
                [group addUnitTest:unitTest];
            }
        }
    }

done:        
    free(methods);
    
    return group;
}

- (NSArray*) discoverTests {
	int count = objc_getClassList(NULL, 0);

	Class* classList = malloc(sizeof(Class) * count);
	
	objc_getClassList(classList, count);
 
    NSMutableArray* groups = [NSMutableArray array];
    NSInteger discoveredCount = 0;
    
	for(int i = 0; i < count; i++) {
        FLUnitTestGroup* group = [self _createUnitTestsForClass:classList[i]];
        if(group && group.unitTests.count) {
            discoveredCount += group.unitTests.count; 
            [groups addObject:group];
        }
	}
	
	free(classList);
    
    [_delegate unitTestManager:self didDiscoverTestsInGroups:groups testCount:discoveredCount];

    return groups;
}

- (void) _runTestsInGroup:(FLUnitTestGroup*) group {
    
    group.unitTestManager = self;
    
    [_delegate unitTestManager:self willRunTestsInGroup:group];
    [group setup];
    @try {    
        for(FLUnitTest* test in group.unitTests) {
            if(test.testState == FLUnitTestStateNone) {
                [_delegate unitTestManager:self willRunTest:test inGroup:group];

                test.unitTestGroup = group;
                test.unitTestManager = self;
                
                [test runTest];

                [_delegate unitTestManager:self didRunTest:test inGroup:group];
            }
        }
    } 
    @finally {
        [group tearDown];
        [_delegate unitTestManager:self didRunTestsInGroup:group];
    }
}

- (void) runTests {
    NSArray* groups = [self discoverTests];
    for(FLUnitTestGroup* group in groups) {
        [self _runTestsInGroup:group];
    }
}

- (void) logString:(NSString*) string {
    [_delegate unitTestManager:self logOutput:string];
}


@end
