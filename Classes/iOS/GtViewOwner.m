//
//	GtViewOwner.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewOwner.h"


@implementation GtViewOwner

@synthesize view = m_view;

- (id) initWithView:(UIView*) view
{	
	if((self = [super init]))
	{
		self.view = view;
	}
	
	return self;
}

+ (GtViewOwner*) viewOwner:(UIView*) view
{
	return GtReturnAutoreleased([[GtViewOwner alloc] initWithView:view]);
}

- (void) dealloc
{
	[m_view removeFromSuperview];
	GtReleaseWithNil(m_view);
	GtSuperDealloc();
}

@end