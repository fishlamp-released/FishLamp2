//
//	FLGradientView.h
//	ShadowedTableView
//
//	Created by Mike Fullerton on 2009/08/21.
//	Copyright 2009 Mike Fullerton. All rights reserved.
//

#import "FLCocoa.h"
#if IOS
#import "FLWidgetView.h"
#import "FLGradientWidget.h"
#import "FLColorRange.h"

@interface FLGradientView : FLWidgetView {
@private
	FLGradientWidget* _gradientWidget;
}

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;

@property (readonly, strong, nonatomic) FLGradientWidget* gradient;

- (void) setColorRange:(FLColorRange*) range forControlState:(UIControlState) state;

// returns normal if a colorRange isn't set for state;
- (FLColorRange*) colorRangeForControlState:(UIControlState) state; 


@end

@interface FLBlackGradientView : SDKView
@end

#endif