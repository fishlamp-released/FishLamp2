//
//	GtUnitTestGroup.m
//	PackMule
//
//	Created by Mike Fullerton on 4/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if UNIT_TESTS
#import "GtUnitTestGroup.h"
#import "GtUnitTest.h"

@implementation GtUnitTestGroup

@synthesize unitTests = m_unitTests;
@synthesize userData = m_userData;
@synthesize domain = m_domain;
@synthesize manager = m_manager;

- (id) initWithClass:(Class) aClass
{
	if((self = [super init]))
	{
		m_class = aClass;
		m_unitTests = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(m_domain);
	GtReleaseWithNil(m_userData);
	GtReleaseWithNil(m_unitTests);
	GtSuperDealloc();
}

- (void) setup
{
	if([m_class respondsToSelector:@selector(setupUnitTests:)])
	{
		[m_class performSelector:@selector(setupUnitTests:) withObject:self];
	}
}

- (void) tearDown
{
	if([m_class respondsToSelector:@selector(tearDownUnitTests:)])
	{
		[m_class performSelector:@selector(tearDownUnitTests:) withObject:self];
	}
	
	GtReleaseWithNil(m_userData);
}

NSInteger CompareUnitTests(GtUnitTest* lhs, GtUnitTest* rhs, void* state)
{
	return [lhs.name compare:rhs.name]; 
}

- (void) runTests
{
	[m_unitTests sortUsingFunction:CompareUnitTests context:nil];

	for(GtUnitTest* test in m_unitTests)
	{
		[test execute];
	}
}

- (void) addUnitTest:(GtUnitTest*) test
{
	test.unitTestClass = self;
	[m_unitTests addObject:test];
}


@end
#endif