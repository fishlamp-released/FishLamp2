//
//  GtGradientColorPair.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/28/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@interface GtGradientColorPair : NSObject {
@private
    UIColor* m_startColor;
    UIColor* m_endColor;
}

@property (readonly, retain, nonatomic) UIColor* startColor;
@property (readonly, retain, nonatomic) UIColor* endColor;

- (id) initWithStartColor:(UIColor*) startColor endColor:(UIColor*) endColor;

+ (GtGradientColorPair*) gradientColorPair:(UIColor*) startColor endColor:(UIColor*) endColor;


@end


@interface GtGradientColorPair (GtGradientColors)

+ (GtGradientColorPair*) grayGradientColors;

+ (GtGradientColorPair*) deleteButtonRedGradientColors;

+ (GtGradientColorPair*) paleBlueGradientColors;

+ (GtGradientColorPair*) brightBlueGradientColors;


@end