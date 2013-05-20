//
//	UIView+GtAutoLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if VIEW_AUTOLAYOUT

#import "UIView+GtViewAutoLayout.h"

@implementation UIView (GtViewAutoLayout)

- (void) setPositionInSuperview
{
}

@end

@implementation UIView (GtViewAutoLayoutInternal)

- (void) setPositionInSuperviewWithRectLayout:(GtRectLayout) rectLayout
{
	if(self.superview)
	{
		CGRect frame = GtRectLayoutRectInRect(rectLayout, self.superview.bounds, self.frame);
		if(!CGRectEqualToRect(frame, self.frame))
		{
			self.frame = frame;
		}
	}
}
 
- (void) setPositionInSuperviewWithRectLayout:(GtRectLayout) rectLayout superviewContents:(GtViewContentsDescriptor) superviewContents
{
	if(self.superview)
	{
		CGRect frame = GtViewContentsDescriptorCalculateRect(self.frame, self.superview.bounds, superviewContents, rectLayout);
		if(!CGRectEqualToRect(frame, self.frame))
		{
			self.frame = frame;
		}
	}
}

- (void) setSubviewPositions
{
	for(UIView* view in self.subviews)
	{
		[view setPositionInSuperview];
		[view setSubviewPositions];
	}
}


@end

#endif