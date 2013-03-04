//
//  FLPanelViewController.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLPanelViewController.h"
#import "FLWizardViewController.h"

@interface FLPanelViewController ()

@end

@implementation FLPanelViewController

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
}

- (void) setCanOpenNextPanel:(BOOL) can {
    _canOpenNextPanel = can;
    [_wizard updateButtonEnabledStates];
}

- (void) setWizard:(FLWizardViewController*) wizard {
    _wizard = wizard;
    [self didMoveToWizard:wizard];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void) didMoveToWizard:(FLWizardViewController*) wizard {
}

- (void) respondToOtherButton:(FLWizardViewController*) wizard {
}

//- (id) userContext {
//    return [_wizard userContext];
//}

- (void) panelWillAppearInWizard:(FLWizardViewController*) wizard {
}

- (void) panelDidAppearInWizard:(FLWizardViewController*) wizard {
}

- (void) panelWillDisappearInWizard:(FLWizardViewController*) wizard {
}

- (void) panelDidDisappearInWizard:(FLWizardViewController*) wizard {
}

- (BOOL) respondToNextButton:(FLWizardViewController*) wizard {
    return NO;
}

- (BOOL) respondToBackButton:(FLWizardViewController*) wizard {
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

- (NSButton*) otherButton {
    return [self.wizard otherButton];
}

- (void) enableBackButton:(BOOL) enable {
    self.backButton.enabled = enable;
}


@end
#endif