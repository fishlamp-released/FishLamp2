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

@synthesize wizard = _wizard;
@synthesize delegate = _delegate;
@synthesize wizardPanelPrompt = _wizardPanelPrompt;
@synthesize nextPanelBlock = _nextPanelBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_nextPanelBlock release];
    [_wizardPanelPrompt release];
    [super dealloc];
}
#endif

- (void) loadView {
    [super loadView];
    self.view.wantsLayer = YES;
}

- (void) didMoveToWizard:(FLWizardViewController*) wizard {
    _wizard = wizard;
}

- (void) wizardPanelWillAppear {
    FLPerformSelector1(self.delegate, @selector(wizardPanelWillAppear:), self);
}

- (void) wizardPanelDidAppear {
    FLPerformSelector1(self.delegate, @selector(wizardPanelDidAppear:), self);
}

- (void) wizardPanelWillDisappear {
   FLPerformSelector1(self.delegate, @selector(wizardPanelWillDisappear:), self);
}

- (void) wizardPanelDidDisappear {
   FLPerformSelector1(self.delegate, @selector(wizardPanelDidDisappear:), self);
}

- (void) respondToNextButton:(id) sender {
    FLPerformSelector1(self.delegate, @selector(wizardPanelRespondToNextButton:), self);
    [self.wizard pushNextWizardPanelAnimated:YES completion:nil];
}

- (void) respondToBackButton:(id) sender {
    FLPerformSelector1(self.delegate, @selector(wizardPanelRespondToBackButton:), self);
    
    [self.wizard popWizardPanelAnimated:YES completion:nil];
}

- (void) respondToOtherButton:(id) sender {
    FLPerformSelector1(self.delegate, @selector(wizardPanelRespondToOtherButton:), self);
}

- (void) respondToError:(NSError*) error errorMessage:(NSString*) errorMessage {

}

@end
