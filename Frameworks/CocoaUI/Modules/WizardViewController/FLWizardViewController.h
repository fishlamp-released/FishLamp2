//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLBreadcrumbBarView.h"
#import "FLFlipTransition.h"
#import "FLStatusBarViewController.h"
#import "FLBreadcrumbBarViewController.h"

@class FLWizardPanel;
@protocol FLWizardViewControllerDelegate;

typedef void (^FLWizardPanelBlock)(FLWizardPanel* panel);

typedef FLWizardPanel* (^FLWizardPanelFactory)();

@interface FLWizardViewController : UIViewController<FLBreadcrumbBarViewControllerDelegate> {
@private
    __unsafe_unretained id<FLWizardViewControllerDelegate> _delegate;

    NSView* _backgroundView;
    NSView* _wizardPanelBackgroundView;
    
    IBOutlet NSView* _breadcrumbView;
    
    IBOutlet NSView* _wizardPanelEnclosureView;
    IBOutlet NSTextField* _titleTextField;
    
    IBOutlet NSView* _buttonEnclosureView;
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _backButton;
    IBOutlet NSView* _modalShieldView;
    
    NSMutableArray* _visiblePanels;
    NSMutableArray* _nextPanelQueue;
    
    FLBreadcrumbBarViewController* _breadcrumbBar;
}

// delegate
@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

// controls
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSTextField* titleTextField;

// enclosures
@property (readonly, strong, nonatomic) NSView* buttonEnclosureView;
@property (readonly, strong, nonatomic) NSView* wizardPanelEnclosureView;

@property (readwrite, strong, nonatomic) NSView* backgroundView;
@property (readwrite, strong, nonatomic) NSView* wizardPanelBackgroundView;

+ (id) wizardViewController;

- (void) startWizardInWindow:(NSWindow*) window;

// 
// Panel creation
// 
//- (void) pushPanel:(FLWizardPanel*) panel;
- (void) appendPanel:(FLWizardPanel*) panel;

//
// Visible Panel Stack
//
@property (readonly, strong, nonatomic) FLWizardPanel* visibleWizardPanel;

- (void) showNextWizardPanelAnimated:(BOOL) animated 
                      completion:(FLWizardPanelBlock) completion;

- (void) hideVisibleWizardPanelAnimated:(BOOL) animated
                             completion:(FLWizardPanelBlock) completion;

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel;

//
// Utils
//
- (void) updateBackButtonEnabledState;
- (void) showModalShield;
- (void) hideModalShield;

//
// optional overrides
//
- (void) didHideWizardPanel:(FLWizardPanel*) wizardPanel;
- (void) willHideWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) didShowWizardPanel:(FLWizardPanel*) wizardPanel;
- (void) willShowWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) willStartWizardInWindow:(NSWindow*) window;
- (void) didStartWizardInWindow:(NSWindow*) window;



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

//- (BOOL) wizardViewController:(FLWizardViewController*) wizard
//wizardPanelWillRespondToNextButton:(FLWizardPanel*) wizardPanel;
//
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel willRespondToBackButtonInWizard:(FLWizardViewController*) wizard;
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard;


@end

