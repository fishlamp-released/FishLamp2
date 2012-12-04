//
//  FLHorizonalDragBarWidget.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLWidget.h"

typedef enum {
    FLHorizontalDragBarWidgetStyleTop,
    FLHorizontalDragBarWidgetStyleBottom
} FLHorizontalDragBarWidgetStyle;

@interface FLHorizonalDragBarWidget : FLWidget

@property (readwrite, assign, nonatomic) FLHorizontalDragBarWidgetStyle style;
@property (readwrite, assign, nonatomic) UIEdgeInsets padding;  
@property (readwrite, assign, nonatomic) CGFloat lineThickness;
@property (readwrite, retain, nonatomic) UIColor* lineColor;

- (id) initWithStyle:(FLHorizontalDragBarWidgetStyle) style;

+ (FLHorizonalDragBarWidget*) horizonalDragBarWidget:(FLHorizontalDragBarWidgetStyle) style;

@end
