//
//  FLDraggableButtonView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDraggableButtonView.h"
#import "FLAuxiliaryViewController.h"
#import "FLGradientWidget.h"
#import "FLGradientView.h"

@implementation FLDraggableButtonView 

@synthesize openButton = _openButton;
@synthesize closeButton = _closeButton;
//@synthesize dragBar = _dragBar;
@synthesize openBackgroundWidget = _openBackgroundWidget;

- (UIButton*) _createButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,44,44);
    button.showsTouchWhenHighlighted = YES;
    [self addSubview:button];
    
    return button;
}

- (void) setOpenButton:(UIButton*) button
{
    if(_openButton)
    {
        [_openButton removeFromSuperview];
    }
    FLSetObjectWithRetain(_openButton, button);
    [self addSubview:_openButton];
    
    [self setNeedsLayout];
}

- (void) setCloseButton:(UIButton*) button
{
    if(_closeButton)
    {
        [_closeButton removeFromSuperview];
    }
    FLSetObjectWithRetain(_closeButton, button);
    [self addSubview:_closeButton];
    _closeButton.hidden = YES;
    
    [self setNeedsLayout];
}

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES;
        self.exclusiveTouch = YES;
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        self.autoresizesSubviews = NO;
        
//        self.dragBar = [FLVerticalDragBarWidget verticalDragBarWidget:FLVerticalDragBarWidgetStyleRight];
//        [self.rootWidget addWidget:self.dragBar];
        
        FLGradientWidget* widget = [FLGradientWidget widget];
        widget.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalFill, FLRectLayoutVerticalFill);
        widget.hidden = YES;
        [self.rootWidget addWidget:widget];
        
//        FLGradientColorizerLightLightGray(widget);

        self.openBackgroundWidget = widget;
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
//    self.dragBar.frame = frame;
    _openBackgroundWidget.frame = frame;
    _openButton.frameOptimizedForLocation = FLRectCenterRectInRect(self.bounds, frame);
    _closeButton.frameOptimizedForLocation = FLRectCenterRectInRect(self.bounds, frame);
}

- (void) swapButtonsAnimated:(BOOL) animated
{
    CGFloat duration = animated ? 0.3f : 0;
    if(_openButton.hidden)
    {
        _openButton.alpha = 0;
        _openButton.hidden = NO;
    
        [UIView animateWithDuration:duration
            delay:duration
            options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
                _openButton.alpha = 1.0;
                _closeButton.alpha = 0.0f;
            } 
            completion:^(BOOL completed) {
                _closeButton.hidden = YES;
                _closeButton.alpha = 1.0f;
//                self.dragBar.hidden = NO;
                self.backgroundColor = [UIColor clearColor];
                
                _openBackgroundWidget.hidden = YES;
                
                self.layer.shadowColor = [UIColor clearColor].CGColor;
                self.layer.shadowOpacity = 0;
                self.layer.shadowRadius = 0.0;
                self.layer.shadowOffset = CGSizeMake(0,0);
                self.clipsToBounds = YES;
                
            }
        ];
        
    }
    else
    {
        _closeButton.alpha = 0;
        _closeButton.hidden = NO;

        [UIView animateWithDuration:duration
            delay:duration
            options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
                _closeButton.alpha = 1.0;
                _openButton.alpha = 0.0f;
            } 
            completion:^(BOOL completed) {
                _openButton.hidden = YES;
                _openButton.alpha = 1.0f;
//                self.dragBar.hidden = YES;
                
                _openBackgroundWidget.hidden = NO;

                self.clipsToBounds = NO;
                self.layer.shadowColor = [UIColor grayColor].CGColor;
                self.layer.shadowOpacity = .6;
                self.layer.shadowRadius = 20.0;
                self.layer.shadowOffset = CGSizeMake(0,3);
                [self.layer setNeedsDisplay];
            }
        ];
    }
}

- (void) showOpenButtonAnimated:(BOOL) animated
{
    if(_openButton.hidden)
    {
        [self swapButtonsAnimated:NO];
    }
}

- (void) showCloseButtonAnimated:(BOOL) animated
{
    if(_closeButton.hidden)
    {
        [self swapButtonsAnimated:NO];
    }
}

- (void) auxiliaryViewControllerDragWillBegin:(FLAuxiliaryViewController*) controller
{
    if(controller.dragController.touchedView == self)
    {
        _openBackgroundWidget.hidden = NO;
        _openBackgroundWidget.highlighted = YES;
    }
}

- (void) auxiliaryViewController:(FLAuxiliaryViewController*) controller didFinishDraggingWithResults:(FLViewDraggerResults) results
{
    _openBackgroundWidget.highlighted = NO;

    if(controller.dragController.touchedView == self)
    {
        if( results.userDidTouchView &&
            results.lastTouchInTouchableView &&
            !results.didDragView)
        {
            if(controller.auxiliaryViewIsOpen)
            {
                [controller hideViewController:YES];
            }
            else
            {
                [controller showViewControllerAnimated:YES];
            }
        }    
    }
    
    if(controller.auxiliaryViewIsOpen)
    {
       [self showCloseButtonAnimated:NO];
    }
    else
    {
       [self showOpenButtonAnimated:NO];
    }
}

- (void) dealloc
{
    FLRelease(_openBackgroundWidget);
//    FLRelease(_dragBar);
    FLRelease(_openButton);
    FLRelease(_closeButton);
    FLSuperDealloc();
}

- (BOOL) auxiliaryViewControllerTapWillToggle:(FLAuxiliaryViewController*) controller
{
    return YES;
}


@end
