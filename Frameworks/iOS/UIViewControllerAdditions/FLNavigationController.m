//
//	FLNavigationController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNavigationController.h"
#import "FLFloatingViewController.h"
#import "FLViewController.h"
#import "FLMobileTheme.h"
#import "FLToolbarButtonbarView.h"

static CGFloat s_prevAlpha;

@implementation UINavigationController (FLExtras)

- (UINavigationController*) rootNavigationController 
{
    return self;
}

- (void) _doneAnimating:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	
	self.navigationBar.hidden = FLStringsAreEqual(animationID, @"hide");
	
//	  FLCallbackObject* cb = (FLCallbackObject*) context;
//	  if(cb)
//	  {
//		  [cb invoke:self];
//		  FLRelease(cb);
//	  }
//	  
//	  [browser.navigationController setNavigationBarHidden:YES animated:YES]
}

- (void) setNavigationBarHiddenWithFadeAnimation:(BOOL) hidden
{
//	  if(!hidden)
//	  {
//		  self.navigationBar.alpha = 0.0;
//	  }
//
//	  self.navigationBar.hidden = NO;
//
//	  [UIView beginAnimations:hidden ? @"hide" : @"show" context:nil];
//	  [UIView setAnimationDuration:0.3];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	  [UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(_doneAnimating:finished:context:)];
//	  
//	  self.navigationBar.alpha = hidden ? 0.0 : 1.0;
//	  
//		[UIView commitAnimations];

	[self.navigationBar setHiddenWithFade:hidden duration:0.3 finishedBlock:nil];

}

- (void) doneAnimatingSlideInFromBottom:(NSString *)animationID 
	finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	UIViewController* viewController = FLAutorelease(bridge_(UIViewController*, context));
	[viewController.view removeFromSuperview];
	[self pushViewController:viewController animated:NO];

	[UIView beginAnimations:@"slide" context:bridge_(void*,FLRetain(viewController))];
    [UIView setAnimationDuration:0.15];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.navigationBar.alpha = s_prevAlpha;
	[UIView commitAnimations];
			
}

- (void)pushViewController:(UIViewController *)viewController 
			 withAnimation:(FLNavigationControllerAnimation) animation
{
	if([viewController respondsToSelector:@selector(setNavigationControllerCloseAnimation:)])
	{
		switch(animation)
		{
			case FLNavigationControllerAnimationSlideInFromBottom:
			case FLNavigationControllerAnimationNone:
			case FLNavigationControllerAnimationFade:
			case FLNavigationControllerAnimationDefault:
				[((id)viewController) setNavigationControllerCloseAnimation:animation];
				break;
				
			case FLNavigationControllerAnimationFlipFromLeft:
				[((id)viewController) setNavigationControllerCloseAnimation:FLNavigationControllerAnimationFlipFromRight];
				break;
			case FLNavigationControllerAnimationFlipFromRight:
				[((id)viewController) setNavigationControllerCloseAnimation:FLNavigationControllerAnimationFlipFromLeft];
				break;
			case FLNavigationControllerAnimationCurlUp:
				[((id)viewController) setNavigationControllerCloseAnimation:FLNavigationControllerAnimationCurlDown];
				break;
			case FLNavigationControllerAnimationCurlDown:
				[((id)viewController) setNavigationControllerCloseAnimation:FLNavigationControllerAnimationCurlUp];
				break;
		}				 
	}

	switch(animation)
	{
		case FLNavigationControllerAnimationNone:
			[self pushViewController:viewController animated:NO];
			break;
			
		case FLNavigationControllerAnimationDefault:
			[self pushViewController:viewController animated:YES];
			break;

		case FLNavigationControllerAnimationSlideInFromBottom:
		{
			UIView* parentView = self.topViewController.view;
			UIView* view = viewController.view;
			
			view.frame = FLRectSetTop(parentView.bounds, parentView.bounds.size.height);
			[parentView addSubview:view];
			
			[UIView beginAnimations:@"slide" context:bridge_(void*,FLRetain(viewController))];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneAnimatingSlideInFromBottom:finished:context:)];
			[UIView setAnimationDuration:0.25];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			view.frame = FLRectSetTop(view.frame, [UIDevice currentDevice].navigationBarHeight);
			s_prevAlpha = self.navigationBar.alpha;
			self.navigationBar.alpha = .2;// = YES;
			[UIView commitAnimations];
		}
		break;
			
		case FLNavigationControllerAnimationFade:
		{

			self.view.alpha = 0.0;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.5];
			self.view.alpha = 1.0;
			[UIView commitAnimations];
			[self pushViewController:viewController animated:NO];

