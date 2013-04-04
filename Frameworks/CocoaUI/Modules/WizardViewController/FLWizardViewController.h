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
#import "FLSpinningProgressView.h"

@class FLPanelViewController;

@interface FLWizardViewController : SDKViewController<FLBreadcrumbBarViewControllerDelegate, FLPanelManagerDelegate, FLWizardButtonViewControllerDelegate> {
@private
    IBOutlet FLWizardHeaderViewController* _headerViewController;
    IBOutlet FLWizardButtonViewController* _buttonViewController;
    IBOutlet FLWizardNavigationViewController* _navigationViewController;
    IBOutlet FLPanelManager* _panelManager;
    
    IBOutlet FLSpinningProgressView* _progressView;
}

// views
@property (readonly, strong, nonatomic) FLWizardHeaderViewController* headerViewController;
@property (readonly, strong, nonatomic) FLWizardButtonViewController* buttonViewController;
@property (readonly, strong, nonatomic) FLWizardNavigationViewController* navigationViewController;
@property (readonly, strong, nonatomic) FLPanelManager* panelManager;

+ (id) wizardViewController;

- (void) startWizardInWindow:(NSWindow*) window;

- (void) addPanel:(FLPanelViewController*) panel;
- (void) removePanelForTitle:(NSString*) title;


- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error;

- (void) didHideErrorAlertForError:(NSError*) error;

//
// optional overrides
//
- (void) showFirstPanel;

- (void) willShowPanel:(FLPanelViewController*) toShow 
         willHidePanel:(FLPanelViewController*) toHide;

- (void) didShowPanel:(FLPanelViewController*) toShow 
         didHidePanel:(FLPanelViewController*) toHide;

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