//
//  FLAlertView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAlertView.h"

#define kTitleHeight 18.0f

@implementation FLAlertView

@synthesize triangleSize = _triangleSize;
@synthesize colorBarSize = _colorBarSize;
@synthesize buttonSize = _buttonSize;
@synthesize buttonCornerRadius = _buttonCornerRadius;
@synthesize titleHeight = _titleHeight;
@synthesize titleLabel = _title;
@synthesize buttonContainerView = _buttonBox;

- (void) applyTheme:(FLTheme*) theme {
    [[[FLTheme currentTheme] alertViewThemeApplicator] applyThemeToObject:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        self.autoresizesSubviews = NO;
        self.wantsApplyTheme = YES;
        self.titleHeight = kTitleHeight;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,40)];
        _title.backgroundColor = [UIColor clearColor];
        _title.textAlignment = UITextAlignmentLeft;
        _title.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
        _title.numberOfLines = 1;
        [self addSubview:_title];

        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,20)];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textAlignment = UITextAlignmentLeft;
        _messageLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
        _messageLabel.numberOfLines = 0;

// default look
        _messageLabel.textColor = [UIColor gray25Color];
        _messageLabel.shadowColor = [UIColor whiteColor];
        _messageLabel.shadowOffset = CGSizeMake(0,1);
        _messageLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];

        [self addSubview:_messageLabel];
        
        _buttonBox = [[FLButtonContainerView alloc] initWithFrame:self.bounds];
//        _buttonBox.onSetupButton = ^(FLButtonContainerView* view, FLButton* button) {
//            [_dialogStyle setupButtonInContainerView:view button:button];
//        };
        _buttonBox.hidden = YES;
        
        [self addSubview:_buttonBox];
     }
    return self;
}

- (CGFloat) calculateContentViewHeightForWidth:(CGFloat) width {
    return [_messageLabel sizeThatFits:CGSizeMake(width, 2048)].height;
}

#define kBuffer 10.0

- (CGSize)sizeThatFits:(CGSize) inSize {
    
    UIEdgeInsets padding = self.innerInsets;

    CGFloat contentHeight = _titleHeight + padding.top;

    if(FLStringIsNotEmpty(_messageLabel.text)) {
        contentHeight += kBuffer;
        contentHeight += [self calculateContentViewHeightForWidth:inSize.width];
    }

    if(_buttonBox && !_buttonBox.hidden) {
        contentHeight += kBuffer;
        contentHeight += ([_buttonBox sizeThatFits:inSize].height);
    }
    
    return CGSizeMake(inSize.width, contentHeight);
}

- (void) layoutSubviews {
    [super layoutSubviews];

    UIEdgeInsets padding = self.innerInsets;

    CGFloat contentWidth = self.bounds.size.width - kBuffer*2.0f;
    
    _title.frameOptimizedForLocation = CGRectMake(
            padding.left, padding.top * .66, contentWidth, _titleHeight);
    
    if(_colorBar && !_colorBar.hidden) {
        _colorBar.frame = CGRectMake(0,0,8,self.bounds.size.height);
    }

    if(FLStringIsNotEmpty(_messageLabel.text)) {
        CGRect frame = _messageLabel.frame;
        frame.origin.x = padding.left;
        frame.origin.y = FLRectGetBottom(self.titleLabel.frame) - padding.bottom;
        frame.size.width = contentWidth;
        frame.size.height = [self calculateContentViewHeightForWidth:contentWidth];
        _messageLabel.frameOptimizedForLocation = frame;
    }
    
    if(!_buttonBox.hidden) {
        _buttonBox.frame = FLRectSetWidth(_buttonBox.frame, contentWidth);
        [_buttonBox layoutSubviewsWithArrangement:_buttonBox.arrangement
                                   adjustViewSize:YES];

        _buttonBox.frameOptimizedForLocation =
            CGRectMake(padding.left,
                        FLRectGetBottom(self.bounds) -
                            _buttonBox.frame.size.height -
                            padding.bottom,
                            contentWidth,
                            _buttonBox.frame.size.height);
    }
}

- (void) setAlertMessage:(NSString*) message {
    _messageLabel.text = message;
    [self setNeedsLayout];
}

- (NSString*) alertMessage {
    return _messageLabel.text;
}

#if FL_MRC 
- (void) dealloc {
    FLRelease(_buttonBox);
    FLRelease(_triangleShapeWidget);
    FLRelease(_colorBar);
    FLRelease(_title);    FLRelease(_messageLabel);
    FLSuperDealloc();
}

#endif

- (void) setTitle:(NSString*) title {
    _title.text = title;
    [self setNeedsLayout];
}

- (NSString*) title {
    return _title.text;
}

- (void) addButton:(FLButton*) button {
    [self.buttonContainerView addButton:button];
    self.buttonContainerView.hidden = NO;
    [self setNeedsLayout];
}
                
// experimental

@synthesize colorBar = _colorBar;
@synthesize cornerTriangle = _triangleShapeWidget;

- (void) setColorBarWithColorRange:(FLColorRange*) range
                            onSide:(FLAlertViewColorBarSide) side {
    if(!_colorBar) {
        _colorBar = [[FLGradientWidget alloc] initWithFrame:CGRectMake(0,0,10,10)];
        _colorBar.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalLeft, FLRectLayoutVerticalFill);
        [self addWidget:_colorBar];
    }

    [_colorBar setColorRange:range forControlState:UIControlStateNormal];
}

- (void) setCornerTriangleWithColorRange:(FLColorRange*) colorRange 
                               inCorner:(FLTriangleCorner) corner{
    
    if(_triangleShapeWidget) {
        [_triangleShapeWidget removeFromParent];
        FLRelease(_triangleShapeWidget);
    }
    
    _triangleShapeWidget = [[FLTriangleShapeWidget alloc] initWithFrame:CGRectMake(0,0,_triangleSize,_triangleSize)];
    _triangleShapeWidget.triangleCorner = corner;
    
    switch(_triangleShapeWidget.triangleCorner) {
        case FLTriangleCornerUpperLeft:
            _triangleShapeWidget.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalLeft, FLRectLayoutVerticalTop);
            break;
        case FLTriangleCornerUpperRight:
            _triangleShapeWidget.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalRight, FLRectLayoutVerticalTop);
            break;
        case FLTriangleCornerBottomRight:
            _triangleShapeWidget.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalRight, FLRectLayoutVerticalBottom);
            break;
        case FLTriangleCornerBottomLeft:
            _triangleShapeWidget.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalLeft, FLRectLayoutVerticalBottom);
            break;

    }
    
    FLGradientWidget* fill = [FLGradientWidget gradientWidget];
    fill.contentMode = FLRectLayoutFill;
    [_triangleShapeWidget addWidget:fill];
    [fill setColorRange:colorRange forControlState:UIControlStateNormal];
    
    [self addWidget:_triangleShapeWidget];
}

@end

