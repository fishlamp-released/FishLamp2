//
//  NSValue+CocoaCompatibility.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "UIKitRequired.h"

#if OSX

#import "UIGeometry.h"

@interface NSValue (UIKit)

+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGSize:(CGSize)size;
+ (NSValue *)valueWithCGRect:(CGRect)rect;
+ (NSValue *)valueWithUIEdgeInsets:(UIEdgeInsets)insets;

- (CGPoint) CGPointValue;
- (CGSize) CGSizeValue;
- (CGRect) CGRectValue;
- (UIEdgeInsets) UIEdgeInsetsValue;

@end

#endif
