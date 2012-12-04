//
//  UIView+UIView_FLWidget.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLWidget.h"
@class FLWidget;

@interface UIView (FLWidget)
- (void) addWidget:(FLWidget*) widget;
- (void) widgetWasTouched:(FLWidget*) widget;
@end
