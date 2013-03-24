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
@synthesize spinner = _spinner;

- (void)awakeFromNib {
    [super awakeFromNib];

    _spinner.hidden = YES;
//    [_logoView sendToBack];
    [_titleView removeFromSuperview];
    [self.view addSubview:_titleView positioned:NSWindowAbove relativeTo:_logoView];
}

- (void) setPrompt:(NSString*) title animationDuration:(CGFloat) animationDuration {
//    [_logoView sendToBack];
    _titleView.stringValue = title;
//    [_titleView bringToFront];
}

- (void) showSpinner:(BOOL) show {
    [_spinner setHidden:!show];
    if(show) {
        [_spinner startAnimation:self];
    }
    else {
        [_spinner stopAnimation:self];
    }
}

- (SDKView*) contentView {
    return self.view;
}

@end
