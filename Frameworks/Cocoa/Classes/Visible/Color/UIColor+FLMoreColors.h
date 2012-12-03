//
//	NSColors+FLMoreColors.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/11/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"


// http://whatcolor.heroku.com/

@interface UIColor_ (FLMoreColors) 

+ (UIColor_*) iPhoneBlueColor;

+ (UIColor_*) blueLabelColor;
+ (UIColor_*) indigoColor;
+ (UIColor_*) tealColor;
+ (UIColor_*) violetColor;
+ (UIColor_*) electricVioletColor;
+ (UIColor_*) vividVioletColor;
+ (UIColor_*) darkVioletColor;
+ (UIColor_*) amberColor;
+ (UIColor_*) darkAmberColor;
+ (UIColor_*) lemonColor;
+ (UIColor_*) roseColor;
+ (UIColor_*) rubyColor;
+ (UIColor_*) fireEngineRed;
+ (UIColor_*) darkBlueColor;

+ (UIColor_*) skyBlueColor;
+ (UIColor_*) lightSkyBlueColor;
+ (UIColor_*) lightBlueColor;

+ (UIColor_*) gray10Color; // almost black
+ (UIColor_*) gray15Color;
+ (UIColor_*) gray20Color; 
+ (UIColor_*) gray25Color; 
+ (UIColor_*) gray33Color; // darkGray
+ (UIColor_*) gray45Color;
+ (UIColor_*) gray50Color; // grayColor
+ (UIColor_*) gray66Color; // lightGray
+ (UIColor_*) gray75Color; 
+ (UIColor_*) gray85Color; 
+ (UIColor_*) gray95Color; // almostWhite

+ (UIColor_*) silverColor;

+ (UIColor_*) paleYellowColor;

+ (UIColor_*) darkGreenColor;

+ (UIColor_*) lightBlueTintedGrayColor;
+ (UIColor_*) blueTintedGrayColor;
+ (UIColor_*) darkBlueTintedGrayColor;
+ (UIColor_*) darkDarkBlueTintedGrayColor;

//+ (UIColor_*) orangeColor; // 198, 101, 26

+ (UIColor_*) grayGlossyButtonColor;
+ (UIColor_*) redGlossyButtonColor;
+ (UIColor_*) greenGlossyButtonColor;
+ (UIColor_*) yellowGlossyButtonColor;
+ (UIColor_*) blackGlossyButtonColor;


@end

#import "FLProperties.h"

#if IOS
#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [UIColor_ colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )

#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [UIColor_ colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )
//#else 
//if NS_AVAILABLE_MAC(10_7)
//
//#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
//    FLReturnStaticObjectFromBlock(^{ \
//        return [UIColor_ colorWithSRGBRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )
//
//#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
//    FLReturnStaticObjectFromBlock(^{ \
//        return [UIColor_ colorWithSRGBRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )
//
#else
#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [UIColor_ colorWithDeviceRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )

#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [UIColor_ colorWithDeviceRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )

#endif
