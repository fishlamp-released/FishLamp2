// [Generated]
//
// FLColorRange.h
// Project: FishLamp Themes
// Schema: FLColorObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]
#import "FLCocoaUIRequired.h"

#import "FLColorRange.h"
#import "FLColor_t.h"

@interface FLColorRange : NSObject { 
@private
	UIColor* _startColor;
	UIColor* _endColor;
	CGFloat _alpha;
} 

@property (readonly, assign, nonatomic) CGFloat alpha;

@property (readonly, strong, nonatomic) UIColor* endColor;

@property (readonly, strong, nonatomic) UIColor* startColor;

@property (readonly, assign, nonatomic) FLColorRange_t colorRange_t;

- (id) initWithStartColor:(UIColor*) startColor
                 endColor:(UIColor*) endColor;

+ (FLColorRange*) colorRange:(UIColor*) startColor
                    endColor:(UIColor*) endColor;
 
@end

@interface FLMutableColorRange : FLColorRange {
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

@property (readwrite, strong, nonatomic) UIColor* endColor;

@property (readwrite, strong, nonatomic) UIColor* startColor;

+ (FLMutableColorRange*) colorRange; 

@end


@interface FLColorRange (FLGradientColors)
// utils
+ (FLColorRange*) gradientColorsFromColor:(UIColor*) color                                  
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
