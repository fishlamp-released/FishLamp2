//
//  FLWizardViewController.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX

#import "FLWizardViewController.h"
#import "FLAnimation.h"
#import "FLFadeAnimation.h"
#import "FLMoveAnimation.h"
#import "FLDropBackAnimation.h"
#import "FLViewController.h"
#import "FLPanelViewController.h"
#import "FLStatusBarViewController.h"

#import "FLSlideInAndDropTransition.h"
#import "FLSlideOutAndComeForwardTransition.h"

@interface FLWizardViewController ()
@end

@implementation FLWizardViewController

//@synthesize delegate = _delegate;

@synthesize buttonViewController = _buttonViewController;
@synthesize headerViewController = _headerViewController;
@synthesize navigationViewController = _navigationViewController;
@synthesize panelManager = _panelManager;

- (id) init {
    return [self initWithNibName:@"FLWizardViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

+ (id) wizardViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) updateButtonEnabledStates:(BOOL) animated {
    [self.buttonViewController updateButtons];
    [self.navigationViewController updateViewsAnimated:animated];
}

- (void) addPanel:(FLPanelViewController*) panel {
    [self.panelManager addPanel:panel];
}

- (void) removePanelForTitle:(id) title {
    [self.panelManager removePanelForTitle:title];
}

- (void) willShowPanel:(FLPanelViewController*) toShow willHidePanel:(FLPanelViewController*) toHide {
}

- (void) didShowPanel:(FLPanelViewController*) toShow didHidePanel:(FLPanelViewController*) toHide {
}

- (void) startWizardInWindow:(NSWindow*) window {
    [window setContentView:self.view];
    [window setDefaultButtonCell:[self.buttonViewController.nextButton cell]];
    [self.panelManager showFirstPanel];  
}

- (void)loadView {
    [super loadView];
    [self view];
    self.navigationViewController.delegate = self;
    self.buttonViewController.delegate = self;
    self.panelManager.delegate = self;
    
    [_progressView setRespondsToGlobalNetworkActivity:YES];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (void) removePanel:(FLPanelViewController*) panel {
    [self.panelManager removePanelForTitle:panel.title];
    [self updateButtonEnabledStates:NO];
}

#pragma mark button view controller delegate

- (void) wizardButtonViewControllerRespondToNextButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.panelManager.visiblePanel respondToNextButton:&handled];

    if(!handled) {
        [self.panelManager showNextPanelAnimated:YES completion:nil];
    }
}

- (void) wizardButtonViewControllerRespondToBackButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.panelManager.visiblePanel respondToBackButton:&handled];

    if(!handled) {
        [self.panelManager showPreviousPanelAnimated:YES completion:nil];
    }
}

- (void) wizardButtonViewControllerRespondToOtherButton:(FLWizardButtonViewController*) controller {
    BOOL handled = NO;
    [self.panelManager.visiblePanel respondToOtherButton:&handled];
}

- (void) wizardButtonViewControllerUpdateButtonStates:(FLWizardButtonViewController*) controller {
    self.buttonViewController.backButton.enabled = 
        !self.panelManager.isShowingFirstPanel;
        
    self.buttonViewController.nextButton.enabled = 
        [self.panelManager visiblePanel].canOpenNextPanel &&
        ![self.panelManager isShowingLastPanel];
}

