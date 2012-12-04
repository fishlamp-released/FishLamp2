// [Generated]
//
// FLColorRange.h
// Project: FishLamp Themes
// Schema: FLColorObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]
#import "FishLampCore.h"

#import "FLColorRange.h"
#import "FLColor_t.h"

@interface FLColorRange : NSObject { 
@private
	UIColor_* _startColor;
	UIColor_* _endColor;
	CGFloat _alpha;
} 


@property (readonly, assign, nonatomic) CGFloat alpha;

@property (readonly, strong, nonatomic) UIColor_* endColor;

@property (readonly, strong, nonatomic) UIColor_* startColor;

@property (readonly, assign, nonatomic) FLColorRange_t colorRange_t;


- (id) initWithStartColor:(UIColor_*) startColor
                 endColor:(UIColor_*) endColor;

+ (FLColorRange*) colorRange:(UIColor_*) startColor
                    endColor:(UIColor_*) endColor;
 
@end

@interface FLMutableColorRange : FLColorRange {
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

@property (readwrite, strong, nonatomic) UIColor_* endColor;

@property (readwrite, strong, nonatomic) UIColor_* startColor;

+ (FLMutableColorRange*) colorRange; 

@end


@interface FLColorRange (FLGradientColors)
// utils
+ (FLColorRange*) gradientColorsFromColor:(UIColor_*) color                                  
                               intensity:(CGFloat) intensity; // from 0.0 to 1.0 (.7 is typical)

// premade gradients

+ (FLColorRange*) iPhoneBlueGradientColorRange;

+ (FLColorRange*) redGradientColorRange;
+ (FLColorRange*) paleBlueGradientColorRange;
+ (FLColorRange*) brightBlueGradientColorRange;
+ (FLColorRange*) darkGrayGradientColorRange;
+ (FLColorRange*) darkGrayWithBlueTintGradientColorRange;
+ (FLColorRange*) blackGradientColorRange;
+ (FLColorRange*) grayGradientColorRange;
+ (FLColorRange*) lightGrayGradientColorRange;
+ (FLColorRange*) lightLightGrayGradientColorRange;


@end
