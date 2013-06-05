//
//  FLHorizonalDragBarWidget.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
