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
#import "FLWizardPanel.h"
#import "FLStatusBarViewController.h"

#import "FLSlideInAndDropTransition.h"
#import "FLSlideOutAndComeForwardTransition.h"

@interface FLWizardViewController ()
@property (readonly, strong, nonatomic) NSArray* wizardPanels;
- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
@end

@implementation FLWizardViewController
@synthesize nextButton = _nextButton;
@synthesize backButton = _backButton;
@synthesize delegate = _delegate;
@synthesize wizardPanels = _panels;
@synthesize titleTextField = _titleTextField;
@synthesize buttonEnclosureView = _buttonEnclosureView;
@synthesize wizardPanelEnclosureView = _wizardPanelEnclosureView;
@synthesize breadcrumbBar = _breadcrumbBar;
@synthesize currentPanelIndex = _currentPanel;

- (NSUInteger) panelCount {
    return _panels.count;
}

#if FL_MRC
- (void) dealloc {
    [_breadcrumbBar release];
    [_panels release];
    [super dealloc];
}
#endif

- (id) init {
    return [self initWithNibName:@"FLWizardViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _panels = [[NSMutableArray alloc] init];
        _currentPanel = INT_MAX;
    }
    
    return self;
}

+ (id) wizardViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) setPanelFrame:(FLWizardPanel*) panel {

    CGRect frame = panel.view.frame;
    CGRect bounds = _wizardPanelEnclosureView.bounds;
    bounds = CGRectInset(bounds, 1.0, 1.0);
    
    NSUInteger originalMask = panel.view.autoresizingMask;
    
    if(FLBitTest(originalMask, (NSViewWidthSizable))) {
        frame.size.width = bounds.size.width;
        frame.origin.x = bounds.origin.x;
    }
    else {
        frame = FLRectCenterRectInRectHorizontally(bounds, frame);
    }

    if(FLBitTest(originalMask, (NSViewHeightSizable))) {
        frame.size.height = bounds.size.height;
        frame.origin.y = bounds.origin.y;
    }
    else {
//        frame = FLRectPositionRectInRectVerticallyBottomThird(bounds, frame);
        frame = FLRectCenterRectInRectVertically(bounds, frame);
    }

    panel.view.frame = frame;
}

- (void) appendPanel:(FLWizardPanel*) panel 
              forKey:(id) key{
              
    panel.key = key;
    [_panels addObject:panel];
    [_breadcrumbBar addBreadcrumb:panel.breadcrumbTitle forKey:key];
    panel.wizard = self;
}
                    
- (void) willStartWizardInWindow:(NSWindow*) window {
   FLPerformSelector1(self.delegate, @selector(wizardViewControllerWillStartWizard:), self);
}

- (void) didStartWizardInWindow:(NSWindow*) window {
    FLPerformSelector1(self.delegate, @selector(wizardViewControllerDidStartWizard:), self);
}

- (void) startWizardInWindow:(NSWindow*) window {
    [self willStartWizardInWindow:window];

    [self.view setWantsLayer:YES];
    [window setContentView:self.view];
    [window setDefaultButtonCell:[self.nextButton cell]];
      
    FLWizardPanel* toShow = [_panels objectAtIndex:0];
    _currentPanel = 0;
    [self setPanelFrame:toShow];
    [self willShowWizardPanel:toShow];
    [_wizardPanelEnclosureView addSubview:[toShow view]];
    [self setWizardPanelTitleFields:toShow];
    [self didShowWizardPanel:toShow];
    [self didStartWizardInWindow:window];
    [self.view.window display];
    [self updateButtonEnabledStates];
}

