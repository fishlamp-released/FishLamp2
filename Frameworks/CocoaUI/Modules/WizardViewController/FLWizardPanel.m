//
//  FLWizardPanel.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLWizardPanel.h"
#import "FLWizardViewController.h"

@interface FLWizardPanel ()

@end

@implementation FLWizardPanel

@synthesize breadcrumbTitle = _breadcrumbTitle;
@synthesize canOpenNextPanel = _canOpenNextPanel;
@synthesize wizard = _wizard;
@synthesize key = _key;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.canOpenNextPanel = NO;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_key release];
    [_breadcrumbTitle release];
    [super dealloc];
}
#endif

- (void) loadView {
    [super loadView];
    self.view.wantsLayer = YES;
}

- (void) setCanOpenNextPanel:(BOOL) can {
    _canOpenNextPanel = can;
    [_wizard updateButtonEnabledStates];
}

- (void) setWizard:(FLWizardViewController*) wizard {
    _wizard = wizard;
    [self didMoveToWizard:wizard];
}

- (void) didMoveToWizard:(FLWizardViewController*) wizard {
}

//- (id) userContext {
//    return [_wizard userContext];
//}

- (void) wizardPanelWillAppearInWizard:(FLWizardViewController*) wizard {
}

- (void) wizardPanelDidAppearInWizard:(FLWizardViewController*) wizard {
}

- (void) wizardPanelWillDisappearInWizard:(FLWizardViewController*) wizard {
}

- (void) wizardPanelDidDisappearInWizard:(FLWizardViewController*) wizard {
}

- (BOOL) willRespondToNextButtonInWizard:(FLWizardViewController*) wizard {
    return NO;
}

- (BOOL) willRespondToBackButtonInWizard:(FLWizardViewController*) wizard {
    return NO;
}

- (BOOL) willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard {
    return NO;
}

- (NSButton*) nextButton {
    return [self.wizard nextButton];
}

- (NSButton*) backButton {
    return [self.wizard backButton];
}

- (void) enableBackButton:(BOOL) enable {
    self.backButton.enabled = enable;
}



@end
#endif