//
//  FLHierarchicalGridViewCellView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHierarchicalGridViewCellView.h"
#import "FLColorRange.h"

@implementation FLHierarchicalGridViewCellView 

@synthesize titleWidget = _label;
@synthesize titleGradient = _gradient1;
@synthesize buttonGradient = _gradient2;
@synthesize selectedGradient = _selectedGradient;
@synthesize disclosureWidget = _disclosureWidget;
@synthesize disclosureButtonOnLeft = _disclosureButtonOnLeft;

- (BOOL) disclosureButtonHidden {
    return _gradient2.isHidden;
}

- (void) setDisclosureButtonHidden:(BOOL) hidden {
    _gradient2.hidden = hidden;
    _disclosureWidget.hidden = hidden;
    [self setNeedsLayout];
}

- (id) initWithFrame:(CGRect) frame {
    if((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.autoresizesSubviews = NO;

        _gradient1 = [[FLGradientWidget alloc] initWithFrame:frame];
        _gradient1.alpha = 1.0; //0.80;
        _gradient1.touchHandler = [FLSelectOnTouchUpHandler selectOnTouchUpHandler];
        [self addWidget:_gradient1];

        _gradient2 = [[FLGradientWidget alloc] initWithFrame:frame];
        _gradient2.alpha = _gradient1.alpha;
        _gradient2.touchHandler = [FLSelectOnTouchUpHandler selectOnTouchUpHandler];
        [self addWidget:_gradient2];

        _selectedGradient = [[FLGradientWidget alloc] initWithFrame:FLRectSetWidth(frame, 6)];
        _selectedGradient.highlighted = YES;
        _selectedGradient.hidden = YES;
        [self addWidget:_selectedGradient];
       
        _label = [[FLLabelWidget alloc] initWithFrame:frame];
        _label.textDescriptor.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        _label.textDescriptor.enabledColor = [UIColor whiteColor];
        _label.textDescriptor.highlightedColor = [UIColor whiteColor];
        _label.textDescriptor.selectedColor = [_selectedGradient colorRangeForControlState:UIControlStateHighlighted].startColor;
        [_gradient1 addWidget:_label];

        _disclosureWidget = [[FLTableViewCellAccessoryWidget alloc] initWithFrame:_gradient2.frame];
        _disclosureWidget.type = UITableViewCellAccessoryDisclosureIndicator;
        _disclosureWidget.selectedColor = _label.textDescriptor.selectedColor;
        [_disclosureWidget resizeToAccessorySize];
        
        [_gradient2 addWidget:_disclosureWidget];
                              
//        _titleButton = [[FLRoundRectWidget alloc] initWithFrame:frame];
//        _titleButton.superview = self;
//        _titleButton.cornerRadius = 1.0;
//
//        _disclosureButton = [[FLRoundRectWidget alloc] initWithFrame:frame];
//        _disclosureButton.superview = self;
//        _disclosureButton.cornerRadius = 1.0;
    }

    return self;
}

- (void) dealloc {
    FLRelease(_selectedGradient);
    FLRelease(_disclosureWidget);
    FLRelease(_gradient1);
    FLRelease(_gradient2);
    FLRelease(_label);
    FLSuperDealloc();
}

#define kButtonWidth 44.0f
#define kLabelHeight 16.0f
#define kPadding 10.0f
#define kDividerLineWidth 2.0f
#define kSelectedBarWidth 6.0f

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if(_gradient2.isHidden) {
        _gradient1.frame = self.bounds;
        _label.frameOptimizedForSize = FLRectCenterRectInRectVertically(self.bounds, 
            CGRectMake(kPadding,0,self.frame.size.width - kPadding, kLabelHeight));
        
    }
    else {
        if(_disclosureButtonOnLeft) {
            _gradient1.frame = CGRectMake(kButtonWidth+kDividerLineWidth,0,self.bounds.size.width-kDividerLineWidth-kButtonWidth,self.bounds.size.height);
            _gradient2.frame = FLRectSetWidth(self.bounds, kButtonWidth);
        }
        else {
            _gradient1.frame = FLRectSetWidth(self.bounds, self.bounds.size.width - kButtonWidth - kDividerLineWidth);
            _gradient2.frame = CGRectMake(self.bounds.size.width-kButtonWidth,0,kButtonWidth,self.bounds.size.height);
        }
    }

    if(_disclosureButtonOnLeft) {
        _selectedGradient.frame = CGRectMake(FLRectGetRight(self.bounds)-kSelectedBarWidth, self.bounds.origin.y, kSelectedBarWidth, self.bounds.size.height);
        _label.textAlignment = UITextAlignmentRight;
    }
    else {
        _label.textAlignment = UITextAlignmentLeft;
        _selectedGradient.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, kSelectedBarWidth, self.bounds.size.height);
    }

    CGRect labelFrame = CGRectInset(_gradient1.frame, kPadding, 0);
    labelFrame.size.height = kLabelHeight;
    
     _label.frameOptimizedForSize = FLRectCenterRectInRectVertically(_gradient1.frame, labelFrame);
        
     _disclosureWidget.frameOptimizedForLocation = FLRectCenterRectInRect(_gradient2.frame, _disclosureWidget.frame);

}

@end