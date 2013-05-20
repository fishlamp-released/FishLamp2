//
//	GtTableViewCellGradientBackgroundView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewCellGradientBackgroundView.h"
#import "UITableView+GtExtras.h"

@implementation GtTableViewCellGradientBackgroundView

@synthesize drawDisclosureArrow = m_drawDisclosureArrow;
@synthesize arrowColor = m_arrowColor;
@synthesize arrowAlpha = m_arrowAlpha;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.alpha = 0.8f;
		self.arrowAlpha = 1.0f;
		self.arrowColor = [UIColor whiteColor];
	}
	
	return self;
}

- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	
	if(self.drawDisclosureArrow)
	{
		[UITableViewCell drawDisclosureArrowInRect:self.bounds
			color:m_arrowColor
			alpha:m_arrowAlpha
			context:UIGraphicsGetCurrentContext()];
	}
}

- (void) dealloc
{
	GtRelease(m_arrowColor);
	GtSuperDealloc();
}
@end
