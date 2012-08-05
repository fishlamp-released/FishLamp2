//
//  FLUnitTestCase.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLUnitTestCase.h"
#import "FLUnitTest.h"

@implementation FLUnitTestCase

@synthesize testClass = _class;
@synthesize selector = _selector;

- (id) initWithTestClass:(Class) testClass selector:(SEL) selector {

	if((self = [super init])) {
		_class = testClass;
		_selector = selector;
    }
	
	return self;
}

+ (FLUnitTestCase*) unitTestCase:(Class) testClass selector:(SEL) selector {
    return FLReturnAutoreleased([[[self class] alloc] initWithTestClass:testClass selector:selector]);
}

- (NSString*) testName {
    return NSStringFromSelector(_selector);
}

- (void) runTest:(FLUnitTest*) unitTest {
    [_class performSelector:_selector withObject:unitTest];
}

@end
