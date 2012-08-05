//
//	FLViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLViewController.h"
#import "FLAction.h"

#import "FLActionContextManager.h"
#import "FLNavigationControllerViewController.h"
#import "FLFloatingViewController.h"
#import "FLNavigationController.h"
#import "FLGradientButton.h"
#import "FLReachableNetwork.h"
#import "FLBackgroundTaskMgr.h"
#import "FLGradientView.h"

#import <objc/runtime.h>

// TODO: there is a lot of coupling and old crusty code in here.

@interface FLViewController ()
@end

@implementation FLViewController 

@synthesize navigationControllerCloseAnimation = _navigationControllerCloseAnimation;
@synthesize actionContext = _context;

@synthesize modalParentViewController = _modalParent;
@synthesize contentSizeForViewInFloatingView = _floatingViewContentSize;

static FLViewController* s_presentingModalViewController = nil;

@synthesize viewIsVisible = _viewIsVisible; 
@synthesize disableBackgroundTasks = _disableBackgroundTasks; 

+ (id) viewController {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

#if DEBUG
- (FLActionContext*) actionContext {
    FLAssert(_context != nil, @"action context is nil");
    return _context;
}
#endif

- (void) handleShake:(id) sender {
	if(_context.isActive) {
		[self onDeviceWasShaken];
	}
}

- (void) _networkReachabilityDidChange:(NSNotification*) notification {
    if([notification.object isReachable]) {
        [self networkDidBecomeAvailable];
    }
    else {
        [self networkDidBecomeUnavailable];
    }
}

- (void) createActionContext {
    if(!_context) {
        _context = [[FLManagedActionContext alloc] initAndActivate:YES];
        _context.actionContextDelegate = self; 
    }
}

- (void) willBePushedOnNavigationController:(UINavigationController *)controller {
    if(self.isViewLoaded) {
        if([self.topBarView respondsToSelector:@selector(viewController:willBePushedOnNavigationController:)]) {
            [self.topBarView viewController:self willBePushedOnNavigationController:controller];
        }
        
        if([self.bottomBarView respondsToSelector:@selector(viewController:willBePushedOnNavigationController:)]) {
            [self.bottomBarView viewController:self willBePushedOnNavigationController:controller];
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [[FLBackgroundTaskMgr instance] addDelegate:self];
				
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleShake:)
                                                     name:FLDeviceWasShakenNotification 
                                                   object:[UIApplication sharedApplication]];

		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_networkReachabilityDidChange:)
                                                     name:FLReachabilityChangedNotification 
                                                   object:[FLReachableNetwork instance]];

		self.wantsFullScreenLayout = YES;
        self.wantsApplyTheme = YES;
    }
	
	return self;
}

- (UIView*) createView {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	UIView* view = FLReturnAutoreleased([[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)]);
	view.backgroundColor = [UIColor blackColor];
	view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	view.autoresizesSubviews = YES;
    return view;
}

- (void) loadView {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	if(FLStringIsNotEmpty(self.nibName)) {
		[super loadView];
	}
	else {
        UIView* view = [self createView];
        _startSize = view.frame.size;
        self.view = view;
	}
}

- (UIViewController*) actionContextGetViewController:(FLActionContext*) context {
	return self;
}

- (void) wasPoppedFromNavigationController:(UINavigationController*) controller {
}

#if DEBUG
- (void) wasPushedOnNavigationController:(UINavigationController*) controller {
    _dismissed = NO;
    [super wasPushedOnNavigationController:controller];
}
#endif

- (BOOL) viewEnclosesStatusBar {
    return self.floatingViewController == nil;
}

- (void) updateViewContentsDescriptor {
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    [super didMoveToParentViewController:parent];
    [self updateViewContentsDescriptor];
    
#if DEBUG
    if(parent) {
        _dismissed = NO;
    }
#endif    
}

- (void) viewDidUnload {
    [super viewDidUnload];

    self.topBarView = nil;
    self.bottomBarView = nil;
}

- (void) viewDidLoad {
#if TRACE
    FLLog(@"view controller loaded: %@", NSStringFromClass([self class]));
#endif
	[super viewDidLoad];

    if(!CGSizeEqualToSize(_startSize, CGSizeZero)) {
        self.view.frame = FLRectSetSizeWithSize(self.view.frame, _startSize);
    }
}

- (void) addDidAppearCallback:(FLCallbackObject*) callback {

	if(self.viewIsVisible) {
		[callback invoke:self];
	}
	else {
		if(!_didAppearCallbacks) {
			_didAppearCallbacks = [[NSMutableArray alloc] init];
		}
		[_didAppearCallbacks addObject:callback];
	}
}

- (void) dealloc {
  	[[FLBackgroundTaskMgr instance] removeDelegate:self];

	FLRelease(_didAppearCallbacks);
    
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	_context.actionContextDelegate = nil;
	FLReleaseWithNil(_context);

	FLSuperDealloc();
}

- (void) onDeviceWasShaken {
	FLLog(@"Got shake event: %@", NSStringFromClass([self class]));
}

- (void) actionContextActivated:(FLActionContext*) context {
	[self didBecomeActiveContext];
}

- (void) actionContextDeactivated:(FLActionContext*) context {
	[self didBecomeInactiveContext];
}

- (void) didCancelActions:(FLActionContext*) context {
	[self didCancelActions];
}

- (void) appDidEnterForeground {
}

- (void) appDidEnterBackground {
}

- (void) didBecomeActiveContext {
}

- (void) didBecomeInactiveContext {
}

