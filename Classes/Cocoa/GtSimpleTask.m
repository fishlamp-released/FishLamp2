//
//	GtSimpleTask.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSimpleTask.h"

@implementation GtSimpleTask

- (void) dealloc
{
	[m_target performSelectorOnMainThread:@selector(release) withObject:nil waitUntilDone:NO];
	GtSuperDealloc();
}

- (void) _performInForeground
{
	GtAssert([NSThread isMainThread], @"performing action on main thread");

	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	@try
	{
		[m_target performSelector:m_foregroundAction];
	}
	@catch(NSException* exception)
	{
		GtLog(@"Unexpected error in _performInForeground: %@", [exception description]);
	}
		
	GtReleaseWithNil(m_target);
	GtDrainPool(&pool);
}

- (void) _performInBackground
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	@try
	{
		GtAssert(![NSThread isMainThread], @"performing action on main thread");
	
		[m_target performSelector:m_backgroundAction];
		[self performSelectorOnMainThread:@selector(_performInForeground) withObject:nil waitUntilDone:NO];
	}
	@catch(NSException* exception)
	{
		GtLog(@"Unexpected error in _performInBackground: %@", [exception description]);
	
		// don't propagate.
	}
	
	GtDrainPool(&pool);
}


- (void) beginTaskOnQueue:(NSOperationQueue*) queue 
	target :(id) target 
	backgroundAction:(SEL) backgroundAction 
	foregroundAction:(SEL) foregroundAction
{
	m_target = GtRetain(target);
	m_backgroundAction = backgroundAction;
	m_foregroundAction = foregroundAction;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self _performInBackground];
        });
}
@end

