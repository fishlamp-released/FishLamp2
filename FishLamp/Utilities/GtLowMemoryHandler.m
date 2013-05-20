//
//  GtLowMemoryHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/24/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtLowMemoryHandler.h"
#import "GtClassContainer.h"

@implementation GtLowMemoryHandler

GtSynthesizeSingleton(GtLowMemoryHandler);

- (void) handleLowMemoryNotification:(id)sender
{
#if DEBUG
	GtTrace(GtTraceLowMemory, @"GtLowMemoryHandler got low memory alert");
#endif

	if(m_responderClasses)
	{
		for(Class class in m_responderClasses)
		{
#if DEBUG
			GtTrace(GtTraceLowMemory, @"Releasing class: %@", NSStringFromClass(class));
#endif		
			[class performSelector:@selector(handleLowMemoryNotificationForClass:) withObject:self];
		}
	}
	if(m_responders)
	{
		for(id instance in m_responders)
		{
#if DEBUG
			GtTrace(GtTraceLowMemory, @"Releasing instance: %@", NSStringFromClass(instance));
#endif		
			[instance performSelector:@selector(handleLowMemoryNotification:) withObject:self];
		}
	}
	
}

- (id) init
{
	if(self = [super init])
	{
#if IPHONE
		[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(handleLowMemoryNotification:) 
			name: UIApplicationDidReceiveMemoryWarningNotification
			object: [UIApplication sharedApplication]];
			
		[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(handleLowMemoryNotification:) 
			name: GtReleaseObjectsCachedInMemoryNotification
			object: [UIApplication sharedApplication]];	
			
		[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(handleLowMemoryNotification:) 
			name: UIApplicationWillTerminateNotification
			object: [UIApplication sharedApplication]];
#endif
	}
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	GtRelease(m_responders);
	GtRelease(m_responderClasses);
	[super dealloc];
}

- (void) addResponderByClass:(Class)inClass
{
	if(!m_responderClasses)
	{
		m_responderClasses = [GtAlloc(NSMutableArray) initWithObjects:inClass, nil];
	}
	else
	{
		[m_responderClasses addObject:inClass];
	}
}
- (void) addResponder:(id) instance
{
	if(!m_responders)
	{
		m_responders = [GtAlloc(NSMutableArray) initWithObjects:instance, nil];
	}
	else
	{
		[m_responders addObject:instance];
	}
	
}

+ (void) broadcastReleaseMessage
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtReleaseObjectsCachedInMemoryNotification object:[UIApplication sharedApplication]]];
}

@end