- (void)loadView {
    [super loadView];
    [self view];
    _backButton.hidden = NO;
    _nextButton.hidden = NO;
    _nextButton.enabled = NO;
    _backButton.enabled = NO;
    
    FLPerformSelector1(self.delegate, @selector(wizardViewControllerCanStart:), self);
    _wizardPanelEnclosureView.wantsLayer = YES;
    
    _breadcrumbBar = [[FLBreadcrumbBarViewController alloc] init];
    _breadcrumbBar.view.frame = _navigationViewEnclosure.bounds;
    _breadcrumbBar.delegate = self;
    
    [_navigationViewEnclosure addSubview:_breadcrumbBar.view];
    
    [self showSpinner:NO];
    
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    [self setPanelFrame:self.visibleWizardPanel];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (IBAction) respondToNextButton:(id) sender {

    BOOL handled = [self.visibleWizardPanel willRespondToNextButtonInWizard:self];

    if(!handled) {
        [self showNextWizardPanelAnimated:YES completion:nil];
    }
}

- (IBAction) respondToBackButton:(id) sender {

    BOOL handled = [self.visibleWizardPanel willRespondToBackButtonInWizard:self];

    if(!handled) {
        [self showPreviousWizardPanelAnimated:YES completion:nil];
    }
}

- (FLWizardPanel*) visibleWizardPanel {
    return _panels.count > _currentPanel ? [_panels objectAtIndex:_currentPanel] : nil;
}

- (void) updateButtonEnabledStates {
    self.backButton.enabled = _currentPanel > 0;
    self.nextButton.enabled = [self visibleWizardPanel].canOpenNextPanel;
    [_breadcrumbBar update];
}

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel {
    [_panels removeObject:wizardPanel];
    [self updateButtonEnabledStates];
}

- (void) willShowWizardPanel:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelWillAppearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelWillAppear:), self, wizardPanel);
    }
    [self updateButtonEnabledStates];
}

- (void) didShowWizardPanel:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelDidAppearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelDidAppear:), self, wizardPanel);
    }
    [self updateButtonEnabledStates];
}

- (void) willHideWizardPanel:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelWillDisappearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelWillDisappear:), self, wizardPanel);
    }
}