//			  [UIView setAnimationPreparesFromCurrentState:YES];		  
//			  [UIView setAnimationTransition:animation forView:self.view cache:YES];
		}
		break;	  
			
		case FLNavigationControllerAnimationFlipFromLeft:
		case FLNavigationControllerAnimationFlipFromRight:
		case FLNavigationControllerAnimationCurlUp:
		case FLNavigationControllerAnimationCurlDown:
		{
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.75];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationTransition:(UIViewAnimationTransition) animation forView:self.view cache:YES];
			[self pushViewController:viewController animated:NO];
			[UIView commitAnimations];
		}
		break;
	}
}

- (void) doneAnimatingPopViewController:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	UIView* view = FLAutorelease(bridge_(UIView*, context));
	[view removeFromSuperview];
}

- (void) popToViewController:(UIViewController*) viewController withAnimation:(FLNavigationControllerAnimation) animation
{
	switch(animation)
	{
		case FLNavigationControllerAnimationFade:
		// TODO
		[self popToViewController:viewController animated:NO];
				
		break;
		
		case FLNavigationControllerAnimationSlideInFromBottom:
		{
			UIViewController* controller = [self topViewController];
			UIViewController* parent = [self parentControllerForController:controller];
			UIView* view = FLRetain(controller.view);
			[self popToViewController:viewController animated:NO];
			[parent.view addSubview:view];
			
			[UIView beginAnimations:@"slide" context:bridge_(void*,view)];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneAnimatingPopViewController:finished:context:)];
			view.frame = FLRectSetTop(view.frame, view.frame.size.height);
			[UIView commitAnimations];
		}
			break;
		
		case FLNavigationControllerAnimationNone:
			[self popToViewController:viewController animated:NO];
			break;
			
		case FLNavigationControllerAnimationDefault:
			[self popToViewController:viewController animated:YES];
			break;
			
		case FLNavigationControllerAnimationFlipFromLeft:
		case FLNavigationControllerAnimationFlipFromRight:
		case FLNavigationControllerAnimationCurlUp:
		case FLNavigationControllerAnimationCurlDown:
		{
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.5];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationTransition:(UIViewAnimationTransition) animation forView:self.view cache:YES];
			[self popToViewController:viewController animated:NO];
			[UIView commitAnimations];
		}
		break;
	}
}

- (void) popViewControllerWithAnimation:(FLNavigationControllerAnimation) animation	   
{
	switch(animation)
	{
		case FLNavigationControllerAnimationFade:
		[self popViewControllerAnimated:NO];
			
		break;
		
		case FLNavigationControllerAnimationSlideInFromBottom:
		{
			UIViewController* controller = [self topViewController];
			UIViewController* parent = [self parentControllerForController:controller];
			UIView* view = FLRetain(controller.view);
			[self popViewControllerAnimated:NO];
			[parent.view addSubview:view];
			
			[UIView beginAnimations:@"slide" context:bridge_(void*,view)];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneAnimatingPopViewController:finished:context:)];
			view.frame = FLRectSetTop(view.frame, view.frame.size.height);
			[UIView commitAnimations];
		}
			break;
		
		case FLNavigationControllerAnimationNone:
			[self popViewControllerAnimated:NO];
			break;
			
		case FLNavigationControllerAnimationDefault:
			[self popViewControllerAnimated:YES];
			break;
			
		case FLNavigationControllerAnimationFlipFromLeft:
		case FLNavigationControllerAnimationFlipFromRight:
		case FLNavigationControllerAnimationCurlUp:
		case FLNavigationControllerAnimationCurlDown:
		{
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.5];
			[UIView setAnimationBeginsFromCurrentState:YES];		
			[UIView setAnimationTransition:(UIViewAnimationTransition) animation forView:self.view cache:YES];
			[self popViewControllerAnimated:NO];
			[UIView commitAnimations];
		}
		break;
	}
}

