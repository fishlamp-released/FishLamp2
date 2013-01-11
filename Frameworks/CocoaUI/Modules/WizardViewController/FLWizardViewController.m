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
@property (readonly, strong, nonatomic) FLWizardPanel* nextWizardPanel;
@property (readonly, strong, nonatomic) FLWizardPanel* previousWizardPanel;
@property (readonly, strong, nonatomic) NSArray* visibleWizardPanels;
@property (readwrite, strong, nonatomic) UIView* notificationView;

- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
- (IBAction) respondToOtherButton:(id) sender;
- (IBAction) respondToLogoutButton:(id) sender;

@end

@implementation FLWizardViewController

@synthesize nextButton = _nextButton;
@synthesize backButton = _backButton;
@synthesize otherButton = _otherButton;
@synthesize delegate = _delegate;
@synthesize visibleWizardPanels = _wizardPanels;
@synthesize titleTextField = _titleTextField;
@synthesize buttonEnclosureView = _buttonEnclosureView;
@synthesize wizardPanelBackgroundView = _wizardPanelBackgroundView;
@synthesize backgroundView = _backgroundView;
@synthesize wizardPanelEnclosureView = _wizardPanelEnclosureView;
@synthesize notificationView = _notificationView;
@synthesize notificationViewEnclosure = _notificationViewEnclosure;
@synthesize statusBar = _statusViewController;

#if FL_MRC
- (void) dealloc {
    [_wizardPanelBackgroundView release];
    [_backgroundView release];
    [_wizardPanelEnclosureView release];
    [_buttonEnclosureView release];
    [_breadcrumbEnclosureView release];
    [_wizardPanels release];
    [_nextButton release];
    [_backButton release];
    [_otherButton release];
    [_notificationView release];
    [_statusViewController release];
    
    [super dealloc];
}
#endif

- (id) init {
    return [self initWithDefaultNibName];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _wizardPanels = [[NSMutableArray alloc] init];
        _statusViewController = [[FLStatusBarViewController alloc] init];
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

//- (void) presentNextWizardPanelAnimated:(BOOL) animated
//                       completion:(FLWizardPanelBlock) completion {
//
//    FLWizardPanel* nextPanel = [_wizardPanel popFirstObject];
//                        
//    if(nextPanel) {
//        [self pushWizardPanel:nextPanel 
//                     animated:NO 
//                   completion:completion];
//    }
//}                       

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
    _statusViewController.view.frame = _notificationViewEnclosure.bounds;
    [_notificationViewEnclosure addSubview:_statusViewController.view];
    [self didStartWizardInWindow:window];
}

- (void)loadView {
    [super loadView];
    _backButton.hidden = YES;
    _otherButton.hidden = YES;
    _nextButton.enabled = NO;
    FLPerformSelector1(self.delegate, @selector(wizardViewControllerCanStart:), self);
    _wizardPanelEnclosureView.wantsLayer = YES;
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
    
    [self performBlockOnMainThread:^{
        [self.visibleWizardPanel respondToNextButton:sender];
    }];
}

- (IBAction) respondToBackButton:(id) sender {
    [self.view.window makeFirstResponder:self];
    [self.view.window display];

    [self performBlockOnMainThread:^{
        [self.visibleWizardPanel respondToBackButton:sender];
    }];
}

- (IBAction) respondToLogoutButton:(id) sender {
    
}

- (IBAction) respondToOtherButton:(id) sender {
    [self.visibleWizardPanel respondToOtherButton:sender];
}

- (FLWizardPanel*) nextWizardPanel {
    return _wizardPanels.count > 0 ? FLAutorelease(FLRetain([_wizardPanels objectAtIndex:_wizardPanels.count - 1])) : nil;
}

- (FLWizardPanel*) visibleWizardPanel {
    return _wizardPanels.count > 0 ? FLAutorelease(FLRetain([_wizardPanels objectAtIndex:_wizardPanels.count - 1])) : nil;
}

- (FLWizardPanel*) previousWizardPanel {
    return _wizardPanels.count > 1 ? FLAutorelease(FLRetain([_wizardPanels objectAtIndex:_wizardPanels.count - 2])) : nil;
}

- (void) updateBackButtonEnabledState {

    if(_wizardPanels.count == 1) {
        self.backButton.enabled = NO; // (_wizardPanels.count > 1);
    }

}

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel {
    [_wizardPanels removeObject:wizardPanel];
    [wizardPanel didMoveToWizard:nil];
    [self updateBackButtonEnabledState];
}

- (void) wizardPanelWillAppear:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelWillAppear];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelWillAppear:), self, wizardPanel);
    }
}

- (void) wizardPanelDidAppear:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelDidAppear];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelDidAppear:), self, wizardPanel);
    }
}

- (void) wizardPanelWillDissappear:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelWillDisappear];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelWillDisappear:), self, wizardPanel);
    }
}

- (void) wizardPanelDidDissappear:(FLWizardPanel*) wizardPanel {
    if(wizardPanel) {
        [wizardPanel wizardPanelDidDisappear];
        FLPerformSelector2(self.delegate, @selector(wizardViewController:wizardPanelDidAppear:), self, wizardPanel);
    }
}

