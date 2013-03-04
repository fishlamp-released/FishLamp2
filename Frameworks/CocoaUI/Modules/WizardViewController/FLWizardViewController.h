//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLCocoaUIRequired.h"

#import "FLWizardHeaderViewController.h"
#import "FLWizardButtonViewController.h"
#import "FLWizardNavigationViewController.h"
#import "FLPanelManager.h"

@class FLPanelViewController;
@protocol FLWizardViewControllerDelegate;


@interface FLWizardViewController : UIViewController<FLBreadcrumbBarViewControllerDelegate, FLPanelManagerDelegate> {
@private
    __unsafe_unretained id<FLWizardViewControllerDelegate> _delegate;

    IBOutlet FLWizardHeaderViewController* _headerViewController;
    IBOutlet FLWizardButtonViewController* _buttonViewController;
    IBOutlet FLWizardNavigationViewController* _navigationViewController;
    IBOutlet FLPanelManager* _panelManager;
}

// delegate
@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

// views
@property (readonly, strong, nonatomic) FLWizardHeaderViewController* headerViewController;
@property (readonly, strong, nonatomic) FLWizardButtonViewController* buttonViewController;
@property (readonly, strong, nonatomic) FLWizardNavigationViewController* navigationViewController;
@property (readonly, strong, nonatomic) FLPanelManager* panelManager;

+ (id) wizardViewController;

- (void) startWizardInWindow:(NSWindow*) window;

- (void) addPanel:(FLPanelViewController*) panel forKey:(id) key;

//
// Utils
//
- (void) updateButtonEnabledStates;

//
// optional overrides
//
- (void) willHidePanel:(FLPanelViewController*) panel;
- (void) didHidePanel:(FLPanelViewController*) panel;

- (void) willShowPanel:(FLPanelViewController*) panel;
- (void) didShowPanel:(FLPanelViewController*) panel;

- (void) willStartWizardInWindow:(NSWindow*) window;
- (void) didStartWizardInWindow:(NSWindow*) window;

//    [self.window setDefaultButtonCell:[_button cell]];

@end


@protocol FLWizardViewControllerDelegate <NSObject>
@optional
- (void) wizardViewControllerCanStart:(FLWizardViewController*) wizard;

- (void) wizardViewControllerWillStartWizard:(FLWizardViewController*) wizard;

- (void) wizardViewControllerDidStartWizard:(FLWizardViewController*) wizard;

- (void) wizardViewController:(FLWizardViewController*) wizard 
     didFinishWithPanel:(FLPanelViewController*) panel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
        panelWillAppear:(FLPanelViewController*) panel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
         panelDidAppear:(FLPanelViewController*) panel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
     panelWillDisappear:(FLPanelViewController*) panel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
      panelDidDisappear:(FLPanelViewController*) panel;

//- (BOOL) wizardViewController:(FLWizardViewController*) wizard
//panelWillRespondToNextButton:(FLPanelViewController*) panel;
//
//- (BOOL) panel:(FLPanelViewController*) panel respondToBackButton:(FLWizardViewController*) wizard;
//- (BOOL) panel:(FLPanelViewController*) panel willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard;


@end

@interface NSWindowController (FLModalAdditions)
@property (readonly, assign, nonatomic) NSWindow* modalInWindow;

- (void) showModallyInWindow:(NSWindow*) window 
           withDefaultButton:(NSButton*) button;

- (IBAction) closeIfModalInWindow:(id) sender;
@end

@interface NSWindow (FLModalAdditions)
- (void) closeModalWindowController;
@property (readonly, strong, nonatomic) NSWindowController* modalWindowController;
@end

#endif