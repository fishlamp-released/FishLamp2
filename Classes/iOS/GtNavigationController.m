//
//	GtNavigationController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNavigationController.h"
#import "GtHoverViewController.h"
#import "GtViewController.h"

static CGFloat s_prevAlpha;

@implementation UINavigationController (GtExtras)

- (void) _doneAnimating:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	
	self.navigationBar.hidden = GtStringsAreEqual(animationID, @"hide");
	
//	  GtCallbackObject* cb = (GtCallbackObject*) context;
//	  if(cb)
//	  {
//		  [cb invoke:self];
//		  GtRelease(cb);
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

- (void) willShowInHoverViewController:(GtHoverViewController*) controller
{
    [self.visibleViewController willShowInHoverViewController:controller];
}

- (void) didShowInHoverViewController:(GtHoverViewController*) controller
{
    [self.visibleViewController didShowInHoverViewController:controller];
}

- (void) doneAnimatingSlideInFromBottom:(NSString *)animationID 
	finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	UIViewController* viewController = (UIViewController*) context;			
	[viewController.view removeFromSuperview];
	[self pushViewController:viewController animated:NO];
	GtRelease(viewController);

	[UIView beginAnimations:@"slide" context:GtRetain(viewController)];
	[UIView setAnimationDuration:0.15];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.navigationBar.alpha = s_prevAlpha;
	[UIView commitAnimations];
			
}

- (void)pushViewController:(UIViewController *)viewController 
			 withAnimation:(GtNavigationControllerAnimation) animation
{
	if([viewController respondsToSelector:@selector(setNavigationControllerCloseAnimation:)])
	{
		switch(animation)
		{
			case GtNavigationControllerAnimationSlideInFromBottom:
			case GtNavigationControllerAnimationNone:
			case GtNavigationControllerAnimationFade:
			case GtNavigationControllerAnimationDefault:
				[((id)viewController) setNavigationControllerCloseAnimation:animation];
				break;
				
			case GtNavigationControllerAnimationFlipFromLeft:
				[((id)viewController) setNavigationControllerCloseAnimation:GtNavigationControllerAnimationFlipFromRight];
				break;
			case GtNavigationControllerAnimationFlipFromRight:
				[((id)viewController) setNavigationControllerCloseAnimation:GtNavigationControllerAnimationFlipFromLeft];
				break;
			case GtNavigationControllerAnimationCurlUp:
				[((id)viewController) setNavigationControllerCloseAnimation:GtNavigationControllerAnimationCurlDown];
				break;
			case GtNavigationControllerAnimationCurlDown:
				[((id)viewController) setNavigationControllerCloseAnimation:GtNavigationControllerAnimationCurlUp];
				break;
		}				 
	}

	switch(animation)
	{
		case GtNavigationControllerAnimationNone:
			[self pushViewController:viewController animated:NO];
			break;
			
		case GtNavigationControllerAnimationDefault:
			[self pushViewController:viewController animated:YES];
			break;

		case GtNavigationControllerAnimationSlideInFromBottom:
		{
			UIView* parentView = self.topViewController.view;
			UIView* view = viewController.view;
			
			view.frame = GtRectSetTop(parentView.bounds, parentView.bounds.size.height);
			[parentView addSubview:view];
			
			[UIView beginAnimations:@"slide" context:GtRetain(viewController)];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneAnimatingSlideInFromBottom:finished:context:)];
			[UIView setAnimationDuration:0.25];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			view.frame = GtRectSetTop(view.frame, [UIDevice currentDevice].navigationBarHeight);
			s_prevAlpha = self.navigationBar.alpha;
			self.navigationBar.alpha = .2;// = YES;
			[UIView commitAnimations];
		}
		break;
			
		case GtNavigationControllerAnimationFade:
		{

			self.view.alpha = 0.0;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.5];
			self.view.alpha = 1.0;
			[UIView commitAnimations];
			[self pushViewController:viewController animated:NO];

//			  [UIView setAnimationBeginsFromCurrentState:YES];		  
//			  [UIView setAnimationTransition:animation forView:self.view cache:YES];
		}
		break;	  
			
		case GtNavigationControllerAnimationFlipFromLeft:
		case GtNavigationControllerAnimationFlipFromRight:
		case GtNavigationControllerAnimationCurlUp:
		case GtNavigationControllerAnimationCurlDown:
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
	UIView* view = (UIView*) context;
	[view removeFromSuperview];
	GtRelease(view);
			
}

- (void) popToViewController:(UIViewController*) viewController withAnimation:(GtNavigationControllerAnimation) animation
{
	switch(animation)
	{
		case GtNavigationControllerAnimationFade:
		// TODO
		[self popToViewController:viewController animated:NO];
				
		break;
		
		case GtNavigationControllerAnimationSlideInFromBottom:
		{
			UIViewController* controller = [self topViewController];
			UIViewController* parent = [self parentControllerForController:controller];
			UIView* view = GtRetain(controller.view);
			[self popToViewController:viewController animated:NO];
			[parent.view addSubview:view];
			
			[UIView beginAnimations:@"slide" context:view];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneAnimatingPopViewController:finished:context:)];
			view.frame = GtRectSetTop(view.frame, view.frame.size.height);
			[UIView commitAnimations];
		}
			break;
		
		case GtNavigationControllerAnimationNone:
			[self popToViewController:viewController animated:NO];
			break;
			
		case GtNavigationControllerAnimationDefault:
			[self popToViewController:viewController animated:YES];
			break;
			
		case GtNavigationControllerAnimationFlipFromLeft:
		case GtNavigationControllerAnimationFlipFromRight:
		case GtNavigationControllerAnimationCurlUp:
		case GtNavigationControllerAnimationCurlDown:
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

