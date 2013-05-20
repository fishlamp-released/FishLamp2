//
//	NSColors+GtMoreColors.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/11/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIColor+GtMoreColors.h"

#define RETURN_RGB_COL

@implementation UIColor (GtMoreColors)

+ (UIColor*) iPhoneBlueColor
{
	//	return [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
	
	RETURN_RGB_COLOR(36,99,222); // 0.035294117647059, 0.388235294117647, 0.870588235294118
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
	RETURN_COLOR(.294f, 0.0f, .509f);
}




+ (UIColor*)tealColor
{
	RETURN_COLOR(0.0f, 0.5f, 0.5f);
}

+ (UIColor*)violetColor
{
	RETURN_COLOR (.498f, 0.0f, 1.0f); 
}

+ (UIColor*)electricVioletColor
{
	RETURN_COLOR(.506f, 0.0f, 1.0f);
}

+ (UIColor*)vividVioletColor
{
	RETURN_COLOR(.506f, 0.0f, 1.0f);
}

+ (UIColor*)darkVioletColor
{
	RETURN_COLOR(.58f, 0.0f, .827f);
}

+ (UIColor*)amberColor
{
	RETURN_COLOR(1.0f, .75f, 0.0f);
}

+ (UIColor*)darkAmberColor
{
	RETURN_COLOR(1.0f, .494f, 0.0f);
}

+ (UIColor*)lemonColor
{
	RETURN_COLOR(1.0f, .914f, .0627f);
}

+ (UIColor*) paleYellowColor
{
	RETURN_COLOR(1.0f, .914f, .0627f);
}

+ (UIColor*)roseColor
{
	RETURN_COLOR(1.0f, 0.0f, 0.5f);
}

+ (UIColor*)rubyColor
{
	RETURN_COLOR(0.8784f, .06667f, .3725f);
}

+ (UIColor*)fireEngineRed
{
	RETURN_COLOR(0.8078f, 0.0863f, 0.1255f);
}

+ (UIColor*)darkBlueColor
{
	RETURN_COLOR(0.0f, 0.0f, 0.25f);
}

+ (UIColor*) skyBlueColor
{
	RETURN_RGB_COLOR(135,206,235);
}

+ (UIColor*) lightSkyBlueColor
{
	RETURN_RGB_COLOR(135,206,250);
}
+ (UIColor*) lightBlueColor
{
	RETURN_RGB_COLOR(173,206,230);
}

+ (UIColor*) darkGreenColor
{
	RETURN_RGB_COLOR(0x2f, 0x4f, 0x2f);
}

+ (UIColor*) blueLabelColor
{
	/*
	 static UIColor* s_color = nil;
	 if(!s_color)
	 {
	 s_color = [[UIColor	colorWithRed:50.0f/255.0f 
	 green:79.0f/255.0f 
	 blue:133.0f/255.0f 
	 alpha:1.0f ] retain];
	 }
	 return s_color;
	 */ 
	RETURN_RGB_COLOR(50.0,79.0,133.0);
}

+ (UIColor*) silverColor
{
	RETURN_RGB_COLOR(192,192,192);
}

+ (UIColor*) gray10Color
{
	static UIColor* s_color = nil;
	if(!s_color)
	{
		s_color = [[UIColor colorWithWhite:0.1 alpha:1.0f ] retain];
	}
	return s_color;
}

+ (UIColor*)gray75Color
{
	RETURN_COLOR(0.75f, 0.75f, 0.75f);
}

+ (UIColor*)gray85Color
{
	RETURN_COLOR(0.85f, 0.85f, 0.85f);
}

+ (UIColor*)gray15Color
{
	RETURN_COLOR(0.15f, 0.15f, 0.15f);
}

+ (UIColor*) gray95Color
{
	RETURN_COLOR(0.95f, 0.95f, 0.95f);
}


+ (UIColor*) gray45Color
{
	RETURN_COLOR(0.45f, 0.45f, 0.45f);
}

+ (UIColor*) gray25Color
{
	RETURN_COLOR(0.25f, 0.25f, 0.25f);
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
	static UIColor* s_color = nil;
	if(!s_color)
	{
		s_color = [[UIColor colorWithWhite:0.2 alpha:1.0f ] retain];
	}
	return s_color;
}

+ (UIColor*) gray50Color
{
	return [UIColor grayColor];
}

+ (UIColor*) lightBlueTintedGrayColor
{
	RETURN_RGB_COLOR(80,80,83);
}


+ (UIColor*) blueTintedGrayColor
{
	RETURN_RGB_COLOR(69,69,71);
}

//+ (UIColor*) blueTintedGrayColor
//{
//	RETURN_RGB_COLOR(69,69,71);
//}


+ (UIColor*) darkBlueTintedGrayColor
{
	RETURN_RGB_COLOR(41,41,42);
}

+ (UIColor*) darkDarkBlueTintedGrayColor
{
	RETURN_RGB_COLOR(20,20,24);
}


//+ (UIColor*) darkBlueTintedGrayColor
//{
//	RETURN_RGB_COLOR(41,41,42);
//}
//
//+ (UIColor*) mediumGrayColor
//{
//	RETURN_RGB_COLOR(79,81,82);
//}
//
//+ (UIColor*) blueTextColor
//{
//	RETURN_RGB_COLOR(171,197,225);
//}



@end
