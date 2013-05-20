//
//	GtTableViewCellwidgetBehavior.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWidget.h"
#import "GtApplication.h"
#import <objc/runtime.h>

@interface GtDeallocNotifier : NSObject {
@private
    GtCallback m_callback;
}
- (id) initWithTarget:(id) target action:(SEL) action;
+ (GtDeallocNotifier*) deallocNotifier:(id) target action:(SEL) action;
@end

@interface NSObject (GtDeallocNotifier)
- (void) addDeallocNotifier:(GtDeallocNotifier*) notifier;
@end

static void * const kNotifierKey = (void*)&kNotifierKey;

@implementation NSObject (GtDeallocNotifier) 
- (void) addDeallocNotifier:(GtDeallocNotifier*) kNotifierKey
{
    objc_setAssociatedObject(self, &kNotifierKey, kNotifierKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation GtDeallocNotifier 

- (id) initWithTarget:(id) target action:(SEL) action
{
    if((self = [super init]))
    {
        m_callback = GtCallbackMake(target, action);
    }
    
    return self;
}

+ (GtDeallocNotifier*) deallocNotifier:(id) target action:(SEL) action
{
    return GtReturnAutoreleased([[GtDeallocNotifier alloc] initWithTarget:target action:action]);
}

- (void) dealloc
{
    GtCallbackPerformWithObject(m_callback, nil);
    GtSuperDealloc();
}

@end


@interface GtWidget ()
@property (readwrite, assign, nonatomic) id parent;
@end

@interface UIView (GtWidget)
- (UIView*) view;
@end

static void * const kWidgetsKey = (void*)&kWidgetsKey;

@implementation UIView (Widget)

- (NSArray*) widgets
{
    return objc_getAssociatedObject(self, &kWidgetsKey);
}

- (void) removeAllWidgets
{
    NSArray* widgets = self.widgets;
    if(widgets)
    {
        objc_setAssociatedObject(self, &kWidgetsKey, nil, OBJC_ASSOCIATION_ASSIGN);
        for(GtWidget* widget in widgets)
        {
            widget.parent = nil;
            [widget didMoveToParent];
        }
        GtRelease(widgets);
    }
}

- (void) _deallocWasCalled:(id) sender
{
    [self removeAllWidgets];
}

- (NSMutableArray*) _widgets
{
    NSMutableArray* widgets = (NSMutableArray*) self.widgets;
    if(!widgets)
    {
        widgets = [[NSMutableArray alloc] init];
        [self addDeallocNotifier:[GtDeallocNotifier deallocNotifier:self action:@selector(_deallocWasCalled:)]];
        objc_setAssociatedObject(self, &kWidgetsKey, widgets, OBJC_ASSOCIATION_ASSIGN);
    }
    return widgets;
}   

- (void) addWidget:(GtWidget*) widget
{
    [widget removeFromParent];
    [self._widgets addObject:widget];
    widget.parent = self;
    [widget didMoveToParent];
}

- (void) removeWidget:(GtWidget*) widget
{
    [self._widgets removeObject:widget];
    widget.parent = nil;
	[widget didMoveToParent];
}



@end

@implementation UIView (GtWidget)
- (UIView*) view
{
    return self;
}   
@end

@implementation GtWidget

@synthesize frame = m_frame;
@synthesize layoutMode = m_locationMode;
@synthesize subwidgets = m_widgets;
@synthesize parent = m_parent;
@synthesize themeAction = m_themeAction;
@synthesize highlighter = m_highlighter;
@synthesize backgroundColor = m_backgroundColor;
@synthesize backgroundWidget = m_backgroundWidget;
@synthesize touchHandler = m_touchHandler;
@synthesize userData = m_userData;
@synthesize userInteractionEnabled = m_userInteractionEnabled;
@synthesize widgetDelegate = m_widgetDelegate;


GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_state);
GtSynthesizeStructProperty(isParentHidden, setParentHidden, BOOL, m_state);

- (void) setTouchHandler:(GtTouchHandler*) touchHandler
{
    if(m_touchHandler)
    {
        m_touchHandler.touchableObject = nil;
    }
    
    GtAssignObject(m_touchHandler, touchHandler);
    m_touchHandler.touchableObject = self;
}

- (void) setLayoutFrame:(CGRect) layoutFrame
{
    [self setFrameOptimizedForLocation:layoutFrame];
}

- (void) layoutInBounds:(CGRect) bounds
{
}

- (id) init
{
	return [self initWithFrame:CGRectZero];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super init]))
	{
		m_frame = frame;
	}
	
	return self;
}

