//
//	UIImageView+FLViewGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import "UIImageView+FLViewGeometry.h"
#import "UIImage+Resize.h"

@implementation UIImageView (FLViewGeometry)

- (BOOL) resizeToImageSize {
	return FLViewSetFrame(self, FLRectSetSizeWithSize(self.frame, self.image.size));
}

- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview
{
	UIImage* image = self.image;
	if(image && self.superview)
	{
		CGRect superviewBounds = self.superview.bounds;
		CGRect newFrame = FLRectFitInRectInRectProportionally(
			FLRectMakeWithSize(superviewBounds.size), 
			FLRectMakeWithSize(image.size));
			
		if(centerInSuperview)
		{
			newFrame = FLRectCenterRectInRect(superviewBounds, newFrame);
		}
		
		return newFrame;
	}
	
	return CGRectZero;
}

- (void) resizeProportionally:(CGSize) maxSize
{
//	  [self setViewSizeToImageSize];
	CGRect newBounds = [self.image proportionalBoundsWithMaxSize:maxSize];
	FLViewSetFrame(self, CGRectIntegral(FLRectSetSizeWithSize(self.frame, newBounds.size)));
}

@end