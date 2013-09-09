//
//	FLRoundRectView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/25/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#define FLRoundRectViewCornerRadiusDefault 6
#define FLRoundRectViewBorderLineWidthDefault 1.5

@interface FLRoundRectView : UIView {
@private
	UIColor* _fillColor;
	UIColor* _highlightedFillColor;
	UIColor* _highlightedBorderColor;
	CGFloat _fillAlpha;
	
	UIColor* _borderColor;
	CGFloat _borderAlpha;
	
	CGFloat _cornerRadius;
	CGFloat _borderLineWidth;
	
	struct {
		unsigned int highlighted: 1;
	} _roundRectFlags;
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
