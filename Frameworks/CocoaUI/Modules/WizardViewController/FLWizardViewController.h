//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLBreadcrumbBarView.h"
#import "FLWizardPanel.h"

@protocol FLWizardViewControllerDelegate;


@interface FLWizardViewController : UIViewController {
@private
    __unsafe_unretained id<FLWizardViewControllerDelegate> _delegate;

    NSView* _backgroundView;
    NSView* _wizardPanelBackgroundView;
    
    IBOutlet NSView* _breadcrumbEnclosureView;
    IBOutlet FLBreadcrumbBarView* _breadcrumbBarView;
    
    IBOutlet NSView* _wizardPanelEnclosureView;
    IBOutlet NSTextField* _titleTextField;
    
    IBOutlet NSView* _buttonEnclosureView;
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _backButton;
    IBOutlet NSButton* _otherButton;
    
    NSMutableArray* _wizardPanels;
        
// temp    
    IBOutlet NSButton* _logoutButton;

}

// delegate
@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

// views
@property (readwrite, strong, nonatomic) NSView* backgroundView;
@property (readwrite, strong, nonatomic) NSView* wizardPanelBackgroundView;

// backgrounds
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;
@property (readonly, strong, nonatomic) NSTextField* titleTextField;

@property (readonly, strong, nonatomic) NSView* buttonEnclosureView;
@property (readonly, strong, nonatomic) NSView* wizardPanelEnclosureView;

- (void) startWizardInWindow:(NSWindow*) window;

// creation
+ (id) wizardViewController;

// optional overrides
- (void) setWizardPanelTitleFields:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelDidDissappear:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelWillDissappear:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelDidAppear:(FLWizardPanel*) wizardPanel;
- (void) wizardPanelWillAppear:(FLWizardPanel*) wizardPanel;

// utils
- (void) updateBackButtonEnabledState;
@end

@interface FLWizardViewController (Navigation)

@property (readonly, strong, nonatomic) NSArray* wizardPanels;

@property (readonly, strong, nonatomic) FLWizardPanel* visibleWizardPanel;

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) pushWizardPanel:(FLWizardPanel*) viewController 
                animated:(BOOL) animated 
              completion:(FLWizardPanelBlock) completion;

- (void) popWizardPanelAnimated:(BOOL) animated
                     completion:(FLWizardPanelBlock) completion;
@end


@protocol FLWizardViewControllerDelegate <NSObject>
@optional
- (void) wizardViewControllerCanStart:(FLWizardViewController*) wizard;

- (void) wizardViewControllerWillStartWizard:(FLWizardViewController*) wizard;

- (void) wizardViewControllerDidStartWizard:(FLWizardViewController*) wizard;

- (void) wizardViewController:(FLWizardViewController*) wizard 
     didFinishWithWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
        wizardPanelWillAppear:(FLWizardPanel*) wizardPanel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
         wizardPanelDidAppear:(FLWizardPanel*) wizardPanel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
     wizardPanelWillDisappear:(FLWizardPanel*) wizardPanel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
      wizardPanelDidDisappear:(FLWizardPanel*) wizardPanel;

@end

