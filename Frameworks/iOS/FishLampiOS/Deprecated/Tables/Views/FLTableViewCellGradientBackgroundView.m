//
//	FLTableViewCellGradientBackgroundView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableViewCellGradientBackgroundView.h"
#import "UITableView+FLExtras.h"

@implementation FLTableViewCellGradientBackgroundView

@synthesize drawDisclosureArrow = _drawDisclosureArrow;
@synthesize arrowColor = _arrowColor;
@synthesize arrowAlpha = _arrowAlpha;

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.alpha = 0.8f;
		self.arrowAlpha = 1.0f;
		self.arrowColor = [UIColor whiteColor];
	}
	
	return self;
}

- (void) drawRect:(FLRect) rect
{
	[super drawRect:rect];
	
	if(self.drawDisclosureArrow)
	{
		[UITableViewCell drawDisclosureArrowInRect:self.bounds
			color:_arrowColor
			alpha:_arrowAlpha
			context:UIGraphicsGetCurrentContext()];
	}
}

- (void) dealloc
{
	release_(_arrowColor);
	super_dealloc_();
}
@end
