//
//	GtTouch.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTouch.h"


@implementation GtTouch

@synthesize timestamp = m_timestamp;
@synthesize phase = m_phase;
@synthesize tapCount = m_tapCount;
@synthesize view = m_view;
@synthesize window = m_window;
@synthesize locationInView = m_location;
@synthesize previousLocationInView = m_previousLocation;
@synthesize locationInWindow = m_windowLocation;
@synthesize previousLocationInWindow = m_windowPreviousLocation;

- (id) initWithUITouch:(UITouch*) touch
{
	if((self = [super init]))
	{
		m_timestamp = touch.timestamp;
		m_phase = touch.phase;
		m_tapCount = touch.tapCount;
		m_view = touch.view;
		m_window = touch.window;
		m_location = [touch locationInView:m_view];
		m_previousLocation = [touch previousLocationInView:m_view];
		m_windowLocation = [touch locationInView:m_window];
		m_windowPreviousLocation = [touch locationInView:m_window];
	}
	
	return self;
}

+ (GtTouch*) touchWithUITouch:(UITouch*) touch
{
	return GtReturnAutoreleased([[GtTouch alloc] initWithUITouch:touch]);
}

@end