+ (id) widgetWithFrame:(CGRect) frame
{
	return GtReturnAutoreleased([[[self class] alloc] initWithFrame:frame]);
}

+ (id) widget
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (BOOL) isUserInteractionEnabled
{
    return m_touchHandler != nil;
}

- (void) setBackgroundColor:(UIColor*) color
{
	if(GtAssignObject(m_backgroundColor, color))
	{
		[self setNeedsDisplay];
	}
}
- (void) teardown
{
	self.parent = nil;
}

- (void) removeAllSubwidgets
{
    if(m_backgroundWidget)
	{
        [m_backgroundWidget teardown];
        GtReleaseWithNil(m_backgroundWidget);
    }
    for(GtWidget* widget in m_widgets)
	{
        [widget teardown];
    }
	GtReleaseWithNil(m_widgets);
}

- (void) dealloc
{
    [self teardown];
	[self removeAllSubwidgets];

    m_touchHandler.touchableObject = nil;
    GtRelease(m_touchHandler);
	GtRelease(m_backgroundColor);
    GtRelease(m_userData);
	GtSuperDealloc();
}

- (void) setNeedsLayout
{
	if(	self.frame.size.width > 0 && self.frame.size.height > 0)
	{
		[self layoutSubwidgets];
		
//		if(self.viewLayout)
//		{
//			CGSize size = [self.viewLayout layoutArrangeableViews:m_widgets inBounds:self.frame];
//
//            if(GtBitMaskTest(self.viewLayoutBehavior, GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout))
//            {
//                self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, size);
//            }
//
//// TODO: remove this extra loop
//            for(GtWidget* widget in m_widgets)
//            {
//                [widget setNeedsLayout];
//            }
//		}
//        else
        {
            for(GtWidget* widget in m_widgets)
            {
                widget.frame = GtRectLayoutRectInRect(widget.layoutMode, self.frame, widget.frame);
                [widget setNeedsLayout];
            }
        }
		
//		if(self.viewLayout && GtBitMaskTest(self.viewLayoutBehavior, GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout))
//		{
//			[self.viewLayout setViewSize:self];
//		}

		if(m_backgroundWidget)
		{
			m_backgroundWidget.frame = self.frame;
		}

		[self setNeedsDisplay];
	}
}

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint
{
    return hint.size;
}

- (void) visitSubwidgets:(GtWidgetEvent) visitor
{
	GtAssertNotNil(visitor);
    if(visitor)
    {
        for(GtWidget* widget in self.subwidgets)
        {
            [widget visitSubwidgets:visitor];
            visitor(widget);
        }
    }
}

- (void) themeDidChange
{
	if(self.themeAction)
	{
		[GtThemeManager applyThemeToObject:self themeAction:self.themeAction];
		
		[self setNeedsLayout];
	}
	
	for(GtWidget* subview in m_widgets)
	{
		[subview themeDidChange];
	}
}

- (NSMutableString*) moreDescription
{
	return nil;
}

- (NSString*) description
{
	NSString* moreDescription = [self moreDescription];
	return [NSString stringWithFormat:@"<%@; parent:%@; frame:%@; in view:%@;%@>", 
        [super description],
		NSStringFromClass([self.parent class]), 
		NSStringFromCGRect(self.frame), 
		[self.view description],
		moreDescription ? moreDescription : @""
		];
}

- (void) layoutSubwidgets
{
}

//- (void) setSuperview:(UIView*) view
//{
//	[self applyTheme];
//	if(m_backgroundWidget)
//	{
//		m_backgroundWidget.superview = view;
//	}
//	for(GtWidget* widget in m_widgets)
//	{
//		widget.superview = view;
//	}
//}

- (BOOL)pointInside:(CGPoint)point
{
	return CGRectContainsPoint(self.frame, point);
}	

- (CGRect) frameOptimizedForLocation
{
	return GtRectMoveRectToOptimizedLocationIfNeeded(self.frame);
}

- (void) setFrameOptimizedForLocation:(CGRect) frame
{
	self.frame = GtRectMoveRectToOptimizedLocationIfNeeded(frame);
}

- (CGRect) frameOptimizedForSize
{
	return GtRectGrowRectToOptimizedSizeIfNeeded(self.frame);
}

