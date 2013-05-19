//
//	FLGradientWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLWidget.h"

@class FLColorRange;
@class FLViewGradients;

@interface FLGradientWidget : FLWidget {
@private 
    FLViewGradients* _gradientColors;
}

+ (FLGradientWidget*) gradientWidget;
+ (FLGradientWidget*) gradientWidgetWithFrame:(CGRect) frame;

@property (readwrite, strong, nonatomic) FLViewGradients* gradientColors;

- (void) setColorRange:(FLColorRange*) range forControlState:(FLControlState) state;

// returns normal if a colorRange isn't set for state;
- (FLColorRange*) colorRangeForControlState:(FLControlState) state; 

@end

