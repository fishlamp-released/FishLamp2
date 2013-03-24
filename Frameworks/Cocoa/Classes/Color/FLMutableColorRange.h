//
//  FLMutableColorRange.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColorRange.h"

@interface FLMutableColorRange : FLColorRange {
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

@property (readwrite, strong, nonatomic) SDKColor* endColor;

@property (readwrite, strong, nonatomic) SDKColor* startColor;

- (void) setColorValues:(FLColorRangeColorValues) values;

@end

