//
//	GtRoundRectView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#define GtRoundRectViewCornerRadiusDefault 6
#define GtRoundRectViewBorderLineWidthDefault 1.5

@interface GtRoundRectView : UIView {
@private
	UIColor* m_fillColor;
	UIColor* m_highlightedFillColor;
	UIColor* m_highlightedBorderColor;
	CGFloat m_fillAlpha;
	
	UIColor* m_borderColor;
	CGFloat m_borderAlpha;
	
	CGFloat m_cornerRadius;
	CGFloat m_borderLineWidth;
	
	struct {
		unsigned int highlighted: 1;
	} m_roundRectFlags;
}

@property (readwrite, assign, nonatomic) BOOL highlighted;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@property (readwrite, assign, nonatomic) CGFloat cornerRadius; 
@property (readwrite, assign, nonatomic) CGFloat borderLineWidth;

@property (readwrite, retain, nonatomic) UIColor* fillColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedFillColor;
@property (readwrite, assign, nonatomic) CGFloat fillAlpha;

@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, retain, nonatomic) UIColor* highlightedBorderColor;
@property (readwrite, assign, nonatomic) CGFloat borderAlpha;

//- (CGRect) rectForPath;

@end
