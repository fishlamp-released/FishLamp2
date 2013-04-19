//
//  FLWizardHeaderViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardHeaderViewController.h"

#define kAnimationDuration 0.2

@interface FLWizardHeaderViewController ()

@end

@implementation FLWizardHeaderViewController

@synthesize promptTextField = _titleView;

- (void)awakeFromNib {
    [super awakeFromNib];
    [_titleView removeFromSuperview];
    if(_logoView && _titleView) {
        [self.view addSubview:_titleView positioned:NSWindowAbove relativeTo:_logoView];
    }
}

- (void) setPrompt:(NSString*) title animated:(BOOL) animated {
    
    if(animated) {
        NSTextField* old = FLAutorelease([[[_titleView class] alloc] initWithFrame:_titleView.frame]);
        old.textColor = _titleView.textColor;
        old.drawsBackground = _titleView.drawsBackground;
        old.font = _titleView.font;
        old.stringValue = _titleView.stringValue;
        old.bordered = _titleView.isBordered;
        old.bezeled = _titleView.isBezeled;
        old.backgroundColor = _titleView.backgroundColor;
        old.bezelStyle = _titleView.bezelStyle;
        
        [_titleView.superview addSubview:old];
        _titleView.alphaValue = 0.0;
        _titleView.stringValue = FLEmptyStringOrString(title);
    
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            [context setDuration: kAnimationDuration];
            [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]];
            
            [old.animator setAlphaValue:0.0];
            [_titleView.animator setAlphaValue: 1.0];
        } completionHandler: ^{
            [old removeFromSuperview];
        }];

    }
    else {
        _titleView.stringValue = title;
    }
    
}

- (SDKView*) contentView {
    return self.view;
}

- (void) panelWillAppear:(FLPanelViewController*) panel {

    if(panel.isAuthenticated && _logoutButton.isHidden) {
        _logoutButton.hidden = NO;
        _welcomeText.hidden = NO;
        _logoutButton.alphaValue = 0.0;
        _welcomeText.alphaValue = 0.0;

        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            [context setDuration: kAnimationDuration];
            [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]];
            
            [_welcomeText.animator setAlphaValue:1.0];
            [_logoutButton.animator setAlphaValue: 1.0];
        } completionHandler: ^{
        }];    
    }
    else if(!panel.isAuthenticated && !_logoutButton.isHidden) {
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            [context setDuration: kAnimationDuration];
            [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]];
            
            [_logoutButton.animator setAlphaValue:0.0];
            [_welcomeText.animator setAlphaValue: 0.0];
        } completionHandler: ^{
            _logoutButton.hidden = YES;
            _welcomeText.hidden = YES;
            _logoutButton.alphaValue = 1.0;
            _welcomeText.alphaValue = 1.0;
        }];
    }
}

- (void) setTextNextToLogoutButton:(NSString*) welcomeText {
    _welcomeText.stringValue = welcomeText;
}


@end
