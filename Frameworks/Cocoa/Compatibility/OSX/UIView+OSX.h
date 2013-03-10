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
#define FLCompatibleView NSView

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

@interface NSView (UIKit)
@property (readwrite, strong, nonatomic) UIColor* backgroundColor;
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;

- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
- (void) setNeedsDisplay;   // calls setNeedsDisplay:YES
- (void) layoutIfNeeded;

- (void) insertSubview:(UIView*) view belowSubview:(UIView*) subview;
- (void) insertSubview:(UIView*) view aboveSubview:(UIView*) subview;
- (void) insertSubview:(UIView*) view atIndex:(NSUInteger) atIndex;

- (void) bringSubviewToFront:(UIView*) view;
- (void) sendToBack;
- (void) bringToFront;

- (void) layoutSubviews;
@end


//@interface UIView : UIView {
//@private
//    NSColor* _backgroundColor;
//}
//@property (readwrite, strong, nonatomic) NSColor* backgroundColor;
//@property (readwrite, assign, nonatomic) CGFloat alpha;
//@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;
//
//- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
//- (void) setNeedsDisplay;   // calls setNeedsDisplay:YES
//- (void) layoutIfNeeded;
//
//- (void) insertSubview:(UIView*) view belowSubview:(UIView*) subview;
//- (void) insertSubview:(UIView*) view aboveSubview:(UIView*) subview;
//- (void) insertSubview:(UIView*) view atIndex:(NSUInteger) atIndex;
//
//- (void) bringSubviewToFront:(UIView*) view;
//- (void) sendToBack;
//
//- (void) layoutSubviews;
//
//- (UIView*) superview;
//
//@end
#endif

