//
//  NSView+FLCompatibility.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSView+FLCompatibility.h"

#if OSX
@implementation NSView (FLCompatibility)

- (void) setNeedsLayout {
    [self setNeedsDisplay:YES];
}

- (void) setNeedsDisplay {
    [self setNeedsDisplay:YES];
}

- (BOOL) userInteractionEnabled {
    return NO;
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

- (void) insertSubview:(NSView*) view belowSubview:(NSView*) subview {
}

- (void) insertSubview:(NSView*) view aboveSubview:(NSView*) subview {
}

- (void) bringSubviewToFront:(NSView*) view {
}


- (void)sendToBack {
    id superView = [self superview]; 
    if (superView) {
        FLAutoreleaseObject(FLRetain(self));
        [self removeFromSuperview];
        [superView addSubview:self positioned:NSWindowBelow relativeTo:nil];
    }
}


@end

#endif
