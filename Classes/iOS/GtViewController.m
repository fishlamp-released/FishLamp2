//
//	GtViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewController.h"
#import "GtAction.h"

#import "GtActionContextManager.h"
#import "GtNavigationControllerViewController.h"
#import "GtHoverViewController.h"
#import "GtNavigationController.h"
#import "GtGradientButton.h"
#import "GtNetworkStatusMonitor.h"
#import "GtBackgroundTaskMgr.h"
#import "GtGradientView.h"

#import <objc/runtime.h>

@interface GtViewController ()
@end

@implementation GtViewController

@synthesize navigationControllerCloseAnimation = m_navigationControllerCloseAnimation;

@synthesize actionContext = m_context;
@synthesize tag = m_tag;
@synthesize buttonbar = m_buttonbar; 
//@synthesize tabBarDelegate = m_tabBarDelegate;
@synthesize backButtonTitle = m_backButtonTitle;
@synthesize modalParentViewController = m_modalParent;
@synthesize contentSizeForViewInHoverView = m_hoverViewContentSize;
@synthesize autoLayout = _autoLayout;
@synthesize autoLayoutMode = _autoLayoutMode;
@synthesize wasThemed = _wasThemed;
@synthesize themeAction = _themeAction;


static GtViewController* s_presentingModalViewController = nil;

GtSynthesizeStructProperty(viewIsVisible, setViewIsVisible, BOOL, m_viewControllerFlags);
GtSynthesizeStructProperty(disableBackgroundTasks, setDisableBackgroundTasks, BOOL, m_viewControllerFlags);

+ (id) viewController
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

#if DEBUG
- (GtActionContext*) actionContext
{
    GtAssert(m_context != nil, @"action context is nil");
    return m_context;
}
#endif

- (void) handleShake:(id) sender
{
	if(m_context.isActive)
	{
		[self onDeviceWasShaken];
	}
}

- (void) respondToBackButtonPress:(id) sender
{
	if([self backButtonWillDismissViewController])
	{
		[self dismissViewControllerAnimated:YES];
//        GtInvokeCallback(m_dismissEvent, self);
	}
}

- (void) _networkBecameAvailable:(NSNotification*) notification
{
	[self networkDidBecomeAvailable];
}

- (void) _networkBecameUnavailable:(NSNotification*) notification
{
	[self networkDidBecomeUnavailable];
}

- (void) _themeDidChange:(NSNotification*) notification
{
	if(self.isViewLoaded)
	{
		[self.view themeDidChange];
	}
}

- (void) createActionContext
{
    if(!m_context)
    {
        m_context = [[GtManagedActionContext alloc] initAndActivate:YES];
        m_context.actionContextDelegate = self; 
    }
}

- (void) createButtonBar
{
    if(!m_buttonbar)
    {
        m_buttonbar = [[GtButtonbarView alloc] initWithFrame:CGRectZero];
    }
}

- (GtButtonbarView*) buttonbar
{
    return m_buttonbar;
}

- (void) willBePushedOnNavigationController:(UINavigationController *)controller
{
    if(m_buttonbar && !m_buttonbar.backButton && GtStringIsNotEmpty(self.backButtonTitle))
    {
        [m_buttonbar addBackButton:self.title target:self action:@selector(respondToBackButtonPress:)];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
        [[GtBackgroundTaskMgr instance] addDelegate:self];
				
		[[NSNotificationCenter defaultCenter] addObserver:self
						selector:@selector(handleShake:)
						name:GtDeviceWasShakenNotification 
						object:[UIApplication sharedApplication]];

		[[NSNotificationCenter defaultCenter] addObserver:self
						selector:@selector(_networkBecameAvailable:)
						name:GtNetworkStatusNetworkBecameAvailableNotification 
						object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
						selector:@selector(_networkBecameUnavailable:)
						name:GtNetworkStatusNetworkBecameUnavailableNotification 
						object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
						selector:@selector(_themeDidChange:)
						name:GtThemeDidChangeNotification 
						object:nil];

		self.wantsFullScreenLayout = YES;
	}
	
	return self;
}

- (UIView*) createView
{
	return GtReturnAutoreleased([[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)]);
}

