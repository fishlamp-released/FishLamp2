//
//	FLTableViewCellwidgetBehavior.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLWidget.h"
#import "FLApplication.h"

@interface FLWidget ()
@property (readwrite, assign, nonatomic, getter=isParentHidden) BOOL parentHidden;
@end

@interface UIView (FLWidgetPrivate)
- (UIView*) view;
@end

@implementation UIView (FLWidgetPrivate)
- (UIView*) view {
    return self;
}   
@end

@implementation FLWidget 
@synthesize subwidgets = _widgets;
@synthesize parent = _parent;
@synthesize backgroundColor = _backgroundColor;
@synthesize touchHandler = _touchHandler;
@synthesize userData = _userData;
@synthesize parentHidden = _parentHidden;
@synthesize alpha = _alpha;
@synthesize arrangement = _arrangement;
@synthesize userInteractionEnabled = _userInteractionEnabled;
@synthesize contentMode = _contentMode;
@synthesize tag = _tag;

- (void) setTouchHandler:(FLTouchHandler*) touchHandler {
    if(_touchHandler) {
        _touchHandler.touchableObject = nil;
    }
    
    FLAssignObject(_touchHandler, touchHandler);
    _touchHandler.touchableObject = self;
    
    __block id myself = self;
    _touchHandler.onSelected = ^(id widget) {
// TODO: should we just pass the widget instead of self? ARC conversion issue
        [self.view widgetWasTouched:myself];
    };
}

- (void) setLayoutFrame:(FLRect) layoutFrame {
    [self setFrameOptimizedForLocation:layoutFrame];
}

- (void) layoutInBounds:(FLRect) bounds {
}

- (id) init {
	return [self initWithFrame:CGRectZero];
}

- (id) initWithFrame:(FLRect) frame {   
    self = [super initWithFrame:frame];
	if(self) {
        _alpha = 1.0;
	}
	
	return self;
}

+ (id) widgetWithFrame:(FLRect) frame {
	return FLReturnAutoreleased([[[self class] alloc] initWithFrame:frame]);
}

+ (id) widget {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) setBackgroundColor:(UIColor*) color {
	FLAssignObject(_backgroundColor, color);
    [self setNeedsDisplay];
}

- (void) teardown {
	self.parent = nil;
}

- (void) removeAllWidgets {   
    NSArray* widgets = _widgets;
    _widgets = nil;

    for(FLWidget* widget in widgets) {
        [widget removeFromParent];
    }

	FLRelease(widgets);
}

- (void) setAlpha:(CGFloat) alpha {
    if(!FLFloatEqualToFloat(alpha, alpha)) {
        _alpha = alpha;
        [self setNeedsDisplay];
    }
}

- (void) dealloc {
    [self teardown];
	[self removeAllWidgets];

    _touchHandler.touchableObject = nil;
    FLRelease(_arrangement);
    FLRelease(_touchHandler);
	FLRelease(_backgroundColor);
    FLRelease(_userData);
	FLSuperDealloc();
}

- (void) setNeedsLayout {
	if(	self.frame.size.width > 0 && self.frame.size.height > 0) {
        for(FLWidget* widget in _widgets) {
            widget.frame = FLRectPositionRectInRectWithContentMode(self.frame, widget.frame,widget.contentMode);
            [widget setNeedsLayout];
        }
               
        [self layoutWidgets];
        [self setNeedsDisplay];
	}
}

- (void) visitWidgets:(void (^)(id widget, BOOL* stop)) visitor stop:(BOOL*) stop {
    for(FLWidget* widget in self.subwidgets) {

        visitor(widget, stop);

        if(*stop) {
            return;
        }
        
        [widget visitWidgets:visitor stop:stop];
        
        if(*stop) {
            return;
        }
        
    }
    
}

- (void) visitWidgets:(void (^)(id widget, BOOL* stop)) visitor {
	FLAssertIsNotNil_(visitor);
    BOOL stop = NO;
    [self visitWidgets:visitor stop:&stop];
}

- (void) didApplyTheme {
    [self setNeedsLayout];
}

- (NSMutableString*) moreDescription {
	return nil;
}

- (NSString*) description {
    id parent = self.parent;

	NSString* moreDescription = [self moreDescription];
	return [NSString stringWithFormat:@"%@: parent:%@; frame:%@; in view:%@;%@",
		[super description],
		NSStringFromClass([parent class]),
		NSStringFromCGRect(self.frame), 
		[self.view description],
		moreDescription ? moreDescription : @""
		];
}

- (void) layoutWidgets {
}

