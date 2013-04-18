//
//  FLPanelWizard.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardNavigationViewController.h"
#import "FLPanelManager.h"
#import "NSWindowController+FLModalAdditions.h"

@class FLPanelViewController;

@interface FLPanelWizard : SDKViewController<FLBreadcrumbBarViewControllerDelegate, FLPanelManagerDelegate> {
@private
    IBOutlet FLWizardNavigationViewController* _navigationViewController;
    IBOutlet FLPanelManager* _panelManager;
}

@property (readonly, strong, nonatomic) FLWizardNavigationViewController* navigationViewController;
@property (readonly, strong, nonatomic) FLPanelManager* panelManager;

- (void) startWizardInWindow:(NSWindow*) window;

- (void) addPanel:(FLPanelViewController*) panel;
- (void) addPanel:(FLPanelViewController*) panel withDelegate:(id) delegate;

- (void) removePanelForTitle:(NSString*) title;

//
// optional overrides
//
- (void) showFirstPanel;

- (void) willShowPanel:(FLPanelViewController*) toShow 
         willHidePanel:(FLPanelViewController*) toHide;

- (void) didShowPanel:(FLPanelViewController*) toShow 
         didHidePanel:(FLPanelViewController*) toHide;

- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error;

- (void) didHideErrorAlertForError:(NSError*) error;


@end