- (void) setFrameOptimizedForSize:(CGRect) frame
{
	self.frame = GtRectGrowRectToOptimizedSizeIfNeeded(frame);
}

- (BOOL) isFrameOptimized
{
	return GtRectIsOptimizedForView(self.frame);
}

- (void) setFrame:(CGRect) frame
{
#if DEBUG
	if(frame.origin.x > 5000 || frame.origin.x < -5000)
	{
		GtLog(@"widget frame is out of bounds");
	}
#endif

	if(!CGRectEqualToRect(frame, m_frame))
	{
#if DEBUG
		if(!GtRectIsIntegral(frame))
		{
			GtLog(@"Warning setting non-integral rect in widget: %@", NSStringFromCGRect(frame));
		}
#endif	
	
		CGPoint offset = GtPointSubtractPointFromPoint(frame.origin, self.frame.origin);
		if(!CGPointEqualToPoint(offset, CGPointZero))
		{
			for(GtWidget* widget in m_widgets)
			{
				[widget moveFrameBy:offset];
			}
		}
		
		[self setNeedsDisplay];
		m_frame = frame;	
		
		if(m_backgroundWidget)
		{
			m_backgroundWidget.frame = frame;
		}
		[self setNeedsDisplay];
		
#if DEBUG
		[UIView warnIfNonIntegralFramesInViewHierarchy:self.view];
#endif
	}
}

- (void) moveFrameBy:(CGPoint) offset
{
	self.frame = GtRectMoveWithPoint(self.frame, offset);
}

- (BOOL) setFrameIfChanged:(CGRect) frame
{
	CGRect prev = m_frame;
	self.frame = frame;
	return !CGRectEqualToRect(m_frame, prev);
}

- (void) _updateParentHidden
{
    self.parentHidden = [m_parent isHidden];
    [self visitSubwidgets:^(id widget){
        [widget _updateParentHidden];
    }];
}

- (BOOL) isHidden
{
	return  m_parent == nil || 
            m_state.isHidden || 
            m_state.isParentHidden;
}

- (void) setHidden:(BOOL) hidden
{
	if(m_state.isHidden != hidden)
	{
		m_state.isHidden = hidden;
		[self setNeedsDisplay];
        
        [self _updateParentHidden];
	}
}

- (BOOL) isHighlighted
{
	return m_state.isHighlighted;
}

- (void) setHighlighted:(BOOL) highlighted
{
//	if(highlighted != (BOOL) m_state.isHighlighted)
	{
		if(m_backgroundWidget)
		{
			m_backgroundWidget.highlighted = highlighted;
		}
	
		for(GtWidget* widget in m_widgets)
		{
			widget.highlighted = highlighted;
		}
	
		m_state.isHighlighted = highlighted;
		
		[self.view setNeedsDisplay];
	}
}

- (BOOL) isSelected
{
	return m_state.isSelected;
}

- (void) setSelected:(BOOL) selected
{
	if(selected != (BOOL) m_state.isSelected)
	{
		m_state.isSelected = selected;
	
		for(GtWidget* widget in m_widgets)
		{
			widget.selected = selected;
		}
		[self setNeedsDisplay];
	}
}

- (BOOL) isDisabled
{
	return m_state.isDisabled;
}

- (void) setDisabled:(BOOL) disabled
{
	if(disabled != (BOOL) m_state.isDisabled)
	{
		if(m_backgroundWidget)
		{
			m_backgroundWidget.disabled = disabled;
		}
	
		for(GtWidget* widget in m_widgets)
		{
			widget.disabled = disabled;
		}
	
		m_state.isDisabled = disabled;
		[self setNeedsDisplay];
	}
}

- (GtWidget *)hitTest:(CGPoint)point interactiveCellsOnly:(BOOL) interactiveCellsOnly
{
	for(GtWidget* widget in m_widgets)
	{
		if(!widget.isHidden && CGRectContainsPoint(widget.frame, point))
		{
			GtWidget* touched = [widget hitTest:point interactiveCellsOnly:interactiveCellsOnly];
			if(touched)
			{
				return touched;
			}
		}
	}
	
	if([self pointInside:point] && (self.isUserInteractionEnabled || !interactiveCellsOnly))
	{
		return self;
	} 
	
	return nil;
}

