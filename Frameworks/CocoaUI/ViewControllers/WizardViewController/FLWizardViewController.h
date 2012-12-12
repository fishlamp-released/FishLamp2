//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLViewController.h"
#import "FLView.h"
#import "FLBreadcrumbBarView.h"
#import "FLWizardPanel.h"

@protocol FLWizardViewControllerDelegate;

@interface FLWizardViewController : FLViewController {
@private
    NSView* _backgroundView;
    NSView* _wizardPanelBackgroundView;
    
    IBOutlet FLBreadcrumbBarView* _breadcrumbBarView;
    IBOutlet NSView* _wizardPanelEnclosureView;
    IBOutlet NSView* _titleEnclosureView;
    IBOutlet NSView* _buttonEnclosureView;
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _previousButton;
    IBOutlet NSButton* _otherButton;
    IBOutlet NSTextField* _titleTextField;
    __unsafe_unretained id<FLWizardViewControllerDelegate> _delegate;

    NSMutableArray* _visibleWizardPanels;
    NSMutableArray* _queuedWizardPanels;
}

// delegate
@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

@property (readwrite, strong, nonatomic) NSView* backgroundView;
@property (readwrite, strong, nonatomic) NSView* wizardPanelBackgroundView;

// backgrounds
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* previousButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;
@property (readonly, strong, nonatomic) NSTextField* titleTextField;

@property (readonly, strong, nonatomic) NSView* titleEnclosureView;
@property (readonly, strong, nonatomic) NSView* buttonEnclosureView;

@property (readonly, strong, nonatomic) NSView* wizardPanelEnclosureView;

// panels
@property (readonly, strong, nonatomic) NSArray* visibleWizardPanels;
@property (readonly, strong, nonatomic) NSArray* queuedWizardPanels;

@property (readonly, strong, nonatomic) FLWizardPanel* visibleWizardPanel;

- (void) addWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) presentNextWizardPanelAnimated:(BOOL) animated
                       completion:(void (^)(FLWizardPanel* newPanel)) completion;

- (void) pushWizardPanel:(FLWizardPanel*) viewController 
                animated:(BOOL) animated 
              completion:(void (^)(FLWizardPanel* newPanel)) completion;

- (void) popWizardPanelAnimated:(BOOL) animated
                     completion:(void (^)(FLWizardPanel* poppedPanel)) completion;

// visible panels.

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

@protocol FLWizardViewControllerDelegate <NSObject>
@optional
- (void) wizardViewControllerCanStart:(FLWizardViewController*) wizard;

- (void) wizardViewController:(FLWizardViewController*) wizard 
     willStartWithWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) wizardViewController:(FLWizardViewController*) wizard 
      didStartWithWizardPanel:(FLWizardPanel*) wizardPanel;

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

