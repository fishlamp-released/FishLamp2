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
#endif

#import "FLColorRange.h"

@interface FLGradientView : FLWidgetView {
@private
#if IOS
	FLGradientWidget* _gradientWidget;
#endif
}

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;

#if IOS
@property (readonly, strong, nonatomic) FLGradientWidget* gradient;
#endif

- (void) setColorRange:(FLColorRange*) range forControlState:(UIControlState) state;

// returns normal if a colorRange isn't set for state;
- (FLColorRange*) colorRangeForControlState:(UIControlState) state; 


@end

@interface FLBlackGradientView : UIView
@end
