//
//  UIView+UIView_FLWidget.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "UIView+FLWidget.h"

@implementation UIView (FLWidget)

- (void) addWidget:(FLWidget*) widget {
    [widget removeFromParent];
    widget.parent = self;
}

- (void) removeWidget:(FLWidget*) widget {
    if(widget.parent == self) {
        widget.parent = nil;
        [self setNeedsDisplay];
    }
}

- (void) willRemoveWidget:(FLWidget*) widget {
}

- (void) widgetWasTouched:(FLWidget*) widget {
}


@end
