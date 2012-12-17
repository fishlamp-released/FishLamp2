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

@interface FLWizardViewController ()
@property (readonly, strong, nonatomic) FLWizardPanel* nextWizardPanel;
@property (readonly, strong, nonatomic) FLWizardPanel* previousWizardPanel;

- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToBackButton:(id) sender;
- (IBAction) respondToOtherButton:(id) sender;
@end

@implementation FLWizardViewController

@synthesize nextButton = _nextButton;
@synthesize previousButton = _previousButton;
@synthesize otherButton = _otherButton;
@synthesize delegate = _delegate;
@synthesize visibleWizardPanels = _visibleWizardPanels;
@synthesize titleTextField = _titleTextField;
@synthesize titleEnclosureView = _titleEnclosureView;
@synthesize buttonEnclosureView = _buttonEnclosureView;
@synthesize wizardPanelBackgroundView = _wizardPanelBackgroundView;
@synthesize backgroundView = _backgroundView;
@synthesize wizardPanelEnclosureView = _wizardPanelEnclosureView;
@synthesize queuedWizardPanels = _queuedWizardPanels;

#if FL_MRC
- (void) dealloc {
    [_wizardPanelBackgroundView release];
    [_backgroundView release];
    [_wizardPanelEnclosureView release];
    [_buttonEnclosureView release];
    [_titleEnclosureView release];
    [_queuedWizardPanels release];
    [_nextButton release];
    [_previousButton release];
    [_otherButton release];
    [_visibleWizardPanels release];
    
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
        _visibleWizardPanels = [[NSMutableArray alloc] init];
        _queuedWizardPanels = [[NSMutableArray alloc] init];
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

- (void) presentNextWizardPanelAnimated:(BOOL) animated
                       completion:(void (^)(FLWizardPanel* newPanel)) completion {
                       
    [self pushWizardPanel:[_queuedWizardPanels popFirstObject] animated:NO 
               completion:completion];
}                       

- (void) startWizardInWindow:(NSWindow*) window {

    [self.view setWantsLayer:YES];
    
    [window setContentView:self.view];
    [window setDefaultButtonCell:[self.nextButton cell]];

    FLPerformSelector2(self.delegate, @selector(wizardViewController:willStartWithWizardPanel:), self, [_queuedWizardPanels firstObject]);
    
    [self presentNextWizardPanelAnimated:NO completion:^(FLWizardPanel* panel){
        FLPerformSelector2(self.delegate, @selector(wizardViewController:didStartWithWizardPanel:), self, panel);
    }];
}

- (void)loadView {
    [super loadView];
    _previousButton.hidden = YES;
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
        [self.visibleWizardPanel respondToNextButton];
    }];
}

- (IBAction) respondToBackButton:(id) sender {
    [self.view.window makeFirstResponder:self];
    [self.view.window display];

    [self performBlockOnMainThread:^{
        [self.visibleWizardPanel respondToBackButton];
    }];
}

- (IBAction) respondToOtherButton:(id) sender {
    [self.visibleWizardPanel respondToOtherButton];
}

- (FLWizardPanel*) nextWizardPanel {
    return _visibleWizardPanels.count > 0 ? FLAutorelease(FLRetain([_visibleWizardPanels objectAtIndex:_visibleWizardPanels.count - 1])) : nil;
}

- (FLWizardPanel*) visibleWizardPanel {
    return _visibleWizardPanels.count > 0 ? FLAutorelease(FLRetain([_visibleWizardPanels objectAtIndex:_visibleWizardPanels.count - 1])) : nil;
}

- (FLWizardPanel*) previousWizardPanel {
    return _visibleWizardPanels.count > 1 ? FLAutorelease(FLRetain([_visibleWizardPanels objectAtIndex:_visibleWizardPanels.count - 2])) : nil;
}

- (void) updateBackButtonEnabledState {
    self.previousButton.enabled = (_visibleWizardPanels.count > 1);
}

