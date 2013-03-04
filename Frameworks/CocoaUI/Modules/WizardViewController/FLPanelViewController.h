//
//  FLPanelViewController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX

#import "FLCocoaUIRequired.h"

@class FLWizardViewController;
@interface FLPanelViewController : UIViewController {
@private
    NSString* _breadcrumbTitle;
    BOOL _canOpenNextPanel;
    __unsafe_unretained FLWizardViewController* _wizard;
    id _key;
}
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;

//- (void) enableBackButton:(BOOL) enable;
//- (void) enableNextButton:(BOOL) enable;

@property (readwrite, strong, nonatomic) id key;
@property (readwrite, assign, nonatomic) id wizard;

@property (readwrite, assign, nonatomic) BOOL canOpenNextPanel;

@property (readwrite, strong, nonatomic) NSString* breadcrumbTitle;

- (void) panelWillAppearInWizard:(FLWizardViewController*) wizard;
- (void) panelDidAppearInWizard:(FLWizardViewController*) wizard;
- (void) panelWillDisappearInWizard:(FLWizardViewController*) wizard;
- (void) panelDidDisappearInWizard:(FLWizardViewController*) wizard;

- (BOOL) respondToNextButton:(FLWizardViewController*) wizard;
- (BOOL) respondToBackButton:(FLWizardViewController*) wizard;
- (void) respondToOtherButton:(FLWizardViewController*) wizard;

- (void) didMoveToWizard:(FLWizardViewController*) wizard;
@end


#endif