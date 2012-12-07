//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLBreadcrumbBarView.h"

@protocol FLWizardViewControllerDelegate;
@class FLWizardViewController;

@protocol FLWizardPanel <NSObject>
@optional
- (void) wizardPanelWillAppear:(FLWizardViewController*) wizard;
- (void) wizardPanelDidAppear:(FLWizardViewController*) wizard;
- (void) wizardPanelWillDisappear:(FLWizardViewController*) wizard;
- (void) wizardPanelDidDisappear:(FLWizardViewController*) wizard;

- (void) wizardPanelRespondToNextButton:(FLWizardViewController*) wizard;
- (void) wizardPanelRespondToPreviousButton:(FLWizardViewController*) wizard;
- (void) wizardPanelRespondToOtherButton:(FLWizardViewController*) wizard;
@end

typedef NSViewController<FLWizardPanel> FLWizardPanel;

@interface FLWizardViewController : NSViewController {
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

    NSMutableArray* _viewStack;
    NSMutableArray* _pendingStack;
    NSMutableArray* _wizardPanels;
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

@property (readonly, strong, nonatomic) NSArray* wizardPanels;
@property (readonly, strong, nonatomic) FLWizardPanel* visibleWizardPanel;
@property (readonly, strong, nonatomic) FLWizardPanel* nextWizardPanel;
@property (readonly, strong, nonatomic) FLWizardPanel* previousWizardPanel;
- (void) addWizardPanel:(FLWizardPanel*) wizardPanel;
- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel;


// visible panels.
- (void) popWizardPanelAnimated:(BOOL) animated
                     completion:(void (^)()) completion;

- (void) pushWizardPanel:(FLWizardPanel*) viewController 
                animated:(BOOL) animated 
              completion:(void (^)()) completion;
              
- (void) startWizardInWindow:(NSWindow*) window;

// creation
+ (id) wizardViewController;

@end

@protocol FLWizardViewControllerDelegate <NSObject>
@optional
- (void) wizardViewControllerCanStart:(FLWizardViewController*) wizard;
- (void) wizardViewControllerWillStart:(FLWizardViewController*) wizard;
- (void) wizardViewControllerDidStart:(FLWizardViewController*) wizard;
- (void) wizardViewControllerDidFinish:(FLWizardViewController*) wizard;
@end

