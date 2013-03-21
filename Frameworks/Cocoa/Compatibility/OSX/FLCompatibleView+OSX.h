//
//  FLView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

#import "UIColor+OSX.h"
#define UIView NSView
#define SDKView NSView

#if REFACTOR
// temp
typedef enum {
    UIViewContentModeScaleToFill,
    UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
    UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
    UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
    UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
    UIViewContentModeTop,
    UIViewContentModeBottom,
    UIViewContentModeLeft,
    UIViewContentModeRight,
    UIViewContentModeTopLeft,
    UIViewContentModeTopRight,
    UIViewContentModeBottomLeft,
    UIViewContentModeBottomRight,
} UIViewContentMode;

typedef NSUInteger UIViewAnimationOptions;
#endif

@interface FLCompatibleView : NSView {
@private
    NSColor* _backgroundColor;
    BOOL _needsLayout;
}


// note this sets the color in the layer (if there is one)
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic) CGFloat alpha;

- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
- (void) layoutIfNeeded;
@end

@interface NSView (FLCompatibleView)
- (void) setNeedsDisplay; // setNeedsDisplay:YES

// note that view layer doesn't work for POOPY in OSX because
// when a view becomes the responder it moves forward (I think)
- (void) bringSubviewToFront:(NSView*) view;
- (void) bringToFront;
- (void) sendToBack;
- (void) insertSubview:(NSView*) view belowSubview:(NSView*) subview;
- (void) insertSubview:(NSView*) view aboveSubview:(NSView*) subview;
- (void) insertSubview:(NSView*) view atIndex:(NSUInteger) atIndex;

- (void) layoutSubviews;
@end

#endif

