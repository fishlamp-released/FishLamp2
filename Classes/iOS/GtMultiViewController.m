//
//  GtMultiViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMultiViewController.h"

@implementation GtViewControllerPlaceholder

GtSynthesizeStructProperty(autoPurgeHiddenViewController, setAutoPurgeHiddenViewController, BOOL, m_flags);
@synthesize viewController = m_viewController;
@synthesize viewControllerFactory = m_viewControllerFactory;
@synthesize title = m_title;
@synthesize frame = m_frame;

- (void) dealloc
{
    GtRelease(m_title);
    GtRelease(m_viewControllerFactory);
    GtRelease(m_viewController);
    GtSuperDealloc();
}

- (id) initWithViewControllerFactory:(GtViewControllerFactory) factory title:(NSString*) title
{
    GtAssertNotNil(factory);

    if((self = [super init]))
    {
        self.title = title;
        self.viewControllerFactory = factory;
    }
    
    return self;
}

+ (GtViewControllerPlaceholder*) viewControllerPlaceholder:(GtViewControllerFactory) viewControllerFactory title:(NSString*) title
{
    return GtReturnAutoreleased([[GtViewControllerPlaceholder alloc] initWithViewControllerFactory:viewControllerFactory title:title]);
}

- (void) purgeViewController
{
    if( m_viewController && 
        m_viewController.isViewLoaded && 
        m_viewController.view.superview == nil)
    {
        GtLog(@"purged view for: %@", NSStringFromClass([self.viewController class]));
        [[m_viewController view] removeFromSuperview];
        [m_viewController setView:nil];
        [m_viewController viewDidUnload];
    }

    if(self.autoPurgeHiddenViewController)
    {
        GtAutorelease(GtRetain(m_viewController));
        [m_viewController removeFromParentViewController];
        GtReleaseWithNil(m_viewController);
    }
}

- (void) hideViewController
{
    if(self.viewControllerIsActive)
    {
        [[m_viewController view] removeFromSuperview];
        GtLog(@"hiding view for: %@", NSStringFromClass([self.viewController class]));
    }
}

- (void) showViewControllerInSuperView:(UIView*) superview
                      inViewController:(UIViewController*) viewController
{
    if(!self.viewControllerIsActive)
    {
        [self createViewControllerIfNeededInViewController:viewController];
        
        UIView* view =  m_viewController.view; // loads the view if needed
        if(!CGRectEqualToRect(view.frame, self.frame))
        {
           view.frame = self.frame;
        }
        
        if( view.superview == nil)
        {
            [superview addSubview:view];
            GtLog(@"Showed view for: %@", NSStringFromClass([self.viewController class]));
        }

    }
}

- (void) createViewControllerIfNeededInViewController:(UIViewController*) inViewController
{
    GtAssertNotNil(inViewController);
    
    if(!m_viewController && m_viewControllerFactory)
    {
        m_viewController = GtRetain(m_viewControllerFactory());
        if(m_viewController)
        {
            m_viewController.title = self.title;
            [inViewController addChildViewController:m_viewController];
        }
    }
}

- (BOOL) viewControllerIsActive
{
    return  m_viewController != nil && 
            m_viewController.isViewLoaded && 
            m_viewController.view.superview != nil;
}

@end

@implementation GtMultiViewController

@synthesize placeholders = m_viewControllers;
@synthesize viewLayout = m_viewLayout;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	GtAssertNil(nibNameOrNil);

	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		m_viewControllers = [[GtOrderedCollection alloc] init];
	}
	
	return self;
}

- (void)addPlaceholder:(GtViewControllerPlaceholder *) placeholder forKey:(id) key
{
    [m_viewControllers addOrReplaceObject:placeholder forKey:key];
}

- (GtViewControllerPlaceholder*) placeholderAtIndex:(NSUInteger) idx
{
	return [m_viewControllers objectAtIndex:idx];
}

- (GtViewControllerPlaceholder*) placeholderForKey:(id) key
{
	return [m_viewControllers objectForKey:key];
}

- (void) updateLayout
{
}

- (UIView*) createView
{
	UIView* view = GtReturnAutoreleased([[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)]);
	view.autoresizesSubviews = YES;
	view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	return view;
}

- (void) viewDidLayoutSubviews
{
    [self updateLayout];
    [super viewDidLayoutSubviews];
}

- (void) loadView
{
	if(GtStringIsEmpty(self.nibName))
	{
		self.view = [self createView];
	}
	else
	{
		[super loadView];
	}
}

- (void) dealloc
{	
    GtRelease(m_viewLayout);
	GtRelease(m_viewControllers);

	GtSuperDealloc();
}

- (NSUInteger) viewControllerCount
{
    return m_viewControllers.count;
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
    
    for(GtViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
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
    for(GtViewControllerPlaceholder* placeholder in m_viewControllers.forwardObjectEnumerator)
    {
        if(![placeholder viewControllerIsActive])
        {
            [placeholder purgeViewController];
        }
	}
}

- (void) didReceiveMemoryWarning
{
    for(GtViewControllerPlaceholder* placeholder in m_viewControllers.forwardObjectEnumerator)
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

@implementation GtSelectableViewControllerMultiViewController

@synthesize selectedIndex = m_selectedIndex;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	GtAssertNil(nibNameOrNil);

	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		m_selectedIndex = 0;
	}
	
	return self;
}

- (GtViewControllerPlaceholder*) selectedViewControllerPlaceholder
{
    return [self placeholderAtIndex:m_selectedIndex];
}

- (void) selectedIndexDidChange
{
}

- (void) didSelectViewController:(UIViewController*) viewController 
                         animate:(BOOL) animate
{
}

- (void) didUnselectViewController:(UIViewController*) viewController 
                           animate:(BOOL) animate
{
}

- (void) setSelectedIndex:(NSUInteger) idx animate:(BOOL) animate
{
	if(idx != m_selectedIndex)
	{
		if(self.selectedViewControllerPlaceholder)
		{
			[self didUnselectViewController:self.selectedViewControllerPlaceholder animate:animate];
        }
		
		m_selectedIndex = idx;
        
        [self didSelectViewController:self.selectedViewControllerPlaceholder animate:animate];
        
        [self selectedIndexDidChange];
	}
}

@end
