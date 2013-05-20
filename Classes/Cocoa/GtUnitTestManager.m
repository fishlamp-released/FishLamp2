//
//	GtUnitTestManager.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if UNIT_TESTS

#import "GtUnitTestManager.h"
#import "GtUnitTestGroup.h"
#import "GtUnitTest.h"
#import <objc/runtime.h>

@implementation GtUnitTestManager

- (id) init
{
	if((self = [super init]))
	{
		m_tests = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(m_tests);
	GtSuperDealloc();
}

- (void) addTest:(GtUnitTest*) unitTest
{
	[m_tests addObject:unitTest];
}

- (void) addUnitTestsForClass:(Class) class
{
	NSUInteger count = 0;
	Method* methods = class_copyMethodList(object_getClass(class), &count);
	
	GtUnitTestGroup* utClass = nil;
				
	for(NSUInteger i = 0; i < count; i++)
	{
		SEL sel = method_getName(methods[i]); 
		if([NSStringFromSelector(sel) hasPrefix:@"unitTest"])
		{
			unsigned int argCount = method_getNumberOfArguments(methods[i]);
			if(argCount == 3)// two objc params, plus ours.
			{
				if(!utClass)
				{
					utClass = [[GtUnitTestGroup alloc] initWithClass:class];
					[m_tests addObject:utClass];
				}
				
				GtUnitTest* test = [[GtUnitTest alloc] initWithTestClassAndSelector:class selector:sel];
				[utClass addUnitTest:test];
				GtReleaseWithNil(test);
			}
		}
	}
	
	if(utClass)
	{
		if([class respondsToSelector:@selector(configureUnitTests:)])
		{
			[class performSelector:@selector(configureUnitTests:) withObject:utClass];
		}
		
		GtReleaseWithNil(utClass);
	}
	
	free(methods);
}

- (void) discoverTests
{
	int count = objc_getClassList(NULL, 0);

	Class* classList = malloc(sizeof(Class) * count);
	
	objc_getClassList(classList, count);
 
	for(int i = 0; i < count; i++)
	{
		[self addUnitTestsForClass:classList[i]];
	}
	
	free(classList);
}

- (void) executeTests
{
	for(GtUnitTestGroup* testClass in m_tests)
	{
		[testClass setup];
		[testClass runTests];
		[testClass tearDown];
	}
}

- (void) _runOnMainThread
{
	[self discoverTests];
	[self executeTests];
}

- (void) runOnMainThread
{
	[self performSelectorOnMainThread:@selector(_runOnMainThread) withObject:nil waitUntilDone:NO];
}

+ (void) configureUnitTests:(GtUnitTestGroup*) class
{
	class.domain = @"unittest";
}

+ (void) setupUnitTests:(GtUnitTestGroup*) test
{
}

+ (void) tearDownUnitTests:(GtUnitTestGroup*) test
{
}

+ (void) unitTestUnitTestManager:(GtUnitTest*) test
{
}

@end
#endif