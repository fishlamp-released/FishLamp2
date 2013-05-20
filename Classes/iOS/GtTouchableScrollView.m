//
//	GtTouchableScrollView.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTouchableScrollView.h"

@implementation GtTouchableScrollView

@synthesize touchableScrollViewDelegate = m_touchDelegate;

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
	if(m_touchDelegate)
	{
	   handled = [m_touchDelegate touchableScrollView:self touchesBegan:touches withEvent:event];
	}

	if(!handled)
	{
		[super touchesBegan:touches withEvent:event];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
	if(m_touchDelegate)
	{
		handled = [m_touchDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
	}

	if(!handled)
	{
		[super touchesMoved:touches withEvent:event];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
	if(m_touchDelegate)
	{
		handled = [m_touchDelegate touchableScrollView:self touchesCancelled:touches withEvent:event];
	}

	if(!handled)
	{
		[super touchesCancelled:touches withEvent:event];
	}
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	

	BOOL handled = NO;
	if(m_touchDelegate)
	{
		handled = [m_touchDelegate touchableScrollView:self touchesEnded:touches withEvent:event];
	}

	if(!handled)
	{	
		// Getting multiple calls here. bug is in sdk fixed in 3.0??
		[super touchesEnded: touches withEvent: event];

		if (!self.dragging && m_lastEventTimeStamp != event.timestamp) 
		{
			m_lastEventTimeStamp = event.timestamp;
			[self.nextResponder touchesEnded: touches withEvent:event]; 
		}
	
	}

}

@end
