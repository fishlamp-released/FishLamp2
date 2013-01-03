// [Generated]
//
// FLColorRange.m
// Project: FishLamp Themes
// Schema: FLColorObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLColorRange.h"
#import "UIColor+FLMoreColors.h"

@interface FLColorRange ()
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, strong, nonatomic) UIColor* endColor;
@property (readwrite, strong, nonatomic) UIColor* startColor;
@end

@implementation FLColorRange

@synthesize alpha = _alpha;
@synthesize endColor = _endColor;
@synthesize startColor = _startColor;

- (id) initWithStartColor:(UIColor*) startColor
                 endColor:(UIColor*) endColor
{
    self = [super init];
    if(self) {
        self.startColor = startColor;
        self.endColor = endColor;
    }
    
    return self;
}

+ (FLColorRange*) colorRange:(UIColor*) startColor
                    endColor:(UIColor*) endColor {
    return FLAutorelease([[[self class] alloc] initWithStartColor:startColor endColor:endColor]);
}

#if FL_MRC
- (void) dealloc
{
	FLRelease(_startColor);
	FLRelease(_endColor);
	FLSuperDealloc();
}
#endif

- (id) init {
	if((self = [self initWithStartColor:nil endColor:nil])) {
	}
	return self;
}

- (FLColorRangeColorValues) decimalColorRangeValues {
    return FLColorRangeMakeDecimal(self.startColor.rgbColorValues, self.endColor.rgbColorValues);
}

- (FLColorRangeColorValues) rgbColorRangeValues {
    return FLColorRangeMakeRGB(self.startColor.rgbColorValues, self.endColor.rgbColorValues);
}


- (id) initWithColorValues:(FLColorRangeColorValues) colorValues {
    return [self initWithStartColor:[UIColor colorWithColorValues:colorValues.startColor]
                           endColor:[UIColor colorWithColorValues:colorValues.endColor]];
}

+ (id) colorRangeWithColorValues:(FLColorRangeColorValues) colorValues {
    return FLAutorelease([[[self class] alloc] initWithColorValues:colorValues]);
}


@end




