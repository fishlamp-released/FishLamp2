//
//  FLWizardViewController.m
//  Zenfolio Composer
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX

#import "FLWizardViewController.h"
#import "FLAnimation.h"
#import "FLFadeAnimation.h"
#import "FLMoveAnimation.h"
#import "FLViewController.h"
#import "FLPanelViewController.h"
#import "FLStatusBarViewController.h"

#import "FLWizardStyleViewTransition.h"
#import "FLLocalNotification.h"



@interface FLWizardViewController ()
@end

@implementation FLWizardViewController

@synthesize buttonViewController = _buttonViewController;
@synthesize headerViewController = _headerViewController;

- (id) init {
    return [self initWithNibName:@"FLWizardViewController" bundle:nil];
}

+ (id) wizardViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) updateButtonEnabledStates:(BOOL) animated {
    [self.buttonViewController updateButtons];
    [self.navigationViewController updateViewsAnimated:animated];
}

- (void) startWizardInWindow:(NSWindow*) window {
    [window setDefaultButtonCell:[self.buttonViewController.nextButton cell]];
    [super startWizardInWindow:window];
}

- (void) awakeFromNib {
    [super awakeFromNib];

    self.buttonViewController.delegate = self;
    self.panelManager.delegate = self;
    [_progressView setRespondsToGlobalNetworkActivity];
    [_panelManager addPanelArea:_headerViewController];
    [_panelManager addPanelArea:_buttonViewController];
}

- (void) removePanel:(FLPanelViewController*) panel {
    [super removePanel:panel];
    [self updateButtonEnabledStates:NO];
}

#pragma mark button view controller delegate

- (void) wizardButtonViewControllerRespondToNextButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.panelManager.visiblePanel respondToNextButton:&handled];

    if(!handled) {
        [self.panelManager showNextPanelAnimated:YES completion:nil];
    }
}

- (void) wizardButtonViewControllerRespondToBackButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.panelManager.visiblePanel respondToBackButton:&handled];

    if(!handled) {
        [self.panelManager showPreviousPanelAnimated:YES completion:nil];
    }
}

- (void) wizardButtonViewControllerRespondToOtherButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.panelManager.visiblePanel respondToOtherButton:&handled];
}

- (void) wizardButtonViewControllerUpdateButtonStates:(FLWizardButtonViewController*) controller {
    
    BOOL backEnabled = !self.panelManager.isShowingFirstPanel;
    BOOL nextEnabled = [self.panelManager visiblePanel].canOpenNextPanel && ![self.panelManager isShowingLastPanel];
    
    if(backEnabled != self.buttonViewController.backButton.isEnabled) {
        self.buttonViewController.backButton.enabled = backEnabled;
    }
    
    if(nextEnabled != self.buttonViewController.nextButton.isEnabled) {
        self.buttonViewController.nextButton.enabled = nextEnabled;
    }
}

#pragma mark panel manager delegate

- (void) panelManager:(FLPanelManager*) controller panelStateDidChange:(FLPanelViewController*) panel {
    [super panelManager:controller panelStateDidChange:panel];
    [self updateButtonEnabledStates:YES];
}

- (void) panelManager:(FLPanelManager*) controller didAddPanel:(FLPanelViewController*) panel {
    panel.buttons = self.buttonViewController;
    panel.header = self.headerViewController;
    [super panelManager:controller didAddPanel:panel];
}
       
- (void) panelManager:(FLWizardViewController*) wizard 
        willShowPanel:(FLPanelViewController*) toShow
        willHidePanel:(FLPanelViewController*) toHide
    animationDuration:(CGFloat) animationDuration {

    self.buttonViewController.nextButton.enabled = NO;
    self.buttonViewController.backButton.enabled = NO;
    self.buttonViewController.otherButton.hidden = YES;
    [super panelManager:wizard willShowPanel:toShow willHidePanel:toHide animationDuration:animationDuration];
}     


@end


#endif