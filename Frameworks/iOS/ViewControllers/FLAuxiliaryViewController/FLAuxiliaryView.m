//
//  FLAuxiliaryView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAuxiliaryView.h"

@implementation FLAuxiliaryView

@synthesize containedView = _containedView;

- (void) applyTheme:(FLTheme*) theme {
    //    FLGradientWidget* widget = [FLGradientWidget gradientWidget];
    //    [widget setColorRange:[FLColorRange darkGrayGradientColorRange] forControlState:UIControlStateNormal];
    
    FLWidget* widget = [FLWidget widget];
    widget.backgroundColor = [UIColor blackColor];
    
    widget.contentMode = FLContentModeFill;
    widget.alpha = 0.15;
    [self addWidget:widget];
}

- (id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame]; 
    if(self) {
        self.autoresizesSubviews = NO;
        self.autoresizingMask = 0;
        self.backgroundColor = [UIColor clearColor];
        self.wantsApplyTheme = YES;
    }
    return self;
}

- (void) setContainedView:(UIView*) view {
    
    if(_containedView) {
        [_containedView removeFromSuperview];
    }
    
    FLRetainObject_(_containedView, view);
    [self addSubview:view];
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    _containedView.frame = self.bounds;
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_containedView);
    super_dealloc_();
}

#endif

@end