- (void) setNeedsDisplay
{
//	  GtRect bigger = CGRectMake(self.frame.origin.x - 4.0, self.rame.origin.y - 4.0
	if(self.view)
	{
		[self.view setNeedsDisplayInRect:CGRectInset(self.frame, -4.0,-4.0)];
	}
}

- (void) layoutWithLayoutModeInRect:(CGRect) containerRect
{
	self.frameOptimizedForSize = GtRectLayoutRectInRect(self.layoutMode, containerRect, self.frame); 
}

- (void) _setSuperwidget:(GtWidget*) widget
{
	self.parent = widget;
	[self didMoveToParent];
}

- (void) didMoveToParent
{
    if(m_parent)
    {
        [self applyTheme];
        [self _updateParentHidden];
    }
}

- (void) addSubwidget:(GtWidget*) widget 
{
	if(!m_widgets)
	{
		m_widgets = [[NSMutableArray alloc] init];
	}
	
	GtRetain(widget);
    if(widget.parent)
    {
        [widget removeFromParent];
    }

	[m_widgets addObject:widget];
	widget.parent = self;
	[widget didMoveToParent];
	GtRelease(widget);
}

- (void) removeSubwidget:(GtWidget*) widget
{
	GtAssert(widget.parent == self, @"attempting to remove subwidget from non-owning superwidget");
	GtAutorelease(GtRetain(widget));
	
    widget.parent = nil;
    [m_widgets removeObject:widget];
	[widget didMoveToParent];
	[self setNeedsDisplay];
}

- (void) removeFromParent
{
	[m_parent removeSubwidget:self];
}

- (GtWidget*) subwidgetAtIndex:(NSUInteger) idx
{
	return [m_widgets objectAtIndex:idx];
}

- (void) updateState
{
	for(GtWidget* widget in m_widgets)
	{
		[widget updateState];
	}
}

- (void) drawRect:(CGRect) drawRect
{
	for(GtWidget* widget in m_widgets)
	{
		if(!widget.isHidden && CGRectIntersectsRect(widget.frame, drawRect) && CGRectIntersectsRect(widget.frame, self.frame))
		{
			[widget drawInRect:drawRect];
		}
	}
}

- (void) drawInRect:(CGRect) drawRect
{
	if(self.backgroundColor)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);
		[self.backgroundColor setFill];
		CGContextFillRect( context , self.frame );
		CGContextRestoreGState(context);
	}

	if(m_backgroundWidget)
	{
		[m_backgroundWidget drawInRect:drawRect];
	}

//	if(self.isHighlighted && m_touchHandler && m_touchHandler.touchHighlighter && m_touchHandler.isTouching)
//	{
//		m_touchHandler.touchHighlighter(self, drawRect);
//	}
	
	[self drawRect:drawRect];
}

- (GtWidget*) topInteractiveWidget
{
	for(GtWidget* widget in m_widgets)
	{
		if(!widget.isHidden && widget.isUserInteractionEnabled)
		{
			return widget;
		}
	}
	for(GtWidget* widget in m_widgets)
	{
		if(widget.isUserInteractionEnabled)
		{
			GtWidget* outWidget = [widget topInteractiveWidget];
			if(outWidget)
			{
				return outWidget;
			}
		}
	}
	
	return nil;
}

- (UIView*) view
{
    return m_parent ? [m_parent view] : nil;
}

- (UIView*) superview {
    return self.view;
}

@end

@implementation GtWidget (GtViewLayout)

//- (CGRect) bounds
//{
//	return self.frame;
//}

-(void) visitSubviews:(GtViewVisitor) visitor
{
	[self visitSubwidgets:visitor];
}
@end


void (^GtWidgetSunburstHighlighter)(GtWidget* viewwidget, CGRect rect) = ^(GtWidget* viewwidget, CGRect rect)
{
	viewwidget.view.clipsToBounds = NO;
	viewwidget.view.superview.clipsToBounds = NO;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

//	  CGRect bigRect = GtRectScale(viewwidget.frame, 4.0);
//	  bigRect = GtRectCenterOnPoint(bigRect, GtRectGetCenter(viewwidget.frame));

	CGPoint startPoint = GtRectGetCenter(viewwidget.frame);
	CGPoint endPoint = startPoint;
   
	GtColorStruct color = [UIColor whiteColor].colorStruct;
	GtColorStruct end = [UIColor grayColor].colorStruct;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] =
	{
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