- (void) setFrame:(FLRect) frame {
#if DEBUG
	if(frame.origin.x > 5000 || frame.origin.x < -5000) {
		FLLog(@"widget frame is out of bounds");
	}
#endif

	if(!CGRectEqualToRect(frame, self.frame)) {
#if DEBUG
		if(!FLRectIsIntegral(frame)) {
			FLLog(@"Warning setting non-integral rect in widget: %@", NSStringFromCGRect(frame));
		}
#endif	
	
		FLPoint offset = FLPointSubtractPointFromPoint(frame.origin, self.frame.origin);
		if(!CGPointEqualToPoint(offset, CGPointZero)) {
			for(FLWidget* widget in _widgets) {
				[widget moveFrameBy:offset];
			}
		}
		
		[self setNeedsDisplay];
		[super setFrame:frame];	

		[self setNeedsDisplay];
		
#if DEBUG
		[UIView warnIfNonIntegralFramesInViewHierarchy:self.view];
#endif
	}
}

- (void) _updateParentHidden {
    id parent = _parent;
    self.parentHidden = [parent isHidden];
    [self visitWidgets:^(id widget, BOOL* stop){
        [widget _updateParentHidden];
    }];
}

- (BOOL) isHidden {
	return  _parent == nil || 
            [super isHidden] || 
            _parentHidden;
}

- (void) setHidden:(BOOL) hidden {
	if([super isHidden] != hidden) {
		[super setHidden:hidden];
		[self setNeedsDisplay];
        [self _updateParentHidden];
	}
}

- (void) setControlState:(FLControlState) controlState {
    [super setControlState:controlState];
        
    [self visitWidgets:^(id widget, BOOL* stop) {
        [widget setControlState:controlState];
    }];

    [self.view setNeedsDisplay];
}

- (FLWidget *)hitTest:(FLPoint)point interactiveCellsOnly:(BOOL) interactiveCellsOnly {
	for(FLWidget* widget in _widgets) {
		if(!widget.isHidden && CGRectContainsPoint(widget.frame, point)) {
			FLWidget* touched = [widget hitTest:point interactiveCellsOnly:interactiveCellsOnly];
			if(touched) {
				return touched;
			}
		}
	}
	
	if([self pointIsInside:point] && (self.canBeTouched || !interactiveCellsOnly)) {
		return self;
	} 
	
	return nil;
}

- (void) setNeedsDisplay {
	if(self.view) {
		[self.view setNeedsDisplayInRect:CGRectInset(self.frame, -4.0,-4.0)];
	}
}

- (void) didMoveToParent {
    if(_parent) {
        [self applyThemeIfNeeded];
        [self _updateParentHidden];
    }
}

- (FLWidget*) widgetAtIndex:(NSUInteger) widgetIndex {
    return [_widgets objectAtIndex:widgetIndex];
}

- (void) addWidget:(FLWidget*) widget  {
    [self insertWidget:widget atIndex:_widgets ? _widgets.count : 0];
}

- (void) insertWidget:(FLWidget*) widget atIndex:(NSUInteger) index {
	if(!_widgets) {
		_widgets = [[NSMutableArray alloc] init];
	}
	
    FLAssert_v(widget != self, @"can't add yourself to your subwidgets!");
    FLAssert_v(widget != self.parent, @"can't add your parent to your subwidgets!");
    
	[_widgets insertObject:widget atIndex:index];
	if(widget.parent) {
        [widget removeFromParent];
    }

	widget.parent = self;
	[widget didMoveToParent];
}

- (void) willRemoveWidget:(FLWidget*) widget {
}

- (void) removeWidget:(FLWidget*) widget {
	FLAssert_v(widget.parent == self, @"attempting to remove subwidget from non-owning superwidget");
    if(_widgets && widget.parent == self) {
        FLAutorelease(FLReturnRetain(widget));
        [_widgets removeObject:widget];
        widget.parent = nil;
        [self setNeedsDisplay];
    }    
}

- (void) removeFromParent {
    id parent = _parent;
    if(parent) {
        [parent willRemoveWidget:self];
        [parent removeWidget:self];
        [self didMoveToParent];
    }
}

- (void) drawSelf:(FLRect) rect {
    FLAssertIsNotNil_(self.parent);

    for(FLWidget* widget in _widgets) {
        if(!self.isHidden && 
            CGRectIntersectsRect(widget.frame, rect) &&  // if widget intersects drawing area.
            CGRectIntersectsRect(widget.frame, self.frame)) { // if widget intersects parent frame
            [widget drawWidget:rect];
        }
    }
}

- (void) drawWidget:(FLRect) drawRect {
    FLAssertIsNotNil_(self.parent);


TODO("MF: optimize this.")

//  The color with alpha can be created when either the background color or alpha is changed 
//  and it can be member data instead of the UIColor for the background.

//  I Also don't ike the comparison for check the clear color. 
//  When setting the color property for a widget if the color is the clear color, just
//  set the background color to nil, then we can avoid the comparison while drawing.

	if(!self.isHidden && CGRectIntersectsRect(self.frame, drawRect)) {
        if(self.backgroundColor && ![self.backgroundColor isEqual:[UIColor clearColor]]) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            CGColorRef fillColor = CGColorCreateCopyWithAlpha(self.backgroundColor.CGColor, self.alpha);
            CGContextSetFillColorWithColor(context, fillColor);
            CGContextFillRect( context , CGRectIntersection(self.frame, drawRect) );
            CGContextRestoreGState(context);
            CGColorRelease(fillColor);
       }

        [self drawSelf:drawRect];
    }
}

