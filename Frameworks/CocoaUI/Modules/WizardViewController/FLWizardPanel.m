//
//  FLWizardPanel.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardPanel.h"
#import "FLWizardViewController.h"

@interface FLWizardPanel ()

@end

@implementation FLWizardPanel

@synthesize breadcrumbTitle = _breadcrumbTitle;
@synthesize enabled = _enabled;
@synthesize wizard = _wizard;
@synthesize key = _key;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.enabled = YES;
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
    [self.wizard nextButton].enabled = YES;
    [self.wizard backButton].enabled = YES;
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

@end
