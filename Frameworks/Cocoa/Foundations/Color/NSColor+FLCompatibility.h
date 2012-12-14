//
//  NSColor+FLCompatibility.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import "FLCocoa.h"

@interface NSColor (FLCompatibility)
+ (NSColor*) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
@end

#endif

