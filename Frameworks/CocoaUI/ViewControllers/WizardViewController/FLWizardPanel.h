//
//  FLWizardPanel.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLViewController.h"

@class FLWizardViewController;
@class FLWizardPanel;

@protocol FLWizardPanelDelegate <NSObject>
@optional
- (void) wizardPanelWillAppear:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelDidAppear:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelWillDisappear:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelDidDisappear:(FLWizardPanel*) wizardPanel;

- (void) wizardPanelRespondToNextButton:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelRespondToBackButton:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelRespondToOtherButton:(FLWizardPanel*) wizardPanel;
@end

@interface FLWizardPanel : FLViewController<FLWizardPanelDelegate> {
@private
    __unsafe_unretained FLWizardViewController* _wizard;
    __unsafe_unretained id<FLWizardPanelDelegate> _delegate;
    NSString* _wizardPanelPrompt;
}

@property (readonly, assign, nonatomic) FLWizardViewController* wizard;
@property (readwrite, assign, nonatomic) id<FLWizardPanelDelegate> delegate;
@property (readwrite, strong, nonatomic) NSString* wizardPanelPrompt;

- (void) wizardPanelWillAppear;
- (void) wizardPanelDidAppear;
- (void) wizardPanelWillDisappear;
- (void) wizardPanelDidDisappear;

- (void) respondToNextButton;
- (void) respondToBackButton;
- (void) respondToOtherButton;

- (void) didMoveToWizard:(FLWizardViewController*) wizard;
@end