- (void) didCreateView:(UIView*) view
{
	view.backgroundColor = [UIColor blackColor];
	view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	view.autoresizesSubviews = YES;
}

- (void) loadView
{
	if(GtStringIsNotEmpty(self.nibName))
	{
		[super loadView];
	}
	else
	{
		UIView* view = [self createView];
		[self didCreateView:view];
		self.view = view;
	}
}

- (UIViewController*) actionContextGetViewController:(GtActionContext*) context
{
	return self;
}

- (void) wasPoppedFromNavigationController:(UINavigationController*) controller
{
}

#if DEBUG
- (void) wasPushedOnNavigationController:(UINavigationController*) controller
{
    m_viewControllerFlags.dismissed = NO;
    [super wasPushedOnNavigationController:controller];
}

- (void) didShowInHoverViewController:(GtHoverViewController*) controller
{
    m_viewControllerFlags.dismissed = NO;
    [super didShowInHoverViewController:controller];
}
#endif

#if 0
- (void) dismissViewControllerAnimated:(BOOL) animated
{
#if DEBUG
    GtAssert(m_viewControllerFlags.dismissed == false, @"already dismissed");
    m_viewControllerFlags.dismissed = YES;
#endif
    
	GtAutorelease(GtRetain(self));
	
	if(m_modalParent)
	{
		[m_modalParent dismissModalViewControllerAnimated:YES];
	}
	else if(self.navigationController)
	{
		if([self.navigationController rootViewController] == self)
		{
			GtHoverViewController* popover = self.hoverViewController;
			if(popover)
			{
				[popover dismissHoverViewAnimated:animated];
				return;
			}
		}

		[self.navigationController popViewControllerWithAnimation:animated ? self.navigationControllerCloseAnimation : GtNavigationControllerAnimationNone];
		
	}
	else if(self.viewControllerStack)
    {
        [self.viewControllerStack popViewControllerAnimated:animated];
    }
    else 
	{
		GtHoverViewController* popover = self.hoverViewController;
		if(popover)
		{
			[popover dismissHoverViewAnimated:animated];
		}
	}
}
#endif

- (BOOL) backButtonWillDismissViewController
{
	return YES;
}

- (GtViewContentsDescriptor) viewContentsDescriptor
{
	GtViewContentsDescriptor contentsDescriptor = self.describeViewContents;

	if(self.hoverViewController)
	{
		if(GtBitTestAny(contentsDescriptor.top, GtViewContentItemStatusBar))
		{
			contentsDescriptor.top = GtBitClear(contentsDescriptor.top, GtViewContentItemStatusBar);
		}
    }
	
	return contentsDescriptor;
}

- (GtViewContentsDescriptor) describeViewContents
{
	return GtViewContentsDescriptorNone;
}

- (void) viewDidLoad
{
#if TRACE
    GtLog(@"view controller loaded: %@", NSStringFromClass([self class]));
#endif

	[super viewDidLoad];
}

- (void) addDidAppearCallback:(GtCallbackObject*) callback
{
	if(self.viewIsVisible)
	{
		[callback invoke:self];
	}
	else
	{
		if(!m_didAppearCallbacks)
		{
			m_didAppearCallbacks = [[NSMutableArray alloc] init];
		}
		[m_didAppearCallbacks addObject:callback];
	}
}

- (NSString*) backButtonTitle
{
	return GtStringIsEmpty(m_backButtonTitle) ? [super backButtonTitle] : m_backButtonTitle;
}

- (void) dealloc
{
  	[[GtBackgroundTaskMgr instance] removeDelegate:self];

	GtRelease(m_buttonbar);
	GtRelease(m_didAppearCallbacks);
	GtRelease(m_backButtonTitle);
    
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	m_context.actionContextDelegate = nil;
	GtReleaseWithNil(m_context);

	GtSuperDealloc();
}

- (void) onDeviceWasShaken
{
	GtLog(@"Got shake event: %@", NSStringFromClass([self class]));
}

- (void) actionContextActivated:(GtActionContext*) context
{
	[self didBecomeActiveContext];
}

- (void) actionContextDeactivated:(GtActionContext*) context
{
	[self didBecomeInactiveContext];
}

- (void) didCancelActions:(GtActionContext*) context
{
	[self didCancelActions];
}

