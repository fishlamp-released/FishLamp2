//
//	GtPerformSelectorOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPerformSelectorOperation.h"

@implementation GtPerformSelectorOperation

@synthesize callback = m_callback;

- (id) initWithTarget:(id) target action:(SEL) action
{
	if((self = [super init]))
	{
		[self setCallback:target action:action];
	}
	
	return self;
}

+ (GtPerformSelectorOperation*) performSelectorOperation:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtPerformSelectorOperation alloc] initWithTarget:target action:action]);
}
//
//- (void) dealloc
//{
//	  [m_callback.target release];
//	  GtSuperDealloc();
//}

- (void) performSelf
{
	GtInvokeCallback(m_callback, self);
}

- (void) setCallback:(id) target action:(SEL) action
{
	GtAssertNotNil(target);
	GtAssertNotNil(action);
	
	GtAssert([target respondsToSelector:action], @"target doesn't respond to selector");

	m_callback.target = target;
	m_callback.action = action;
}

#if UNIT_TESTS

+ (void) _didExecuteOperation:(GtPerformSelectorOperation*) operation
{
	GtLog(@"did execute");
}

- (void) _asyncDone:(GtPerformSelectorOperation*) operation
{
//	[operation finishOperation];
	
//	GtAssert(operation.wasPerformed, @"not performed");
//	  GtAssert(operation.wasStarted, @"not started");
//
//	[[GtUnitTest currentTest] didCompleteAsyncTest];
}

+ (void) unitTestAsyncOperation:(GtUnitTest*) unitTest
{
//	GtPerformSelectorOperation* operation = [GtPerformSelectorOperation performSelectorOperation:self action:@selector(_didExecuteOperation:)];
//
//	  [operation startOperation:GtCallbackMake(operation, @selector(_asyncDone:))];
//	  
//	  [unitTest blockUntilTestCompletes];
}
#endif

@end


