//
//  NSValue+CocoaCompatibility.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "SDKPoint.h"
#import "SDKSize.h"
#import "SDKRect.h"

@interface NSValue (SDKCompatibility)

+ (NSValue *)valueWithSDKPoint:(SDKPoint)point;
+ (NSValue *)valueWithSDKSize:(SDKSize)size;
+ (NSValue *)valueWithSDKRect:(SDKRect)rect;

- (SDKPoint) SDKPointValue;
- (SDKSize) SDKSizeValue;
- (SDKRect) SDKRectValue;

@end
