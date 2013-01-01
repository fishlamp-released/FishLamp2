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

@class FLWizardPanel;
@protocol FLWizardPanelDelegate;

typedef void (^FLWizardPanelBlock)(FLWizardPanel* panel);
typedef void (^FLWizardPanelNextPanelBlock)(FLWizardViewController* wizard, BOOL animated, FLWizardPanelBlock completion);

@interface FLWizardPanel : UIViewController {
@private
    __unsafe_unretained FLWizardViewController* _wizard;
    __unsafe_unretained id<FLWizardPanelDelegate> _delegate;
    NSString* _wizardPanelPrompt;
    
    FLWizardPanelNextPanelBlock _nextPanelBlock;
}

@property (readwrite, copy, nonatomic) FLWizardPanelNextPanelBlock nextPanelBlock;
 
@property (readonly, assign, nonatomic) FLWizardViewController* wizard;
@property (readwrite, assign, nonatomic) id<FLWizardPanelDelegate> delegate;
@property (readwrite, strong, nonatomic) NSString* wizardPanelPrompt;

- (void) wizardPanelWillAppear;
- (void) wizardPanelDidAppear;
- (void) wizardPanelWillDisappear;
- (void) wizardPanelDidDisappear;

- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
- (IBAction) respondToOtherButton:(id) sender;

- (void) pushNextPanel:(BOOL) animated completion:(FLWizardPanelBlock) completion;

- (void) respondToError:(NSError*) error errorMessage:(NSString*) errorMessage;

- (void) didMoveToWizard:(FLWizardViewController*) wizard;
@end

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