- (void) appDidEnterForeground
{
}

- (void) appDidEnterBackground
{
}

- (void) didBecomeActiveContext
{
}

- (void) didBecomeInactiveContext
{
}

- (void) actionContextAppEnteredForeground:(GtActionContext*) context
{
	if(self.viewIsVisible)
	{
		[self appDidEnterForeground];
	}
}

- (void) actionContextAppEnteredBackground:(GtActionContext*) context
{
	if(self.viewIsVisible)
	{
		[self appDidEnterBackground];
	}
}

- (void) didCancelActions
{
}

- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(GtBackgroundTaskMgr*) mgr
{
    return !self.disableBackgroundTasks;
}

- (BOOL) backgroundTaskMgr:(GtBackgroundTaskMgr*) mgr canBeginBackgroundTask:(id<GtBackgroundTask>) task
{
    return YES;
}

- (void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	
    m_buttonbar.title = self.title;
    [m_buttonbar backButton].title = self.backButtonTitle;
    [m_buttonbar setNeedsLayout];
    
	if(self.hoverViewController)
	{
		self.navigationController.navigationBar.frame = GtRectSetTop(self.navigationController.navigationBar.frame, 0.0);
	}
    

    
#if TRACE
    GtLog(@"viewWillAppear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewDidAppear:(BOOL)animated
{
	m_viewControllerFlags.viewIsVisible = YES;
	[m_context activate];
	[super viewDidAppear:animated];
   
	if(m_didAppearCallbacks)
	{
		NSMutableArray* callbacks = m_didAppearCallbacks;
		m_didAppearCallbacks = nil;
		
		for(GtCallbackObject* cb in callbacks)
		{
			[cb invoke:self];
		}
		
		GtRelease(callbacks);
	}

#if TRACE
    GtLog(@"viewDidAppear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewWillDisappear:(BOOL) animated
{
	[m_context cancelActions];
	[super viewWillDisappear:animated];

#if TRACE
    GtLog(@"viewWillDisappear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewDidDisappear:(BOOL)animated
{
	m_viewControllerFlags.viewIsVisible = NO;
	[super viewDidDisappear:animated];

#if TRACE
    GtLog(@"viewDidDisappear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) setTitle:(NSString*) title
{
	[super setTitle:title];

	if(m_buttonbar)
	{
		m_buttonbar.title = GtStringIsEmpty(title) ? @"" : title;
	}
}

- (void) networkDidBecomeAvailable
{
}

- (void) networkDidBecomeUnavailable
{
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

	[self.view setNeedsLayout];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    GtLog(@"did rotate: %@", NSStringFromClass([self class]));

	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

	[self.view setNeedsLayout];
}

+ (void) setPresentingModalViewController:(GtViewController*) viewController
{
#if DEBUG
    if(viewController)
    {
        GtAssertNil(s_presentingModalViewController);
    }
    else
    {
        GtAssertNotNil(s_presentingModalViewController);
    }
#endif
    s_presentingModalViewController= viewController;
}

+ (GtViewController*) presentingModalViewController
{
	return s_presentingModalViewController;
}

+ (BOOL) isPresentingModalViewController
{
	return [GtViewController presentingModalViewController] != nil;
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    [modalViewController willBePresentedModallyInViewController:self];
    [GtViewController setPresentingModalViewController:self];
	[super presentModalViewController:modalViewController animated:animated];
	[modalViewController wasPresentedModally:self];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
	GtAssert([GtViewController presentingModalViewController] == self, @"dismissing with wrong view controller");
	
	GtAssertNotNil(self.modalViewController); 
	GtAutorelease(GtRetain(self.modalViewController));
	
	[super dismissModalViewControllerAnimated:animated];
	[self.modalViewController wasDismissedFromModalPresentation:self];
	
    [GtViewController setPresentingModalViewController:nil];
}

- (void) setContentSizeForViewInPopover:(CGSize) size
{
	[super setContentSizeForViewInPopover:size];
}

- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController
{   
    [super willBePresentedModallyInViewController:superViewController];
    self.disableBackgroundTasks = YES;
}

- (void) createTopToolbar
{
    UIView* buttonBarHost = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 44)];
    buttonBarHost.autoresizesSubviews = YES;
    buttonBarHost.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    buttonBarHost.backgroundColor = [UIColor clearColor];
    
    GtGradientView* gradient = [[GtGradientView alloc] initWithFrame:buttonBarHost.bounds];
    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    gradient.alpha = 0.6f;
    [buttonBarHost addSubview:gradient];
    
    GtButtonbarView* bar = self.buttonbar;
    if(bar)
    {
        bar.title = self.title;
        bar.frame = buttonBarHost.bounds;
        [buttonBarHost addSubview:bar];
    }
    
    self.topBarView = buttonBarHost;
}

- (void) configureNavigationBar {
}



@end

#define kTopBarTag      'topB'
#define kBottomBarTag   'botB'
static void * const kDismissHandlerKey = (void*)&kDismissHandlerKey;

@implementation UIViewController (GtViewController)

- (NSString*) backButtonTitle
{
	return self.title;
}

- (void) setBackButtonTitle:(NSString *)backButtonTitle
{
    self.title = backButtonTitle;
}

- (UIViewController*) superViewController
{
	return nil;
}

- (void) setSuperViewController:(UIViewController*) viewController
{
}

- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController
{
}

- (void) wasPresentedModally:(UIViewController*) superViewController
{
	self.superViewController = superViewController;
}

- (void) wasDismissedFromModalPresentation:(UIViewController*) superViewController
{
	if(self.superViewController == superViewController)
	{
		self.superViewController = nil;
	}
}

- (UIView*) viewByTag:(NSInteger) tag
{
    GtAssert(self.isViewLoaded, @"view is not loaded");

    if(self.isViewLoaded)
    {
        for(UIView* view in self.view.subviews)
        {
            if(view.tag == tag)
            {
                return view;
            }
        }
    }
    
    return nil;
}

- (void) addViewWithTag:(UIView*) view tag:(NSInteger) tag
{
    GtAssert(self.isViewLoaded, @"view is not loaded");

    if(self.isViewLoaded)
    {
        UIView* prev = [self viewByTag:tag];
        if(prev)
        {
            [prev removeFromSuperview];
        }
        view.tag = tag;
        [self.view addSubview:view];
    }
}

- (GtViewContentsDescriptor) viewContentsDescriptor
{
	return GtViewContentsDescriptorNone;
}

- (UIView*) topBarView
{
    return [self viewByTag:kTopBarTag];
}

- (UIView*) bottomBarView
{
    return [self viewByTag:kBottomBarTag];
}

- (void) setTopBarView:(UIView*) view
{
    view.frame = [self frameForTopBarView:view];
    [self addViewWithTag:view tag:kTopBarTag];
}

- (void) setBottomBarView:(UIView*) view
{
    view.frame = [self frameForBottomBarView:view];
    [self addViewWithTag:view tag:kBottomBarTag];
}

- (CGRect) frameForTopBarView:(UIView*) view
{
    CGRect frame = view.frame;

    GtViewContentsDescriptor viewContents = self.viewContentsDescriptor;
    frame.origin.y = GtBitMaskTest(viewContents.top, GtViewContentItemStatusBar) ? 20.0f : 0.0f;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (CGRect) frameForBottomBarView:(UIView*) view
{
    CGRect frame = view.frame;
    frame.origin.y = GtRectGetBottom(self.view.bounds) - frame.size.height;
    frame.origin.x = 0;
    frame.size.width = self.view.bounds.size.width;
    return frame;
}

- (void) dismissViewControllerAnimated:(BOOL) animated
{
    id<GtViewControllerDismissDelegate> delegate = self.dismissDelegate;
    if(delegate)
    {
        [delegate viewControllerDismissDelegate:self dismissViewControllerAnimated:animated];
        self.dismissDelegate = nil;
    } 
    else
    {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
}

- (id) dismissDelegate
{
    return objc_getAssociatedObject(self, &kDismissHandlerKey);
}

- (void) setDismissDelegate:(id) delegate
{
    objc_setAssociatedObject(self, &kDismissHandlerKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (GtNavigationControllerAnimation) navigationControllerCloseAnimation
{
    return GtNavigationControllerAnimationDefault;
}





@end






