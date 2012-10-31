//
//	FLLowMemoryHandler.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLowMemoryHandler.h"

#if IOS
#import <Foundation/NSNotification.h>
#import <UIKit/UIKit.h>
#endif

@implementation FLLowMemoryHandler

NSString* release_ObjectsCachedInMemoryNotification = @"release_ObjectsCachedInMemoryNotification";

static FLLowMemoryHandler* s_handler = nil;

+ (void) initialize
{
	s_handler = [[FLLowMemoryHandler alloc] init];
}

- (void) handleLowMemoryNotification:(id)sender
{	
	@synchronized(s_handler)
	{
		[s_handler broadcastReleaseMessage];
	}
}

- (void) registerForEvents
{
#if IOS
	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(handleLowMemoryNotification:) 
		name: UIApplicationDidReceiveMemoryWarningNotification
		object: [UIApplication sharedApplication]];
		
	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(handleLowMemoryNotification:) 
		name: UIApplicationWillTerminateNotification
		object: [UIApplication sharedApplication]];
#endif
}

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	mrc_super_dealloc_();
}

- (void) broadcastReleaseMessage
{
#if IOS
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:release_ObjectsCachedInMemoryNotification object:[UIApplication sharedApplication]]];
#endif
}

- (void) addObserver:(id) observer action:(SEL) action
{
#if IOS
		[[NSNotificationCenter defaultCenter] addObserver:observer
			selector:action 
			name: release_ObjectsCachedInMemoryNotification
			object: [UIApplication sharedApplication]]; 
#endif		  
}

- (void) removeObserver:(id) observer
{
#if IOS
	[[NSNotificationCenter defaultCenter] removeObserver:observer];
#endif
}

+ (void) setDefaultHandler:(FLLowMemoryHandler*) handler
{
	FLRetainObject_(s_handler, handler);
}

+ (id) defaultHandler
{
	return s_handler;
}


@end
