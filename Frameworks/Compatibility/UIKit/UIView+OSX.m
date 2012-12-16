//
//  FLView.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import "UIView+OSX.h"
#import "UIViewController+OSX.h"

@implementation NSView (UIKit)

FLSynthesizeAssociatedProperty(retain_nonatomic, backgroundColor, setBackgroundColor, UIColor*)
FLSynthesizeAssociatedProperty(assign_nonatomic, viewController, setViewController, UIViewController*)

//@synthesize backgroundColor = _backgroundColor;

//- (void)drawRect:(NSRect)dirtyRect {
//    // set any NSColor for filling, say white:
//    UIColor* bgColor = self.backgroundColor;
//    if(bgColor) {
//        [bgColor setFill];
//        NSRectFill(dirtyRect);
//    }
//}

- (void) setNeedsLayout {
    [self setNeedsDisplay:YES];
}

- (void) setNeedsDisplay {
    [self setNeedsDisplay:YES];
}

- (BOOL) userInteractionEnabled {
    return NO;
}

- (void) layoutIfNeeded {

}

- (void) setUserInteractionEnabled:(BOOL) enabled {
}

- (BOOL) setFrameIfChanged:(CGRect) newFrame {
	
    if(!CGRectEqualToRect(newFrame, self.frame)) {
		self.frame = newFrame;
		return YES;
	}
	
	return NO;
}

- (CGFloat) alpha {
    return self.alphaValue;
}

- (void) setAlpha:(CGFloat) alpha {
    self.alphaValue = alpha;
}

- (void) insertSubview:(UIView*) view belowSubview:(UIView*) subview {
}

- (void) insertSubview:(UIView*) view aboveSubview:(UIView*) subview {
}

- (void) insertSubview:(UIView*) view atIndex:(NSUInteger) atIndex {
}

- (void) bringSubviewToFront:(UIView*) view {
}

- (void)sendToBack {
    id superView = [self superview]; 
    if (superView) {
        FLAutoreleaseObject(FLRetain(self));
        [self removeFromSuperview];
        [superView addSubview:self positioned:NSWindowBelow relativeTo:nil];
    }
}

- (void) layoutSubviews {
}


@end
#endif


