//
//	GtButtonbarToolbar.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtButtonbarToolbar.h"

@implementation GtButtonbarToolbar

@synthesize buttonbar = m_buttonbar;

- (id) initWithFrame:(CGRect)frame buttonbarView:(GtButtonbarView*) buttonbarView
{
	if((self = [super initWithFrame:frame]))
    {
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
		self.barStyle = UIBarStyleBlack;
		self.translucent = YES;
        
        m_buttonbar = GtRetain(buttonbarView);
        [self addSubview:m_buttonbar];
    }

    return self;
}

- (id) initWithFrame:(CGRect) frame
{
	return [self initWithFrame:frame buttonbarView:GtReturnAutoreleased([[GtToolbarButtonbarView alloc] initWithFrame:frame])];
}

- (void) dealloc
{
	GtRelease(m_buttonbar);
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	m_buttonbar.newFrame = self.bounds;
}

@end