- (void) popViewControllerWithAnimation:(GtNavigationControllerAnimation) animation	   
{
	switch(animation)
	{
		case GtNavigationControllerAnimationFade:
		[self popViewControllerAnimated:NO];
			
		break;
		
		case GtNavigationControllerAnimationSlideInFromBottom:
		{
			UIViewController* controller = [self topViewController];
			UIViewController* parent = [self parentControllerForController:controller];
			UIView* view = GtRetain(controller.view);
			[self popViewControllerAnimated:NO];
			[parent.view addSubview:view];
			
			[UIView beginAnimations:@"slide" context:view];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneAnimatingPopViewController:finished:context:)];
			view.frame = GtRectSetTop(view.frame, view.frame.size.height);
			[UIView commitAnimations];
		}
			break;
		
		case GtNavigationControllerAnimationNone:
			[self popViewControllerAnimated:NO];
			break;
			
		case GtNavigationControllerAnimationDefault:
			[self popViewControllerAnimated:YES];
			break;
			
		case GtNavigationControllerAnimationFlipFromLeft:
		case GtNavigationControllerAnimationFlipFromRight:
		case GtNavigationControllerAnimationCurlUp:
		case GtNavigationControllerAnimationCurlDown:
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

- (void) visitViewControllers:(GtNavigationControllerVisitor) visitor
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
                                                visitor:(GtNavigationControllerVisitor) visitor
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
                              visitor:(GtNavigationControllerVisitor) visitor
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

- (void) viewControllerDismissDelegate:(UIViewController*) viewController dismissViewControllerAnimated:(BOOL) animated
{
    if(animated)
    {
        [self popViewControllerWithAnimation:viewController.navigationControllerCloseAnimation];
    }
    else
    {
        [self popViewControllerAnimated:NO];
    }
}

@end

@implementation UIViewController (GtNavigationController)

- (void) willBePushedOnNavigationController:(UINavigationController*) controller
{
}

- (void) wasPushedOnNavigationController:(UINavigationController*) controller
{
}

- (void) wasPoppedFromNavigationController:(UINavigationController*) controller
{
}

- (GtButtonbarView*) buttonbar
{
	return nil;
}

@end

@implementation GtNavigationController

+ (GtNavigationController*) navigationController:(UIViewController*) rootViewController
{
	return GtReturnAutoreleased([[GtNavigationController alloc] initWithRootViewController:rootViewController]);
}

- (void) _prepareForButtonBar:(UINavigationItem*) item
{
	[item setHidesBackButton:YES animated:NO];

	self.title = nil;
	item.titleView = GtReturnAutoreleased([[UIView alloc] initWithFrame:CGRectZero]);
	[item setLeftBarButtonItem:nil animated:NO];
	[item setRightBarButtonItem:nil animated:NO];
}

- (void) _prepareToShowButtonBar:(GtButtonbarView*) buttonbar
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
		if([subview isKindOfClass:[GtButtonbarView class]] && !subview.hidden)
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
	
	GtButtonbarView* buttonbar = viewController.buttonbar;
	if(buttonbar)
	{	
		[viewController.navigationItem setHidesBackButton:YES animated:NO];
	
		[self _prepareForButtonBar:viewController.navigationItem];
		buttonbar.hidden = NO;

		[self _prepareToShowButtonBar:buttonbar];	
		if(animated)
		{
			[buttonbar animateOntoScreen:GtViewAnimationTypeSlideFromRight duration:0.3 finishedBlock:nil];
		}
		
		UIViewController* parent = self.visibleViewController;
		if(!parent)
		{
			buttonbar.backButton.hidden = YES;
		}
		else if(GtStringIsEmpty(parent.backButtonTitle))
		{
			buttonbar.backButton.title = NSLocalizedString(@"Back", nil);
		}
		else
		{
			buttonbar.backButton.title = parent.backButtonTitle;
		}
	}
    viewController.dismissDelegate = self;

	[viewController willBePushedOnNavigationController:self];
	[super pushViewController:viewController animated:animated];
	[viewController wasPushedOnNavigationController:self];
}

- (void) _viewControllerWasPopped:(UIViewController*) viewController animated:(BOOL) animated
{
	GtButtonbarView* buttonbar = viewController.buttonbar;
	if(buttonbar)
	{
		if(animated)
		{
			[buttonbar removeFromSuperviewWithAnimationType:GtViewAnimationTypeSlideFromRight duration:0.3 finishedBlock:nil];
		}
		else
		{
			[buttonbar removeFromSuperview];
		}
	}
	
	[viewController wasPoppedFromNavigationController:self];
	
	GtButtonbarView* topButtonbar = self.topViewController.buttonbar;
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
    
    viewController.dismissDelegate = nil;
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

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated; // Pops until there's only a single view controller left on the stack. Returns the popped 
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
	return m_superViewController;
}

- (void) setSuperViewController:(UIViewController*) viewController
{
	m_superViewController = viewController;
}


@end