- (UIViewController*) parentControllerForController:(UIViewController*) controller
{
	NSArray* viewControllers = self.viewControllers;
	NSInteger idx = [viewControllers indexOfObject:controller];
	if(idx != NSNotFound && idx >= 1)
	{
		return [viewControllers objectAtIndex:idx - 1];
	}
	
	return nil;
}

- (UIViewController*) rootViewController
{
	return [self.viewControllers objectAtIndex:0];
}

- (BOOL) containsViewController:(UIViewController*) controller
{
	NSArray* viewControllers = self.viewControllers;
	for(UIViewController* aController in viewControllers)
	{
		if(aController == controller)
		{
			return YES;
		}
	}
	
	return NO;
}

- (void) visitViewControllers:(FLNavigationControllerVisitor) visitor
{
    if(visitor)
    {
        BOOL stop = NO;
        
        for(UIViewController* viewController in self.viewControllers.reverseObjectEnumerator)
        {
            visitor(viewController, &stop);
            
            if(stop)
            {
                break;
            }
        }
    }
}

- (void) visitViewControllersStartingWithViewController:(UIViewController*) aViewController 
                                                visitor:(FLNavigationControllerVisitor) visitor
{
    if(visitor)
    {
        BOOL foundIt = NO;
        BOOL stop = NO;
        
        for(UIViewController* viewController in self.viewControllers)
        {
            if(viewController == aViewController) 
            {
                foundIt = YES;
            }
        
            if(foundIt)
            {
                visitor(viewController, &stop);
            }
            
            if(stop)
            {
                break;
            }
        }
    }
}    

- (void) visitViewControllersForClass:(Class) aClass 
                              visitor:(FLNavigationControllerVisitor) visitor
{
    if(visitor)
    {
        BOOL stop = NO;
        
        for(UIViewController* viewController in self.viewControllers.reverseObjectEnumerator)
        {
            if([viewController isKindOfClass:aClass])
            {
                visitor(viewController, &stop);
                
                if(stop)
                {
                    break;
                }
            }
        }
    }
}                              

@end

@implementation UIViewController (FLNavigationController)

- (void) willBePushedOnNavigationController:(UINavigationController *)controller
{
}

- (void) wasPushedOnNavigationController:(UINavigationController*) controller
{
}

- (void) wasPoppedFromNavigationController:(UINavigationController*) controller
{
}

- (FLDeprecatedButtonbarView*) buttonbar
{   
    id view = self.topBarView;
	return [view isKindOfClass:[FLDeprecatedButtonbarView class]] ? (FLDeprecatedButtonbarView*) view : nil;
}



- (UINavigationController*) createContainingNavigationController
{
	FLNavigationController* controller = FLAutorelease([[FLNavigationController alloc] initWithRootViewController:self]);
    self.wantsFullScreenLayout = self.wantsFullScreenLayout;
    [controller addChildViewController:self];
    [controller.view addSubview:self.view]; 

    return controller;
}

@end

@implementation FLNavigationController

- (void) applyTheme:(FLTheme*) theme {
	self.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationBar.translucent = YES;
	self.wantsFullScreenLayout = YES;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self) {
        self.wantsApplyTheme = YES;
    }
    
    return self;
}

+ (FLNavigationController*) navigationController:(UIViewController*) rootViewController
{
	return FLAutorelease([[FLNavigationController alloc] initWithRootViewController:rootViewController]);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
}

- (void) _prepareForButtonBar:(UINavigationItem*) item
{
	[item setHidesBackButton:YES animated:NO];

	self.title = nil;
	item.titleView = FLAutorelease([[UIView alloc] initWithFrame:CGRectZero]);
	[item setLeftBarButtonItem:nil animated:NO];
	[item setRightBarButtonItem:nil animated:NO];
}

