//
//  GtActionContextWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtActionWidget.h"


@implementation GtActionWidget

@synthesize actionContext = m_actionContext; 

- (GtAction*) action
{
	return m_action.object;
}

- (void) setAction:(GtAction*) action
{
	m_action.object = action;
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_action = [[GtActionReference alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_action);
	GtRelease(m_actionContext);
	GtSuperDealloc();
}
@end
