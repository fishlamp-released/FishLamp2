//
//	GtAlertButtonCallback.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/19/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAlertButtonCallback.h"

@implementation GtAlertButtonCallback

@synthesize buttonCallback = m_callback;
@synthesize buttonTitle = m_buttonTitle;
@synthesize blockCallback = m_blockCallback;

- (id) initWithTitle:(NSString*) buttonTitle target:(id) target action:(SEL) action
{	
	if((self = [super init]))
	{
		self.buttonTitle = buttonTitle;
		if(target)
		{
			self.buttonCallback = [GtCallbackObject callback:target action:action];
		}
	}

	return self;
}


- (id) initWithTitle:(NSString*) buttonTitle blockCallback:(GtBlock) blockCallback
{	
	if((self = [super init]))
	{
		self.buttonTitle = buttonTitle;
		self.blockCallback = blockCallback;
	}

	return self;
}


+ (GtAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle blockCallback:(GtBlock) blockCallback
{
	return GtReturnAutoreleased([[GtAlertButtonCallback alloc] initWithTitle:buttonTitle blockCallback:blockCallback]);
}

+ (GtAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtAlertButtonCallback alloc] initWithTitle:buttonTitle target:target action:action]);
}

+ (GtAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle
{
	return GtReturnAutoreleased([[GtAlertButtonCallback alloc] initWithTitle:buttonTitle target:nil action:nil]);
}

- (void) releaseCallbacks
{
    GtReleaseBlockWithNil(m_blockCallback);
    GtReleaseWithNil(m_callback);
}

- (void) dealloc
{
    GtRelease(m_blockCallback);
	GtRelease(m_buttonTitle);
	GtRelease(m_callback);
	GtSuperDealloc();
}

+ (GtAlertButtonCallback*) cancelButtonCallback
{
	return [[[GtAlertButtonCallback alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) target:nil action:nil] autorelease];
}

@end