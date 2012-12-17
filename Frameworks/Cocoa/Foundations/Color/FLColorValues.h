//
//  FLColorUtils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLColorUtilities.h"

typedef struct {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
    BOOL valuesAreRGB;
} FLColorValues;

@interface UIColor (FLColorValues)
@property (readonly, assign, nonatomic) FLColorValues rgbColorValues;
@property (readonly, assign, nonatomic) FLColorValues decimalColorValues;
+ (UIColor*) colorWithColorValues:(FLColorValues) value;
@end

#if DEBUG
    NS_INLINE
    FLColorValues FLAssertColorValuesAreRGB(FLColorValues values) {
        FLAssertColorValueIsRGB(values.red);
        FLAssertColorValueIsRGB(values.green);
        FLAssertColorValueIsRGB(values.blue);
        FLAssert_(values.valuesAreRGB);
        return values;
    }

    NS_INLINE
    FLColorValues FLAssertColorValuesAreDecimal(FLColorValues values) {
        FLAssertColorValueIsDecimal(values.red)
        FLAssertColorValueIsDecimal(values.green)
        FLAssertColorValueIsDecimal(values.blue)
        FLAssert_(!values.valuesAreRGB);
        return values;
    }
#else 
    #define FLAssertColorValuesAreRGB(__VALUES__) __VALUES__
    #define FLAssertColorValuesAreDecimal(__VALUES__) __VALUES__
#endif

NS_INLINE
FLColorValues FLColorValuesMakeRGB(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
	FLColorValues color = { red, green, blue, alpha, YES };
	return	FLAssertColorValuesAreRGB(color);
}

NS_INLINE
FLColorValues FLColorValuesMakeDecimal(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
	FLColorValues color = { red, green, blue, alpha, NO };
	return	FLAssertColorValuesAreDecimal(color);
}

NS_INLINE
FLColorValues FLColorValuesRgbToDecimal(FLColorValues values) {
    if(values.valuesAreRGB) {
        values.red = FLRgbColorToDecimalColor(values.red);
        values.green = FLRgbColorToDecimalColor(values.green);
        values.blue = FLRgbColorToDecimalColor(values.blue);
        values.valuesAreRGB = NO;
    }
    return FLAssertColorValuesAreDecimal(values);
}

NS_INLINE
FLColorValues FLColorValuesDecimalToRgb(FLColorValues values) {
    if(!values.valuesAreRGB) {
        values.red = FLRgbColorToDecimalColor(values.red);
        values.green = FLRgbColorToDecimalColor(values.green);
        values.blue = FLRgbColorToDecimalColor(values.blue);
        values.valuesAreRGB = YES;
    }
    return FLAssertColorValuesAreRGB(values);
}

extern
FLColorValues FLColorValuesDarken(FLColorValues values, CGFloat byPercent);

extern
FLColorValues FLColorValuesLighten(FLColorValues values, CGFloat byPercent);
