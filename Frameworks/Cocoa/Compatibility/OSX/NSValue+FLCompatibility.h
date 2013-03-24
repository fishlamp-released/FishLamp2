//
//  NSValue+CocoaCompatibility.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#if OSX
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import "FLCompatibleGeometry+OSX.h"

@interface NSValue (FLCompatibility)

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
