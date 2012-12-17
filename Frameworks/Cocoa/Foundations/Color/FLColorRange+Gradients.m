//
//  FLColorRange+Gradients.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColorRange+Gradients.h"
#import "UIColor+FLMoreColors.h"
#import "FLColorUtilities.h"

@implementation FLColorRange (FLGradientColors)

+ (FLColorRange*) gradientColorsFromColor:(UIColor*) color 
                rangeSeperationPercentage:(CGFloat) percentage
{
    FLColorValues rgbColorValues = color.rgbColorValues;
	FLColorValues startColor = FLColorValuesLighten(rgbColorValues, percentage);
	FLColorValues endColor = FLColorValuesDarken(rgbColorValues, percentage);
	
    return [FLColorRange colorRange:[UIColor colorWithColorValues:startColor]
                           endColor:[UIColor colorWithColorValues:endColor]];
}	

+ (FLColorRange*) iPhoneBlueGradientColorRange {

	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange gradientColorsFromColor:[UIColor iPhoneBlueColor] rangeSeperationPercentage:0.3f];
        });

}

+(FLColorRange*) redGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(236,19,20,1.0)  endColor:[UIColor fireEngineRed]];
        });
}

+(FLColorRange*) paleBlueGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(74,108,155,1.0) endColor:FLColorCreateWithRGBColorValues(72,106,154,1.0)];
        });
}

+(FLColorRange*) brightBlueGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(36,99,222,1.0) endColor:FLColorCreateWithRGBColorValues(34,96,221,1.0)];
        });
}

+(FLColorRange*) darkGrayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(71,71,73,1.0) endColor:FLColorCreateWithRGBColorValues(33,33,35,1.0)];
        });
}

+(FLColorRange*) darkGrayWithBlueTintGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(65,71,80,1.0) endColor:FLColorCreateWithRGBColorValues(43,50,59,1.0)];
        });
}

+(FLColorRange*) blackGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:[UIColor darkGrayColor] endColor:[UIColor blackColor]];
        });
}

+(FLColorRange*) grayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(71,71,73,1.0) endColor:FLColorCreateWithRGBColorValues(33,33,35,1.0)];
        });
}

+(FLColorRange*) lightGrayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(128,128,128,1.0)  endColor:FLColorCreateWithRGBColorValues(71,71,73,1.0)];
        });
}

+(FLColorRange*) lightLightGrayGradientColorRange {
	FLReturnStaticObjectFromBlock(^{ 
        return [FLColorRange colorRange:FLColorCreateWithRGBColorValues(250,250,250,1.0)  endColor:FLColorCreateWithRGBColorValues(112,118,118,1.0)];
        });
}



//+ (FLGradientColorPair*) grayGradientColors
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLColorCreateWithRGBColorValues(71,71,73,1.0) endColor:FLColorCreateWithRGBColorValues(33,33,35,1.0)]);
//    return s_color;
//}

//+ (FLGradientColorPair*) deleteButtonRedGradientColors;
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLColorCreateWithRGBColorValues(240,127,136,1.0) endColor:[UIColor fireEngineRed]]);
////    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLColorCreateWithRGBColorValues(240,127,136,1.0) endColor:FLColorCreateWithRGBColorValues(231,53,66,1.0)]);
////    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLColorCreateWithRGBColorValues(236,19,20,1.0)  endColor:[UIColor fireEngineRed]]);
//    return s_color;
//}
//
//+ (FLGradientColorPair*) paleBlueGradientColors
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLColorCreateWithRGBColorValues(74,108,155,1.0) endColor:FLColorCreateWithRGBColorValues(72,106,154,1.0)]);
//    return s_color;
//}
//
//+ (FLGradientColorPair*) brightBlueGradientColors
//{
//    FLSynchronizedStatic(s_color, FLGradientColorPair, [[FLGradientColorPair alloc] initWithStartColor:FLColorCreateWithRGBColorValues(108,147,232,1.0) endColor:FLColorCreateWithRGBColorValues(57,112,224,1.0)]);
//    return s_color;
//}
//
//


@end