//
//	GtUnitTest.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if UNIT_TESTS

#import "GtUnitTest.h"

@implementation GtUnitTest

@synthesize unitTestClass = m_unitTestClass;
@synthesize testClass = m_class;
@synthesize selector = m_selector;
@synthesize name = m_name;
@synthesize asyncLock = m_lock;

@synthesize exception = m_exception;

- (id) initWithTestClassAndSelector:(Class) testClass 
	selector:(SEL) selector
{
	if((self = [super init]))
	{
		m_class = testClass;
		m_selector = selector;
		m_name = [NSStringFromSelector(m_selector) stringByReplacingOccurrencesOfString:@"unitTest" withString:@""];
		m_name = [[m_name stringByReplacingOccurrencesOfString:@":" withString:@""] retain];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_lock);
	GtRelease(m_name);
	GtRelease(m_exception);
	GtSuperDealloc();
}

- (void) didCompleteAsyncTest
{
	[m_lock lockWhenCondition:YES];
	[m_lock unlockWithCondition:NO];
}

- (void) blockUntilTestCompletes
{
	while(![m_lock tryLockWhenCondition:NO])
	{
		[[NSRunLoop mainRunLoop] runUntilDate:[NSDate date]];
	}
	[m_lock unlock];
}

static GtUnitTest* s_currentTest = nil;

+ (GtUnitTest*) currentTest
{
	return s_currentTest;
}

- (void) execute
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		
	@try
	{
		s_currentTest = self;
		m_lock = [[NSConditionLock alloc] initWithCondition:YES];
		[m_class performSelector:m_selector withObject:self];
	
	}
	@catch(NSException* exception)
	{
		self.exception = exception;
	}
	
	GtDrainPool(&pool);

	s_currentTest = nil;
	GtReleaseWithNil(m_lock);
}

@end
#endif