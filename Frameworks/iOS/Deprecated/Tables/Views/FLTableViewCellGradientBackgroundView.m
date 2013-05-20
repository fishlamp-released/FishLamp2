//
//	FLTableViewCellGradientBackgroundView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTableViewCellGradientBackgroundView.h"
#import "UITableView+FLExtras.h"

@implementation FLTableViewCellGradientBackgroundView

@synthesize drawDisclosureArrow = _drawDisclosureArrow;
@synthesize arrowColor = _arrowColor;
@synthesize arrowAlpha = _arrowAlpha;

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
			color:_arrowColor
			alpha:_arrowAlpha
			context:UIGraphicsGetCurrentContext()];
	}
}

- (void) dealloc
{
	FLRelease(_arrowColor);
	FLSuperDealloc();
}
@end
