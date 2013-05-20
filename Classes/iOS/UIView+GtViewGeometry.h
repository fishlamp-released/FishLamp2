//
//	UIView+GtViewGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define UIViewAutoresizingFlexibleEverything	UIViewAutoresizingFlexibleLeftMargin | \
												UIViewAutoresizingFlexibleWidth | \
												UIViewAutoresizingFlexibleRightMargin | \
												UIViewAutoresizingFlexibleTopMargin | \
												UIViewAutoresizingFlexibleHeight | \
												UIViewAutoresizingFlexibleBottomMargin

#define UIViewAutoresizingPositioned			UIViewAutoresizingFlexibleLeftMargin | \
												UIViewAutoresizingFlexibleRightMargin | \
												UIViewAutoresizingFlexibleTopMargin | \
												UIViewAutoresizingFlexibleBottomMargin


@interface UIView (GtViewGeometry)
- (void) moveBy:(CGPoint) delta;
- (void) moveBy:(CGFloat) x y:(CGFloat)y;
- (void) moveTo:(CGPoint) newOrigin;
- (void) moveTo:(CGFloat) left top:(CGFloat) top;

- (void) resize:(CGSize) newSize;

/* 
	Regarding optimizeFrame

	There are two issues here:
	1.	you don't want your origin on a subpixel boundary, e.g. frame.origin.x = 10.5. You want it
		on integral bounderies, e.g. 10.0. Images and Text will render "fuzzy" if you do.
	2.	you don't want the center point of the view to be on a subpixel, which means the width an 
		height need to be evenly divisible by 2. Note that I opted to grow the frame by 1 pixel
		so that finely sized views aren't clipped (like text with decenders).
*/ 


@property (readonly, assign, nonatomic) BOOL isFrameOptimized;
@property (readwrite, assign, nonatomic) CGRect frameOptimizedForLocation;
@property (readwrite, assign, nonatomic) CGRect frameOptimizedForSize;

// only sets it if it changed. returns frame
@property (readwrite, assign, nonatomic) CGRect newFrame; 
- (BOOL) setFrameIfChanged:(CGRect) newFrame;
- (BOOL) setBoundsIfChanged:(CGRect) newBounds;

- (BOOL) setViewSizeToFitInSuperview:(BOOL) centerInSuperview;
- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview; 
- (CGSize) sizeThatFitsInSuperview;

- (BOOL) setViewSizeToContentSize; // does nothing by default, up to subclasses or categories to implement 

#if DEBUG
+ (void) warnIfNonIntegralFramesInViewHierarchy:(UIView*) view;
#endif

@end