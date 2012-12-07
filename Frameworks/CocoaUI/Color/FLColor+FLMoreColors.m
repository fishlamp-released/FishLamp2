//
//  FLColor+Colors.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColor+FLMoreColors.h"

@implementation FLColor (FLMoreColors)

+ (FLColor*) iPhoneBlueColor
{
	//	return [FLColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
	
	FLReturnRGBColor(36,99,222, 1.0); // 0.035294117647059, 0.388235294117647, 0.870588235294118
}

+ (FLColor*) standardLabelColor
{
	return [FLColor blackColor];
}

+ (FLColor*) standardTextFieldColor
{
	return [FLColor blueLabelColor];
}	

+ (FLColor*) disabledControlColor
{
	return [FLColor lightGrayColor];
}

+ (FLColor*)indigoColor
{
	FLReturnColor(.294f, 0.0f, .509f, 1.0);
}

+ (FLColor*)tealColor
{
	FLReturnColor(0.0f, 0.5f, 0.5f, 1.0);
}

+ (FLColor*)violetColor
{
	FLReturnColor (.498f, 0.0f, 1.0f, 1.0); 
}

+ (FLColor*)electricVioletColor
{
	FLReturnColor(.506f, 0.0f, 1.0f, 1.0);
}

+ (FLColor*)vividVioletColor
{
	FLReturnColor(.506f, 0.0f, 1.0f, 1.0);
}

+ (FLColor*)darkVioletColor
{
	FLReturnColor(.58f, 0.0f, .827f, 1.0);
}

+ (FLColor*)amberColor
{
	FLReturnColor(1.0f, .75f, 0.0f, 1.0);
}

+ (FLColor*)darkAmberColor
{
	FLReturnColor(1.0f, .494f, 0.0f, 1.0);
}

+ (FLColor*)lemonColor
{
	FLReturnColor(1.0f, .914f, .0627f, 1.0);
}

+ (FLColor*) paleYellowColor
{
	FLReturnColor(1.0f, .914f, .0627f, 1.0);
}

+ (FLColor*)roseColor
{
	FLReturnColor(1.0f, 0.0f, 0.5f, 1.0);
}

+ (FLColor*)rubyColor
{
	FLReturnColor(0.8784f, .06667f, .3725f, 1.0);
}

+ (FLColor*)fireEngineRed
{
	FLReturnColor(0.8078f, 0.0863f, 0.1255f, 1.0);
}

+ (FLColor*)darkBlueColor
{
	FLReturnColor(0.0f, 0.0f, 0.25f, 1.0);
}

+ (FLColor*) skyBlueColor
{
	FLReturnRGBColor(135,206,235, 1.0);
}

+ (FLColor*) lightSkyBlueColor
{
	FLReturnRGBColor(135,206,250, 1.0);
}
+ (FLColor*) lightBlueColor
{
	FLReturnRGBColor(173,206,230, 1.0);
}

+ (FLColor*) darkGreenColor
{
	FLReturnRGBColor(0x2f, 0x4f, 0x2f, 1.0);
}

+ (FLColor*) blueLabelColor
{
	FLReturnRGBColor(50.0,79.0,133.0, 1.0);
}

+ (FLColor*) silverColor
{
	FLReturnRGBColor(192,192,192, 1.0);
}

+ (FLColor*) gray10Color
{
    FLReturnColor(0.1f, 0.1f, 0.1f, 1.0);
}

+ (FLColor*)gray75Color
{
	FLReturnColor(0.75f, 0.75f, 0.75f, 1.0);
}

+ (FLColor*)gray85Color
{
	FLReturnColor(0.85f, 0.85f, 0.85f, 1.0);
}

+ (FLColor*)gray15Color
{
	FLReturnColor(0.15f, 0.15f, 0.15f, 1.0);
}

+ (FLColor*) gray95Color
{
	FLReturnColor(0.95f, 0.95f, 0.95f, 1.0);
}


+ (FLColor*) gray45Color
{
	FLReturnColor(0.45f, 0.45f, 0.45f, 1.0);
}

+ (FLColor*) gray25Color
{
	FLReturnColor(0.25f, 0.25f, 0.25f, 1.0);
}

+ (FLColor*) gray33Color
{
	return [FLColor darkGrayColor];
}

+ (FLColor*) gray66Color
{
	return [FLColor lightGrayColor];
}

+ (FLColor*) gray20Color
{
    FLReturnColor(0.2f, 0.2f, 0.2f, 1.0);
}

+ (FLColor*) gray50Color
{
	return [FLColor grayColor];
}

+ (FLColor*) lightBlueTintedGrayColor
{
	FLReturnRGBColor(80,80,83, 1.0);
}


+ (FLColor*) blueTintedGrayColor
{
	FLReturnRGBColor(69,69,71, 1.0);
}

+ (FLColor*) darkBlueTintedGrayColor
{
	FLReturnRGBColor(41,41,42, 1.0);
}

+ (FLColor*) darkDarkBlueTintedGrayColor
{
	FLReturnRGBColor(20,20,24, 1.0);
}


//+ (FLColor*) darkBlueTintedGrayColor
//{
//	FLReturnRGBColor(41,41,42, 1.0);
//}
//
//+ (FLColor*) mediumGrayColor
//{
//	FLReturnRGBColor(79,81,82, 1.0);
//}
//
//+ (FLColor*) blueTextColor
//{
//	FLReturnRGBColor(171,197,225, 1.0);
//}

+ (FLColor*) grayGlossyButtonColor
{
	FLReturnRGBColor(235, 235, 237, 1.0f);
}

+ (FLColor*) redGlossyButtonColor
{
	FLReturnRGBColor(160, 1, 20, 1.0f);
}

+ (FLColor*) greenGlossyButtonColor
{
	FLReturnRGBColor(24, 157, 22, 1.0f);
}

+ (FLColor*) yellowGlossyButtonColor
{
	FLReturnRGBColor(240, 191, 34, 1.0f);
}

+ (FLColor*) blackGlossyButtonColor
{
	return [FLColor gray10Color];
}


@end
