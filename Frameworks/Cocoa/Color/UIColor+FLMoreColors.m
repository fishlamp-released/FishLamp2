//
//  UIColor+Colors.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIColor+FLMoreColors.h"

@implementation UIColor (FLMoreColors)

+ (UIColor*) iPhoneBlueColor
{
	//	return [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
	
	FLReturnRGBColor(36,99,222, 1.0); // 0.035294117647059, 0.388235294117647, 0.870588235294118
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
	FLReturnColor(.294f, 0.0f, .509f, 1.0);
}

+ (UIColor*)tealColor
{
	FLReturnColor(0.0f, 0.5f, 0.5f, 1.0);
}

+ (UIColor*)violetColor
{
	FLReturnColor (.498f, 0.0f, 1.0f, 1.0); 
}

+ (UIColor*)electricVioletColor
{
	FLReturnColor(.506f, 0.0f, 1.0f, 1.0);
}

+ (UIColor*)vividVioletColor
{
	FLReturnColor(.506f, 0.0f, 1.0f, 1.0);
}

+ (UIColor*)darkVioletColor
{
	FLReturnColor(.58f, 0.0f, .827f, 1.0);
}

+ (UIColor*)amberColor
{
	FLReturnColor(1.0f, .75f, 0.0f, 1.0);
}

+ (UIColor*)darkAmberColor
{
	FLReturnColor(1.0f, .494f, 0.0f, 1.0);
}

+ (UIColor*)lemonColor
{
	FLReturnColor(1.0f, .914f, .0627f, 1.0);
}

+ (UIColor*) paleYellowColor
{
	FLReturnColor(1.0f, .914f, .0627f, 1.0);
}

+ (UIColor*)roseColor
{
	FLReturnColor(1.0f, 0.0f, 0.5f, 1.0);
}

+ (UIColor*)rubyColor
{
	FLReturnColor(0.8784f, .06667f, .3725f, 1.0);
}

+ (UIColor*)fireEngineRed
{
	FLReturnColor(0.8078f, 0.0863f, 0.1255f, 1.0);
}

+ (UIColor*)darkBlueColor
{
	FLReturnColor(0.0f, 0.0f, 0.25f, 1.0);
}

+ (UIColor*) skyBlueColor
{
	FLReturnRGBColor(135,206,235, 1.0);
}

+ (UIColor*) lightSkyBlueColor
{
	FLReturnRGBColor(135,206,250, 1.0);
}
+ (UIColor*) lightBlueColor
{
	FLReturnRGBColor(173,206,230, 1.0);
}

+ (UIColor*) darkGreenColor
{
	FLReturnRGBColor(0x2f, 0x4f, 0x2f, 1.0);
}

+ (UIColor*) blueLabelColor
{
	FLReturnRGBColor(50.0,79.0,133.0, 1.0);
}

+ (UIColor*) silverColor
{
	FLReturnRGBColor(192,192,192, 1.0);
}

+ (UIColor*) gray10Color
{
    FLReturnColor(0.1f, 0.1f, 0.1f, 1.0);
}

+ (UIColor*)gray75Color
{
	FLReturnColor(0.75f, 0.75f, 0.75f, 1.0);
}

+ (UIColor*)gray85Color
{
	FLReturnColor(0.85f, 0.85f, 0.85f, 1.0);
}

+ (UIColor*)gray15Color
{
	FLReturnColor(0.15f, 0.15f, 0.15f, 1.0);
}

+ (UIColor*) gray95Color
{
	FLReturnColor(0.95f, 0.95f, 0.95f, 1.0);
}


+ (UIColor*) gray45Color
{
	FLReturnColor(0.45f, 0.45f, 0.45f, 1.0);
}

+ (UIColor*) gray25Color
{
	FLReturnColor(0.25f, 0.25f, 0.25f, 1.0);
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
    FLReturnColor(0.2f, 0.2f, 0.2f, 1.0);
}

+ (UIColor*) gray50Color
{
	return [UIColor grayColor];
}

+ (UIColor*) lightBlueTintedGrayColor
{
	FLReturnRGBColor(80,80,83, 1.0);
}


+ (UIColor*) blueTintedGrayColor
{
	FLReturnRGBColor(69,69,71, 1.0);
}

+ (UIColor*) darkBlueTintedGrayColor
{
	FLReturnRGBColor(41,41,42, 1.0);
}

+ (UIColor*) darkDarkBlueTintedGrayColor
{
	FLReturnRGBColor(20,20,24, 1.0);
}


//+ (UIColor*) darkBlueTintedGrayColor
//{
//	FLReturnRGBColor(41,41,42, 1.0);
//}
//
//+ (UIColor*) mediumGrayColor
//{
//	FLReturnRGBColor(79,81,82, 1.0);
//}
//
//+ (UIColor*) blueTextColor
//{
//	FLReturnRGBColor(171,197,225, 1.0);
//}

+ (UIColor*) grayGlossyButtonColor
{
	FLReturnRGBColor(235, 235, 237, 1.0f);
}

+ (UIColor*) redGlossyButtonColor
{
	FLReturnRGBColor(160, 1, 20, 1.0f);
}

+ (UIColor*) greenGlossyButtonColor
{
	FLReturnRGBColor(24, 157, 22, 1.0f);
}

+ (UIColor*) yellowGlossyButtonColor
{
	FLReturnRGBColor(240, 191, 34, 1.0f);
}

+ (UIColor*) blackGlossyButtonColor
{
	return [UIColor gray10Color];
}


@end
