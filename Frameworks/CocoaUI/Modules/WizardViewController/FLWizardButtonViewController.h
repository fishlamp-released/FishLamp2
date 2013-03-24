//
//  FLWizardButtonViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLPanelViewController.h"

@protocol FLWizardButtonViewControllerDelegate;
@interface FLWizardButtonViewController : FLCompatibleViewController<FLPanelButtons> {
@private
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _backButton;
    IBOutlet NSButton* _otherButton;
    __unsafe_unretained id<FLWizardButtonViewControllerDelegate> _delegate;
}
@property (readwrite, assign, nonatomic) id<FLWizardButtonViewControllerDelegate> delegate;
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;

- (void) updateButtons;

@end

@protocol FLWizardButtonViewControllerDelegate <NSObject>
- (void) wizardButtonViewControllerUpdateButtonStates:(FLWizardButtonViewController*) controller;
- (void) wizardButtonViewControllerRespondToNextButton:(FLWizardButtonViewController*) controller;
- (void) wizardButtonViewControllerRespondToBackButton:(FLWizardButtonViewController*) controller;
- (void) wizardButtonViewControllerRespondToOtherButton:(FLWizardButtonViewController*) controller;
@end
