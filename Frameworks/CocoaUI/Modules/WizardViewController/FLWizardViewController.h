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
//@protocol FLWizardViewControllerDelegate;


@interface FLWizardViewController : UIViewController<FLBreadcrumbBarViewControllerDelegate, FLPanelManagerDelegate, FLWizardButtonViewControllerDelegate> {
@private
//    __unsafe_unretained id<FLWizardViewControllerDelegate> _delegate;

    IBOutlet FLWizardHeaderViewController* _headerViewController;
    IBOutlet FLWizardButtonViewController* _buttonViewController;
    IBOutlet FLWizardNavigationViewController* _navigationViewController;
    IBOutlet FLPanelManager* _panelManager;
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

//
// optional overrides
//

- (void) willShowPanel:(FLPanelViewController*) toShow 
         willHidePanel:(FLPanelViewController*) toHide;

- (void) didShowPanel:(FLPanelViewController*) toShow 
         didHidePanel:(FLPanelViewController*) toHide;

@end


// delegate
//@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

//@protocol FLWizardViewControllerDelegate <NSObject>
//@optional
////- (void) wizardViewControllerCanStart:(FLWizardViewController*) wizard;
//
////- (void) wizardViewControllerWillStartWizard:(FLWizardViewController*) wizard;
//
////- (void) wizardViewControllerDidStartWizard:(FLWizardViewController*) wizard;
//
////- (void) wizardViewController:(FLWizardViewController*) wizard 
////     didFinishWithPanel:(FLPanelViewController*) panel;
//
////- (void) wizardViewController:(FLWizardViewController*) wizard 
////        panelWillAppear:(FLPanelViewController*) panel;
//
////- (void) wizardViewController:(FLWizardViewController*) wizard 
////         panelDidAppear:(FLPanelViewController*) panel;
//
////- (void) wizardViewController:(FLWizardViewController*) wizard 
////     panelWillDisappear:(FLPanelViewController*) panel;
//
////- (void) wizardViewController:(FLWizardViewController*) wizard 
////      panelDidDisappear:(FLPanelViewController*) panel;
//
//@end

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