- (FLWidget*) topInteractiveWidget {
	for(FLWidget* widget in _widgets) {
		if(widget.canBeTouched) {
			return widget;
		}
	}
	for(FLWidget* widget in _widgets) {
		if(widget.canBeTouched) {
			FLWidget* outWidget = [widget topInteractiveWidget];
			if(outWidget) {
				return outWidget;
			}
		}
	}
	
	return nil;
}

- (id) objectByMoniker:(id) aMoniker {
    id outObj = [self objectByMoniker:aMoniker];
    if(!outObj) {
        for(FLWidget* widget in _widgets) {
            outObj = [widget objectByMoniker:aMoniker];
            if(outObj) {
                break;
            }
        }
    }

    return outObj;
}

- (UIView*) view {
    id parent = _parent;
    return parent ? [parent view] : nil;
}

- (BOOL) canBeTouched {
    return  self.touchHandler != nil && 
            !self.touchHandler.isDisabled && 
            !self.isDisabled && 
            !self.isHidden && 
            !_parentHidden;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    if(self.canBeTouched) {
        if(self.touchHandler) {
            [self.touchHandler touchesBegan:touches withEvent:event];
        }
    }    
    
    for(FLWidget* widget in _widgets) {
        [widget touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.canBeTouched) {
        if(self.touchHandler) {
            [self.touchHandler touchesMoved:touches withEvent:event];
        }
    }
    for(FLWidget* widget in _widgets) {
        [widget touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.canBeTouched) {
        if(self.touchHandler) {
            [self.touchHandler touchesEnded:touches withEvent:event];
        }
    }
    for(FLWidget* widget in _widgets) {
        [widget touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if(self.canBeTouched) {
        if(self.touchHandler) {
            [self.touchHandler touchesCancelled:touches withEvent:event];
        }
    }
    for(FLWidget* widget in _widgets) {
        [widget touchesCancelled:touches withEvent:event];
    }
}

- (void) didMoveToGridCell:(FLGridCell*) cell {
    _gridViewCell = cell;
    for(FLWidget* view in self.subwidgets) {
        [view didMoveToGridCell:cell];
    }
}

- (id) gridCell {
    return _gridViewCell;
}

@end

@implementation FLWidget (FLArrangeable)

- (id) lastSubwidgetByWeight:(FLArrangeableWeight) weight {
    return [NSObject lastSubframeByWeight:weight subframes:self.subwidgets];
}

- (void) layoutSubwidgetsWithArrangement:(BOOL) adjustSize {
    FLArrangement* layout = self.arrangement;
    if(layout) {
        FLRect bounds = [self frame];
        bounds.size = [layout performArrangement:[self subwidgets] inBounds:bounds];
        if(adjustSize) {
            [self setFrame:bounds];
        }
    }

    for(id subview in self.subwidgets) {
        [subview layoutSubwidgetsWithArrangement:YES];
    }
}

//-(void) visitSubviews:(void (^)(id view)) visitor {
//	[self visitWidgets:visitor];
//}


//- (void) autoPositionInRect:(FLRect) bounds;
- (void) autoPositionInRect:(FLRect) bounds {
    self.frameOptimizedForLocation = FLRectPositionRectInRectWithContentMode(bounds, self.frame, self.contentMode);
}



@end

void (^FLWidgetSunburstHighlighter)(FLWidget* viewwidget, FLRect rect) = ^(FLWidget* viewwidget, FLRect rect) {
	viewwidget.view.clipsToBounds = NO;
	viewwidget.view.superview.clipsToBounds = NO;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

//	  FLRect bigRect = FLRectScale(viewwidget.frame, 4.0);
//	  bigRect = FLRectCenterOnPoint(bigRect, FLRectGetCenter(viewwidget.frame));

	FLPoint startPoint = FLRectGetCenter(viewwidget.frame);
	FLPoint endPoint = startPoint;
   
	FLColor_t color = [UIColor whiteColor].color_t;
	FLColor_t end = [UIColor grayColor].color_t;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] = {
		color.red,	color.green, color.blue, 0.80,
		end.red,	end.green, end.blue, 0.0,
	};
	CGGradientRef	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(rgb);	 

	CGContextSetShadowWithColor(context, 
					CGSizeZero, 
					20.0, 
					[UIColor blackColor].CGColor);

	CGFloat sunburstSize = 26.0f;

	CGContextDrawRadialGradient(context, 
		gradient, 
		startPoint, 
		sunburstSize * 0.25, // 0.125, 
		endPoint, 
		sunburstSize * 1.25f, 
		kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
	
};

