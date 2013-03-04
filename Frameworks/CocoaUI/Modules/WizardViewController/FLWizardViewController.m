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
#import "UIViewController+FLAdditions.h"
#import "FLPanelViewController.h"
#import "FLStatusBarViewController.h"

#import "FLSlideInAndDropTransition.h"
#import "FLSlideOutAndComeForwardTransition.h"

@interface FLWizardViewController ()
- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
- (IBAction) respondToOtherButton:(id) sender;
@end

@implementation FLWizardViewController

@synthesize delegate = _delegate;

// views
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

- (void) addPanel:(FLPanelViewController*) panel forKey:(id) key {
    panel.key = key;
    panel.wizard = self;
    [self.panelManager addPanel:panel];
    [self.navigationViewController addBreadcrumb:panel.breadcrumbTitle forKey:key];
}

- (void) willStartWizardInWindow:(NSWindow*) window {
   FLPerformSelector1(self.delegate, @selector(wizardViewControllerWillStartWizard:), self);
}

- (void) didStartWizardInWindow:(NSWindow*) window {
    FLPerformSelector1(self.delegate, @selector(wizardViewControllerDidStartWizard:), self);
}

- (void) startWizardInWindow:(NSWindow*) window {
    [self willStartWizardInWindow:window];

    [window setContentView:self.view];
    [window setDefaultButtonCell:[self.buttonViewController.nextButton cell]];

    self.panelManager.delegate = self; 
    [self.panelManager showFirstPanel];  
}

- (void)loadView {
    [super loadView];
    [self view];
    
    FLPerformSelector1(self.delegate, @selector(wizardViewControllerCanStart:), self);
    
    _navigationViewController.delegate = self;
//    
//    [self.navigationViewController.view bringToFront];
//    [self.panelManager.view sendToBack];
//    
//    CGRect managerFrame = self.panelManager.view.frame;
//    
//    managerFrame.origin.y = FLRectGetBottom(self.buttonViewController.view.frame);
//    managerFrame.origin.x = FLRectGetRight(self.navigationViewController.view.frame) - 5;
//    managerFrame.size.height = self.headerViewController.view.frame.origin.y - FLRectGetBottom(self.buttonViewController.view.frame);
//    
//    
//    self.panelManager.view.frame = managerFrame;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (IBAction) respondToNextButton:(id) sender {

    BOOL handled = [self.panelManager.visiblePanel respondToNextButton:self];

    if(!handled) {
        [self.panelManager showNextPanelAnimated:YES completion:nil];
    }
}

- (IBAction) respondToOtherButton:(id) sender {
    [self.panelManager.visiblePanel respondToOtherButton:self];
}

- (IBAction) respondToBackButton:(id) sender {

    BOOL handled = [self.panelManager.visiblePanel respondToBackButton:self];

    if(!handled) {
        [self.panelManager showPreviousPanelAnimated:YES completion:nil];
    }
}

- (void) updateButtonEnabledStates {
    self.buttonViewController.backButton.enabled = 
        !self.panelManager.isShowingFirstPanel;
        
    self.buttonViewController.nextButton.enabled = 
        [self.panelManager visiblePanel].canOpenNextPanel &&
        ![self.panelManager isShowingLastPanel];
        
    [self.navigationViewController update];
}

- (void) removePanel:(FLPanelViewController*) panel {
    [self.panelManager removePanel:panel];
    [self updateButtonEnabledStates];
}

- (void) willShowPanel:(FLPanelViewController*) panel {
    [self.headerViewController removePanelViews];

    if(panel) {
        [panel panelWillAppearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:panelWillAppear:), self, panel);
    }
    [self updateButtonEnabledStates];
}

- (void) didShowPanel:(FLPanelViewController*) panel {
    if(panel) {
        [panel panelDidAppearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:panelDidAppear:), self, panel);
    }
    [self updateButtonEnabledStates];
    
    [self.view.window makeFirstResponder:panel];
    [panel setNextResponder:self];
}

- (void) willHidePanel:(FLPanelViewController*) panel {
    if(panel) {
        [panel panelWillDisappearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:panelWillDisappear:), self, panel);
    }
}