- (void) addWizardPanel:(FLWizardPanel*) wizardPanel {
    
    [self setViewToResize:wizardPanel.view];
    [wizardPanel didMoveToWizard:self];
    [_queuedWizardPanels addObject:wizardPanel];
}

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel {
    [_queuedWizardPanels removeObject:wizardPanel];
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
        [_breadcrumbBarView setBreadcrumb:[FLBreadcrumb breadcrumb:wizardPanel.title] forKey:wizardPanel.title];
    }
}


#define kDuration 0.2f

- (void) pushWizardPanel:(FLWizardPanel*) toShow 
                animated:(BOOL) animated 
              completion:(void (^)(FLWizardPanel* panel)) completion {

    FLWizardPanel* toHide = self.visibleWizardPanel;
    
    self.nextButton.enabled = NO;
    self.previousButton.hidden = NO;
    self.previousButton.enabled = (_visibleWizardPanels.count > 0);
    self.otherButton.hidden = YES;
    toShow.view.frame = _wizardPanelEnclosureView.bounds;
    
    [self wizardPanelWillAppear:toShow];
    
    [_visibleWizardPanels addObject:toShow];
    
    [self wizardPanelWillDissappear:toHide];
    
    completion = FLAutoreleasedCopy(completion);
    
    dispatch_block_t finished = ^{
        [self setWizardPanelTitleFields:toShow];
        [self wizardPanelDidDissappear:toHide];
        [self updateBackButtonEnabledState];
        [self wizardPanelDidAppear:toShow];
        
        [toHide.view removeFromSuperview];
        toHide.view.alphaValue = 1.0;
        
        if(completion) {
            completion(toShow);
        }

        [self.view.window display];
    };

    [_wizardPanelEnclosureView addSubview:toShow.view];

    if(animated) {
        
        FLAnimation* animation = [FLAnimation animation];
        [animation addAnimation:[FLFadeOutAnimation animationWithTarget:toHide]];
        [animation addAnimation:[FLDropBackAnimation animationWithTarget:toHide]];
        [animation addAnimation:[FLSlideInFromRightAnimation animationWithTarget:toShow]];
        [animation addAnimation:[FLFadeInAnimation animationWithTarget:toShow]];
        
        [animation startAnimating:finished];
        
        
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
    }
    else {
        finished();
    }
}

- (void) popWizardPanelAnimated:(BOOL) animated 
                     completion:(void (^)(FLWizardPanel* panel)) completion{

    FLWizardPanel* toHide = self.visibleWizardPanel;
    FLWizardPanel* toShow = self.previousWizardPanel;

    toShow.view.frame = _wizardPanelEnclosureView.bounds;
            
    self.nextButton.enabled = NO;
    self.previousButton.hidden = NO;
    self.previousButton.enabled = NO;
    self.otherButton.hidden = YES;
    
    [self wizardPanelWillAppear:toShow];
    [self wizardPanelWillDissappear:toHide];
 
    [self setWizardPanelTitleFields:toShow];
    
    completion = FLAutoreleasedCopy(completion);
 
    dispatch_block_t finished = ^{
        
        [_visibleWizardPanels removeObject:toHide];
        [_queuedWizardPanels pushObject:toHide];
        
        [self wizardPanelDidDissappear:toHide];
        [self updateBackButtonEnabledState];
        [self wizardPanelDidAppear:toShow];
        [toHide.view removeFromSuperview];
        toHide.view.alphaValue = 1.0;
        
        if(completion) {
            completion(toHide);
        }        
        [self.view.window display];
    };
          
    if(animated) {
        
        FLAnimation* animation = [FLAnimation animation];
        
        [animation addAnimation:[FLFadeInAnimation animationWithTarget:toShow]];
        [animation addAnimation:[FLComeForwardAnimation animationWithTarget:toShow]];

        [animation addAnimation:[FLSlideOutToRightAnimation animationWithTarget:toHide]];
        [animation addAnimation:[FLFadeOutAnimation animationWithTarget:toHide]];

        [animation startAnimating:finished];

        
//        toShow.view.alphaValue = 0.0f;
//        [_wizardPanelEnclosureView addSubview:toShow.view positioned:NSWindowAbove relativeTo:nil];
//    
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
    }
    else {
        [_wizardPanelEnclosureView addSubview:toShow.view positioned:NSWindowAbove relativeTo:nil];
        finished();
    }
}


@end
