//
//  FLWizardButtonViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardButtonViewController.h"

@interface FLWizardButtonViewController ()
- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
- (IBAction) respondToOtherButton:(id) sender;
@end

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
@synthesize delegate = _delegate;

- (void) updateButtons {
    [self.delegate wizardButtonViewControllerUpdateButtonStates:self];
}

- (IBAction) respondToNextButton:(id) sender {
    [self.delegate wizardButtonViewControllerRespondToNextButton:self];
}

- (IBAction) respondToOtherButton:(id) sender {
    [self.delegate wizardButtonViewControllerRespondToOtherButton:self];
}

- (IBAction) respondToBackButton:(id) sender {
    [self.delegate wizardButtonViewControllerRespondToBackButton:self];
}

@end
