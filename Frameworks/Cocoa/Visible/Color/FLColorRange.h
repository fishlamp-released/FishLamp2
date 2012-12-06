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
	SDKColor* _startColor;
	SDKColor* _endColor;
	CGFloat _alpha;
} 


@property (readonly, assign, nonatomic) CGFloat alpha;

@property (readonly, strong, nonatomic) SDKColor* endColor;

@property (readonly, strong, nonatomic) SDKColor* startColor;

@property (readonly, assign, nonatomic) FLColorRange_t colorRange_t;


- (id) initWithStartColor:(SDKColor*) startColor
                 endColor:(SDKColor*) endColor;

+ (FLColorRange*) colorRange:(SDKColor*) startColor
                    endColor:(SDKColor*) endColor;
 
@end

@interface FLMutableColorRange : FLColorRange {
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

@property (readwrite, strong, nonatomic) SDKColor* endColor;

@property (readwrite, strong, nonatomic) SDKColor* startColor;

+ (FLMutableColorRange*) colorRange; 

@end


@interface FLColorRange (FLGradientColors)
// utils
+ (FLColorRange*) gradientColorsFromColor:(SDKColor*) color                                  
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