- (void) _prepareToShowButtonBar:(FLDeprecatedButtonbarView*) buttonbar
{
	buttonbar.frame = self.navigationBar.bounds;
	
	if(buttonbar.superview != self.navigationBar)
	{
		[buttonbar removeFromSuperview];
		[self.navigationBar addSubview:buttonbar];
	}
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	NSArray* views = self.navigationBar.subviews;
	for(UIView* subview in views)
	{
		if([subview isKindOfClass:[FLDeprecatedButtonbarView class]] && !subview.hidden)
		{
			if(animated)
			{
				[subview setHiddenWithFade:YES duration:0.3 finishedBlock:nil];
			}
			else
			{
				subview.hidden = YES;
			}
		}
	}
	
    if(viewController.view) // force loading of view.
    {
        FLDeprecatedButtonbarView* buttonbar = viewController.buttonbar;
        if(buttonbar)
        {	
            [viewController.navigationItem setHidesBackButton:YES animated:NO];
        
            [self _prepareForButtonBar:viewController.navigationItem];
            buttonbar.hidden = NO;

            [self _prepareToShowButtonBar:buttonbar];	
            if(animated)
            {
                [buttonbar animateOntoScreen:FLAnimatedViewTypeSlideFromRight duration:0.3 finishedBlock:nil];
            }
            
            UIViewController* parent = self.visibleViewController;
            if(!parent)
            {
                buttonbar.backButton.hidden = YES;
            }
            else if(FLStringIsEmpty(parent.backButtonTitle))
            {
                buttonbar.backButton.title = NSLocalizedString(@"Back", nil);
            }
            else
            {
                buttonbar.backButton.title = parent.backButtonTitle;
            }
        }
    }

    viewController.dismissHandler = ^(UIViewController* dismissMe, BOOL dismissAnimated) {

        FLNavigationController* navController = (FLNavigationController*) dismissMe.navigationController;
        if(dismissAnimated)
        {
            [navController popViewControllerWithAnimation:dismissMe.navigationControllerCloseAnimation];
        }
        else
        {
            FLAssertWithComment(navController.visibleViewController == dismissMe, @"popping wrong view controller");
            [navController popViewControllerAnimated:NO];
        }
    };


	[viewController willBePushedOnNavigationController:self];
	[super pushViewController:viewController animated:animated];
	[viewController wasPushedOnNavigationController:self];
}

- (void) _viewControllerWasPopped:(UIViewController*) viewController animated:(BOOL) animated
{
	FLDeprecatedButtonbarView* buttonbar = viewController.buttonbar;
	if(buttonbar)
	{
		if(animated)
		{
			[buttonbar removeFromSuperviewWithAnimationType:FLAnimatedViewTypeSlideFromRight duration:0.3 finishedBlock:nil];
		}
		else
		{
			[buttonbar removeFromSuperview];
		}
	}
	
	[viewController wasPoppedFromNavigationController:self];
	
	FLDeprecatedButtonbarView* topButtonbar = self.topViewController.buttonbar;
	if(topButtonbar)
	{	
		[self _prepareToShowButtonBar:topButtonbar];   

		if(animated)
		{
			[topButtonbar setHiddenWithFade:NO duration:0.3 finishedBlock:nil];
		}
		else
		{
			topButtonbar.hidden = NO;
		}
	}
    
    viewController.dismissHandler = nil;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
	UIViewController* popped = [super popViewControllerAnimated:animated];
	[self _viewControllerWasPopped:popped animated:animated];
	return popped;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	NSArray* controllers = [super popToViewController:viewController animated:animated];
	for(UIViewController* controller in controllers)
	{
		[self _viewControllerWasPopped:controller animated:animated && controller == [controllers lastObject]];
	}
	return controllers;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated // Pops until there's only a single view controller left on the stack. Returns the popped 
{
	NSArray* controllers = [super popToRootViewControllerAnimated:animated];
	for(UIViewController* controller in controllers)
	{
		[self _viewControllerWasPopped:controller animated:animated && controller == [controllers lastObject]];
	}
	return controllers;
}

- (UIViewController*) superViewController
{
	return _superViewController;
}

- (void) setSuperViewController:(UIViewController*) viewController
{
	_superViewController = viewController;
}


@end

