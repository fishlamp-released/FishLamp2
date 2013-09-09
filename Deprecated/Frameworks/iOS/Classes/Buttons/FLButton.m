//
//  FLButton.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLButton.h"
#import "FLRoundRectWidget.h"
#import "FLColorRange.h"
#import "FLTheme.h"

@interface FLButton ()
@end

@implementation FLButton

@synthesize backgroundWidget = _backgroundWidget;
@synthesize shapeWidget = _shapeWidget;
@synthesize onPress = _onPress;
@synthesize buttonColors = _colorizer;
@synthesize buttonStyle = _stylizer;
@synthesize buttonRole = _role;

- (FLWidget*) createShapeWidget {
    return nil;
}

- (void) highlight:(id) sender {
    _shapeWidget.highlighted = YES;
}

- (void) unhighlight:(id) sender {
    _shapeWidget.highlighted = NO;
}

- (void) setPressed:(id) sender {
    _shapeWidget.highlighted = NO;
    if(_onPress) {
        _onPress(self);
    }
}

//- (void) applyTheme:(FLTheme*) theme {
//    [super applyTheme:theme];
//    [theme setButtonColors:self];
//}

- (void) privateInit {
    self.wantsApplyTheme = YES;

    [self addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(highlight:) forControlEvents:UIControlEventTouchDragInside];

    [self addTarget:self action:@selector(unhighlight:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(unhighlight:) forControlEvents:UIControlEventTouchDragOutside];

    [self addTarget:self action:@selector(setPressed:) forControlEvents:UIControlEventTouchUpInside];

	[super setBackgroundColor:[UIColor clearColor]];
	
	self.backgroundWidget = [FLButtonBackgroundWidget buttonBackgroundWidget];
}

- (void) setAlpha:(CGFloat) alpha {
	[super setAlpha:alpha];
	self.backgroundWidget.alpha = alpha;
}

- (void) didMoveToSuperview {
	[super didMoveToSuperview];
	if(self.superview) {
		[self applyThemeIfNeeded];
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    [self privateInit];
	
    if ((self = [super initWithCoder:aDecoder])) {	
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)aRect {
	if ((self = [super initWithFrame: aRect])) {
		[self privateInit];
	}

	return self;
}

- (id) init {
    return [self initWithFrame:CGRectZero];
}

- (id) initWithTitle:(NSString*) title {
    return [self initWithTitle:title onPress:nil];
}

- (id) initWithTitle:(NSString*) title
             onPress:(FLButtonPress) onPress {

    self = [self init];
    if(self) {
        [self setTitle:title forState:UIControlStateNormal];
        self.onPress = onPress;
    }
    
    return self;
}

+ (FLButton*) button {
    return FLAutorelease([[[self class] alloc] initWithFrame:CGRectZero]);
}

+ (FLButton*) buttonWithTitle:(NSString*) title {
    return FLAutorelease([[[self class] alloc] initWithTitle:title]);
}

+ (FLButton*) buttonWithTitle:(NSString*) title
                      onPress:(FLButtonPress) onPress {
    return FLAutorelease([[[self class] alloc] initWithTitle:title onPress:onPress]);
}

- (void) dealloc {
    FLRelease(_stylizer);
    FLRelease(_colorizer);
    FLRelease(_onPress);
    FLRelease(_shapeWidget);
	FLRelease(_backgroundWidget);
	FLSuperDealloc();
}

- (void) layoutSubviews {
    
    if(_colorizer) {
        _colorizer(self);
    }

	_shapeWidget.frame = self.bounds;
    [_shapeWidget setNeedsLayout];

	[super layoutSubviews];
}

- (void) setBackgroundWidget:(FLButtonBackgroundWidget*) widget {
	if(_backgroundWidget) {
		[_backgroundWidget removeFromParent];
	}
	FLSetObjectWithRetain(_backgroundWidget, widget);
	_backgroundWidget.contentMode = FLRectLayoutFill;

	[self.shapeWidget addWidget:_backgroundWidget];
	[self setNeedsLayout];
}

- (void) setShapeWidget:(FLShapeWidget*) widget {
	if(_backgroundWidget) {
		[_backgroundWidget removeFromParent];
	}
	FLSetObjectWithRetain(_shapeWidget, widget);
	_shapeWidget.contentMode = FLRectLayoutFill;
    [self addWidget:_shapeWidget];
    
	if(_backgroundWidget) {
		[_shapeWidget insertWidget:_backgroundWidget atIndex:0];
	}
	
	[self setNeedsLayout];
}

- (void) drawRect:(CGRect) rect {
	[super drawRect:rect];
    [_shapeWidget drawWidget:rect];
}

- (void) setDarkText {
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateDisabled];
}

- (void) setLightText {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];

    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateDisabled];
}
 
