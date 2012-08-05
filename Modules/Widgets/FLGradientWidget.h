//
//	FLGradientWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLWidget.h"
#import "FLColorRange.h"
#import "FLViewGradients.h"

@interface FLGradientWidget : FLWidget {
@private 
    FLViewGradients* _gradientColors;
}

+ (FLGradientWidget*) gradientWidget;
+ (FLGradientWidget*) gradientWidgetWithFrame:(CGRect) frame;

@property (readwrite, strong, nonatomic) FLViewGradients* gradientColors;

- (void) setColorRange:(FLColorRange*) range forControlState:(FLControlStateMask) state;

// returns normal if a colorRange isn't set for state;
- (FLColorRange*) colorRangeForControlState:(FLControlStateMask) state; 

@end

