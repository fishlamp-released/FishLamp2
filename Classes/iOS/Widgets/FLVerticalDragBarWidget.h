//
//  FLVerticalDragBarWidget.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWidget.h"

typedef enum {
    FLVerticalDragBarWidgetStyleLeft,
    FLVerticalDragBarWidgetStyleRight
    
} FLVerticalDragBarWidgetStyle;

@interface FLVerticalDragBarWidget : FLWidget

@property (readwrite, assign, nonatomic) FLVerticalDragBarWidgetStyle style;
@property (readwrite, assign, nonatomic) UIEdgeInsets padding;  
@property (readwrite, assign, nonatomic) CGFloat lineThickness;
@property (readwrite, retain, nonatomic) UIColor* lineColor;

- (id) initWithStyle:(FLVerticalDragBarWidgetStyle) style;

+ (FLVerticalDragBarWidget*) verticalDragBarWidget:(FLVerticalDragBarWidgetStyle) style;

@end