- (void) autoSetTextColor {
	
    if(self.backgroundColor.isLightColor) {
		[self setDarkText];
	}
	else {
		[self setLightText];
	}	 
}

- (void) setShapeToRoundRect:(CGFloat) cornerRadius {
	FLRoundRectWidget* widget = [FLRoundRectWidget widgetWithFrame:self.bounds];
    widget.cornerRadius = cornerRadius;
    [self setShapeWidget:widget];
}

- (void) setButtonColors:(FLButtonColorizer) colorizer {
    
    FLCopyObject_(_colorizer, colorizer);
    [self setNeedsLayout];
}

@end

FLButtonColorizer FLButtonColorRed = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(240,127,136,1.0) endColor:FLColorCreateWithRGBColorValues(231,53,66,1.0)] forControlState:UIControlStateNormal] ;
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:/*FLColorCreateWithRGBColorValues(225,1,17,1.0)*/ [UIColor fireEngineRed] endColor:FLColorCreateWithRGBColorValues(236,19,20,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
};
FLButtonColorizer FLButtonColorPaleBlue = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(132,156,187,1.0) endColor:FLColorCreateWithRGBColorValues(89,119,162,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(72,106,154,1.0) endColor:FLColorCreateWithRGBColorValues(74,108,155,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
};
FLButtonColorizer FLButtonColorBrightBlue = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(108,147,232,1.0) endColor:FLColorCreateWithRGBColorValues(57,112,224,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(34,96,221,1.0) endColor:FLColorCreateWithRGBColorValues(36,99,222,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
};
FLButtonColorizer FLButtonColorDarkGray = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(112,112,114,1.0) endColor:FLColorCreateWithRGBColorValues(55,55,57,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(33,33,35,1.0) endColor:FLColorCreateWithRGBColorValues(71,71,73,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
};

FLButtonColorizer FLButtonColorDarkGrayWithBlueTint = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(106,112,118,1.0) endColor:FLColorCreateWithRGBColorValues(55,63,71,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(43,50,59,1.0) endColor:FLColorCreateWithRGBColorValues(65,71,80,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
};
FLButtonColorizer FLButtonColorBlack = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(112,112,112,1.0) endColor:FLColorCreateWithRGBColorValues(54,54,54,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:[UIColor blackColor] endColor:[UIColor blackColor]] forControlState:UIControlStateNormal];
	[button setLightText];
};

FLButtonColorizer FLButtonColorGray = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(112,112,114,1.0) endColor:FLColorCreateWithRGBColorValues(55,55,57,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(33,33,35,1.0) endColor:FLColorCreateWithRGBColorValues(71,71,73,1.0)] forControlState:UIControlStateNormal];
};

FLButtonColorizer FLButtonColorLightGray = ^(FLButton* button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(112,112,114,1.0) endColor:FLColorCreateWithRGBColorValues(55,55,57,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLColorCreateWithRGBColorValues(33,33,35,1.0) endColor:FLColorCreateWithRGBColorValues(71,71,73,1.0)] forControlState:UIControlStateNormal];
};




