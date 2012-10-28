//
//  NSValue+CocoaCompatibility.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSValue+FLCocoaCompatibility.h"

@implementation NSValue (FLCompatibility)

#if IOS
+ (NSValue *)valueWithFLPoint:(FLPoint)point {
    return [NSValue valueWithCGPoint:point];
}
+ (NSValue *)valueWithFLSize:(FLSize)size {
    return [NSValue valueWithCGSize:size];
}
+ (NSValue *)valueWithFLRect:(FLRect)rect {
    return [NSValue valueWithCGRect:rect];
}
- (FLPoint)FLPointValue {
    return self.CGPointValue;
}
- (FLSize)FLSizeValue {
    return self.CGSizeValue;
}
- (FLRect)FLRectValue {
    return self.CGRectValue;
}

#else

+ (NSValue *)valueWithFLPoint:(FLPoint)point {
    return [NSValue valueWithPoint:point];
}
+ (NSValue *)valueWithFLSize:(FLSize)size {
    return [NSValue valueWithSize:size];
}
+ (NSValue *)valueWithFLRect:(FLRect)rect {
    return [NSValue valueWithRect:rect];
}
- (FLPoint)FLPointValue {
    return self.pointValue;
}
- (FLSize)FLSizeValue {
    return self.sizeValue;
}
- (FLRect)FLRectValue {
    return self.rectValue;
}

#endif

@end
