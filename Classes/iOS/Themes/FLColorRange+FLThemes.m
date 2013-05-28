//
//  FLColorRange+FLThemes.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 5/24/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLColorRange+FLThemes.h"

@implementation FLColorRange (FLThemes)

+ (FLColorRange*) colorRangeWithColorRangeName:(FLColorRangeEnum) name {
    switch(name) {
        case FLColorRangeEnumNone:
            return nil;
        
        case FLColorRangeEnumIPhoneBlue:
            return [FLColorRange iPhoneBlueGradientColorRange];
        break;
        
        case FLColorRangeEnumRed:
            return [FLColorRange redGradientColorRange];
        break;
        
        case FLColorRangeEnumPaleBlue:
            return [FLColorRange paleBlueGradientColorRange];
        break;
        
        case FLColorRangeEnumBrightBlue:
            return [FLColorRange brightBlueGradientColorRange];
        break;
        
        case FLColorRangeEnumDarkGray:
            return [FLColorRange darkGrayGradientColorRange];
        break;
        
        case FLColorRangeEnumDarkGrayWithBlueTint:
            return [FLColorRange darkGrayWithBlueTintGradientColorRange];
        break;
        
        case FLColorRangeEnumBlack:
            return [FLColorRange blackGradientColorRange];
        break;
        
        case FLColorRangeEnumGray:
            return [FLColorRange grayGradientColorRange];
        break;
        
        case FLColorRangeEnumLightGray:
            return [FLColorRange lightGrayGradientColorRange];
        break;
        
        case FLColorRangeEnumLightLightGray:
            return [FLColorRange lightLightGrayGradientColorRange];
        break;
    }
    
    return nil;
}

@end