- (void) setWizardPanelTitleFields:(FLWizardPanel*) wizardPanel {

    NSString* prompt = wizardPanel.wizardPanelPrompt;

    if(FLStringIsNotEmpty(prompt)) {
        self.titleTextField.hidden = NO;
        self.titleTextField.stringValue = prompt;
    }
    else {
        self.titleTextField.hidden = YES;
        self.titleTextField.stringValue = @"";
    }
    
    if(FLStringIsNotEmpty(wizardPanel.title)) {
        [_breadcrumbBarView setAttributedString:[FLAttributedString attributedString:wizardPanel.title] forKey:wizardPanel.title];
    }
}


#define kDuration 0.2f

- (void) pushWizardPanel:(FLWizardPanel*) toShow 
                animated:(BOOL) animated 
              completion:(FLWizardPanelBlock) completion {

    FLAssertNotNil_(toShow);
    
    FLWizardPanel* toHide = self.visibleWizardPanel;
    
    self.nextButton.enabled = NO;
    self.backButton.hidden = NO;
    self.backButton.enabled = NO; // (_wizardPanels.count > 0);
    self.otherButton.hidden = YES;
    [toShow didMoveToWizard:self];
    
    toShow.view.frame = _wizardPanelEnclosureView.bounds;
    [self setViewToResize:toShow.view];
    
    [self wizardPanelWillAppear:toShow];
    
    [_wizardPanels addObject:toShow];

    [self wizardPanelWillDissappear:toHide];
    
    completion = FLCopyWithAutorelease(completion);
    
    dispatch_block_t finished = ^{
        [self setWizardPanelTitleFields:toShow];
        [self wizardPanelDidDissappear:toHide];
        [self updateBackButtonEnabledState];
        [self wizardPanelDidAppear:toShow];
        
        if(completion) {
            completion(toShow);
        }
        

        [self.view.window display];
    };

    [_wizardPanelEnclosureView addSubview:toShow.view];

    if(animated) {
        FLSlideInAndDropTransition* transition = [FLSlideInAndDropTransition transitionWithViewToShow:toShow.view viewToHide:toHide.view];
        [transition startAnimating:^{
            finished();
        }];
    }
    else {
        finished();
    }
}

- (void) popWizardPanelAnimated:(BOOL) animated 
                     completion:(FLWizardPanelBlock) completion{

    FLWizardPanel* toHide = self.visibleWizardPanel;
    FLWizardPanel* toShow = self.previousWizardPanel;

    toShow.view.frame = _wizardPanelEnclosureView.bounds;
            
    self.nextButton.enabled = NO;
    self.backButton.hidden = NO;
    self.backButton.enabled = NO;
    self.otherButton.hidden = YES;
    
    [self wizardPanelWillAppear:toShow];
    [self wizardPanelWillDissappear:toHide];
 
    [self setWizardPanelTitleFields:toShow];
    
    completion = FLCopyWithAutorelease(completion);
    [_wizardPanelEnclosureView addSubview:toShow.view];
        
    dispatch_block_t finished = ^{
        
        [_wizardPanels removeObject:toHide];
        
        [self wizardPanelDidDissappear:toHide];
        [self updateBackButtonEnabledState];
        [self wizardPanelDidAppear:toShow];
         
        if(completion) {
            completion(toHide);
        }        
        [self.view.window display];
    };
      
    if(animated) {
        
        FLSlideOutAndComeForwardTransition* transition = [FLSlideOutAndComeForwardTransition transitionWithViewToShow:toShow.view viewToHide:toHide.view];
        [transition startAnimating:^{
            finished();
        }];
    }
    else {
       finished();
    }
}

- (void) flipToNextNotificationViewWithDirection:(FLFlipAnimationDirection) direction 
                                        nextView:(UIView*) nextView
                                      completion:(void (^)()) completion {

    completion = FLCopyWithAutorelease(completion);

    FLFlipTransition* animation = [FLFlipTransition transitionWithViewToShow:nextView 
                                                       viewToHide:self.notificationView];
                                              
    [animation startAnimating:^(FLResult result) {
        [self.notificationView removeFromSuperview];
        self.notificationView = nextView;
        if(completion) {
            completion();
        }
    }];
}

- (void) setNotificationView:(UIView*) notificationView 
                    animated:(BOOL) animated 
                  completion:(void (^)()) completion {
    
    notificationView.frame = self.notificationViewEnclosure.bounds;
    if(self.notificationView) {
        if(animated) {
            [self flipToNextNotificationViewWithDirection:FLFlipAnimationDirectionDown nextView:notificationView completion:completion];
        }
        else {
            [self.notificationView removeFromSuperview];
            self.notificationView = notificationView;
            [self.notificationViewEnclosure addSubview:notificationView];
            
            if(completion) completion();
        }
    }
    else {
        self.notificationView = notificationView;
        [self.notificationViewEnclosure addSubview:notificationView];
        if(completion) completion();
    }
}

- (void) hideNotificationViewAnimated:(BOOL) animated 
                  completion:(void (^)()) completion {

    [self.notificationView removeFromSuperview];
    self.notificationView = nil;
    if(completion) completion();

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
