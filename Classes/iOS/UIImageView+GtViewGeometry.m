//
//	UIImageView+GtViewGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/17/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIImageView+GtViewGeometry.h"
#import "UIImage+Resize.h"

@implementation UIImageView (GtViewGeometry)

- (BOOL) resizeToImageSize
{
	return [self setFrameIfChanged:GtRectSetSizeWithSize(self.frame, self.image.size)];
}

- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview
{
	UIImage* image = self.image;
	if(image && self.superview)
	{
		CGRect superviewBounds = self.superview.bounds;
		CGRect newFrame = GtRectFitInRectInRectProportionally(
			GtRectMakeWithSize(superviewBounds.size), 
			GtRectMakeWithSize(image.size));
			
		if(centerInSuperview)
		{
			newFrame = GtRectCenterRectInRect(superviewBounds, newFrame);
		}
		
		return newFrame;
	}
	
	return CGRectZero;
}

- (void) resizeProportionally:(CGSize) maxSize
{
//	  [self setViewSizeToImageSize];
	CGRect newBounds = [self.image proportionalBoundsWithMaxSize:maxSize];
	self.newFrame = CGRectIntegral(GtRectSetSizeWithSize(self.frame, newBounds.size));
}

@end