//
//	GtTableViewCellContentBehavior.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtCallbackObject.h"
#import "GtRectLayout.h"
#import "GtCallback.h"
#import "GtViewLayout.h"
#import "GtTouchHandler.h"

@class GtWidget;

typedef void (^GtWidgetEvent)(id widget);

@class GtWidget;

@interface UIView (Widget)
@property (readonly, retain, nonatomic) NSArray* widgets;
- (void) addWidget:(GtWidget*) widget;
- (void) removeWidget:(GtWidget*) widget;
- (void) removeAllWidgets;
@end

@protocol GtWidgetDelegate <NSObject>
@end

@interface GtWidget : NSObject {
@private
	id m_parent; // not retained.
	
    NSMutableArray* m_widgets;
	GtWidget* m_backgroundWidget;
    UIColor* m_backgroundColor;
    
    CGRect m_frame;
	SEL m_themeAction;

	GtCustomHighlighter m_highlighter;
	
	struct {
		unsigned int isHidden:1;
		unsigned int isSelected:1;
		unsigned int isHighlighted:1;
		unsigned int isDisabled:1;
		unsigned int wasThemed:1;
        unsigned int isParentHidden:1;
	} m_state;
	
    GtTouchHandler* m_touchHandler;
    
    id m_userData;
    
// temp???    
    id m_widgetDelegate;
    BOOL m_userInteractionEnabled;
}

// temp???    
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic) id<GtWidgetDelegate> widgetDelegate;

- (id) init;
- (id) initWithFrame:(CGRect) frame;
+ (id) widgetWithFrame:(CGRect) frame;
+ (id) widget;

@property (readonly, assign, nonatomic) BOOL isUserInteractionEnabled;
@property (readwrite, retain, nonatomic) GtTouchHandler* touchHandler;
// backgrounds

@property (readwrite, retain, nonatomic) UIColor* backgroundColor; // default is nil (clear).
@property (readwrite, retain, nonatomic) GtWidget* backgroundWidget; 

@property (readwrite, retain, nonatomic) id userData;

// parents

@property (readonly, assign, nonatomic) id parent;

@property (readonly, assign, nonatomic) UIView* view;

// frame

@property (readwrite, assign, nonatomic) CGRect frame; // the frame is in the coordinates of the superview.
- (BOOL) setFrameIfChanged:(CGRect) newFrame;
- (void) moveFrameBy:(CGPoint) offset;
@property (readonly, assign, nonatomic) BOOL isFrameOptimized;
@property (readwrite, assign, nonatomic) CGRect frameOptimizedForLocation;
@property (readwrite, assign, nonatomic) CGRect frameOptimizedForSize;

// state

// this only tells children that parent is hidden, the hidden flag remains as it was.
@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;

/// propagated to children
@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;
/// propagated to children
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted; 
/// propagated to children
@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled; 



// this is a c function that can customize how a widget is drawn when highlighted.
@property (readwrite, assign, nonatomic) GtCustomHighlighter highlighter;

// themeable
@property (readwrite, assign, nonatomic) BOOL wasThemed;
@property (readwrite, assign, nonatomic) SEL themeAction; 

// layout

@property (readwrite, assign, nonatomic) GtRectLayout layoutMode;
- (void) layoutWithLayoutModeInRect:(CGRect) rect;
- (void) setNeedsLayout;

// drawing 

- (void) setNeedsDisplay;
- (void) drawInRect:(CGRect) rect;

// subwidgets

@property (readonly, retain, nonatomic) NSArray* subwidgets;

- (void) addSubwidget:(GtWidget*) widget;
- (void) removeSubwidget:(GtWidget*) widget;

- (void) removeFromParent; // calls [superwidget removeSubwidget]

- (GtWidget*) subwidgetAtIndex:(NSUInteger) idx;
- (void) visitSubwidgets:(GtWidgetEvent) visitor; // recursively hits all.
- (void) removeAllSubwidgets;

// override points

- (void) drawRect:(CGRect) rect;
- (void) updateState;
- (void) layoutSubwidgets;
- (void) didMoveToParent;

// hit test utils

- (BOOL)pointInside:(CGPoint)point;
- (GtWidget *)hitTest:(CGPoint)point interactiveCellsOnly:(BOOL) interactiveCellsOnly;

- (void) teardown;

// debugging

- (NSMutableString*) moreDescription;

// deprecated
- (UIView*) superview; 

@end


extern void (^GtWidgetSunburstHighlighter)(GtWidget* widget, CGRect rect);

