//
//  FLDialogShapeView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDialogShapeView.h"

@implementation FLDialogShapeView

@synthesize shapeWidget = _roundRect;
@synthesize backgroundGradient = _backgroundGradient;

- (id)initWithFrame:(FLRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
      
        _roundRect = [[FLRoundRectWidget alloc] initWithFrame:self.bounds];
        _roundRect.contentMode = FLContentModeFill;
        [self addWidget:_roundRect];
        
        _backgroundGradient = [[FLGradientWidget alloc] initWithFrame:self.bounds];
        _backgroundGradient.contentMode = FLContentModeFill;
        [_roundRect addWidget:_backgroundGradient];
    }
    
    return self;
}

- (void) setCornerRadius:(CGFloat) radius {
    _roundRect.cornerRadius = radius;
    [self setNeedsLayout];
}

- (CGFloat) cornerRadius {
    return _roundRect.cornerRadius;
}

- (void) dealloc {
    release_(_roundRect);
    release_(_backgroundGradient);
    super_dealloc_();
}

//- (void) setContentView:(UIView*) contentView {
//    if(_contentView) {
//        [_contentView removeFromSuperview];
//    }
//    
//    FLRetainObject_(_contentView, contentView);
//    if(_contentView) {
//        [self addSubview:_contentView];
//        [self setNeedsLayout];
//    }
//}


@end


