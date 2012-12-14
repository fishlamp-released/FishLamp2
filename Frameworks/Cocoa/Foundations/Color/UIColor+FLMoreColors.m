//
//  UIColor+Colors.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLColorUtilities.h"
#import "UIColor+FLMoreColors.h"

@implementation UIColor (FLMoreColors)

+ (UIColor*) iPhoneBlueColor
{
	//	return [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
	
	FLReturnColorWithRGBRed(36,99,222, 1.0); // 0.035294117647059, 0.388235294117647, 0.870588235294118
}

+ (UIColor*) standardLabelColor
{
	return [UIColor blackColor];
}

+ (UIColor*) standardTextFieldColor
{
	return [UIColor blueLabelColor];
}	

+ (UIColor*) disabledControlColor
{
	return [UIColor lightGrayColor];
}

+ (UIColor*)indigoColor
{
	FLReturnColorWithDecimalRed(.294f, 0.0f, .509f, 1.0);
}

+ (UIColor*)tealColor
{
	FLReturnColorWithDecimalRed(0.0f, 0.5f, 0.5f, 1.0);
}

+ (UIColor*)violetColor
{
	FLReturnColorWithDecimalRed (.498f, 0.0f, 1.0f, 1.0); 
}

+ (UIColor*)electricVioletColor
{
	FLReturnColorWithDecimalRed(.506f, 0.0f, 1.0f, 1.0);
}

+ (UIColor*)vividVioletColor
{
	FLReturnColorWithDecimalRed(.506f, 0.0f, 1.0f, 1.0);
}

+ (UIColor*)darkVioletColor
{
	FLReturnColorWithDecimalRed(.58f, 0.0f, .827f, 1.0);
}

+ (UIColor*)amberColor
{
	FLReturnColorWithDecimalRed(1.0f, .75f, 0.0f, 1.0);
}

+ (UIColor*)darkAmberColor
{
	FLReturnColorWithDecimalRed(1.0f, .494f, 0.0f, 1.0);
}

+ (UIColor*)lemonColor
{
	FLReturnColorWithDecimalRed(1.0f, .914f, .0627f, 1.0);
}

+ (UIColor*) paleYellowColor
{
	FLReturnColorWithDecimalRed(1.0f, .914f, .0627f, 1.0);
}

+ (UIColor*)roseColor
{
	FLReturnColorWithDecimalRed(1.0f, 0.0f, 0.5f, 1.0);
}

+ (UIColor*)rubyColor
{
	FLReturnColorWithDecimalRed(0.8784f, .06667f, .3725f, 1.0);
}

+ (UIColor*)fireEngineRed
{
	FLReturnColorWithDecimalRed(0.8078f, 0.0863f, 0.1255f, 1.0);
}

+ (UIColor*)darkBlueColor
{
	FLReturnColorWithDecimalRed(0.0f, 0.0f, 0.25f, 1.0);
}

+ (UIColor*) skyBlueColor
{
	FLReturnColorWithRGBRed(135,206,235, 1.0);
}

+ (UIColor*) lightSkyBlueColor
{
	FLReturnColorWithRGBRed(135,206,250, 1.0);
}
+ (UIColor*) lightBlueColor
{
	FLReturnColorWithRGBRed(173,206,230, 1.0);
}

+ (UIColor*) darkGreenColor
{
	FLReturnColorWithRGBRed(0x2f, 0x4f, 0x2f, 1.0);
}

+ (UIColor*) blueLabelColor
{
	FLReturnColorWithRGBRed(50.0,79.0,133.0, 1.0);
}

+ (UIColor*) silverColor
{
	FLReturnColorWithRGBRed(192,192,192, 1.0);
}

+ (UIColor*) gray10Color
{
    FLReturnColorWithDecimalRed(0.1f, 0.1f, 0.1f, 1.0);
}

+ (UIColor*)gray75Color
{
	FLReturnColorWithDecimalRed(0.75f, 0.75f, 0.75f, 1.0);
}

+ (UIColor*)gray85Color
{
	FLReturnColorWithDecimalRed(0.85f, 0.85f, 0.85f, 1.0);
}

+ (UIColor*)gray15Color
{
	FLReturnColorWithDecimalRed(0.15f, 0.15f, 0.15f, 1.0);
}

+ (UIColor*) gray95Color
{
	FLReturnColorWithDecimalRed(0.95f, 0.95f, 0.95f, 1.0);
}


+ (UIColor*) gray45Color
{
	FLReturnColorWithDecimalRed(0.45f, 0.45f, 0.45f, 1.0);
}

+ (UIColor*) gray25Color
{
	FLReturnColorWithDecimalRed(0.25f, 0.25f, 0.25f, 1.0);
}

+ (UIColor*) gray33Color
{
	return [UIColor darkGrayColor];
}

+ (UIColor*) gray66Color
{
	return [UIColor lightGrayColor];
}

+ (UIColor*) gray20Color
{
    FLReturnColorWithDecimalRed(0.2f, 0.2f, 0.2f, 1.0);
}

+ (UIColor*) gray50Color
{
	return [UIColor grayColor];
}

+ (UIColor*) lightBlueTintedGrayColor
{
	FLReturnColorWithRGBRed(80,80,83, 1.0);
}


+ (UIColor*) blueTintedGrayColor
{
	FLReturnColorWithRGBRed(69,69,71, 1.0);
}

+ (UIColor*) darkBlueTintedGrayColor
{
	FLReturnColorWithRGBRed(41,41,42, 1.0);
}

+ (UIColor*) darkDarkBlueTintedGrayColor
{
	FLReturnColorWithRGBRed(20,20,24, 1.0);
}


//+ (UIColor*) darkBlueTintedGrayColor
//{
//	FLReturnColorWithRGBRed(41,41,42, 1.0);
//}
//
//+ (UIColor*) mediumGrayColor
//{
//	FLReturnColorWithRGBRed(79,81,82, 1.0);
//}
//
//+ (UIColor*) blueTextColor
//{
//	FLReturnColorWithRGBRed(171,197,225, 1.0);
//}

+ (UIColor*) grayGlossyButtonColor
{
	FLReturnColorWithRGBRed(235, 235, 237, 1.0f);
}

+ (UIColor*) redGlossyButtonColor
{
	FLReturnColorWithRGBRed(160, 1, 20, 1.0f);
}

+ (UIColor*) greenGlossyButtonColor
{
	FLReturnColorWithRGBRed(24, 157, 22, 1.0f);
}

+ (UIColor*) yellowGlossyButtonColor
{
	FLReturnColorWithRGBRed(240, 191, 34, 1.0f);
}

+ (UIColor*) blackGlossyButtonColor
{
	return [UIColor gray10Color];
}


@end
