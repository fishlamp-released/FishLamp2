// [Generated]
//
// FLColorRange.h
// Project: FishLamp Themes
// Schema: FLColorObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]
#import "FLCore.h"

#import "FLColorRange.h"
#import "FLColor_t.h"

@interface FLColorRange : NSObject { 
@private
	FLColor* _startColor;
	FLColor* _endColor;
	CGFloat _alpha;
} 


@property (readonly, assign, nonatomic) CGFloat alpha;

@property (readonly, strong, nonatomic) FLColor* endColor;

@property (readonly, strong, nonatomic) FLColor* startColor;

@property (readonly, assign, nonatomic) FLColorRange_t colorRange_t;


- (id) initWithStartColor:(FLColor*) startColor
                 endColor:(FLColor*) endColor;

+ (FLColorRange*) colorRange:(FLColor*) startColor
                    endColor:(FLColor*) endColor;
 
@end

@interface FLMutableColorRange : FLColorRange {
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

@property (readwrite, strong, nonatomic) FLColor* endColor;

@property (readwrite, strong, nonatomic) FLColor* startColor;

+ (FLMutableColorRange*) colorRange; 

@end


@interface FLColorRange (FLGradientColors)
// utils
+ (FLColorRange*) gradientColorsFromColor:(FLColor*) color                                  
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
