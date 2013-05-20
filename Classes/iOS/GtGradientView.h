//
//	GtGradientView.h
//	ShadowedTableView
//
//	Created by Matt Gallagher on 2009/08/21.
//	Copyright (c) 2013 Matt Gallagher. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "GtGradientColorPair.h"

@interface GtGradientView : UIView {
@private
	UIColor* m_gradientStartColor;
	UIColor* m_gradientEndColor;
	CGFloat m_gradientStartAlpha;
	CGFloat m_gradientEndAlpha;
}

@property (readwrite, assign, nonatomic) CGFloat gradientStartAlpha;
@property (readwrite, assign, nonatomic) CGFloat gradientEndAlpha;

@property (readonly, retain, nonatomic) UIColor* gradientStartColor;
@property (readonly, retain, nonatomic) UIColor* gradientEndColor;

- (void) updateGradientColors;

- (void) setGradientToLightLightGray;
- (void) setGradientToDarkDarkGray;
- (void) setGradientToDarkGray;
- (void) setGradientColors:(UIColor*) startColor endColor:(UIColor*) endColor;

- (void) setGradientColors:(GtGradientColorPair*) colors;

+ (GtGradientView*) gradientViewWithColor:(UIColor*) color;

@end

@interface GtBlackGradientView : UIView
@end

typedef void (*GtGradientColorSetter)(GtGradientView* gradient);

extern void GtGradientViewColorDeleteRed(GtGradientView* gradient);
extern void GtGradientViewColorPaleBlue(GtGradientView* gradient);
extern void GtGradientViewColorBrightBlue(GtGradientView* gradient);
extern void GtGradientViewColorDarkGray(GtGradientView* gradient);
extern void GtGradientViewColorDarkGrayWithBlueTint(GtGradientView* gradient);
extern void GtGradientViewColorBlack(GtGradientView* gradient);
extern void GtGradientViewColorGray(GtGradientView* gradient);
extern void GtGradientViewColorLightGray(GtGradientView* gradient);
