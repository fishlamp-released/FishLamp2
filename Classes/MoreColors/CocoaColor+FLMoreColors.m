//
//	NSColors+FLMoreColors.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/11/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "CocoaColor+FLMoreColors.h"

@implementation CocoaColor (FLMoreColors)

+ (CocoaColor*) iPhoneBlueColor
{
	//	return [CocoaColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
	
	RETURN_RGB_COLOR(36,99,222, 1.0); // 0.035294117647059, 0.388235294117647, 0.870588235294118
}

+ (CocoaColor*) standardLabelColor
{
	return [CocoaColor blackColor];
}

+ (CocoaColor*) standardTextFieldColor
{
	return [CocoaColor blueLabelColor];
}	

+ (CocoaColor*) disabledControlColor
{
	return [CocoaColor lightGrayColor];
}

+ (CocoaColor*)indigoColor
{
	RETURN_COLOR(.294f, 0.0f, .509f, 1.0);
}

+ (CocoaColor*)tealColor
{
	RETURN_COLOR(0.0f, 0.5f, 0.5f, 1.0);
}

+ (CocoaColor*)violetColor
{
	RETURN_COLOR (.498f, 0.0f, 1.0f, 1.0); 
}

+ (CocoaColor*)electricVioletColor
{
	RETURN_COLOR(.506f, 0.0f, 1.0f, 1.0);
}

+ (CocoaColor*)vividVioletColor
{
	RETURN_COLOR(.506f, 0.0f, 1.0f, 1.0);
}

+ (CocoaColor*)darkVioletColor
{
	RETURN_COLOR(.58f, 0.0f, .827f, 1.0);
}

+ (CocoaColor*)amberColor
{
	RETURN_COLOR(1.0f, .75f, 0.0f, 1.0);
}

+ (CocoaColor*)darkAmberColor
{
	RETURN_COLOR(1.0f, .494f, 0.0f, 1.0);
}

+ (CocoaColor*)lemonColor
{
	RETURN_COLOR(1.0f, .914f, .0627f, 1.0);
}

+ (CocoaColor*) paleYellowColor
{
	RETURN_COLOR(1.0f, .914f, .0627f, 1.0);
}

+ (CocoaColor*)roseColor
{
	RETURN_COLOR(1.0f, 0.0f, 0.5f, 1.0);
}

+ (CocoaColor*)rubyColor
{
	RETURN_COLOR(0.8784f, .06667f, .3725f, 1.0);
}

+ (CocoaColor*)fireEngineRed
{
	RETURN_COLOR(0.8078f, 0.0863f, 0.1255f, 1.0);
}

+ (CocoaColor*)darkBlueColor
{
	RETURN_COLOR(0.0f, 0.0f, 0.25f, 1.0);
}

+ (CocoaColor*) skyBlueColor
{
	RETURN_RGB_COLOR(135,206,235, 1.0);
}

+ (CocoaColor*) lightSkyBlueColor
{
	RETURN_RGB_COLOR(135,206,250, 1.0);
}
+ (CocoaColor*) lightBlueColor
{
	RETURN_RGB_COLOR(173,206,230, 1.0);
}

+ (CocoaColor*) darkGreenColor
{
	RETURN_RGB_COLOR(0x2f, 0x4f, 0x2f, 1.0);
}

+ (CocoaColor*) blueLabelColor
{
	RETURN_RGB_COLOR(50.0,79.0,133.0, 1.0);
}

+ (CocoaColor*) silverColor
{
	RETURN_RGB_COLOR(192,192,192, 1.0);
}

+ (CocoaColor*) gray10Color
{
    RETURN_COLOR(0.1f, 0.1f, 0.1f, 1.0);
}

+ (CocoaColor*)gray75Color
{
	RETURN_COLOR(0.75f, 0.75f, 0.75f, 1.0);
}

+ (CocoaColor*)gray85Color
{
	RETURN_COLOR(0.85f, 0.85f, 0.85f, 1.0);
}

+ (CocoaColor*)gray15Color
{
	RETURN_COLOR(0.15f, 0.15f, 0.15f, 1.0);
}

+ (CocoaColor*) gray95Color
{
	RETURN_COLOR(0.95f, 0.95f, 0.95f, 1.0);
}


+ (CocoaColor*) gray45Color
{
	RETURN_COLOR(0.45f, 0.45f, 0.45f, 1.0);
}

+ (CocoaColor*) gray25Color
{
	RETURN_COLOR(0.25f, 0.25f, 0.25f, 1.0);
}

+ (CocoaColor*) gray33Color
{
	return [CocoaColor darkGrayColor];
}

+ (CocoaColor*) gray66Color
{
	return [CocoaColor lightGrayColor];
}

+ (CocoaColor*) gray20Color
{
    RETURN_COLOR(0.2f, 0.2f, 0.2f, 1.0);
}

+ (CocoaColor*) gray50Color
{
	return [CocoaColor grayColor];
}

+ (CocoaColor*) lightBlueTintedGrayColor
{
	RETURN_RGB_COLOR(80,80,83, 1.0);
}


+ (CocoaColor*) blueTintedGrayColor
{
	RETURN_RGB_COLOR(69,69,71, 1.0);
}

+ (CocoaColor*) darkBlueTintedGrayColor
{
	RETURN_RGB_COLOR(41,41,42, 1.0);
}

+ (CocoaColor*) darkDarkBlueTintedGrayColor
{
	RETURN_RGB_COLOR(20,20,24, 1.0);
}


//+ (CocoaColor*) darkBlueTintedGrayColor
//{
//	RETURN_RGB_COLOR(41,41,42, 1.0);
//}
//
//+ (CocoaColor*) mediumGrayColor
//{
//	RETURN_RGB_COLOR(79,81,82, 1.0);
//}
//
//+ (CocoaColor*) blueTextColor
//{
//	RETURN_RGB_COLOR(171,197,225, 1.0);
//}

+ (CocoaColor*) grayGlossyButtonColor
{
	RETURN_RGB_COLOR(235, 235, 237, 1.0f);
}

+ (CocoaColor*) redGlossyButtonColor
{
	RETURN_RGB_COLOR(160, 1, 20, 1.0f);
}

+ (CocoaColor*) greenGlossyButtonColor
{
	RETURN_RGB_COLOR(24, 157, 22, 1.0f);
}

+ (CocoaColor*) yellowGlossyButtonColor
{
	RETURN_RGB_COLOR(240, 191, 34, 1.0f);
}

+ (CocoaColor*) blackGlossyButtonColor
{
	return [CocoaColor gray10Color];
}


@end
