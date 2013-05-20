//
//	GtLowMemoryHandler.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/24/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLowMemoryHandler.h"

#if IOS
#import <Foundation/NSNotification.h>
#import <UIKit/UIKit.h>
#endif

@implementation GtLowMemoryHandler

NSString* GtReleaseObjectsCachedInMemoryNotification = @"GtReleaseObjectsCachedInMemoryNotification";

static GtLowMemoryHandler* s_handler = nil;

+ (void) initialize
{
	s_handler = [[GtLowMemoryHandler alloc] init];
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
	GtSuperDealloc();
}

- (void) broadcastReleaseMessage
{
#if IOS
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtReleaseObjectsCachedInMemoryNotification object:[UIApplication sharedApplication]]];
#endif
}

- (void) addObserver:(id) observer action:(SEL) action
{
#if IOS
		[[NSNotificationCenter defaultCenter] addObserver:observer
			selector:action 
			name: GtReleaseObjectsCachedInMemoryNotification
			object: [UIApplication sharedApplication]]; 
#endif		  
}

- (void) removeObserver:(id) observer
{
#if IOS
	[[NSNotificationCenter defaultCenter] removeObserver:observer];
#endif
}

+ (void) setDefaultHandler:(GtLowMemoryHandler*) handler
{
	GtAssignObject(s_handler, handler);
}

+ (id) defaultHandler
{
	return s_handler;
}


@end