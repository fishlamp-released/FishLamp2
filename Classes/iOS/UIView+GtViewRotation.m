//
//	UIView+GtViewRotation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIView+GtViewRotation.h"
#import "UIView+GtViewGeometry.h"
#import "GtOrientationUtilities.h"

@implementation UIView (GtViewRotation) 

- (BOOL) wantsRotationEvent
{
	return NO;
}

- (void) rotateByDegrees:(CGFloat) degrees 
	duration:(CGFloat) duration 
	rotations:(UInt32) rotations
	animationDelegate:(id) delegate
{
	CGFloat radians = GtDegreesToRadians(degrees);

	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.delegate = delegate;
	rotationAnimation.toValue = [NSNumber numberWithFloat: radians * rotations];
	//M_PI * 2.0 /* full rotation*/ * rotations	 ];
	rotationAnimation.duration = duration;
	rotationAnimation.cumulative = YES;
	rotationAnimation.repeatCount = 1.0; 
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

	[self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void) rotateViewToOrientation:(UIInterfaceOrientation) orientation
{
	CGRect bounds = self.bounds;
	CGRect newBounds = bounds;
	
	self.transform = CGAffineTransformMakeRotation(GtDegreesToRadians(UIDegreesFromInterfaceOrientation(orientation)));
	
	if(UIInterfaceOrientationIsLandscape(orientation))
	{
		newBounds.size.width = MAX(bounds.size.width, bounds.size.height);
		newBounds.size.height = MIN(bounds.size.width, bounds.size.height);
	}
	else
	{
		newBounds.size.width = MIN(bounds.size.width, bounds.size.height);
		newBounds.size.height = MAX(bounds.size.width, bounds.size.height);
	}

	[self setBoundsIfChanged:newBounds];
}

@end
