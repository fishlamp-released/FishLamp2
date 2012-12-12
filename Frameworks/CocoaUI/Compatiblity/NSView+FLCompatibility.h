//
//  NSView+FLCompatibility.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#if OSX
@interface NSView (FLCompatibility)
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;
- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
- (void) setNeedsDisplay;   // calls setNeedsDisplay:YES
- (void) layoutIfNeeded;

- (BOOL) setFrameIfChanged:(CGRect) newFrame;
@property (readwrite, assign, nonatomic) CGRect newFrame;
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;
@property (readwrite, assign, nonatomic) CGFloat alpha;

- (void) insertSubview:(NSView*) view belowSubview:(NSView*) view;
- (void) insertSubview:(NSView*) view aboveSubview:(NSView*) view;
@end
#endif
