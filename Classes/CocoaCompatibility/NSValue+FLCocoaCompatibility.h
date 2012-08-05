//
//  NSValue+CocoaCompatibility.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLCocoaCompatibility.h"

@interface NSValue (FLCompatibility)

+ (NSValue *)valueWithFLPoint:(FLPoint)point;
+ (NSValue *)valueWithFLSize:(FLSize)size;
+ (NSValue *)valueWithFLRect:(FLRect)rect;

- (FLPoint) FLPointValue;
- (FLSize) FLSizeValue;
- (FLRect) FLRectValue;

@end
