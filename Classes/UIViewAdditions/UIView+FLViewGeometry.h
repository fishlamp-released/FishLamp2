//
//	UIView+FLViewGeometry.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
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


@interface UIView (FLViewGeometry)

+ (id) viewWithFrame:(FLRect) frame;

- (void) moveBy:(FLPoint) delta;
- (void) moveBy:(CGFloat) x y:(CGFloat)y;
- (void) moveTo:(FLPoint) newOrigin;
- (void) moveTo:(CGFloat) left top:(CGFloat) top;

- (void) resize:(FLSize) newSize;

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
@property (readwrite, assign, nonatomic) FLRect frameOptimizedForLocation;
@property (readwrite, assign, nonatomic) FLRect frameOptimizedForSize;

// only sets it if it changed. returns frame
@property (readwrite, assign, nonatomic) FLRect newFrame; 
- (BOOL) setFrameIfChanged:(FLRect) newFrame;
- (BOOL) setBoundsIfChanged:(FLRect) newBounds;

- (BOOL) setViewSizeToFitInSuperview:(BOOL) centerInSuperview;
- (FLRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview; 
- (FLSize) sizeThatFitsInSuperview;

- (BOOL) setViewSizeToContentSize; // does nothing by default, up to subclasses or categories to implement 

#if DEBUG
+ (void) warnIfNonIntegralFramesInViewHierarchy:(UIView*) view;

/// @brief a useful property for debugging views
/// sets/gets the background color for debugging, but is an error in release code and makes it easy to remove
/// debugging code later.
@property (readwrite, strong, nonatomic) UIColor* debugBackgroundColor;
#endif

@end

