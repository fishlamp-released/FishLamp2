//
//	FLView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWidgetView.h"

@implementation UIView (FLView)

- (void) themeDidChange {
	[self setNeedsLayout];
	[self setNeedsDisplay];
}
@end

@interface FLWidgetView ()
@property (readwrite, strong, nonatomic) FLWidget* rootWidget;
@end

@implementation FLWidgetView

@synthesize rootWidget = _rootWidget;

- (void) addWidget:(FLWidget*) widget {
    if(widget != _rootWidget) {
        [_rootWidget addWidget:widget];
    } else {
        [super addWidget:widget];
    }
}

- (id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:frame])) {
        self.autoresizesSubviews = NO;
        _rootWidget = [[FLWidget alloc] initWithFrame:self.bounds];
        [self addWidget:_rootWidget];
    }
	return self;
}

- (void) didMoveToSuperview {
	[super didMoveToSuperview];
	if(self.superview) {
		[self applyThemeIfNeeded];
	}
}

- (void) setBackgroundColor:(UIColor*) color {
    [super setBackgroundColor:[UIColor clearColor]];
    _rootWidget.backgroundColor = color;
}

- (void) dealloc {
    FLRelease(_rootWidget);
    FLSuperDealloc();
}

- (void) layoutSubviews {
	[super layoutSubviews];
	_rootWidget.frame = self.bounds;
    [_rootWidget setNeedsLayout];
}

- (void) drawRect:(CGRect) rect {
	[super drawRect:rect];
    [_rootWidget drawWidget:rect];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_rootWidget touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [_rootWidget touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [_rootWidget touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [_rootWidget touchesCancelled:touches withEvent:event];
}

- (FLControlState) controlState {
    return _rootWidget.controlState;
}

- (void) setControlState:(FLControlState) state {
    _rootWidget.controlState = state;
}

- (BOOL) isHighlighted {
	return _rootWidget.isHighlighted;
}

- (void) setHighlighted:(BOOL) highlighted {
    _rootWidget.highlighted = highlighted;
}

- (BOOL) isSelected {
	return _rootWidget.isSelected;
}

- (BOOL) isDoubleSelected {
	return _rootWidget.isDoubleSelected;
}

- (void) setSelected:(BOOL) selected {
    _rootWidget.selected = selected;
}

- (void) setDoubleSelected:(BOOL) selected {
    _rootWidget.doubleSelected = selected;
}

- (BOOL) isDisabled {
	return _rootWidget.isDisabled;
}

- (void) setDisabled:(BOOL) disabled {
    _rootWidget.disabled = disabled;
}


@end

