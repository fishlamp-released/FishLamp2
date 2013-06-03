//
//  FLMultiViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMultiViewController.h"

@implementation FLViewControllerPlaceholder

@synthesize autoPurgeHiddenViewController = _autoPurge;
@synthesize viewController = _viewController;
@synthesize title = _title;
@synthesize frame = _frame;
@synthesize viewControllerClass = _viewControllerClass;
@synthesize viewControllerFactory = _viewControllerFactory;

- (void) dealloc
{
    FLRelease(_title);
    FLRelease(_viewController);
    FLSuperDealloc();
}

- (id) initWithViewControllerClass:(Class) viewControllerClass
                             title:(NSString*) title {
    if((self = [super init]))
    {
        self.title = title;
        self.viewControllerClass = viewControllerClass;
    }
    
    return self;
}

- (id) initWithViewControllerFactory:(FLCallback_t) factory
                               title:(NSString*) title
{
    if((self = [super init]))
    {
        self.title = title;
        self.viewControllerFactory = factory;
    }
    
    return self;
}

+ (FLViewControllerPlaceholder*) viewControllerPlaceholder:(NSString*) title viewControllerClass:(Class) viewControllerClass
{
    return FLAutorelease([[FLViewControllerPlaceholder alloc] initWithViewControllerClass:viewControllerClass title:title]);
}

+ (FLViewControllerPlaceholder*) viewControllerPlaceholder:(NSString*) title viewControllerFactory:(FLCallback_t) factory
{
    return FLAutorelease([[FLViewControllerPlaceholder alloc] initWithViewControllerFactory:factory title:title]);
}

- (void) purgeViewController
{
    if( _viewController && 
        _viewController.isViewLoaded && 
        _viewController.view.superview == nil)
    {
        FLLog(@"purged view for: %@", NSStringFromClass([self.viewController class]));
        [[_viewController view] removeFromSuperview];
        [_viewController setView:nil];
        [_viewController viewDidUnload];
    }

    if(self.autoPurgeHiddenViewController)
    {
        FLAutorelease(FLRetain(_viewController));
        [_viewController removeFromParentViewController];
        FLReleaseWithNil(_viewController);
    }
}

- (void) hideViewController
{
    if(self.viewControllerIsActive)
    {
        [[_viewController view] removeFromSuperview];
#if TRACE
        FLLog(@"hiding view for: %@", NSStringFromClass([self.viewController class]));
#endif        
    }
}

- (void) createViewControllerIfNeededInViewController:(UIViewController*) inViewController
{
    FLAssertIsNotNil(inViewController);
    
    if(!_viewController)
    {
        if(_viewControllerClass)
        {
            _viewController = [[self.viewControllerClass alloc] init];
        }
        else 
        {
            FLCallbackInvoke(_viewControllerFactory, self);
        }
        if(_viewController)
        {
            _viewController.title = self.title;
            [inViewController addChildViewController:_viewController];
        }
    }
}

- (void) showViewControllerInSuperView:(UIView*) superview
                      inViewController:(UIViewController*) viewController
{
    if(!self.viewControllerIsActive)
    {
        [self createViewControllerIfNeededInViewController:viewController];
        
        UIView* view =  _viewController.view; // loads the view if needed
        if(!CGRectEqualToRect(view.frame, self.frame))
        {
           view.frame = self.frame;
        }
        
        if( view.superview == nil)
        {
            [superview addSubview:view];
#if TRACE
            FLLog(@"Showed view for: %@", NSStringFromClass([self.viewController class]));
#endif            
        }

    }
}

- (BOOL) viewControllerIsActive
{
    return  _viewController != nil && 
            _viewController.isViewLoaded && 
            _viewController.view.superview != nil;
}

@end

@implementation FLMultiViewController

@synthesize placeholders = _viewControllers;
@synthesize arrangement = _arrangement;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	FLAssertIsNil(nibNameOrNil);

	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		_viewControllers = [[FLOrderedCollection alloc] init];
	}
	
	return self;
}

- (void)addPlaceholder:(FLViewControllerPlaceholder *) placeholder forKey:(id) key
{
    [_viewControllers addOrReplaceObject:placeholder forKey:key];
}

- (FLViewControllerPlaceholder*) placeholderAtIndex:(NSUInteger) idx
{
	return [_viewControllers objectAtIndex:idx];
}

- (FLViewControllerPlaceholder*) placeholderForKey:(id) key
{
	return [_viewControllers objectForKey:key];
}

- (void) updateLayout
{
    CGRect bounds = self.view.bounds;
    bounds.origin.x = 0;
    
    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
    {
        placeholder.frame = bounds;
    }
    
}

- (void) viewWillLayoutSubviews

{
    [self updateLayout];
    [super viewWillLayoutSubviews];
}

- (void) dealloc
{	
    FLRelease(_arrangement);
	FLRelease(_viewControllers);

	FLSuperDealloc();
}

- (NSUInteger) viewControllerCount
{
    return _viewControllers.count;
}

- (UIView*) containerView
{
    return self.view;
}

- (CGRect) containerViewVisibleBounds
{
    return self.view.bounds;
}

- (void) updateVisibleViews
{
    CGRect visibleBounds = self.containerViewVisibleBounds;
    UIView* containerView = self.containerView;
    
    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
    {
        if(CGRectIntersectsRect(visibleBounds, placeholder.frame))
        {
            [placeholder showViewControllerInSuperView:containerView inViewController:self];
        }
        else
        {
            [placeholder hideViewController];
        }
    }
}

- (void) unloadHiddenControllers
{
    for(FLViewControllerPlaceholder* placeholder in _viewControllers.forwardObjectEnumerator)
    {
        if(![placeholder viewControllerIsActive])
        {
            [placeholder purgeViewController];
        }
	}
}

- (void) didReceiveMemoryWarning
{
    for(FLViewControllerPlaceholder* placeholder in _viewControllers.forwardObjectEnumerator)
    {
        if(![placeholder viewControllerIsActive])
		{
            if(placeholder.viewController)
            {
                [placeholder.viewController didReceiveMemoryWarning];
            }
            [placeholder purgeViewController];
        }
	}

	[super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated  
{
    [super viewWillAppear:animated];
    [self updateVisibleViews];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end

@implementation FLSelectableViewControllerMultiViewController

@synthesize selectedIndex = _selectedIndex;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	FLAssertIsNil(nibNameOrNil);

	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		_selectedIndex = NSIntegerMax;
	}
	
	return self;
}

- (FLViewControllerPlaceholder*) selectedViewControllerPlaceholder
{
    return _selectedIndex < self.viewControllerCount ? [self placeholderAtIndex:_selectedIndex] : nil;
}

- (void) selectedIndexDidChange
{
}

- (void) didSelectViewController:(FLViewControllerPlaceholder*) viewControllerPlaceholder
                         animate:(BOOL) animate
{
    [self updateLayout];
    [self updateVisibleViews];
}

- (void) didUnselectViewController:(FLViewControllerPlaceholder*) viewControllerPlaceholder 
                           animate:(BOOL) animate
{
}

- (void) setSelectedIndex:(NSUInteger) idx animate:(BOOL) animate
{
	if(idx != _selectedIndex)
	{
		if(self.selectedViewControllerPlaceholder)
		{
			[self didUnselectViewController:self.selectedViewControllerPlaceholder animate:animate];
        }
		
		_selectedIndex = idx;
        
        if(_selectedIndex < self.viewControllerCount)
        {
            [self didSelectViewController:self.selectedViewControllerPlaceholder animate:animate];
        }
        
        [self selectedIndexDidChange];
	}
}

@end
