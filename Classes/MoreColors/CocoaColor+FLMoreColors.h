//
//	NSColors+FLMoreColors.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/11/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"
#import "FLCocoaCompatibility.h"


@interface CocoaColor (FLMoreColors) 

+ (CocoaColor*) iPhoneBlueColor;

+ (CocoaColor*) blueLabelColor;
+ (CocoaColor*) indigoColor;
+ (CocoaColor*) tealColor;
+ (CocoaColor*) violetColor;
+ (CocoaColor*) electricVioletColor;
+ (CocoaColor*) vividVioletColor;
+ (CocoaColor*) darkVioletColor;
+ (CocoaColor*) amberColor;
+ (CocoaColor*) darkAmberColor;
+ (CocoaColor*) lemonColor;
+ (CocoaColor*) roseColor;
+ (CocoaColor*) rubyColor;
+ (CocoaColor*) fireEngineRed;
+ (CocoaColor*) darkBlueColor;

+ (CocoaColor*) skyBlueColor;
+ (CocoaColor*) lightSkyBlueColor;
+ (CocoaColor*) lightBlueColor;

+ (CocoaColor*) gray10Color; // almost black
+ (CocoaColor*) gray15Color;
+ (CocoaColor*) gray20Color; 
+ (CocoaColor*) gray25Color; 
+ (CocoaColor*) gray33Color; // darkGray
+ (CocoaColor*) gray45Color;
+ (CocoaColor*) gray50Color; // grayColor
+ (CocoaColor*) gray66Color; // lightGray
+ (CocoaColor*) gray75Color; 
+ (CocoaColor*) gray85Color; 
+ (CocoaColor*) gray95Color; // almostWhite

+ (CocoaColor*) silverColor;

+ (CocoaColor*) paleYellowColor;

+ (CocoaColor*) darkGreenColor;

+ (CocoaColor*) lightBlueTintedGrayColor;
+ (CocoaColor*) blueTintedGrayColor;
+ (CocoaColor*) darkBlueTintedGrayColor;
+ (CocoaColor*) darkDarkBlueTintedGrayColor;

//+ (CocoaColor*) orangeColor; // 198, 101, 26

+ (CocoaColor*) grayGlossyButtonColor;
+ (CocoaColor*) redGlossyButtonColor;
+ (CocoaColor*) greenGlossyButtonColor;
+ (CocoaColor*) yellowGlossyButtonColor;
+ (CocoaColor*) blackGlossyButtonColor;


@end

#import "FLProperties.h"

#if IOS
#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [CocoaColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )

#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [CocoaColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )
//#else 
//if NS_AVAILABLE_MAC(10_7)
//
//#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
//    FLReturnStaticObjectFromBlock(^{ \
//        return [CocoaColor colorWithSRGBRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )
//
//#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
//    FLReturnStaticObjectFromBlock(^{ \
//        return [CocoaColor colorWithSRGBRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )
//
#else
#define RETURN_RGB_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [CocoaColor colorWithDeviceRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA ];} )

#define RETURN_COLOR(RED,GREEN,BLUE,ALPHA) \
    FLReturnStaticObjectFromBlock(^{ \
        return [CocoaColor colorWithDeviceRed:RED green:GREEN blue:BLUE alpha:ALPHA ];} )

#endif
