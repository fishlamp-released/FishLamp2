//
//  FLWizardViewController.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardViewController.h"

@interface FLWizardViewController ()
@property (readwrite, strong, nonatomic) NSMutableArray* pendingStack;

- (IBAction) respondToNextButton:(id) sender;
- (IBAction) respondToPreviousButton:(id) sender;
- (IBAction) respondToOtherButton:(id) sender;

@end

@implementation FLWizardViewController

@synthesize nextButton = _nextButton;
@synthesize previousButton = _previousButton;
@synthesize otherButton = _otherButton;
@synthesize delegate = _delegate;
@synthesize wizardPanels = _wizardPanels;
@synthesize titleTextField = _titleTextField;
@synthesize pendingStack = _pendingStack;
@synthesize titleEnclosureView = _titleEnclosureView;
@synthesize buttonEnclosureView = _buttonEnclosureView;
@synthesize wizardPanelBackgroundView = _wizardPanelBackgroundView;
@synthesize backgroundView = _backgroundView;
@synthesize wizardPanelEnclosureView = _wizardPanelEnclosureView;

#if FL_MRC
- (void) dealloc {
    [_wizardPanelBackgroundView release];
    [_backgroundView release];
    [_wizardPanelEnclosureView release];
    [_buttonEnclosureView release];
    [_titleEnclosureView release];
    [_pendingStack release];
    [_wizardPanels release];
    [_nextButton release];
    [_previousButton release];
    [_otherButton release];
    [_viewStack release];
    
    [super dealloc];
}
#endif

- (id) init {
    self = [self initWithNibName:@"FLWizardViewController" bundle:nil];
    if(self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewStack = [[NSMutableArray alloc] init];
        _wizardPanels = [[NSMutableArray alloc] init];
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
    view.frame = _wizardPanelEnclosureView.bounds;
    [self setViewToResize:view];
    [_wizardPanelEnclosureView addSubview:view positioned:NSWindowBelow relativeTo:nil];
}

- (void) startWizardInWindow:(NSWindow*) window {
    [window setContentView:self.view];
    [window setDefaultButtonCell:[self.nextButton cell]];

    self.pendingStack = FLAutoreleasedMutableCopy(self.wizardPanels); 
    
    FLPerformSelector1(_delegate, @selector(wizardViewControllerWillStart:), self);
    
    [self pushWizardPanel:[self.pendingStack popFirstObject] animated:NO completion:^{
        FLPerformSelector1(_delegate, @selector(wizardViewControllerDidStart:), self);
    }];
}

- (void)loadView {
    [super loadView];
    _previousButton.hidden = YES;
    _otherButton.hidden = YES;
    _nextButton.enabled = NO;
    FLPerformSelector1(_delegate, @selector(wizardViewControllerCanStart:), self);
}

- (IBAction) respondToNextButton:(id) sender {
    FLPerformSelector1(self.visibleWizardPanel, @selector(wizardPanelRespondToNextButton:), self);
}

- (IBAction) respondToPreviousButton:(id) sender {
    FLPerformSelector1(self.visibleWizardPanel, @selector(wizardPanelRespondToPreviousButton:), self);
}

- (IBAction) respondToOtherButton:(id) sender {
    FLPerformSelector1(self.visibleWizardPanel, @selector(wizardPanelRespondToOtherButton:), self);
}

- (FLWizardPanel*) nextWizardPanel {
    return _viewStack.count > 0 ? FLAutorelease(FLRetain([_viewStack objectAtIndex:_viewStack.count - 1])) : nil;
}

- (FLWizardPanel*) visibleWizardPanel {
    return _viewStack.count > 0 ? FLAutorelease(FLRetain([_viewStack objectAtIndex:_viewStack.count - 1])) : nil;
}

- (FLWizardPanel*) previousWizardPanel {
    return _viewStack.count > 1 ? FLAutorelease(FLRetain([_viewStack objectAtIndex:_viewStack.count - 2])) : nil;
}

- (void) addWizardPanel:(FLWizardPanel*) wizardPanel {

    [self setViewToResize:wizardPanel.view];

    [_wizardPanels addObject:wizardPanel];
}

- (void) removeWizardPanel:(FLWizardPanel*) wizardPanel {
    [_wizardPanels removeObject:wizardPanel];
}

- (void) popWizardPanelAnimated:(BOOL) animated 
                     completion:(void (^)()) completion{

    animated = NO;

    NSViewController* toHide = self.visibleWizardPanel;
    NSViewController* toShow = self.previousWizardPanel;
    
    if(animated) {
    
    }
    else {
    
        if(toHide) {
            [toHide.view removeFromSuperview];
            [_viewStack removeObject:toHide];
        }

        if(toShow) {
            toShow.view.frame = self.view.frame;
            toShow.view.hidden = NO;
        }

        if(toHide) {
        }

        if(completion) {
            completion();
        }
    }
    
     
    [self.view.window display];
}

- (void) pushWizardPanel:(FLWizardPanel*) viewController 
                animated:(BOOL) animated 
              completion:(void (^)()) completion {


    animated = NO;
    NSViewController* visible = self.visibleWizardPanel;
    
    [_viewStack addObject:viewController];
    
    FLPerformSelector1(viewController, @selector(wizardPanelWillAppear:), self);
    if(visible) {
        FLPerformSelector1(visible, @selector(wizardPanelWillDisappear:), self);
    }
    
    if(animated) {
    
//        [NSAnimationContext beginGrouping];
//        [[NSAnimationContext currentContext] setDuration:0.3f]; // However long you want the slide to take
//
//        [[firstView animator] setFrame:shrunkFirstViewRect];
//
//        [[secondView animator] setFrame:secondViewOnScreenFrame];
//
//        [NSAnimationContext endGrouping];

//        NSView* current = [self.window contentView];
//
//        NSArray *hideAnimations = [NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:
//            self,                           NSViewAnimationTargetKey,
//            NSViewAnimationFadeOutEffect,	NSViewAnimationEffectKey, nil]];
//        
//        NSViewAnimation *animation = FLAutorelease([[NSViewAnimation alloc] initWithViewAnimations:animations]);
//        [animation setAnimationBlockingMode:NSAnimationBlocking];
//        [animation setDuration:0.3];
//        [animation startAnimation];
//        
//        [window makeFirstResponder:self.userNameTextField];
//        [window display];
//

    }
    else {

        self.titleTextField.stringValue = viewController.title;

        [_breadcrumbBarView setBreadcrumb:[FLBreadcrumb breadcrumb:viewController.title] forKey:viewController.title];

        viewController.view.frame = _wizardPanelEnclosureView.bounds;
        
//        NSView* aboveView = visible.view;
//        if(!aboveView) {
//            aboveView = _wizardPanelBackgroundView;
//        }
//        
        [_wizardPanelEnclosureView addSubview:viewController.view positioned:NSWindowAbove relativeTo:nil];
        visible.view.hidden = YES;

        FLPerformSelector1(viewController, @selector(wizardPanelDidAppear:), self);
        if(visible) {
            FLPerformSelector1(visible, @selector(wizardPanelDidDisappear:), self);
        }
        
        if(completion) {
            completion();
        }
    }


    [self.view.window display];
}



@end
