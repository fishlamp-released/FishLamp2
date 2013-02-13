//
//  FLWizardPanel.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX

#import "FLCocoaUIRequired.h"
#import "FLWizardViewController.h"

@interface FLWizardPanel : UIViewController {
@private
    NSString* _breadcrumbTitle;
    BOOL _enabled;
    __unsafe_unretained FLWizardViewController* _wizard;
    id _key;
}
@property (readwrite, strong, nonatomic) id key;
@property (readwrite, assign, nonatomic) id wizard;
//@property (readonly, strong, nonatomic) id userContext;

@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, strong, nonatomic) NSString* breadcrumbTitle;

- (void) wizardPanelWillAppearInWizard:(FLWizardViewController*) wizard;
- (void) wizardPanelDidAppearInWizard:(FLWizardViewController*) wizard;
- (void) wizardPanelWillDisappearInWizard:(FLWizardViewController*) wizard;
- (void) wizardPanelDidDisappearInWizard:(FLWizardViewController*) wizard;

- (BOOL) willRespondToNextButtonInWizard:(FLWizardViewController*) wizard;
- (BOOL) willRespondToBackButtonInWizard:(FLWizardViewController*) wizard;

- (void) didMoveToWizard:(FLWizardViewController*) wizard;
@end


#endif