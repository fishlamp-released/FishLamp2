//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
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

//    NSView* _backgroundView;
//    NSView* _wizardPanelBackgroundView;
    
    IBOutlet NSView* _navigationViewEnclosure;
    IBOutlet NSView* _wizardPanelEnclosureView;
    IBOutlet NSTextField* _titleTextField;
    
    IBOutlet NSView* _buttonEnclosureView;
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _backButton;
    IBOutlet NSButton* _otherButton;
    IBOutlet NSProgressIndicator* _spinner;
    
    NSMutableArray* _panels;
    NSUInteger _currentPanel;
    FLBreadcrumbBarViewController* _breadcrumbBar;
}

// delegate
@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

// controls
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;
@property (readonly, strong, nonatomic) NSTextField* titleTextField;
@property (readonly, strong, nonatomic) FLBreadcrumbBarViewController* breadcrumbBar;

- (void) showSpinner:(BOOL) show;

// enclosures
@property (readonly, strong, nonatomic) NSView* buttonEnclosureView;
@property (readonly, strong, nonatomic) NSView* wizardPanelEnclosureView;

+ (id) wizardViewController;

- (void) startWizardInWindow:(NSWindow*) window;

// 
// Panel creation
// 
//- (void) pushPanel:(FLWizardPanel*) panel;
- (void) appendPanel:(FLWizardPanel*) panel forKey:(id) key;
- (FLWizardPanel*) panelForKey:(id) key;

- (BOOL) canShowPanelForPanelKey:(id) key;

//
// Visible Panel Stack
//
@property (readonly, assign, nonatomic) NSUInteger panelCount;
@property (readonly, assign, nonatomic) NSUInteger currentPanelIndex;

@property (readonly, strong, nonatomic) FLWizardPanel* visibleWizardPanel;

- (void) showNextWizardPanelAnimated:(BOOL) animated 
                      completion:(FLWizardPanelBlock) completion;

- (void) showPreviousWizardPanelAnimated:(BOOL) animated
                             completion:(FLWizardPanelBlock) completion;

- (void) showWizardPanelAnimated:(BOOL) animated withIndex:(NSUInteger) panelIndex completion:(FLWizardPanelBlock) completion;

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel;
//
// Utils
//
- (void) updateButtonEnabledStates;

//
// optional overrides
//
- (void) didHideWizardPanel:(FLWizardPanel*) wizardPanel;
- (void) willHideWizardPanel:(FLWizardPanel*) wizardPanel;

- (void) didShowWizardPanel:(FLWizardPanel*) wizardPanel;
- (void) willShowWizardPanel:(FLWizardPanel*) wizardPanel;

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
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel respondToBackButton:(FLWizardViewController*) wizard;
//- (BOOL) wizardPanel:(FLWizardPanel*) wizardPanel willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard;


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