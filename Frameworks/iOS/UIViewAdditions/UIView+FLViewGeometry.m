//
//	UIView+FLViewGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "UIView+FLViewGeometry.h"

@implementation UIView (FLViewGeometry)

+ (id) viewWithFrame:(CGRect) frame {
    return FLAutorelease([[[self class] alloc] initWithFrame:frame]);
}

- (void) moveBy:(CGPoint) delta {
	if(delta.x != 0.0f || delta.y != 0.0f) {
		CGRect frame = self.frame;
		frame.origin.x += delta.x;
		frame.origin.y += delta.y;
		self.frame = frame;
	}
}

- (void) moveBy:(CGFloat) x y:(CGFloat)y {
	if(x != 0.0f || y != 0.0f) {
		CGRect frame = self.frame;
		frame.origin.x += x;
		frame.origin.y += y;
		self.newFrame = frame;
	}
}

- (void) resize:(FLSize) newSize {
	self.newFrame = FLRectSetSizeWithSize(self.frame, newSize);
}

- (void) moveTo:(CGPoint) newOrigin {
	self.newFrame = FLRectSetOrigin(self.frame, newOrigin.x, newOrigin.y);
}

- (void) moveTo:(CGFloat) left top:(CGFloat) top {
	self.newFrame = FLRectSetOrigin(self.frame, left, top);
}

#if DEBUG
+ (void) warnIfNonIntegralFramesInViewHierarchy:(UIView*) view {
	while(view) {
		if(!FLRectIsIntegral(view.frame)) {
			FLLog(@"Warning a view of type '%@' has non-integral frame: %@", 
				NSStringFromClass([view class]),
				NSStringFromCGRect(view.frame));
		}		 
		view = view.superview;
	}
}

- (UIColor*) debugBackgroundColor {
    return self.backgroundColor;
}

- (void) setDebugBackgroundColor:(UIColor*) color {
    self.backgroundColor = color;
}

#endif

- (CGRect) frameOptimizedForLocation {
	return FLRectOptimizedForViewLocation(self.frame);
}

- (void) setFrameOptimizedForLocation:(CGRect) frame {
	self.newFrame = FLRectOptimizedForViewLocation(frame);
}

- (CGRect) frameOptimizedForSize {
	return FLRectOptimizedForViewSize(self.frame);
}

- (void) setFrameOptimizedForSize:(CGRect) frame {
	self.newFrame = FLRectOptimizedForViewSize(frame);
}

- (BOOL) isFrameOptimized {
	return FLRectIsOptimizedForView(self.frame);
}

- (CGRect) newFrame {
	return self.frame;
}

- (void) setNewFrame:(CGRect) newFrame {
#if DEBUG
	if(!FLRectIsIntegral(newFrame)) {
		FLLog(@"Warning setting non-integral rect in view: %@", NSStringFromCGRect(newFrame));
	}
#endif	  

	if(!CGRectEqualToRect(newFrame, self.frame)) {
		self.frame = newFrame;
	}
	
#if DEBUG
	[UIView warnIfNonIntegralFramesInViewHierarchy:self];
#endif
}

- (BOOL) setFrameIfChanged:(CGRect) newFrame {
	
    if(!CGRectEqualToRect(newFrame, self.frame)) {
		self.frame = newFrame;
		return YES;
	}
	
	return NO;
}

- (BOOL) setBoundsIfChanged:(CGRect) newBounds {
	
    if(!CGRectEqualToRect(newBounds, self.bounds)) {
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

- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview {
	return self.superview ? self.superview.bounds : CGRectZero;
}

- (FLSize) sizeThatFitsInSuperview {
	return self.superview ? [self frameSizedToFitInSuperview:NO].size : CGSizeZero;
}

- (BOOL) setViewSizeToFitInSuperview:(BOOL) centerInSuperview {
	if(self.superview) {
		return [self setFrameIfChanged:[self frameSizedToFitInSuperview:centerInSuperview]];
	}
	
	return NO;
}

- (BOOL) setViewSizeToContentSize {
	return NO;
}

- (void) didApplyTheme {
    [self setNeedsLayout];
}

- (id) objectByMoniker:(id) aMoniker {
    id outObj = [self objectByMoniker:aMoniker];
    if(!outObj) {
        for(UIView* view in self.subviews) {
            outObj = [view objectByMoniker:aMoniker];
            if(outObj) {
                break;
            }
        }
    }

    return outObj;
}

@end
