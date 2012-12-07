//
//  NSValue+CocoaCompatibility.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLGeometryCompatibility.h"

@interface NSValue (FLCompatibility)

+ (NSValue *)valueWithFLPoint:(CGPoint)point;
+ (NSValue *)valueWithFLSize:(FLSize)size;
+ (NSValue *)valueWithFLRect:(CGRect)rect;

- (CGPoint) FLPointValue;
- (FLSize) FLSizeValue;
- (CGRect) FLRectValue;

@end
