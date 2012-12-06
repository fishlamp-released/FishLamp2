//
//  SDKColor+Colors.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "SDKColor+FLMoreColors.h"

@implementation SDKColor (FLMoreColors)

+ (SDKColor*) iPhoneBlueColor
{
	//	return [SDKColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
	
	FLReturnRGBColor(36,99,222, 1.0); // 0.035294117647059, 0.388235294117647, 0.870588235294118
}

+ (SDKColor*) standardLabelColor
{
	return [SDKColor blackColor];
}

+ (SDKColor*) standardTextFieldColor
{
	return [SDKColor blueLabelColor];
}	

+ (SDKColor*) disabledControlColor
{
	return [SDKColor lightGrayColor];
}

+ (SDKColor*)indigoColor
{
	FLReturnColor(.294f, 0.0f, .509f, 1.0);
}

+ (SDKColor*)tealColor
{
	FLReturnColor(0.0f, 0.5f, 0.5f, 1.0);
}

+ (SDKColor*)violetColor
{
	FLReturnColor (.498f, 0.0f, 1.0f, 1.0); 
}

+ (SDKColor*)electricVioletColor
{
	FLReturnColor(.506f, 0.0f, 1.0f, 1.0);
}

+ (SDKColor*)vividVioletColor
{
	FLReturnColor(.506f, 0.0f, 1.0f, 1.0);
}

+ (SDKColor*)darkVioletColor
{
	FLReturnColor(.58f, 0.0f, .827f, 1.0);
}

+ (SDKColor*)amberColor
{
	FLReturnColor(1.0f, .75f, 0.0f, 1.0);
}

+ (SDKColor*)darkAmberColor
{
	FLReturnColor(1.0f, .494f, 0.0f, 1.0);
}

+ (SDKColor*)lemonColor
{
	FLReturnColor(1.0f, .914f, .0627f, 1.0);
}

+ (SDKColor*) paleYellowColor
{
	FLReturnColor(1.0f, .914f, .0627f, 1.0);
}

+ (SDKColor*)roseColor
{
	FLReturnColor(1.0f, 0.0f, 0.5f, 1.0);
}

+ (SDKColor*)rubyColor
{
	FLReturnColor(0.8784f, .06667f, .3725f, 1.0);
}

+ (SDKColor*)fireEngineRed
{
	FLReturnColor(0.8078f, 0.0863f, 0.1255f, 1.0);
}

+ (SDKColor*)darkBlueColor
{
	FLReturnColor(0.0f, 0.0f, 0.25f, 1.0);
}

+ (SDKColor*) skyBlueColor
{
	FLReturnRGBColor(135,206,235, 1.0);
}

+ (SDKColor*) lightSkyBlueColor
{
	FLReturnRGBColor(135,206,250, 1.0);
}
+ (SDKColor*) lightBlueColor
{
	FLReturnRGBColor(173,206,230, 1.0);
}

+ (SDKColor*) darkGreenColor
{
	FLReturnRGBColor(0x2f, 0x4f, 0x2f, 1.0);
}

+ (SDKColor*) blueLabelColor
{
	FLReturnRGBColor(50.0,79.0,133.0, 1.0);
}

+ (SDKColor*) silverColor
{
	FLReturnRGBColor(192,192,192, 1.0);
}

+ (SDKColor*) gray10Color
{
    FLReturnColor(0.1f, 0.1f, 0.1f, 1.0);
}

+ (SDKColor*)gray75Color
{
	FLReturnColor(0.75f, 0.75f, 0.75f, 1.0);
}

+ (SDKColor*)gray85Color
{
	FLReturnColor(0.85f, 0.85f, 0.85f, 1.0);
}

+ (SDKColor*)gray15Color
{
	FLReturnColor(0.15f, 0.15f, 0.15f, 1.0);
}

+ (SDKColor*) gray95Color
{
	FLReturnColor(0.95f, 0.95f, 0.95f, 1.0);
}


+ (SDKColor*) gray45Color
{
	FLReturnColor(0.45f, 0.45f, 0.45f, 1.0);
}

+ (SDKColor*) gray25Color
{
	FLReturnColor(0.25f, 0.25f, 0.25f, 1.0);
}

+ (SDKColor*) gray33Color
{
	return [SDKColor darkGrayColor];
}

+ (SDKColor*) gray66Color
{
	return [SDKColor lightGrayColor];
}

+ (SDKColor*) gray20Color
{
    FLReturnColor(0.2f, 0.2f, 0.2f, 1.0);
}

+ (SDKColor*) gray50Color
{
	return [SDKColor grayColor];
}

+ (SDKColor*) lightBlueTintedGrayColor
{
	FLReturnRGBColor(80,80,83, 1.0);
}


+ (SDKColor*) blueTintedGrayColor
{
	FLReturnRGBColor(69,69,71, 1.0);
}

+ (SDKColor*) darkBlueTintedGrayColor
{
	FLReturnRGBColor(41,41,42, 1.0);
}

+ (SDKColor*) darkDarkBlueTintedGrayColor
{
	FLReturnRGBColor(20,20,24, 1.0);
}


//+ (SDKColor*) darkBlueTintedGrayColor
//{
//	FLReturnRGBColor(41,41,42, 1.0);
//}
//
//+ (SDKColor*) mediumGrayColor
//{
//	FLReturnRGBColor(79,81,82, 1.0);
//}
//
//+ (SDKColor*) blueTextColor
//{
//	FLReturnRGBColor(171,197,225, 1.0);
//}

+ (SDKColor*) grayGlossyButtonColor
{
	FLReturnRGBColor(235, 235, 237, 1.0f);
}

+ (SDKColor*) redGlossyButtonColor
{
	FLReturnRGBColor(160, 1, 20, 1.0f);
}

+ (SDKColor*) greenGlossyButtonColor
{
	FLReturnRGBColor(24, 157, 22, 1.0f);
}

+ (SDKColor*) yellowGlossyButtonColor
{
	FLReturnRGBColor(240, 191, 34, 1.0f);
}

+ (SDKColor*) blackGlossyButtonColor
{
	return [SDKColor gray10Color];
}


@end