- (void) didHidePanel:(FLPanelViewController*) panel {
    if(panel) {
        [panel panelDidDisappearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:panelDidAppear:), self, panel);
    }
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(id) key {
    return [key isEqual:[self.panelManager.visiblePanel key]];
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(id) key {
    return [self.panelManager canOpenPanelForKey:key];
}

- (void) setPanelTitleFields:(FLPanelViewController*) panel {
    [self.headerViewController setTitle:panel.title];
    [self.navigationViewController update];
}
                 
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar 
    breadcrumbWasClicked:(NSString*) key {
    [self.panelManager showPanelForKey:key animated:YES completion:nil];
}
       
- (void) panelManager:(FLWizardViewController*) wizard 
                              willHidePanel:(FLPanelViewController*) toHide
                              willShowPanel:(FLPanelViewController*) toShow {

    if(toHide) {
        [self willHidePanel:toHide];
    }
    [self willShowPanel:toShow];

    self.buttonViewController.nextButton.enabled = NO;
    self.buttonViewController.backButton.enabled = NO;
    self.buttonViewController.otherButton.hidden = YES;
     
}     

- (void) panelManager:(FLWizardViewController*) wizard 
                              didHidePanel:(FLPanelViewController*) toHide
                              didShowPanel:(FLPanelViewController*) toShow {

    if(toHide) {
        [self didHidePanel:toHide];
    }
    [self setPanelTitleFields:toShow];
    [self didShowPanel:toShow];
    [self updateButtonEnabledStates];
}                              

- (Class) panelManagerGetForwardTransitionClass:(FLPanelManager*) controller {
    return nil;
}

- (Class) panelManagerGetBackwardTransitionClass:(FLPanelManager*) controller {
    return nil;
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

- (IBAction) closeIfModalInWindow:(id) sender {
    if(self.modalInWindow) {
        [[NSApplication sharedApplication] endSheet:self.window];
    }
}

- (void) showModallyInWindow:(NSWindow*) window 
           withDefaultButton:(NSButton*) button {
    
    self.modalInWindow = window;
    window.modalWindowController = self;

    [[NSApplication sharedApplication] beginSheet:self.window  
                                   modalForWindow:window
                                   modalDelegate:self 
                                   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
                                      contextInfo:nil];
                                      
    NSModalSession modalSession = [NSApp beginModalSessionForWindow:self.window];
    self.modalSession = [NSValue valueWithPointer:modalSession];
    
    [NSApp runModalSession:modalSession];
    [self.window makeFirstResponder:self.window];
    
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


//        CABasicAnimation *controlPosAnim = [CABasicAnimation animationWithKeyPath:@"frame"];
//        [controlPosAnim setFromValue:[NSValue valueWithPoint:toShow.view.frame.origin]];
//        [controlPosAnim setToValue:[NSValue valueWithPoint:CGPointZero]];
//        controlPosAnim.removedOnCompletion = YES;
//        [toShow.view setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:controlPosAnim, @"frame", nil]];



//        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
//        scale.fromValue =   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)];
//        scale.toValue =     [NSValue valueWithCATransform3D:FLShrunkTransform(toHide.view)];
//        scale.removedOnCompletion = YES;
//        toHide.view.layer.transform = FLShrunkTransform(toHide.view);

//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
//        animation.fromValue = [NSNumber numberWithFloat:1.0f];
//        animation.toValue = [NSNumber numberWithFloat:0.0f];
//        animation.removedOnCompletion = YES;
//        animation.fillMode = kCAFillModeBoth;
//        animation.additive = NO;
//        [toHide.view setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:animation, @"alphaValue", nil]];

        
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:kDuration];
//        [CATransaction setCompletionBlock:finished];
//        [[toShow.view animator] setFrame:_panelManager.bounds];
//        [[toHide.view animator] setAlphaValue:0.0f];
//        [toHide.view.layer addAnimation:scale forKey:@"transform"];
////        toHide.view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
//        [CATransaction commit];

        
//        toShow.view.alphaValue = 0.0f;
//       //    
//        
//        CABasicAnimation *controlPosAnim = [CABasicAnimation animationWithKeyPath:@"frame"];
//        [controlPosAnim setFromValue:[NSValue valueWithPoint:CGPointZero]];
//        [controlPosAnim setToValue:[NSValue valueWithPoint:FLRectGetTopRight(toHide.view.frame)]];
//        controlPosAnim.removedOnCompletion = YES;
//        [toHide.view setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:controlPosAnim, @"frame", nil]];
//
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
//        animation.fromValue = [NSNumber numberWithFloat:0.0f];
//        animation.toValue = [NSNumber numberWithFloat:1.0f];
//        animation.removedOnCompletion = YES;
//        animation.fillMode = kCAFillModeBoth;
//        animation.additive = NO;
//        [toShow.view setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:animation, @"alphaValue", nil]];
//
//
//        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
//        scale.fromValue =   [NSValue valueWithCATransform3D:FLShrunkTransform(toHide.view)];
//        scale.toValue =     [NSValue valueWithCATransform3D:FLUnshrunkTransform(toShow.view)];
//        scale.removedOnCompletion = YES;
// 
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:kDuration];
//        [CATransaction setCompletionBlock:finished];
//        [toShow.view.layer addAnimation:scale forKey:@"transform"];
//        [[toHide.view animator] setFrame:FLRectSetOriginWithPoint(_panelManager.bounds, FLRectGetTopRight(toHide.view.frame))];
//        [[toShow.view animator] setAlphaValue:1.0f];
//        [CATransaction commit];
#endif