//
//	NSColors+GtMoreColors.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/11/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface UIColor (GtMoreColors) 

+ (UIColor*) iPhoneBlueColor;

+ (UIColor*) blueLabelColor;
+ (UIColor*) indigoColor;
+ (UIColor*) tealColor;
+ (UIColor*) violetColor;
+ (UIColor*) electricVioletColor;
+ (UIColor*) vividVioletColor;
+ (UIColor*) darkVioletColor;
+ (UIColor*) amberColor;
+ (UIColor*) darkAmberColor;
+ (UIColor*) lemonColor;
+ (UIColor*) roseColor;
+ (UIColor*) rubyColor;
+ (UIColor*) fireEngineRed;
+ (UIColor*) darkBlueColor;

+ (UIColor*) skyBlueColor;
+ (UIColor*) lightSkyBlueColor;
+ (UIColor*) lightBlueColor;

+ (UIColor*) gray10Color; // almost black
+ (UIColor*) gray15Color;
+ (UIColor*) gray20Color; 
+ (UIColor*) gray25Color; 
+ (UIColor*) gray33Color; // darkGray
+ (UIColor*) gray45Color;
+ (UIColor*) gray50Color; // grayColor
+ (UIColor*) gray66Color; // lightGray
+ (UIColor*) gray75Color; 
+ (UIColor*) gray85Color; 
+ (UIColor*) gray95Color; // almostWhite

+ (UIColor*) silverColor;

+ (UIColor*) paleYellowColor;

+ (UIColor*) darkGreenColor;

+ (UIColor*) lightBlueTintedGrayColor;
+ (UIColor*) blueTintedGrayColor;
+ (UIColor*) darkBlueTintedGrayColor;
+ (UIColor*) darkDarkBlueTintedGrayColor;

//+ (UIColor*) orangeColor; // 198, 101, 26

@end

#define RETURN_RGB_COLOR(RED,GREEN,BLUE) \
    return [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:1.0f ]

#define RETURN_COLOR(RED,GREEN,BLUE) \
    return [UIColor	colorWithRed:RED green:GREEN blue:BLUE alpha:1.0f]
