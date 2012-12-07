// [Generated]
//
// FLColorRange.m
// Project: FishLamp Themes
// Schema: FLColorObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLColorRange.h"
#import "FLColor.h"
#import "FLColor.h"

@interface FLColorRange ()
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, strong, nonatomic) FLColor* endColor;
@property (readwrite, strong, nonatomic) FLColor* startColor;
@end

@implementation FLColorRange

@synthesize alpha = _alpha;
@synthesize endColor = _endColor;
@synthesize startColor = _startColor;

- (id) initWithStartColor:(FLColor*) startColor
                 endColor:(FLColor*) endColor
{
    self = [super init];
    if(self) {
        self.startColor = startColor;
        self.endColor = endColor;
    }
    
    return self;
}

+ (FLColorRange*) colorRange:(FLColor*) startColor
    endColor:(FLColor*) endColor {
    return FLAutorelease([[[self class] alloc] initWithStartColor:startColor endColor:endColor]);
}

#if FL_MRC
- (void) dealloc
{
	FLRelease(_startColor);
	FLRelease(_endColor);
	super_dealloc_();
}
#endif

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (FLColorRange_t) colorRange_t {
    return FLColorRangeMake(self.startColor.color_t, self.endColor.color_t);
}

@end

@implementation FLMutableColorRange
@dynamic alpha;
@dynamic startColor;
@dynamic endColor;

+ (FLMutableColorRange*) colorRange
{
	return FLAutorelease([[FLMutableColorRange alloc] init]);
}
@end

@implementation FLColorRange (FLGradientColors)

+ (FLColorRange*) gradientColorsFromColor:(FLColor*) color 
                                  intensity:(CGFloat) intensity
{
    FLColor_t color_t = color.color_t;
	FLColor_t startColor = FLColorLighten(color_t, intensity);
	FLColor_t endColor = FLColorDarken(color_t, intensity);
	
    return [FLColorRange colorRange:[FLColor colorWithColor_t:startColor] endColor:[FLColor colorWithColor_t:endColor]];
}	

+ (FLColorRange*) iPhoneBlueGradientColorRange {

	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange gradientColorsFromColor:[FLColor iPhoneBlueColor] intensity:0.7f];
        });

}

+(FLColorRange*) redGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(236,19,20,1.0)  endColor:[FLColor fireEngineRed]];
        });
}

+(FLColorRange*) paleBlueGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(74,108,155,1.0) endColor:FLRgbColor(72,106,154,1.0)];
        });
}

+(FLColorRange*) brightBlueGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(36,99,222,1.0) endColor:FLRgbColor(34,96,221,1.0)];
        });
}

+(FLColorRange*) darkGrayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(71,71,73,1.0) endColor:FLRgbColor(33,33,35,1.0)];
        });
}

+(FLColorRange*) darkGrayWithBlueTintGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(65,71,80,1.0) endColor:FLRgbColor(43,50,59,1.0)];
        });
}

+(FLColorRange*) blackGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:[FLColor darkGrayColor] endColor:[FLColor blackColor]];
        });
}

+(FLColorRange*) grayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(71,71,73,1.0) endColor:FLRgbColor(33,33,35,1.0)];
        });
}

+(FLColorRange*) lightGrayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(128,128,128,1.0)  endColor:FLRgbColor(71,71,73,1.0)];
        });
}

+(FLColorRange*) lightLightGrayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLRgbColor(250,250,250,1.0)  endColor:FLRgbColor(112,118,118,1.0)];
        });
}



//+ (FLGradientColorPair*) grayGradientColors
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLRgbColor(71,71,73,1.0) endColor:FLRgbColor(33,33,35,1.0)]);
//    return s_color;
//}

//+ (FLGradientColorPair*) deleteButtonRedGradientColors;
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLRgbColor(240,127,136,1.0) endColor:[FLColor fireEngineRed]]);
////    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLRgbColor(240,127,136,1.0) endColor:FLRgbColor(231,53,66,1.0)]);
////    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLRgbColor(236,19,20,1.0)  endColor:[FLColor fireEngineRed]]);
//    return s_color;
//}
//
//+ (FLGradientColorPair*) paleBlueGradientColors
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLRgbColor(74,108,155,1.0) endColor:FLRgbColor(72,106,154,1.0)]);
//    return s_color;
//}
//
//+ (FLGradientColorPair*) brightBlueGradientColors
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLRgbColor(108,147,232,1.0) endColor:FLRgbColor(57,112,224,1.0)]);
//    return s_color;
//}
//
//


@end

