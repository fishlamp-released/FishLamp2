//
//	GtButtonBackgroundWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtButtonBackgroundWidget.h"


@implementation GtButtonBackgroundWidget

@synthesize topGradient = m_topGradient;
@synthesize bottomGradient = m_bottomGradient;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_topGradient = [[GtGradientWidget alloc] initWithFrame:frame];
		[self addSubwidget:m_topGradient];

		m_bottomGradient = [[GtGradientWidget alloc] initWithFrame:frame];
		[self addSubwidget:m_bottomGradient];
	}
	
	return self;
}	

+ (GtButtonBackgroundWidget*) buttonBackgroundWidget
{
	return GtReturnAutoreleased([[GtButtonBackgroundWidget alloc] initWithFrame:CGRectZero]);
}

- (CGFloat) alpha
{
	return m_topGradient.alpha;
}

- (void) setAlpha:(CGFloat) alpha
{
	m_topGradient.alpha = alpha;
	m_bottomGradient.alpha = alpha;
}

- (void) layoutSubwidgets
{
	CGRect frame = self.frame;
	frame.size.height *= 0.5;
//	  frame.size.height += 0.5;
	m_topGradient.frameOptimizedForSize = frame;

	frame.origin.y = GtRectGetBottom(m_topGradient.frame);
	frame.size.height = self.frame.size.height - frame.origin.y;
	m_bottomGradient.frameOptimizedForSize = frame;
	
	[super layoutSubwidgets];
}

- (void) dealloc
{
	GtRelease(m_topGradient);
	GtRelease(m_bottomGradient);
	GtSuperDealloc();
}

@end
