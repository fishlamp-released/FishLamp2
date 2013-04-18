//
//  FLWizardHeaderViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardHeaderViewController.h"

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

- (void) setPrompt:(NSString*) title animationDuration:(CGFloat) animationDuration {
    _titleView.stringValue = title;
}

- (SDKView*) contentView {
    return self.view;
}

- (void) panelWillAppear:(FLPanelViewController*) panel {
    _logoutButton.hidden = !panel.isAuthenticated;
    _welcomeText.hidden = !panel.isAuthenticated;
}

- (void) setWelcomeText:(NSString*) welcomeText {
    _welcomeText.stringValue = welcomeText;
}


@end
