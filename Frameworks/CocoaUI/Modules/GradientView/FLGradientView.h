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

#import "FLView.h"
#import "FLColorRange.h"

@interface FLGradientView : FLView {
@private
#if IOS
	FLGradientWidget* _gradientWidget;
#endif

/*
    FLColorRange* _normalColorRange;
    FLColorRange* _highlightedColorRange;
    FLColorRange* _selectedColorRange;
    FLColorRange* _disabledColorRange;
    
    UIControlStateNormal       = 0,                       
    UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
    UIControlStateDisabled     = 1 << 1,
    UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
*/
    
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
