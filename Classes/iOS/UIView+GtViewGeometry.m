//
//	UIView+GtViewGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIView+GtViewGeometry.h"

@implementation UIView (GtViewGeometry)




- (void) moveBy:(CGPoint) delta
{
	if(delta.x != 0 || delta.y != 0)
	{
		CGRect frame = self.frame;
		frame.origin.x += delta.x;
		frame.origin.y += delta.y;
		self.frame = frame;
	}
}

- (void) moveBy:(CGFloat) x y:(CGFloat)y
{
	if(x != 0 || y != 0)
	{
		CGRect frame = self.frame;
		frame.origin.x += x;
		frame.origin.y += y;
		self.newFrame = frame;
	}
}

- (void) resize:(CGSize) newSize
{
	self.newFrame = GtRectSetSizeWithSize(self.frame, newSize);
}

- (void) moveTo:(CGPoint) newOrigin
{
	self.newFrame = GtRectSetOrigin(self.frame, newOrigin.x, newOrigin.y);
}

- (void) moveTo:(CGFloat) left top:(CGFloat) top
{
	self.newFrame = GtRectSetOrigin(self.frame, left, top);
}

#if DEBUG
+ (void) warnIfNonIntegralFramesInViewHierarchy:(UIView*) view
{
	while(view)
	{
		if(!GtRectIsIntegral(view.frame))
		{
			GtLog(@"Warning a view of type '%@' has non-integral frame: %@", 
				NSStringFromClass([view class]),
				NSStringFromCGRect(view.frame));
		}		 
		view = view.superview;
	}
}

#endif

- (CGRect) frameOptimizedForLocation
{
	return GtRectMoveRectToOptimizedLocationIfNeeded(self.frame);
}

- (void) setFrameOptimizedForLocation:(CGRect) frame
{
	self.newFrame = GtRectMoveRectToOptimizedLocationIfNeeded(frame);
}

- (CGRect) frameOptimizedForSize
{
	return GtRectGrowRectToOptimizedSizeIfNeeded(self.frame);
}

- (void) setFrameOptimizedForSize:(CGRect) frame
{
	self.newFrame = GtRectGrowRectToOptimizedSizeIfNeeded(frame);
}

- (BOOL) isFrameOptimized
{
	return GtRectIsOptimizedForView(self.frame);
}

- (CGRect) newFrame
{
	return self.frame;
}

- (void) setNewFrame:(CGRect) newFrame
{
#if DEBUG
	if(!GtRectIsIntegral(newFrame))
	{
		GtLog(@"Warning setting non-integral rect in view: %@", NSStringFromCGRect(newFrame));
	}
#endif	  

	if(!CGRectEqualToRect(newFrame, self.frame))
	{
		self.frame = newFrame;
	}
	
#if DEBUG
	[UIView warnIfNonIntegralFramesInViewHierarchy:self];
#endif
	
	
}

- (BOOL) setFrameIfChanged:(CGRect) newFrame
{
	if(!CGRectEqualToRect(newFrame, self.frame))
	{
		self.frame = newFrame;
		return YES;
	}
	
	return NO;
}

- (BOOL) setBoundsIfChanged:(CGRect) newBounds
{
	if(!CGRectEqualToRect(newBounds, self.bounds))
	{
		self.bounds = newBounds;
		return YES;
	}
	
	return NO;
}
#if DEBUG
//- (NSMutableString*) debugDescription
//{	  
//	  NSMutableString* str = [super debugDescription];
//	  [str appendFormat:@"\nview bounds: %@\nview frame: %@\nsuperview bounds: %@", 
//			  NSStringFromCGRect(self.bounds), 
//			  NSStringFromCGRect(self.frame), 
//			  NSStringFromCGRect(self.superview.bounds)];
//	  return str;
//}
#endif

- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview
{
	return self.superview ? self.superview.bounds : CGRectZero;
}

- (CGSize) sizeThatFitsInSuperview
{
	return self.superview ? [self frameSizedToFitInSuperview:NO].size : CGSizeZero;
}

- (BOOL) setViewSizeToFitInSuperview:(BOOL) centerInSuperview
{
	if(self.superview)
	{
		return [self setFrameIfChanged:[self frameSizedToFitInSuperview:centerInSuperview]];
	}
	
	return NO;
}

- (BOOL) setViewSizeToContentSize
{
	return NO;
}

@end
