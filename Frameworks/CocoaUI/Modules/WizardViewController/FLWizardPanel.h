//
//  FLWizardPanel.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//


#import "FLCocoaUIRequired.h"
#import "FLObservable.h"
#import "FLWizardViewController.h"
#import "FLObservable.h"

//@class FLWizardPanel;
//@protocol FLWizardPanelDelegate;

@interface FLWizardPanel : UIViewController<FLObservable> {
@private
//    __unsafe_unretained FLWizardViewController* _wizard;
//    __unsafe_unretained id<FLWizardPanelDelegate> _delegate;
    FLObservable* _observable;
    NSString* _wizardPanelPrompt;
}

@property (readwrite, strong, nonatomic) NSString* wizardPanelPrompt;

- (void) wizardPanelWillAppearInWizard:(FLWizardViewController*) wizard;
- (void) wizardPanelDidAppearInWizard:(FLWizardViewController*) wizard;
- (void) wizardPanelWillDisappearInWizard:(FLWizardViewController*) wizard;
- (void) wizardPanelDidDisappearInWizard:(FLWizardViewController*) wizard;

- (BOOL) willRespondToNextButtonInWizard:(FLWizardViewController*) wizard;
- (BOOL) willRespondToBackButtonInWizard:(FLWizardViewController*) wizard;
- (BOOL) willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard;

//- (void) didMoveToWizard:(FLWizardViewController*) wizard;
@end

//@protocol FLWizardPanelDelegate <NSObject>
//@optional
//- (void) wizardPanel:(FLWizardPanel*) wizardPanel willAppearInWizard:(FLWizardViewController*) wizard;
//- (void) wizardPanel:(FLWizardPanel*) wizardPanel didAppearInWizard:(FLWizardViewController*) wizard;
//- (void) wizardPanel:(FLWizardPanel*) wizardPanel willDisappearInWizard:(FLWizardViewController*) wizard;
//- (void) wizardPanel:(FLWizardPanel*) wizardPanel didDisappearInWizard:(FLWizardViewController*) wizard;
//
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel willRespondToNextButtonInWizard:(FLWizardViewController*) wizard;
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel willRespondToBackButtonInWizard:(FLWizardViewController*) wizard;
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard;
//
//@end

