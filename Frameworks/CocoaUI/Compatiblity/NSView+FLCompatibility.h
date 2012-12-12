//
//  NSView+FLCompatibility.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import <Cocoa/Cocoa.h>

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

@interface NSView (FLCompatibility)

@property (readwrite, assign, nonatomic) CGRect newFrame;
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;

- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
- (void) setNeedsDisplay;   // calls setNeedsDisplay:YES
- (void) layoutIfNeeded;

- (BOOL) setFrameIfChanged:(CGRect) newFrame;

- (void) insertSubview:(NSView*) view belowSubview:(NSView*) subview;
- (void) insertSubview:(NSView*) view aboveSubview:(NSView*) subview;

- (void) bringSubviewToFront:(NSView*) view;
- (void) sendToBack;
@end


@interface NSTextField (FLCompatibility)
@property (readwrite, strong, nonatomic) NSString* text;
@end

#endif
