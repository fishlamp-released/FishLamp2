//
//	NSColors+FLMoreColors.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/11/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLColor.h"

// http://whatcolor.heroku.com/

@interface FLColor (FLMoreColors) 

+ (FLColor*) iPhoneBlueColor;

+ (FLColor*) blueLabelColor;
+ (FLColor*) indigoColor;
+ (FLColor*) tealColor;
+ (FLColor*) violetColor;
+ (FLColor*) electricVioletColor;
+ (FLColor*) vividVioletColor;
+ (FLColor*) darkVioletColor;
+ (FLColor*) amberColor;
+ (FLColor*) darkAmberColor;
+ (FLColor*) lemonColor;
+ (FLColor*) roseColor;
+ (FLColor*) rubyColor;
+ (FLColor*) fireEngineRed;
+ (FLColor*) darkBlueColor;

+ (FLColor*) skyBlueColor;
+ (FLColor*) lightSkyBlueColor;
+ (FLColor*) lightBlueColor;

+ (FLColor*) gray10Color; // almost black
+ (FLColor*) gray15Color;
+ (FLColor*) gray20Color; 
+ (FLColor*) gray25Color; 
+ (FLColor*) gray33Color; // darkGray
+ (FLColor*) gray45Color;
+ (FLColor*) gray50Color; // grayColor
+ (FLColor*) gray66Color; // lightGray
+ (FLColor*) gray75Color; 
+ (FLColor*) gray85Color; 
+ (FLColor*) gray95Color; // almostWhite

+ (FLColor*) silverColor;

+ (FLColor*) paleYellowColor;

+ (FLColor*) darkGreenColor;

+ (FLColor*) lightBlueTintedGrayColor;
+ (FLColor*) blueTintedGrayColor;
+ (FLColor*) darkBlueTintedGrayColor;
+ (FLColor*) darkDarkBlueTintedGrayColor;

//+ (FLColor*) orangeColor; // 198, 101, 26

+ (FLColor*) grayGlossyButtonColor;
+ (FLColor*) redGlossyButtonColor;
+ (FLColor*) greenGlossyButtonColor;
+ (FLColor*) yellowGlossyButtonColor;
+ (FLColor*) blackGlossyButtonColor;


@end

#import "FLProperties.h"

#if IOS
#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [FLColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )

#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [FLColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )
//#else 
//if NS_AVAILABLE_MAC(10_7)
//
//#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
//    FLReturnStaticObjectFromBlock(^{ \
//        return [FLColor colorWithSRGBRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )
//
//#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
//    FLReturnStaticObjectFromBlock(^{ \
//        return [FLColor colorWithSRGBRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )
//
#else
#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [FLColor colorWithDeviceRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )

#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [FLColor colorWithDeviceRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )

#endif
