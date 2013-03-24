//
//  FLMutableColorRange.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMutableColorRange.h"

@implementation FLMutableColorRange
@dynamic alpha;
@dynamic startColor;
@dynamic endColor;

+ (FLMutableColorRange*) colorRange {
	return FLAutorelease([[FLMutableColorRange alloc] init]);
}

- (void) setColorValues:(FLColorRangeColorValues) colorValues {
    self.startColor = [SDKColor colorWithColorValues:colorValues.startColor];
    self.endColor = [SDKColor colorWithColorValues:colorValues.endColor];
}

@end
