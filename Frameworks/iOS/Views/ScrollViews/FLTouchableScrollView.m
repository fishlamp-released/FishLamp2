//
//	FLTouchableScrollView.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLTouchableScrollView.h"

@implementation FLTouchableScrollView

@synthesize touchableScrollViewDelegate = _touchDelegate;

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
	if(_touchDelegate)
	{
	   handled = [_touchDelegate touchableScrollView:self touchesBegan:touches withEvent:event];
	}

	if(!handled)
	{
		[super touchesBegan:touches withEvent:event];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
	if(_touchDelegate)
	{
		handled = [_touchDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
	}

	if(!handled)
	{
		[super touchesMoved:touches withEvent:event];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
	if(_touchDelegate)
	{
		handled = [_touchDelegate touchableScrollView:self touchesCancelled:touches withEvent:event];
	}

	if(!handled)
	{
		[super touchesCancelled:touches withEvent:event];
	}
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	

	BOOL handled = NO;
	if(_touchDelegate)
	{
		handled = [_touchDelegate touchableScrollView:self touchesEnded:touches withEvent:event];
	}

	if(!handled)
	{	
		// Getting multiple calls here. bug is in sdk fixed in 3.0??
		[super touchesEnded: touches withEvent: event];

		if (!self.dragging && !FLFloatEqualToFloat(_lastEventTimeStamp, event.timestamp)) {
			_lastEventTimeStamp = event.timestamp;
			[self.nextResponder touchesEnded: touches withEvent:event]; 
		}
	
	}

}

@end
