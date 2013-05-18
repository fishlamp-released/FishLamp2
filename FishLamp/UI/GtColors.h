//
//  GtColors.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/20/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//


#if IPHONE
@interface UIColor (GtExtras) 


+ (UIColor*) colorWithRgbValues:(CGFloat) red /* 0-255 */
	green:(CGFloat) green /* 0-255 */
	blue:(CGFloat) blue /* 0-255 */
	alpha:(CGFloat) alpha;

- (void) rgbValues:(CGFloat*) red 
	green:(CGFloat*) green 
	blue:(CGFloat*) blue;

- (void) rgbValues:(CGFloat*) red 
	         green:(CGFloat*) green 
	          blue:(CGFloat*) blue 
	         alpha:(CGFloat*) alphaOrNil;

- (NSString*) toHexString:(BOOL) forCss;

+ (UIColor*) iPhoneBlueColor;

+ (UIColor*) blueLabelColor;
+ (UIColor*) almostBlackGrayColor;
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
+ (UIColor*) standardTextFieldColor;
+ (UIColor*) standardLabelColor;
+ (UIColor*) disabledControlColor;
+ (UIColor*) darkBlueColor;

+ (UIColor*) lightLightGrayColor; // 0.85
+ (UIColor*) almostWhiteGrayColor; // 0.95


+ (UIColor*) paleYellowColor;


@end

@interface UIFont (GtExtras)
+ (UIFont*) standardLabelFont;
+ (UIFont*) standardTextFieldFont;
+ (UIFont*) standardNavigationBarLabelFont;
@end

#endif

