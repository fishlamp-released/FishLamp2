//
//  FLWizardViewController.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

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
//@property (readonly, strong, nonatomic) FLWizardPanel* nextWizardPanel;
//@property (readonly, strong, nonatomic) FLWizardPanel* previousWizardPanel;
@property (readonly, strong, nonatomic) NSArray* wizardPanels;

- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
@end

@implementation FLWizardViewController

@synthesize nextButton = _nextButton;
@synthesize backButton = _backButton;
@synthesize delegate = _delegate;
@synthesize wizardPanels = _visiblePanels;
@synthesize titleTextField = _titleTextField;
@synthesize buttonEnclosureView = _buttonEnclosureView;
@synthesize wizardPanelBackgroundView = _wizardPanelBackgroundView;
@synthesize backgroundView = _backgroundView;
@synthesize wizardPanelEnclosureView = _wizardPanelEnclosureView;

- (void) dealloc {
//    for(FLWizardPanel* panel in _visiblePanels) {
//        panel.delegate = nil;
//    }
//    for(FLWizardPanel* panel in _nextPanelQueue) {
//        panel.delegate = nil;
//    }

#if FL_MRC
    [_wizardPanelBackgroundView release];
    [_backgroundView release];
    [_wizardPanelEnclosureView release];
    [_buttonEnclosureView release];
    [_nextButton release];
    [_backButton release];
    [_breadcrumbBar release];

    [_visiblePanels release];
    [_nextPanelQueue release];
    [super dealloc];
#endif
}

- (id) init {
    return [self initWithNibName:@"FLWizardViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _visiblePanels = [[NSMutableArray alloc] init];
        _nextPanelQueue = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (id) wizardViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) setViewToResize:(NSView*) view {
    view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
//    view.layerContentsPlacement = NSViewLayerContentsPlacementBottomLeft;
}

- (void) setBackgroundView:(NSView*) view {
    view.frame = self.view.bounds;
    [self setViewToResize:view];
    [self.view addSubview:view positioned:NSWindowBelow relativeTo:nil];
}

- (void) setWizardPanelBackgroundView:(NSView*) view {
    [view setWantsLayer:YES];
    view.frame = _wizardPanelEnclosureView.bounds;
    [self setViewToResize:view];
    [_wizardPanelEnclosureView addSubview:view positioned:NSWindowBelow relativeTo:nil];
}

//- (void) pushPanel:(FLWizardPanel*) panel {
//    [_nextPanelQueue pushObject:panel];
//}

- (void) appendPanel:(FLWizardPanel*) panel {
    [_nextPanelQueue addObject:panel];
    [_breadcrumbBar addBreadcrumb:panel.breadcrumbTitle];
    
    
    if([panel respondsToSelector:@selector(setDelegate:)]) {
        [((id)panel) setDelegate:self];
    }
    
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
    
    if(_nextPanelQueue.count) {
        [self showNextWizardPanelAnimated:NO completion:nil];
    }
    [self didStartWizardInWindow:window];
}

- (void)loadView {
    [super loadView];
    [self view];
    _backButton.hidden = NO;
    _nextButton.hidden = NO;
    _nextButton.enabled = NO;
    _backButton.enabled = NO;
    _modalShieldView.hidden = YES;
    
    FLPerformSelector1(self.delegate, @selector(wizardViewControllerCanStart:), self);
    _wizardPanelEnclosureView.wantsLayer = YES;
    
    
    _breadcrumbBar = [[FLBreadcrumbBarViewController alloc] init];
    _breadcrumbBar.view.frame = _breadcrumbView.bounds;
    _breadcrumbBar.delegate = self;
    
    [_breadcrumbView addSubview:_breadcrumbBar.view];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (IBAction) respondToNextButton:(id) sender {
    [self.view.window makeFirstResponder:self];
    [self.view.window display];

    BOOL handled = [self.visibleWizardPanel willRespondToNextButtonInWizard:self];

    if(!handled) {
        [self showNextWizardPanelAnimated:YES completion:nil];
    }
}

- (IBAction) respondToBackButton:(id) sender {
    [self.view.window makeFirstResponder:self];
    [self.view.window display];

    BOOL handled = [self.visibleWizardPanel willRespondToBackButtonInWizard:self];

    if(!handled) {
        [self hideVisibleWizardPanelAnimated:YES completion:nil];
    }
}

//- (FLWizardPanel*) nextWizardPanel {
//    return _visiblePanels.count > 0 ? FLAutorelease(FLRetain([[_visiblePanels objectAtIndex:_visiblePanels.count - 1] panel])) : nil;
//}

- (FLWizardPanel*) visibleWizardPanel {
    return _visiblePanels.count > 0 ? [_visiblePanels lastObject] : nil;
}

//- (FLWizardPanel*) previousWizardPanel {
//    return _visiblePanels.count > 1 ? FLAutorelease(FLRetain([[_visiblePanels objectAtIndex:_visiblePanels.count - 2] panel])) : nil;
//}

- (void) updateBackButtonEnabledState {

    if(_visiblePanels.count == 1) {
        self.backButton.enabled = NO; // (_visiblePanels.count > 1);
    }
}

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel {
    [_visiblePanels removeObject:wizardPanel];
    [self updateBackButtonEnabledState];
}

- (void) willShowWizardPanel:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelWillAppearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelWillAppear:), self, wizardPanel);
    }
}

