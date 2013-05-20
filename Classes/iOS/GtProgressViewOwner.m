//
//	GtProgressOwner.m
//	ZenApi1.4
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtProgressViewOwner.h"

@implementation GtProgressViewOwner

@synthesize progressView = m_progressView;

- (id) initWithProgressView:(NSView<GtProgressProtocol>*) progressView
{	
	if((self = [super init]))
	{
		self.progressView = progressView;
	}
	
	return self;
}

+ (GtProgressViewOwner*) progressViewOwner:(NSView<GtProgressProtocol>*) progressView
{
	return GtReturnAutoreleased([[GtProgressViewOwner alloc] initWithProgressView:progressView]);
}

- (void) dealloc
{
	[m_progressView hideProgress];
	GtRelease(m_progressView);
	GtSuperDealloc();
}

@end