- (void) didHideWizardPanel:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelDidDisappearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelDidAppear:), self, wizardPanel);
    }
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(id) key {
    return [key isEqual:[self.visibleWizardPanel key]];
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(id) key {

    if([self.visibleWizardPanel.key isEqual:key]) {
        return YES;
    }

    NSUInteger idx = NSNotFound;
    for(NSUInteger i = 0; i < _panels.count; i++) {
        if([key isEqual:[[_panels objectAtIndex:i] key]]) {
            idx = i;
            break;
        }
    }
    if(idx == NSNotFound) {
        return NO;
    }
    
    for(NSUInteger i = 0; i < idx; i++) {
        FLWizardPanel* panel = [_panels objectAtIndex:i];
        if(panel.canOpenNextPanel == NO) {
            return NO;
        }
    }

    return YES;
}

- (BOOL) canShowPanelForPanelKey:(id) key {

    for(FLWizardPanel* panel in _panels) {
        if(panel.canOpenNextPanel == NO) {
            return NO;
        }
        if([key isEqual:[panel key]]) {
            return panel.canOpenNextPanel;
        }
    }
    
    return NO;
}

- (FLWizardPanel*) panelForKey:(id) key {
    for(FLWizardPanel* panel in _panels) {
        if([key isEqual:[panel key]]) {
            return panel;
        }
    }
    
    return nil;
}

- (NSInteger) indexForKey:(id) key {
    for(NSInteger i = 0; i < _panels.count; i++) {
        if([key isEqual:[[_panels objectAtIndex:i] key]]) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (void) showSpinner:(BOOL) show {
    [_spinner setHidden:!show];
    if(show) {
        [_spinner startAnimation:self];
    }
    else {
        [_spinner stopAnimation:self];
    }
        
}


- (void) setWizardPanelTitleFields:(FLWizardPanel*) wizardPanel {
    self.titleTextField.hidden = NO;
    self.titleTextField.stringValue = wizardPanel.title;
    [_breadcrumbBar update];
}

//#define kDuration 0.2f

- (void) setFirstResponder {
//    [[self.view.window firstResponder] resignFirstResponder];
    [self.view.window makeFirstResponder:self];
}

- (void) showWizardPanelAnimated:(BOOL) animated 
                            show:(FLWizardPanel*) toShow
                            hide:(FLWizardPanel*) toHide
                      completion:(void (^)(FLWizardPanel*)) completion {

    FLAssertNotNil_(toShow);
//    FLAssertNotNil_(toHide);
    
    [self setFirstResponder];

    self.nextButton.enabled = NO;
    self.backButton.enabled = NO; // (_panels.count > 0);
    
    if(toHide) {
        [self willHideWizardPanel:toHide];
    }
    
    [self setPanelFrame:toShow];
    [self willShowWizardPanel:toShow];
              
    completion = FLCopyWithAutorelease(completion);
    
    dispatch_block_t finished = ^{
        [self setWizardPanelTitleFields:toShow];
        if(toHide) {
            [self didHideWizardPanel:toHide];
        }
        [self didShowWizardPanel:toShow];
        [self updateButtonEnabledStates];
        
        if(completion) {
            completion(toShow);
        }

        [self.view.window display];
    };

    [_wizardPanelEnclosureView addSubview:[toShow view]];

    if(0 && animated) {
        FLSlideInAndDropTransition* transition = 
            [FLSlideInAndDropTransition transitionWithViewToShow:[toShow view] 
                                                      viewToHide:toHide ? [toHide view] : nil];

        [transition startAnimating:^{
            finished();
        }];
    }
    else {
        [toHide.view removeFromSuperview];
        finished();
    }
}

- (void) showNextWizardPanelAnimated:(BOOL) animated 
                      completion:(void (^)(FLWizardPanel*)) completion {

    [self.view.window makeFirstResponder:self];
    [self.view.window display];
 
    FLAssert_v(_panels.count > _currentPanel + 1, @"order not set");
       
    FLWizardPanel* toHide = [_panels objectAtIndex:_currentPanel];
    FLWizardPanel* toShow = [_panels objectAtIndex:++_currentPanel];
    FLAssertNotNil_(toShow);
    FLAssertNotNil_(toHide);
    
    [self showWizardPanelAnimated:animated  show:toShow hide:toHide completion:completion];
}

                             
- (void) hideWizardPanelAnimated:(BOOL) animated 
                            hide:(FLWizardPanel*) toHide
                            show:(FLWizardPanel*) toShow
                      completion:(FLWizardPanelBlock) completion {                            

    FLAssertNotNil_(toShow);

    [self setFirstResponder];

    self.nextButton.enabled = NO;
    self.backButton.enabled = NO;

    [self setPanelFrame:toShow];
            
    if(toHide) {
        [self willHideWizardPanel:toHide];
    }
    [self willShowWizardPanel:toShow];
    
    completion = FLCopyWithAutorelease(completion);
    [_wizardPanelEnclosureView addSubview:[toShow view]];
        
    dispatch_block_t finished = ^{
    // this executes after animation is finished.
    
        if(toHide) {
            [self didHideWizardPanel:toHide];
        }
        [self setWizardPanelTitleFields:toShow];
        [self didShowWizardPanel:toShow];
        [self updateButtonEnabledStates];
         
        if(completion) {
            completion(toShow);
        }        
        [self.view.window display];
    };
      
    if(0 && animated) {

        FLSlideInAndDropTransition* transition = 
            [FLSlideInAndDropTransition transitionWithViewToShow:[toShow view] 
                                                      viewToHide:toHide ? [toHide view] : nil];

        
//        FLSlideOutAndComeForwardTransition* transition = 
//            [FLSlideOutAndComeForwardTransition transitionWithViewToShow:[toShow view] 
//                                                              viewToHide:toHide != nil ? [toHide view] : nil];

        [transition startAnimating:^{
            finished();
        }];
    }
    else {
        [toHide.view removeFromSuperview];
        finished();
    }
}

- (void) showPreviousWizardPanelAnimated:(BOOL) animated 
                             completion:(FLWizardPanelBlock) completion {
    [self.view.window makeFirstResponder:self];
    [self.view.window display];

    FLAssert_v(_panels.count >= 2, @"must be at least two panels to hide visible");

    FLWizardPanel* toHide = [_panels objectAtIndex:_currentPanel];
    FLWizardPanel* toShow = [_panels objectAtIndex:--_currentPanel];
    FLAssertNotNil_(toShow);
    FLAssertNotNil_(toHide);

    [self hideWizardPanelAnimated:animated 
                             hide:toHide 
                             show:toShow 
                       completion:completion];
}                             

- (void) showWizardPanelAnimated:(BOOL) animated withIndex:(NSUInteger) idx completion:(FLWizardPanelBlock) completion {

    if(idx < _currentPanel) {
        [self hideWizardPanelAnimated:YES hide:self.visibleWizardPanel show:[_panels objectAtIndex:idx] completion:nil];
        
        _currentPanel = idx;
    }
    else if (idx > _currentPanel) {
        [self showWizardPanelAnimated:YES show:[_panels objectAtIndex:idx] hide:self.visibleWizardPanel completion:nil];

        _currentPanel = idx;
    }
}                             
                   
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar 
    breadcrumbWasClicked:(NSString*) key {
    
    [self showWizardPanelAnimated:YES withIndex:[self indexForKey:key] completion:nil];
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
//        [[toShow.view animator] setFrame:_wizardPanelEnclosureView.bounds];
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
//        [[toHide.view animator] setFrame:FLRectSetOriginWithPoint(_wizardPanelEnclosureView.bounds, FLRectGetTopRight(toHide.view.frame))];
//        [[toShow.view animator] setAlphaValue:1.0f];
//        [CATransaction commit];
#endif