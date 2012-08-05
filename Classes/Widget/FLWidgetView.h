//
//	FLView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLArrangeableView.h"

#import "UIView+FLWidget.h"

@interface FLWidgetView : FLArrangeableView<FLControlStateObserver> {
@private
	FLWidget* _rootWidget;
}

@property (readonly, retain, nonatomic) FLWidget* rootWidget;

@property (readwrite, strong, nonatomic) FLControlState* controlState;

@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;

@property (readwrite, assign, nonatomic, getter=isDoubleSelected) BOOL doubleSelected;

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted; 

@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled; 

- (void) controlStateDidChangeState:(FLControlState*) state                        
                       changedState:(FLControlStateMask) changedState;

- (void) addWidget:(FLWidget*) widget;

@end
