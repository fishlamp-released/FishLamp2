//
//  FLWizardViewController.m
//  FishLamp
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
#import "NSBundle+FLCurrentBundle.h"

@interface FLWizardViewController ()
@end

@implementation FLWizardViewController

@synthesize buttonViewController = _buttonViewController;
@synthesize headerViewController = _headerViewController;

- (id) init {
    return [self initWithNibName:@"FLWizardViewController" bundle:[NSBundle currentBundle]];
}

+ (id) wizardViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) updateButtonEnabledStates:(BOOL) animated {
    [self.buttonViewController updateButtons];
    [self.navigationViewController updateNavigationTitlesAnimated:animated];
}

- (void) showPanelsInWindow:(NSWindow*) window {
    [super showPanelsInWindow:window];
}

- (void) awakeFromNib {
    [super awakeFromNib];

    if(!self.buttonViewController.delegate) {
        self.buttonViewController.delegate = self;

        [_progressView setRespondsToGlobalNetworkActivity];
        [self addPanelArea:_headerViewController];
        [self addPanelArea:_buttonViewController];
    }
}

- (void) removePanel:(FLPanelViewController*) panel {
    [self removePanel:panel];
    [self updateButtonEnabledStates:NO];
}

#pragma mark button view controller delegate

- (void) wizardButtonViewControllerRespondToNextButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.visiblePanel respondToNextButton:&handled];

    if(!handled) {
        [self showNextPanelAnimated:YES completion:nil];
    }
}

- (void) wizardButtonViewControllerRespondToBackButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.visiblePanel respondToBackButton:&handled];

    if(!handled) {
        [self showPreviousPanelAnimated:YES completion:nil];
    }
}

- (void) wizardButtonViewControllerRespondToOtherButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.visiblePanel respondToOtherButton:&handled];
}

- (void) wizardButtonViewControllerUpdateButtonStates:(FLWizardButtonViewController*) controller {
    
    BOOL backEnabled = !self.isShowingFirstPanel;
    BOOL nextEnabled = [self visiblePanel].canOpenNextPanel && ![self isShowingLastPanel];
    
    if(backEnabled != self.buttonViewController.backButton.isEnabled) {
        self.buttonViewController.backButton.enabled = backEnabled;
    }
    
    if(nextEnabled != self.buttonViewController.nextButton.isEnabled) {
        self.buttonViewController.nextButton.enabled = nextEnabled;
        
        if(nextEnabled) {
            [self.view.window setDefaultButtonCell:[self.buttonViewController.nextButton cell]];
        }
    }
}

- (void) setLogoImage:(NSImage*) image {
    _logoImageView.image = image;
}

#pragma mark panel manager 

- (void) panelStateDidChange:(FLPanelViewController*) panel {
    [super panelStateDidChange:panel];
    [self updateButtonEnabledStates:YES];
}

- (void) didAddPanel:(FLPanelViewController*) panel {
    panel.buttons = self.buttonViewController;
    panel.header = self.headerViewController;
    [super didAddPanel:panel];
}
       
- (void)  willShowPanel:(FLPanelViewController*) toShow {
    self.buttonViewController.nextButton.enabled = NO;
    self.buttonViewController.backButton.enabled = NO;
    self.buttonViewController.otherButton.hidden = YES;
    [self.headerViewController setPrompt:toShow.prompt animated:YES];
    [super willShowPanel:toShow];
}

@end


#endif