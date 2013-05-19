//
//	FLTouch.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTouch.h"


@implementation FLTouch

@synthesize timestamp = _timestamp;
@synthesize phase = _phase;
@synthesize tapCount = _tapCount;
@synthesize view = _view;
@synthesize window = _window;
@synthesize locationInView = _location;
@synthesize previousLocationInView = _previousLocation;
@synthesize locationInWindow = _windowLocation;
@synthesize previousLocationInWindow = _windowPreviousLocation;

- (id) initWithUITouch:(UITouch*) touch
{
	if((self = [super init]))
	{
		_timestamp = touch.timestamp;
		_phase = touch.phase;
		_tapCount = touch.tapCount;
		_view = touch.view;
		_window = touch.window;
		_location = [touch locationInView:_view];
		_previousLocation = [touch previousLocationInView:_view];
		_windowLocation = [touch locationInView:_window];
		_windowPreviousLocation = [touch locationInView:_window];
	}
	
	return self;
}

+ (FLTouch*) touchWithUITouch:(UITouch*) touch
{
	return FLAutorelease([[FLTouch alloc] initWithUITouch:touch]);
}

@end
