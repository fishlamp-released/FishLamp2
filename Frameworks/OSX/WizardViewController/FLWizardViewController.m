//
//  FLWizardViewController.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardViewController.h"

@interface FLWizardViewController ()

@end

@implementation FLWizardViewController

@synthesize nextButton = _nextButton;
@synthesize previousButton = _previousButton;
@synthesize cancelButton = _cancelButton;
@synthesize delegate = _delegate;


#if FL_MRC
- (void) dealloc {
    [_nextButton release];
    [_previousButton release];
    [_cancelButton release];
    [_viewStack release];
    [super dealloc];
}
#endif

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewStack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSViewController*) visibleViewController {
    return _viewStack.count > 0 ? autorelease_(retain_([_viewStack objectAtIndex:_viewStack.count - 1])) : nil;
}

- (NSViewController*) tertiaryViewController {
    return _viewStack.count > 1 ? autorelease_(retain_([_viewStack objectAtIndex:_viewStack.count - 2])) : nil;
}

- (NSViewController*) popViewControllerAnimated:(BOOL) animated {

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
    
    return toHide;

}

- (void) pushViewController:(NSViewController*) viewController animated:(BOOL) animated {

    animated = NO;
    NSViewController* visible = self.visibleViewController;
    
    [_viewStack addObject:viewController];
    
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

        viewController.view.frame = self.view.frame;
        [self.view addSubview:viewController.view positioned:NSWindowAbove relativeTo:visible.view];
        visible.view.hidden = YES;
        
    }


    [self.view.window display];
}



@end