- (void) actionContextAppEnteredForeground:(FLActionContext*) context {
	if(self.viewIsVisible) {
		[self appDidEnterForeground];
	}
}

- (void) actionContextAppEnteredBackground:(FLActionContext*) context {
	if(self.viewIsVisible) {
		[self appDidEnterBackground];
	}
}

- (void) didCancelActions {
}

- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(FLBackgroundTaskMgr*) mgr {
    return !self.disableBackgroundTasks;
}

- (BOOL) backgroundTaskMgr:(FLBackgroundTaskMgr*) mgr canBeginBackgroundTask:(id<FLBackgroundTask>) task {
    return YES;
}

- (void) bringBarToFront:(UIView*) bar {
    if(bar) {
        [[bar superview] bringSubviewToFront:bar];
    }
}

- (void) barWillAppear:(UIView*) bar {
    if(bar) {
        if([bar respondsToSelector:@selector(viewControllerViewWillAppear:)]) {
            [((id)bar) viewControllerViewWillAppear:self];
        }
        
//        [[bar superview] bringSubviewToFront:bar];
    }
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    
//    [self bringBarToFront:self.topBarView];
//    [self bringBarToFront:self.bottomBarView];
}
 
- (void) viewWillAppear:(BOOL) animated {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	[super viewWillAppear:animated];
    [self barWillAppear:self.topBarView];
    [self barWillAppear:self.bottomBarView];
 
	if(self.floatingViewController) {
		self.navigationController.navigationBar.frame = FLRectSetTop(self.navigationController.navigationBar.frame, 0.0);
	}
    
    [self applyThemeIfNeeded];

#if TRACE
    FLLog(@"viewWillAppear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewDidAppear:(BOOL)animated {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	_viewIsVisible = YES;
	[_context activate];
	[super viewDidAppear:animated];
   
	if(_didAppearCallbacks) {
		NSMutableArray* callbacks = _didAppearCallbacks;
		_didAppearCallbacks = nil;
		
		for(FLCallbackObject* cb in callbacks)
		{
			[cb invoke:self];
		}
		
		FLRelease(callbacks);
	}

#if TRACE
    FLLog(@"viewDidAppear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewWillDisappear:(BOOL) animated {
	[_context cancelActions];
	[super viewWillDisappear:animated];

#if TRACE
    FLLog(@"viewWillDisappear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewDidDisappear:(BOOL)animated {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	_viewIsVisible = NO;
	[super viewDidDisappear:animated];

    if([self.topBarView respondsToSelector:@selector(viewControllerViewDidDisappear:)]) {
        [self.topBarView viewControllerViewDidDisappear:self];
    }
    if([self.bottomBarView respondsToSelector:@selector(viewControllerViewDidDisappear:)]) {
        [self.bottomBarView viewControllerViewDidDisappear:self];
    }

#if TRACE
    FLLog(@"viewDidDisappear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) setTitle:(NSString*) title {
	[super setTitle:title];
    if(self.isViewLoaded) {
        if([self.topBarView respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
            [self.topBarView viewControllerTitleDidChange:self];
        }
        if([self.bottomBarView respondsToSelector:@selector(viewControllerTitleDidChange:)]) {
            [self.bottomBarView viewControllerTitleDidChange:self];
        }
    }
}

- (void) networkDidBecomeAvailable {
}

- (void) networkDidBecomeUnavailable {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

	[self.view setNeedsLayout];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    FLLog(@"did rotate: %@", NSStringFromClass([self class]));

	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

	[self.view setNeedsLayout];
}

+ (void) setPresentingModalViewController:(FLViewController*) viewController {
#if DEBUG
    if(viewController) {
        FLAssertIsNil(s_presentingModalViewController);
    }
    else {
        FLAssertIsNotNil(s_presentingModalViewController);
    }
#endif
    s_presentingModalViewController= viewController;
}

+ (FLViewController*) presentingModalViewController {
	return s_presentingModalViewController;
}

+ (BOOL) isPresentingModalViewController {
	return [FLViewController presentingModalViewController] != nil;
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    [modalViewController willBePresentedModallyInViewController:self];
    [FLViewController setPresentingModalViewController:self];
	[super presentModalViewController:modalViewController animated:animated];
	[modalViewController wasPresentedModally:self];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	FLAssert([FLViewController presentingModalViewController] == self, @"dismissing with wrong view controller");
	
	FLAssertIsNotNil(self.modalViewController); 
	FLReturnAutoreleased(FLReturnRetained(self.modalViewController));
	
	[super dismissModalViewControllerAnimated:animated];
	[self.modalViewController wasDismissedFromModalPresentation:self];
	
    [FLViewController setPresentingModalViewController:nil];
}

- (void) setContentSizeForViewInPopover:(CGSize) size {
	[super setContentSizeForViewInPopover:size];
}

- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController {   
    [super willBePresentedModallyInViewController:superViewController];
    self.disableBackgroundTasks = YES;
}

@end

@implementation UIViewController (FLViewController)


- (UIViewController*) superViewController {
	return nil;
}

- (void) setSuperViewController:(UIViewController*) viewController {
}

- (void) willBePresentedModallyInViewController:(UIViewController*) superViewController {
}

- (void) wasPresentedModally:(UIViewController*) superViewController {
	self.superViewController = superViewController;
}

- (void) wasDismissedFromModalPresentation:(UIViewController*) superViewController {
	if(self.superViewController == superViewController)
	{
		self.superViewController = nil;
	}
}

- (FLNavigationControllerAnimation) navigationControllerCloseAnimation {
    return FLNavigationControllerAnimationDefault;
}

@end






