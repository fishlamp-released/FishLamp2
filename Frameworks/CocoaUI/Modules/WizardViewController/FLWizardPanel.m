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

@synthesize wizardPanelPrompt = _wizardPanelPrompt;
FLSynthesizeObservable();

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_observable release];
     [_wizardPanelPrompt release];
    [super dealloc];
}
#endif

- (void) loadView {
    [super loadView];
    self.view.wantsLayer = YES;
}

//- (void) didMoveToWizard:(FLWizardViewController*) wizard {
//    _wizard = wizard;
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


@end
