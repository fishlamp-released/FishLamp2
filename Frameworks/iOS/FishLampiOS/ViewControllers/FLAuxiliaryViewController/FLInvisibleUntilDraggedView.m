//
//  FLInvisibleUntilDraggedView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLInvisibleUntilDraggedView.h"

#import "_FLAuxiliaryViewController.h"

#define kInvisibleAlpha 0.0

@implementation FLInvisibleUntilDraggedView

@synthesize visibleAlpha = _visibleAlpha;

- (id) initWithFrame:(FLRect) frame {
    if((self = [super initWithFrame:frame])) {   
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        self.visibleAlpha = 1.0f;
        self.autoresizesSubviews = YES;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0;
        self.layer.shadowRadius = 20.0;
        self.layer.shadowOffset = FLSizeMake(0,3);
    }
    
    return self;
}

- (void) addSubview:(UIView*) view {
    view.hidden = YES;
    [super addSubview:view];
}

- (void) showSubviewsWithFade:(CGFloat) duration {
    NSArray* subviews = self.subviews;
    NSMutableArray* alphas = [NSMutableArray array];
    
    for(UIView* view in subviews) {
        view.hidden = NO;
        [alphas addObject:[NSNumber numberWithFloat:view.alpha]];
        view.alpha = 0;
    }
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         NSUInteger alphaIndex = 0;
                         for(UIView* view in subviews) {
                             view.alpha = [[alphas objectAtIndex:alphaIndex++] floatValue];
                         }        
                         self.layer.shadowOpacity = .8;
                     } 
                     completion:^(BOOL completed) {
                         _visible = YES;        
                     }
     ];
}

- (void) hideSubviewsWithFade:(CGFloat) duration {
    NSArray* subviews = self.subviews;
    NSMutableArray* alphas = [NSMutableArray array];
    
    for(UIView* view in subviews) {
        [alphas addObject:[NSNumber numberWithFloat:view.alpha]];
    }
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         for(UIView* view in subviews) {
                             view.alpha = 0.0;
                         }
                         self.layer.shadowOpacity = 0;
                     } 
                     completion:^(BOOL completed) {
                         NSUInteger alphaIndex = 0;
                         for(UIView* view in subviews) {
                             view.hidden = YES;
                             view.alpha = [[alphas objectAtIndex:alphaIndex++] floatValue];
                         }
                         _visible = NO;        
                     }
     ];
}

- (void) auxiliaryViewControllerDragWillBegin:(FLAuxiliaryViewController*) controller {
    if(!_visible) {
        [self showSubviewsWithFade:0.15];
    }
    self.alpha = 0.5;
}

- (void) auxiliaryViewControllerDragDidFinish:(FLAuxiliaryViewController*) controller {
    if(!controller.auxiliaryViewIsOpen && _visible) {
        [self hideSubviewsWithFade:0.15];
    }
    self.alpha = 1.0;
}

@end
