//
//	FLTableViewCellContentBehavior.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTouchHandler.h"
#import "FLFrame.h"
#import "FLGridViewCellAware.h"
#import "FLArrangement.h"

@interface FLWidget : FLFrame<FLGridViewCellAware> {
@private
    NSMutableArray* _widgets;
    FLArrangement* _arrangement;
    id _parent;
    UIColor* _backgroundColor;
    FLTouchHandler* _touchHandler;
    id _userData;
    BOOL _parentHidden;
    CGFloat _alpha;
    id _gridViewCell;
} 

- (id) init;
- (id) initWithFrame:(CGRect) frame;
+ (id) widgetWithFrame:(CGRect) frame;
+ (id) widget;

@property (readwrite, assign, nonatomic) CGFloat alpha; // this overrides alpha in colors
@property (readwrite, strong, nonatomic) UIColor* backgroundColor; // default is nil (clear).

@property (readwrite, strong, nonatomic) id userData;

- (void) setNeedsLayout;

// drawing 

- (void) setNeedsDisplay;
- (void) drawWidget:(CGRect) rect; // call from view, or superwidget, etc..

// a parent can be another widget or a view.
@property (readwrite, weak, nonatomic) id parent;
@property (readonly, weak, nonatomic) UIView* view;

// subwidgets

@property (readwrite, strong, nonatomic) FLArrangement* subwidgetArrangement;

@property (readonly, retain, nonatomic) NSArray* subwidgets;

- (void) addWidget:(FLWidget*) widget;
- (void) insertWidget:(FLWidget*) widget atIndex:(NSUInteger) index;

- (void) willRemoveWidget:(FLWidget*) widget;
- (void) removeFromParent; // calls [superwidget removeWidget]
- (void) removeAllWidgets;

- (FLWidget*) widgetAtIndex:(NSUInteger) widgetIndex;

- (void) visitWidgets:(void (^)(id widget)) visitor; // recursive

// override points

- (void) drawSelf:(CGRect) rect;
- (void) layoutWidgets;
- (void) didMoveToParent;

// hit test utils
- (FLWidget *)hitTest:(CGPoint)point interactiveCellsOnly:(BOOL) interactiveCellsOnly;

- (void) teardown;

// touches
@property (readonly, assign, nonatomic) BOOL canBeTouched;
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;

@property (readwrite, strong, nonatomic) FLTouchHandler* touchHandler;

// these call into the touch handler, or call be overridden.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
// debugging

- (NSMutableString*) moreDescription;

@end

@interface FLWidget (FLArrangeable)

- (id) lastSubwidgetByWeight:(FLArrangeableWeight) weight;

- (void) layoutSubwidgetsWithArrangement:(BOOL) adjustSize;

//- (void) visitSubviews:(void (^)(id view)) visitor;
@end


// this is a c function that can customize how a widget is drawn when highlighted.
//@property (readwrite, assign, nonatomic) FLCustomHighlighter highlighter;

extern void (^FLWidgetSunburstHighlighter)(FLWidget* widget, CGRect rect);

