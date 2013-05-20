//
//	GtNetworkActivityMonitor.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNetworkActivityIndicator.h"

@implementation GtNetworkActivityIndicator

GtSynthesizeSingleton(GtNetworkActivityIndicator);

- (void) dealloc
{
	if(m_updateTimer)
	{
		[m_updateTimer invalidate];
		m_updateTimer = nil;
	}
	GtSuperDealloc();
}

- (void) showNetworkActivityIndicator
{
	@synchronized(self)
	{
		if(++m_networkActivityCounter == 1)
		{
			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		}
		m_lastUpdate = [NSDate timeIntervalSinceReferenceDate];
	}
}

- (void) timerCallback:(id) sender
{
	@synchronized(self)
	{
		if(m_networkActivityCounter == 0 && ([NSDate timeIntervalSinceReferenceDate] - m_lastUpdate) >= 1)
		{
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			
			[m_updateTimer invalidate];
			m_updateTimer = nil; 
		}
	}
}

- (void) hideNetworkActivityIndicator
{
	@synchronized(self)
	{
		if(!m_updateTimer)
		{
			m_updateTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerCallback:) userInfo:nil repeats:YES];
			[[NSRunLoop mainRunLoop] addTimer:m_updateTimer forMode:NSRunLoopCommonModes];
		}
		
		--m_networkActivityCounter;
		m_lastUpdate = [NSDate timeIntervalSinceReferenceDate];
	}
}

@end
