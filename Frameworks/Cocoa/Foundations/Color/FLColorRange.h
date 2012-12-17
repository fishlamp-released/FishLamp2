// [Generated]
//
// FLColorRange.h
// Project: FishLamp Themes
// Schema: FLColorObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]
#import "FLCocoaRequired.h"
#import "FLColorRangeColorValues.h"

@interface FLColorRange : NSObject { 
@private
	UIColor* _startColor;
	UIColor* _endColor;
	CGFloat _alpha;
} 

@property (readonly, assign, nonatomic) CGFloat alpha;

@property (readonly, strong, nonatomic) UIColor* endColor;

@property (readonly, strong, nonatomic) UIColor* startColor;

@property (readonly, assign, nonatomic) FLColorRangeColorValues rgbColorRangeValues;

@property (readonly, assign, nonatomic) FLColorRangeColorValues decimalColorRangeValues;

- (id) initWithStartColor:(UIColor*) startColor
                 endColor:(UIColor*) endColor;

+ (FLColorRange*) colorRange:(UIColor*) startColor
                    endColor:(UIColor*) endColor;

- (id) initWithColorValues:(FLColorRangeColorValues) colorValues;

+ (id) colorRangeWithColorValues:(FLColorRangeColorValues) colorValues;


@end






