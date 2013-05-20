//
//  GtAsyncOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/21/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtAsyncOperation.h"

@implementation GtAsyncOperation

#if TRACE_CALLBACK
static int s_counter = 0;
#endif

@synthesize callback = m_callback;

GtAssertDefaultInitNotCalled()

- (void) main
{
#if TRACE_CALLBACK
	GtLog(@"Invoking GtAsyncOperation: %d", m_id);
#endif
	
	[m_callback invoke]; // calls autorelease
}

- (id) initWithCallback:(GtCallback*) callback
{
	GtAssert(callback != nil, @"nil callback");

	if(self = [super init])
	{
		m_callback = [callback retain]; 

#if TRACE_CALLBACK
		m_id = ++s_counter;
		GtLog(@"Creating GtAsyncOperation: %d", m_id);
#endif
	}
	
	return self;
}

#if !IPHONE
+ (GtAsyncOperation*) operationWithCallback:(GtCallback*) callback
{
	return [GtAlloc(GtAsyncOperation) initWithCallback:callback];
}
#endif

- (void) dealloc
{
#if TRACE_CALLBACK
	GtLog(@"Deleting GtAsyncOperation: %d", m_id);
#endif

	GtRelease(m_callback);
	
	[super dealloc];
}

- (void) addParameter:(id) object
{
	[m_callback addParameter:object];
}

- (void) addBoolParameter:(BOOL) isTrue
{
	[m_callback addBoolParameter:isTrue];
}

- (void) addIntParameter:(int) value
{
	[m_callback addIntParameter:value];
}




@end
