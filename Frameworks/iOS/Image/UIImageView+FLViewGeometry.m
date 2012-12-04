//
//	UIImageView+FLViewGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "UIImageView+FLViewGeometry.h"
#import "FLImage+Resize.h"

@implementation UIImageView (FLViewGeometry)

- (BOOL) resizeToImageSize
{
	return [self setFrameIfChanged:FLRectSetSizeWithSize(self.frame, self.image.size)];
}

- (FLRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview
{
	UIImage* image = self.image;
	if(image && self.superview)
	{
		FLRect superviewBounds = self.superview.bounds;
		FLRect newFrame = FLRectFitInRectInRectProportionally(
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

- (void) resizeProportionally:(FLSize) maxSize
{
//	  [self setViewSizeToImageSize];
	FLRect newBounds = [self.image proportionalBoundsWithMaxSize:maxSize];
	self.newFrame = CGRectIntegral(FLRectSetSizeWithSize(self.frame, newBounds.size));
}

@end