//
//  NSValue+CocoaCompatibility.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSValue+FLCompatibility.h"

@implementation NSValue (FLCompatibility)

#if IOS
+ (NSValue *)valueWithFLPoint:(CGPoint)point {
    return [NSValue valueWithCGPoint:point];
}
+ (NSValue *)valueWithFLSize:(FLSize)size {
    return [NSValue valueWithCGSize:size];
}
+ (NSValue *)valueWithFLRect:(CGRect)rect {
    return [NSValue valueWithCGRect:rect];
}
- (CGPoint)FLPointValue {
    return self.CGPointValue;
}
- (FLSize)FLSizeValue {
    return self.CGSizeValue;
}
- (CGRect)FLRectValue {
    return self.CGRectValue;
}
#endif

#if OSX
+ (NSValue *)valueWithFLPoint:(CGPoint)point {
    return [NSValue valueWithPoint:point];
}
+ (NSValue *)valueWithFLSize:(FLSize)size {
    return [NSValue valueWithSize:size];
}
+ (NSValue *)valueWithFLRect:(CGRect)rect {
    return [NSValue valueWithRect:rect];
}
- (CGPoint)FLPointValue {
    return self.pointValue;
}
- (FLSize)FLSizeValue {
    return self.sizeValue;
}
- (CGRect)FLRectValue {
    return self.rectValue;
}

#endif

@end
