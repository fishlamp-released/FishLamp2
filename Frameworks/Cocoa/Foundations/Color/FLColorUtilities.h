//
//  FLColorUtilities.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "UIColor+FLUtils.h"
#import "UIColor+FLMoreColors.h"

@class UIColor;

NS_INLINE
BOOL FLColorValueIsDecimal(CGFloat value) {
    return value >= 0.0f && value <= 1.0f;
}

NS_INLINE
BOOL FLColorValueIsRGB(CGFloat value) {
    return value >= 1.0f && value <= 255.0f;
}

#define FLAssertColorValueIsRGB(__VALUE__) \
            FLAssert_v(FLColorValueIsRGB(__VALUE__), @"%f should be between 1 and 255", __VALUE__)

#define FLAssertColorValueIsDecimal(__VALUE__) \
            FLAssert_v(FLColorValueIsDecimal(__VALUE__), @"%f should be between 0.0 and 1.0", __VALUE__)



#define FLDecimalColorToRgbColor(__DECIMAL__)   (__DECIMAL__ * 255.0f)

#define FLRgbColorToDecimalColor(__RGB__)       (__RGB__ / 255.0f)


#define FLColorCreateWithRGBColorValues(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
            [UIColor colorWithRed:FLRgbColorToDecimalColor(__RED__) \
                            green:FLRgbColorToDecimalColor(__GREEN__) \
                             blue:FLRgbColorToDecimalColor(__BLUE__) \
                            alpha:__ALPHA__]

#define FLColorCreateWithDecimalColorValues(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
            [UIColor colorWithRed:__RED__ \
                            green:__GREEN__ \
                             blue:__BLUE__ \
                            alpha:__ALPHA__]


#define FLReturnColorWithRGBRed(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
            FLReturnStaticObject(FLRetain(FLColorCreateWithRGBColorValues(__RED__, __GREEN__,__BLUE__, __ALPHA__)))

#define FLReturnColorWithDecimalRed(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
            FLReturnStaticObject(FLRetain(FLColorCreateWithDecimalColorValues(__RED__, __GREEN__,__BLUE__, __ALPHA__)))

// #112233
// rgb(10,11,12)
// rgb(10,11,12, 0.5);
extern UIColor*  FLColorFromRGBString(NSString* string);
extern NSString* FLRgbStringFromColor(UIColor* color); //rgb(11,11,11,0.5)

extern NSString* FLCssColorStringFromColor(UIColor* color); // #AABBCC
extern UIColor* FLColorFromCssColorString(NSString* string);

extern NSString* FLHexColorStringFromColor(UIColor* color); // AABBCC