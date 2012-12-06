//
//  NSValue+CocoaCompatibility.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "SDKValue.h"

@implementation NSValue (SDKCompatibility)

#if IOS
+ (NSValue *)valueWithSDKPoint:(SDKPoint)point {
    return [NSValue valueWithCGPoint:point];
}
+ (NSValue *)valueWithSDKSize:(SDKSize)size {
    return [NSValue valueWithCGSize:size];
}
+ (NSValue *)valueWithSDKRect:(SDKRect)rect {
    return [NSValue valueWithCGRect:rect];
}
- (SDKPoint)SDKPointValue {
    return self.CGPointValue;
}
- (SDKSize)SDKSizeValue {
    return self.CGSizeValue;
}
- (SDKRect)SDKRectValue {
    return self.CGRectValue;
}
#endif

#if OSX
+ (NSValue *)valueWithSDKPoint:(SDKPoint)point {
    return [NSValue valueWithPoint:point];
}
+ (NSValue *)valueWithSDKSize:(SDKSize)size {
    return [NSValue valueWithSize:size];
}
+ (NSValue *)valueWithSDKRect:(SDKRect)rect {
    return [NSValue valueWithRect:rect];
}
- (SDKPoint)SDKPointValue {
    return self.pointValue;
}
- (SDKSize)SDKSizeValue {
    return self.sizeValue;
}
- (SDKRect)SDKRectValue {
    return self.rectValue;
}

#endif

@end