- (void) didShowWizardPanel:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelDidAppearInWizard:self];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelDidAppear:), self, wizardPanel);
    }
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

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(NSString*) title {
    return FLStringsAreEqual(title, self.visibleWizardPanel.breadcrumbTitle);
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(NSString*) title {
    for(FLWizardPanel* panel in _visiblePanels) {
        if(FLStringsAreEqual(title, panel.breadcrumbTitle)) {
            return YES;
        }
    }
    for(FLWizardPanel* panel in _nextPanelQueue) {
        if(FLStringsAreEqual(title, panel.breadcrumbTitle) && panel.isEnabled) {
            return YES;
        }
    }
    
    return NO;
}

- (void) popToWizardPanel:(FLWizardPanel*) wizardPanel animated:(BOOL) animated completion:(FLWizardPanelBlock) completion {
    [self hideVisibleWizardPanelAnimated:animated completion:completion];
}

- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbWasClicked:(NSString*) title {
    for(FLWizardPanel* panel in _visiblePanels) {
        if(FLStringsAreEqual(title, panel.breadcrumbTitle)) {
            [self popToWizardPanel:panel animated:YES completion:nil];
        }
    }
    for(FLWizardPanel* panel in _nextPanelQueue) {
        if(FLStringsAreEqual(title, panel.breadcrumbTitle) && panel.isEnabled) {
            [self showNextWizardPanelAnimated:YES completion:nil];
        }
    }
}

- (void) setWizardPanelTitleFields:(FLWizardPanel*) wizardPanel {

//    NSString* prompt = [wizardPanel wizardPanelPrompt];
//
//    if(FLStringIsNotEmpty(prompt)) {
        self.titleTextField.hidden = NO;
        self.titleTextField.stringValue = wizardPanel.title;
//    }
//    else {
//        self.titleTextField.hidden = YES;
//        self.titleTextField.stringValue = @"";
//    }
    
    [_breadcrumbBar update];
    
//    if(FLStringIsNotEmpty(wizardPanel.breadcrumbTitle)) {
//        [_breadcrumbBar setBreadcrumbActive:YES forTitle:wizardPanel.breadcrumbTitle];
//    }
}

//#define kDuration 0.2f

- (void) showNextWizardPanelAnimated:(BOOL) animated 
                      completion:(void (^)(FLWizardPanel*)) completion {

    self.nextButton.enabled = NO;
    self.backButton.enabled = NO; // (_visiblePanels.count > 0);
    
    FLAssert_v(_nextPanelQueue.count != 0, @"order not set");
    
    FLWizardPanel* toShow = [_nextPanelQueue popFirstObject];
    FLAssertNotNil_(toShow);
       
    // must be before adding new panel to list
    FLWizardPanel* toHide = [_visiblePanels lastObject];
    [self willHideWizardPanel:toHide];
    
    [toShow view].frame = _wizardPanelEnclosureView.bounds;
    [self setViewToResize:[toShow view]];
    [self willShowWizardPanel:toShow];
    
    [_visiblePanels addObject:toShow];
           
    completion = FLCopyWithAutorelease(completion);
    
    dispatch_block_t finished = ^{
        [self setWizardPanelTitleFields:toShow];
        [self didHideWizardPanel:toHide];
        [self updateBackButtonEnabledState];
        [self didShowWizardPanel:toShow];
        
        if(completion) {
            completion(toShow);
        }

        [self.view.window display];
    };

    [_wizardPanelEnclosureView addSubview:[toShow view]];

    if(animated) {
        FLSlideInAndDropTransition* transition = 
            [FLSlideInAndDropTransition transitionWithViewToShow:[toShow view] 
                                                      viewToHide:[toHide view]];

        [transition startAnimating:^{
            finished();
        }];
    }
    else {
        finished();
    }
}

- (void) hideVisibleWizardPanelAnimated:(BOOL) animated 
                             completion:(FLWizardPanelBlock) completion{

    self.nextButton.enabled = NO;
    self.backButton.hidden = NO;
    self.backButton.enabled = NO;

    FLAssert_v(_visiblePanels.count >= 2, @"must be at least two panels to hide visible");

    FLWizardPanel* toHide = [_visiblePanels lastObject];
    FLWizardPanel* toShow = [_visiblePanels objectAtIndex:_visiblePanels.count - 2];
    [toShow view].frame = _wizardPanelEnclosureView.bounds;
            
    [self willHideWizardPanel:toHide];
    [self willShowWizardPanel:toShow];
    
    completion = FLCopyWithAutorelease(completion);
    [_wizardPanelEnclosureView addSubview:[toShow view]];
        
    dispatch_block_t finished = ^{
    // this executes after animation is finished.
    
        [_visiblePanels removeObject:toHide];
        [_nextPanelQueue pushObject:toHide];
    
        [self didHideWizardPanel:toHide];
        [self updateBackButtonEnabledState];
        [self setWizardPanelTitleFields:toShow];
        [self didShowWizardPanel:toShow];
         
        if(completion) {
            completion(toHide);
        }        
        [self.view.window display];
    };
      
    if(animated) {
        
        FLSlideOutAndComeForwardTransition* transition = 
            [FLSlideOutAndComeForwardTransition transitionWithViewToShow:[toShow view] 
                                                              viewToHide:[toHide view]];

        [transition startAnimating:^{
            finished();
        }];
    }
    else {
       finished();
    }
}


- (void) showModalShield {
    _modalShieldView.hidden = NO;
}

- (void) hideModalShield {
    _modalShieldView.hidden = YES;
}
                   


//- (void) flipToNextNotificationViewWithDirection:(FLFlipAnimationDirection) direction 
//                                        nextView:(UIView*) nextView
//                                      completion:(void (^)()) completion {
//
//    completion = FLCopyWithAutorelease(completion);
//
//    FLFlipTransition* animation = [FLFlipTransition transitionWithViewToShow:nextView 
//                                                       viewToHide:self.notificationView];
//                                              
//    [animation startAnimating:^(FLResult result) {
//        [self.notificationView removeFromSuperview];
//        self.notificationView = nextView;
//        if(completion) {
//            completion();
//        }
//    }];
//}
//
//- (void) setNotificationView:(UIView*) notificationView 
//                    animated:(BOOL) animated 
//                  completion:(void (^)()) completion {
//    
//    notificationView.frame = self.notificationViewEnclosure.bounds;
//    if(self.notificationView) {
//        if(animated) {
//            [self flipToNextNotificationViewWithDirection:FLFlipAnimationDirectionDown nextView:notificationView completion:completion];
//        }
//        else {
//            [self.notificationView removeFromSuperview];
//            self.notificationView = notificationView;
//            [self.notificationViewEnclosure addSubview:notificationView];
//            
//            if(completion) completion();
//        }
//    }
//    else {
//        self.notificationView = notificationView;
//        [self.notificationViewEnclosure addSubview:notificationView];
//        if(completion) completion();
//    }
//}
//
//- (void) hideNotificationViewAnimated:(BOOL) animated 
//                  completion:(void (^)()) completion {
//
//    [self.notificationView removeFromSuperview];
//    self.notificationView = nil;
//    if(completion) completion();
//
//}                  



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
