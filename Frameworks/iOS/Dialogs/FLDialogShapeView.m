//
//  FLDialogShapeView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDialogShapeView.h"

@implementation FLDialogShapeView

@synthesize shapeWidget = _roundRect;
@synthesize backgroundGradient = _backgroundGradient;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
      
        _roundRect = [[FLRoundRectWidget alloc] initWithFrame:self.bounds];
        _roundRect.contentMode = FLRectLayoutFill;
        [self addWidget:_roundRect];
        
        _backgroundGradient = [[FLGradientWidget alloc] initWithFrame:self.bounds];
        _backgroundGradient.contentMode = FLRectLayoutFill;
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
    FLRelease(_roundRect);
    FLRelease(_backgroundGradient);
    FLSuperDealloc();
}

//- (void) setContentView:(UIView*) contentView {
//    if(_contentView) {
//        [_contentView removeFromSuperview];
//    }
//    
//    FLSetObjectWithRetain(_contentView, contentView);
//    if(_contentView) {
//        [self addSubview:_contentView];
//        [self setNeedsLayout];
//    }
//}


@end


