//
//  UIView+UIView_FLWidget.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLWidget.h"
@class FLWidget;

@interface UIView (FLWidget)
- (void) addWidget:(FLWidget*) widget;
- (void) widgetWasTouched:(FLWidget*) widget;
@end
