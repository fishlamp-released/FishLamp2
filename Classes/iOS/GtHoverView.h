//
//	GtPopoverView.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtRoundRectView.h"
#import "GtGradientWidget.h"
#import "GtAutoLayoutViewController.h"

typedef enum {
	GtHoverViewArrowDirectionNone,
	GtHoverViewArrowDirectionUp,
	GtHoverViewArrowDirectionDown,
	GtHoverViewArrowDirectionLeft,
	GtHoverViewArrowDirectionRight,
} GtHoverViewArrowDirection;

extern NSString *const GtPopoverViewWasResized;

@interface GtHoverView : UIView {
@private
	GtRoundRectView* m_containerView;
	UIView* m_containedView;
	GtHoverViewArrowDirection m_arrowDirection;
	id m_positionProvider;
	CGRect m_targetRect;
	CGSize m_popoverContentSize;
	GtGradientWidget* m_gradient;
	GtGradientWidget* m_lineGradient;
	struct { 
		unsigned int adjustingForKeyboard: 1;
	} m_state;
}

@property (readwrite, assign, nonatomic) id positionProvider;

@property (readwrite, assign, nonatomic) GtHoverViewArrowDirection arrowDirection;
@property (readwrite, retain, nonatomic) UIView* containedView;

- (void)setHoverViewContentSize:(CGSize)size animated:(BOOL)animated;
@property (readwrite, assign, nonatomic) CGSize hoverViewContentSize;

- (void) addShadow:(UIColor*) color;

@end


