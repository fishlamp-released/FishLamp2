//
//  FLWizardButtonViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardButtonViewController.h"

@implementation FLWizardButtonViewController

- (void)awakeFromNib {
    [super awakeFromNib];

    _backButton.hidden = NO;
    _nextButton.hidden = NO;
    _nextButton.enabled = NO;
    _backButton.enabled = NO;
    _otherButton.hidden = YES;
}

@synthesize nextButton = _nextButton;
@synthesize otherButton = _otherButton;
@synthesize backButton = _backButton;

@end
