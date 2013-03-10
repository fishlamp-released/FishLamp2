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
FLSynthesizeAssociatedProperty(assign_nonatomic, needsLayoutNumber, setNeedsLayoutNumber, NSNumber*)

//@synthesize backgroundColor = _backgroundColor;

//- (void)drawRect:(NSRect)dirtyRect {
//    // set any NSColor for filling, say white:
//    UIColor* bgColor = self.backgroundColor;
//    if(bgColor) {
//        [bgColor setFill];
//        NSRectFill(dirtyRect);
//    }
//}

//- (void) setNeedsLayout {
//    [self setNeedsDisplay:YES];
//}

- (void) setNeedsDisplay {
    [self setNeedsDisplay:YES];
}

- (BOOL) userInteractionEnabled {
    return NO;
}

- (void) layoutIfNeeded {
    if(self.needsLayoutNumber) {
        self.needsLayoutNumber = nil;
        
        UIViewController* controller = self.viewController;
        if(controller) {
            [controller viewWillLayoutSubviews];
        }
        [self layoutSubviews];
        if(controller) {
            [controller viewDidLayoutSubviews];
        }
    }
}

- (void) setNeedsLayout {
    static NSNumber* s_needsLayout = nil;
    if(!s_needsLayout) {
        s_needsLayout = [[NSNumber alloc] initWithBool:YES];
    }

    self.needsLayoutNumber = s_needsLayout;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
    });

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

- (void) insertSubview:(UIView*) view 
          belowSubview:(UIView*) subview {
    [self addSubview:view positioned:NSWindowBelow relativeTo:subview];
}

- (void) insertSubview:(UIView*) view 
          aboveSubview:(UIView*) subview {
    [self addSubview:view positioned:NSWindowAbove relativeTo:subview];
}

- (void) insertSubview:(UIView*) view 
               atIndex:(NSUInteger) atIndex {

    [self addSubview:view positioned:NSWindowAbove relativeTo:[self.subviews objectAtIndex:atIndex]];
}

- (void) bringSubviewToFront:(UIView*) view {
    id superView = [self superview]; 
    if (superView) {
        FLAutoreleaseObject(FLRetain(self));
        [self removeFromSuperview];
        [superView addSubview:self];
    }
}

- (void) bringToFront {
    [self.superview bringSubviewToFront:self];
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
    for(NSView* view in self.subviews) {
        [view layoutSubviews];
    }
}

- (void) setUIViewCompatibilityMode {

}

@end

//@implementation FLCompatibleView 
//
//@end

#endif


