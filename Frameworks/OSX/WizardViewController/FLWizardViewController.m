//
//  FLWizardViewController.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardViewController.h"

@interface FLWizardViewController ()
@property (readwrite, strong, nonatomic) NSArray* panelClasses;
- (void) popViewControllerAnimated:(BOOL) animated;
- (void) pushViewController:(FLWizardPanelController*) viewController animated:(BOOL) animated;
@property (readonly, strong, nonatomic) FLWizardPanelController* visibleViewController;
@end

@implementation FLWizardViewController

@synthesize nextButton = _nextButton;
@synthesize previousButton = _previousButton;
@synthesize cancelButton = _cancelButton;
@synthesize wizardViewControllerDelegate = _delegate;
@synthesize panelClasses = _panelClasses;
@synthesize titleTextField = _titleTextField;

#if FL_MRC
- (void) dealloc {
    [_panelClasses release];
    [_nextButton release];
    [_previousButton release];
    [_cancelButton release];
    [_viewStack release];
    [super dealloc];
}
#endif

- (id) init {
    self = [super initWithNibName:@"FLWizardViewController" bundle:nil];
    if(self) {
        
    }
    return self;
}

+ (id) wizardViewController {
    return autorelease_([[[self class] alloc] init]);
}

- (void)loadView {
    [super loadView];
    _previousButton.hidden = YES;
    _cancelButton.hidden = YES;
    _nextButton.enabled = NO;
}

- (FLWizardPanelController*) createPanelForIndex:(int) idx {
    Class panelClass = [_panelClasses objectAtIndex:idx];
    return autorelease_([[panelClass alloc] init]); 
}

- (void) startWizardWithPanelClasses:(NSArray*) panelClasses {
    self.panelClasses = panelClasses;
    
    _currentPanel = 0;
    [self pushViewController:[self createPanelForIndex:_currentPanel] animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewStack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (IBAction) nextPanel:(id) sender {

}

- (IBAction) prevPanel:(id) sender {

}

- (IBAction) cancel:(id) sender {
    FLPerformSelector1(self.visibleViewController, @selector(wizardPanelDidDisappear:), self);
}

- (FLWizardPanelController*) visibleViewController {
    return _viewStack.count > 0 ? autorelease_(retain_([_viewStack objectAtIndex:_viewStack.count - 1])) : nil;
}

- (FLWizardPanelController*) tertiaryViewController {
    return _viewStack.count > 1 ? autorelease_(retain_([_viewStack objectAtIndex:_viewStack.count - 2])) : nil;
}

- (void) popViewControllerAnimated:(BOOL) animated {

    animated = NO;

    NSViewController* toHide = self.visibleViewController;
    NSViewController* toShow = self.tertiaryViewController;
    
    if(animated) {
    
    }
    else {
    
        if(toHide) {
            [toHide.view removeFromSuperview];
        }

        if(toShow) {
            toShow.view.frame = self.view.frame;
            toShow.view.hidden = NO;
        }

    }
    
    if(toHide) {
        [_viewStack removeObject:toHide];
    }
     
    [self.view.window display];
}

- (void) pushViewController:(FLWizardPanelController*) viewController animated:(BOOL) animated {


    animated = NO;
    NSViewController* visible = self.visibleViewController;
    
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
//        NSViewAnimation *animation = autorelease_([[NSViewAnimation alloc] initWithViewAnimations:animations]);
//        [animation setAnimationBlockingMode:NSAnimationBlocking];
//        [animation setDuration:0.3];
//        [animation startAnimation];
//        
//        [window makeFirstResponder:self.userNameTextField];
//        [window display];
//

    }
    else {

        self.titleTextField.stringValue = [[viewController class] localizedWizardPanelTitle];

        viewController.view.frame = self.view.frame;
        [self.view addSubview:viewController.view positioned:NSWindowAbove relativeTo:visible.view];
        visible.view.hidden = YES;

        FLPerformSelector1(viewController, @selector(wizardPanelDidAppear:), self);
        if(visible) {
            FLPerformSelector1(visible, @selector(wizardPanelDidDisappear:), self);
        }
    }


    [self.view.window display];
}



@end
