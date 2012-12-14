//
//  FLColorUtilities.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@class UIColor;

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
            FLReturnStaticObject(FLColorCreateWithRGBColorValues(__RED__, __GREEN__,__BLUE__, __ALPHA__))

#define FLReturnColorWithDecimalRed(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
            FLReturnStaticObject(FLColorCreateWithDecimalColorValues(__RED__, __GREEN__,__BLUE__, __ALPHA__))

// #112233
// rgb(10,11,12)
// rgb(10,11,12, 0.5);
extern UIColor*  FLColorFromRGBString(NSString* string);
extern NSString* FLRgbStringFromColor(UIColor* color); //rgb(11,11,11,0.5)

extern NSString* FLCssColorStringFromColor(UIColor* color); // #AABBCC
extern UIColor* FLColorFromCssColorString(NSString* string);

extern NSString* FLHexColorStringFromColor(UIColor* color); // AABBCC