#pragma mark breadcrumb bar delegate

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(id) title {
    return [title isEqual:[self.panelManager.visiblePanel title]];
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(id) title {
    return [self.panelManager canOpenPanelForTitle:title];
}
                
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar 
    breadcrumbWasClicked:(NSString*) title {
    [self.panelManager showPanelForTitle:title animated:YES completion:nil];
}

#pragma mark panel manager delegate

- (void) panelManager:(FLPanelManager*) controller panelStateDidChange:(FLPanelViewController*) panel {
    [self updateButtonEnabledStates:YES];
}

- (void) panelManager:(FLPanelManager*) controller didAddPanel:(FLPanelViewController*) panel {
    panel.buttons = self.buttonViewController;
    panel.header = self.headerViewController;
    panel.wizardViewController = self;
    [self.navigationViewController addBreadcrumb:panel.title];
}

- (void) panelManager:(FLPanelManager*) controller didRemovePanel:(FLPanelViewController*) panel {
    [self.navigationViewController removeBreadcrumb:panel.title];
}
       
- (void) panelManager:(FLWizardViewController*) wizard 
        willShowPanel:(FLPanelViewController*) toShow
        willHidePanel:(FLPanelViewController*) toHide
    animationDuration:(CGFloat) animationDuration {

    [self.headerViewController setPrompt:toShow.prompt animationDuration:animationDuration];
    self.buttonViewController.nextButton.enabled = NO;
    self.buttonViewController.backButton.enabled = NO;
    self.buttonViewController.otherButton.hidden = YES;
    [self willShowPanel:toShow willHidePanel:toHide];
}     

- (void) panelManager:(FLWizardViewController*) wizard 
         didShowPanel:(FLPanelViewController*) toHide
         didHidePanel:(FLPanelViewController*) toShow {
    [self didShowPanel:toShow didHidePanel:toHide];

    [self.panelManager setNextResponder:self];
    [self setNextResponder:self.navigationViewController];
    [self.navigationViewController setNextResponder:self.view.window];
    
//    id responder = self.view.window.firstResponder;
//    while(responder) {
//        FLLog(@"first responder: %@", [responder description]);
//        responder = [responder nextResponder];
//    }
    
}                              
- (void) didHideErrorAlertForError:(NSError*) error {
    [self.view.window makeFirstResponder:self];
    [[self.panelManager visiblePanel] didHideAlertWithError:error];
}

- (void)didPresentErrorWithRecovery:(BOOL)didRecover contextInfo:(void *)contextInfo {
    
    NSError* error = FLAutorelease(FLBridgeTransfer(NSError*, contextInfo));

    [self didHideErrorAlertForError:error];
}

- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error {

    if(error.isCancelError) {
        return;
    }

    FLMutableError* theError = [FLMutableError mutableErrorWithError:error];

    NSMutableString* errorString = [NSMutableString string];
    if(title) {
        [errorString appendString:title];
    
        if(caption) {
            [errorString appendFormat:@"\n\n%@", caption];
        }
        
        theError.localizedDescription = errorString;
    }
    

    NSBeep();
    
    void* context = FLBridgeRetain(void*, error);
    
    [self presentError:error modalForWindow:self.view.window delegate:self didPresentSelector:@selector(didPresentErrorWithRecovery:contextInfo:) contextInfo:context];
    
//    FLLocalNotification* notification = [FLLocalNotification localNotificationWithName:@"Authentication Failed"];
//    notification.subtitle = @"Please try again";
//    [notification deliverNotification];

    [NSApp requestUserAttention:NSCriticalRequest];
}


@end

@implementation NSWindow (FLModalAdditions)
FLSynthesizeAssociatedProperty(retain_nonatomic, modalWindowController, setModalWindowController, NSWindowController*);

- (void) closeModalWindowController {
    [self.modalWindowController closeIfModalInWindow:self];
}

@end

@implementation NSWindowController (FLModalAdditions)

FLSynthesizeAssociatedProperty(assign_nonatomic, modalInWindow, setModalInWindow, NSWindow*);
FLSynthesizeAssociatedProperty(retain_nonatomic, modalSession, setModalSession, NSValue*);
FLSynthesizeAssociatedProperty(assign_nonatomic, previousFirstResponderForModal, setPreviousFirstResponderForModal, id);

- (IBAction) closeIfModalInWindow:(id) sender {
    if(self.modalInWindow) {
        [[NSApplication sharedApplication] endSheet:self.window];
    }
    
    [self.window makeFirstResponder:self.previousFirstResponderForModal];
}

- (void) showModallyInWindow:(NSWindow*) window 
           withDefaultButton:(NSButton*) button {
    
    self.modalInWindow = window;
    self.previousFirstResponderForModal = self.window.firstResponder;
    
    window.modalWindowController = self;

    [[NSApplication sharedApplication] beginSheet:self.window  
                                   modalForWindow:window
                                   modalDelegate:self 
                                   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
                                      contextInfo:nil];
                                      
    NSModalSession modalSession = [NSApp beginModalSessionForWindow:self.window];
    self.modalSession = [NSValue valueWithPointer:modalSession];
    
    [NSApp runModalSession:modalSession];
    [window makeFirstResponder:window];
    
    if(button) {
        [self.window setDefaultButtonCell:[button cell]];
    }
}

- (void)sheetDidEnd:(NSAlert*)alert 
         returnCode:(NSInteger)returnCode 
        contextInfo:(void*)contextInfo {

    [NSApp endModalSession:[[self modalSession] pointerValue]];
    [self.window orderOut:self.window];
    
    self.modalInWindow.modalWindowController = nil;
    self.modalInWindow = nil;
    self.modalSession = nil;
}

@end
#endif