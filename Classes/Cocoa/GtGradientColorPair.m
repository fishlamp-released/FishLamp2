//
//  GtGradientColorPair.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/28/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientColorPair.h"

@implementation GtGradientColorPair

@synthesize startColor = m_startColor;
@synthesize endColor = m_endColor;

- (id) initWithStartColor:(UIColor*) startColor endColor:(UIColor*) endColor
{
    if((self = [super init]))
    {
        m_startColor= GtRetain(startColor);
        m_endColor = GtRetain(endColor);
    }
    
    return self;
}

+ (GtGradientColorPair*) gradientColorPair:(UIColor*) startColor endColor:(UIColor*) endColor
{
    return GtReturnAutoreleased([[GtGradientColorPair alloc] initWithStartColor:startColor endColor:endColor]);
}

- (void) dealloc
{   
    GtRelease(m_startColor);
    GtRelease(m_endColor);
    GtSuperDealloc();
}

@end

@implementation GtGradientColorPair (GtGradientColors)

+ (GtGradientColorPair*) grayGradientColors
{
    return [[[GtGradientColorPair alloc] initWithStartColor:GtRgbColor(71,71,73,1.0) endColor:GtRgbColor(33,33,35,1.0)] autorelease];
}

+ (GtGradientColorPair*) deleteButtonRedGradientColors;
{
    return [[[GtGradientColorPair alloc] initWithStartColor:GtRgbColor(240,127,136,1.0) endColor:[UIColor fireEngineRed]] autorelease];
}

+ (GtGradientColorPair*) paleBlueGradientColors
{
    return [[[GtGradientColorPair alloc] initWithStartColor:GtRgbColor(74,108,155,1.0) endColor:GtRgbColor(72,106,154,1.0)] autorelease];
}

+ (GtGradientColorPair*) brightBlueGradientColors
{
    return [[[GtGradientColorPair alloc] initWithStartColor:GtRgbColor(108,147,232,1.0) endColor:GtRgbColor(57,112,224,1.0)] autorelease];
}



@end

/*

 void GtGradientViewColorDeleteRed(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(236,19,20,1.0)  endColor:[UIColor fireEngineRed]];
 }
 void GtGradientViewColorPaleBlue(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(74,108,155,1.0) endColor:GtRgbColor(72,106,154,1.0)];
 }
 void GtGradientViewColorBrightBlue(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(36,99,222,1.0) endColor:GtRgbColor(34,96,221,1.0)];
 }
 void GtGradientViewColorDarkGray(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(71,71,73,1.0) endColor:GtRgbColor(33,33,35,1.0)];
 }
 
 void GtGradientViewColorDarkGrayWithBlueTint(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(65,71,80,1.0) endColor:GtRgbColor(43,50,59,1.0)];
 }
 void GtGradientViewColorBlack(GtGradientView* gradient)
 {
 [gradient setGradientColors:[UIColor darkGrayColor] endColor:[UIColor blackColor]];
 }
 
 void GtGradientViewColorGray(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(71,71,73,1.0) endColor:GtRgbColor(33,33,35,1.0)];
 }
 
 void GtGradientViewColorLightGray(GtGradientView* gradient)
 {
 [gradient setGradientColors:GtRgbColor(71,71,73,1.0)  endColor:GtRgbColor(33,33,35,1.0)];
 }
 
 */