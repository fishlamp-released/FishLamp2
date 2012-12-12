//
//  NSValue+CocoaCompatibility.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSValue+FLCompatibility.h"

#if OSX
@implementation NSValue (FLCompatibility)

+ (NSValue *)valueWithCGPoint:(CGPoint)point {
    return [NSValue valueWithPoint:point];
}
+ (NSValue *)valueWithCGSize:(CGSize)size {
    return [NSValue valueWithSize:size];
}
+ (NSValue *)valueWithCGRect:(CGRect)rect {
    return [NSValue valueWithRect:rect];
}
- (CGPoint)CGPointValue {
    return self.pointValue;
}
- (CGSize)CGSizeValue {
    return self.sizeValue;
}
- (CGRect)CGRectValue {
    return self.rectValue;
}
@end
#endif
