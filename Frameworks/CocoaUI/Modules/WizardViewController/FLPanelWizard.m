//
//  FLPanelWizard.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPanelWizard.h"

@interface FLWizardView : NSView
@end

@implementation FLWizardView 

#if DEBUG
- (void) setFrame:(CGRect) frame {
//    [super setFrame:frame];

    if(frame.size.height > 0 && frame.size.width > 0) {
        [super setFrame:frame];
    }
}
#endif

@end

@implementation FLPanelWizard
@synthesize navigationViewController = _navigationViewController;
@synthesize panelManager = _panelManager;


- (void) addPanel:(FLPanelViewController*) panel {
    [self.panelManager addPanel:panel];
}

- (void) addPanel:(FLPanelViewController*) panel withDelegate:(id) delegate {
    
    [panel view]; // make sure it's loaded from nib

    [self.panelManager addPanel:panel];
    panel.delegate = self;
}
 
- (void) removePanelForTitle:(id) title {
    [self.panelManager removePanelForTitle:title];
}

- (void) willShowPanel:(FLPanelViewController*) toShow willHidePanel:(FLPanelViewController*) toHide {
}

- (void) didShowPanel:(FLPanelViewController*) toShow didHidePanel:(FLPanelViewController*) toHide {
}

- (void) showFirstPanel {
    [self.panelManager showFirstPanel];  
}

- (void) startWizardInWindow:(NSWindow*) window {
    [window setContentView:self.view];
    [window setDefaultButtonCell:[self.buttonViewController.nextButton cell]];
    [self setNextResponder:window];
    [self showFirstPanel];  
}

- (void) awakeFromNib {
    [super awakeFromNib];
    self.navigationViewController.delegate = self;
    self.panelManager.delegate = self;
    _panelManager.nextResponder = self;
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


- (void) panelManager:(FLWizardViewController*) wizard 
        willShowPanel:(FLPanelViewController*) toShow
        willHidePanel:(FLPanelViewController*) toHide
    animationDuration:(CGFloat) animationDuration {

    [self willShowPanel:toShow willHidePanel:toHide];
}     

- (void) panelManager:(FLWizardViewController*) wizard 
         didShowPanel:(FLPanelViewController*) toHide
         didHidePanel:(FLPanelViewController*) toShow {
    [self didShowPanel:toShow didHidePanel:toHide];
    
//    [self.navigationViewController setNextResponder:self.view.window];
    
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

    FLAssertNotNil(error);

    if(error.isCancelError) {
        return;
    }

    NSError* theError = error;

    if(!title) {
        title = NSLocalizedString(@"An error occurred.", nil); 
    }
    
    NSMutableString* errorString = [NSMutableString stringWithString:title];
    
    if(caption) {
        [errorString appendFormat:@"\n\n%@\n", caption];
    } 
    else {
        [errorString appendFormat:@"\n\n%@\n", [error localizedDescription]];
    }
    
    theError = [NSError errorWithDomain:error.domain code:error.code localizedDescription:errorString];

    NSBeep();
    
    void* context = FLBridgeRetain(void*, error);
    
    [self presentError:theError modalForWindow:self.view.window delegate:self didPresentSelector:@selector(didPresentErrorWithRecovery:contextInfo:) contextInfo:context];
        
    if(![[NSApplication sharedApplication] isActive]) {
#if __MAC_10_8
        FLLocalNotification* notification = [FLLocalNotification localNotificationWithName:title];
//        notification.subtitle = @"Please try again";
        [notification deliverNotification];
#endif
        
        [NSApp requestUserAttention:NSCriticalRequest];
    }
}


- (BOOL)validateMenuItem:(NSMenuItem *)item {
    return YES;
}

- (void) panelManager:(FLPanelManager*) controller panelStateDidChange:(FLPanelViewController*) panel {
}

- (void) panelManager:(FLPanelManager*) controller didAddPanel:(FLPanelViewController*) panel {
    panel.wizardViewController = self;
    [self.navigationViewController addBreadcrumb:panel.title];
}

- (void) panelManager:(FLPanelManager*) controller didRemovePanel:(FLPanelViewController*) panel {
    [self.navigationViewController removeBreadcrumb:panel.title];
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

@end
