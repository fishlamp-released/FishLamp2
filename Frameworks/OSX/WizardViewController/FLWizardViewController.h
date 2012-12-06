//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLClickablePathViewController.h"

@protocol FLWizardViewControllerDelegate;
@class FLWizardViewController;

@protocol FLWizardPanel <NSObject>
+ (NSString*) localizedWizardPanelTitle;

@optional
- (void) wizardPanelWillAppear:(FLWizardViewController*) wizard;
- (void) wizardPanelDidAppear:(FLWizardViewController*) wizard;
- (void) wizardPanelWillDisappear:(FLWizardViewController*) wizard;
- (void) wizardPanelDidDisappear:(FLWizardViewController*) wizard;
- (void) wizardPanelWasCancelled:(FLWizardViewController*) wizard;
@end

typedef NSViewController<FLWizardPanel> FLWizardPanelController;

@interface FLWizardViewController : NSViewController<FLClickablePathViewControllerDelegate> {
@private
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _previousButton;
    IBOutlet NSButton* _cancelButton;
    IBOutlet NSTextField* _titleTextField;

    NSMutableArray* _viewStack;
    NSArray* _panelClasses;
    int _currentPanel;
    
    IBOutlet id<FLWizardViewControllerDelegate> _delegate;
}

- (void) startWizardWithPanelClasses:(NSArray*) panelClasses;

@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* previousButton;
@property (readonly, strong, nonatomic) NSButton* cancelButton;
@property (readonly, strong, nonatomic) NSTextField* titleTextField;

@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> wizardViewControllerDelegate;

- (IBAction) nextPanel:(id) sender;
- (IBAction) prevPanel:(id) sender;
- (IBAction) cancel:(id) sender;
@end

@protocol FLWizardViewControllerDelegate <NSObject>

@end

