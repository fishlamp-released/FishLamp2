//
//	FLTableCellBackground.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableCellBackgroundWidget.h"


@implementation FLTableCellBackgroundWidget
@synthesize selectionStyle = _selectionStyle;

- (void) setHighlighted:(BOOL) highlighted
{
	if(!highlighted || _selectionStyle != UITableViewCellSelectionStyleNone)
	{
		[super setHighlighted:highlighted];
	}
}

- (void) drawSelf:(FLRect) rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if(self.highlighted)
	{
		switch(_selectionStyle)
		{
			case UITableViewCellSelectionStyleGray:
				[[UIColor grayColor] setFill];
			break;
			
			case UITableViewCellSelectionStyleBlue:
				[[UIColor iPhoneBlueColor] setFill];
			break;
			
			case UITableViewCellSelectionStyleNone:
			   [self.backgroundColor setFill];
			break;
		}
	
	}
	else
	{
		[self.backgroundColor setFill];
	}
	CGContextFillRect( context , self.frame );
	
	[super drawSelf:rect];
}


@end
