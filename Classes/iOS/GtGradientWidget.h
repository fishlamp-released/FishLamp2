//
//	GtGradientWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtWidget.h"
#import "UIColor+More.h"

typedef struct {
	GtColorStruct startColor;
	GtColorStruct endColor;
} GtGradientColors;

@interface GtGradientWidget : GtWidget {
@private 
	GtGradientColors m_colors;
	GtGradientColors m_highlightedColors;
	CGFloat m_alpha;
}

@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, assign, nonatomic) GtGradientColors colors;
@property (readwrite, assign, nonatomic) GtGradientColors highlightedColors;

+ (GtGradientColors) gradientColorsForColor:(UIColor*) color;

- (void) setGradientColors:(UIColor*) startColor endColor:(UIColor*) endColor;
- (void) setHighlightedGradientColors:(UIColor*) startColor endColor:(UIColor*) endColor;

@end
