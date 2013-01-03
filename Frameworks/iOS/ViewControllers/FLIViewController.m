//
//	FLViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLIViewController.h"
#import "FLAction.h"

#import "FLNavigationControllerViewController.h"
#import "FLFloatingViewController.h"
#import "FLNavigationController.h"
#import "FLGradientButton.h"
#import "FLReachableNetwork.h"
#import "FLBackgroundTaskMgr.h"
#import "FLGradientView.h"
#import "FLJob.h"
#import "FLDispatchQueues.h"

// TODO: there is a lot of coupling and old crusty code in here.

@interface FLiViewController ()
@end

@implementation FLiViewController 

@synthesize navigationControllerCloseAnimation = _navigationControllerCloseAnimation;
@synthesize operationContext = _operationContext;

@synthesize modalParentViewController = _modalParent;
@synthesize contentSizeForViewInFloatingView = _floatingViewContentSize;

static FLViewController* s_presentingModalViewController = nil;

@synthesize viewIsVisible = _viewIsVisible; 
@synthesize disableBackgroundTasks = _disableBackgroundTasks; 

+ (id) viewController {
	return FLAutorelease([[[self class] alloc] init]);
}

- (void) _networkReachabilityDidChange:(NSNotification*) notification {
    if([notification.object isReachable]) {
        [self networkDidBecomeAvailable];
    }
    else {
        [self networkDidBecomeUnavailable];
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

- (void) _appBecamedInactiveHandler:(id) sender {
    if(self.operationContext) {
        [self.operationContext cancelAllOperations];
    }
}

- (void) _appDidEnterForeground:(id) sender {
//    if(_operationContext && _operationContext.isActive) {
//        [self appDidEnterForeground];
//    }
}

- (void) _subscribeToEvents {
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_appBecamedInactiveHandler:)
			name: UIApplicationWillTerminateNotification
			object: [UIApplication sharedApplication]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_appBecamedInactiveHandler:)
			name: UIApplicationDidEnterBackgroundNotification
			object: [UIApplication sharedApplication]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_appDidEnterForeground:)
			name: UIApplicationWillEnterForegroundNotification
			object: [UIApplication sharedApplication]];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_networkReachabilityDidChange:)
                                                 name:FLReachabilityChangedNotification 
                                               object:[FLReachableNetwork instance]];

    [[FLBackgroundTaskMgr instance] addObserver:self];
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self _subscribeToEvents];
		self.wantsFullScreenLayout = YES;
        self.wantsApplyTheme = YES;
        _operationContext = [[FLOperationContext alloc] init];
        [_operationContext addObserver:self];
    }
	
	return self;
}

- (UIView*) createView {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	UIView* view = FLAutorelease([[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)]);
	view.backgroundColor = [UIColor blackColor];
	view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	view.autoresizesSubviews = YES;
    return view;
}

- (void) loadView {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	if(FLStringIsNotEmpty(self.nibName)) {
		[super loadView];
	}
	else {
        UIView* view = [self createView];
        _startSize = view.frame.size;
        self.view = view;
	}
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
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

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
  	[[FLBackgroundTaskMgr instance] removeObserver:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[_operationContext removeObserver:self];
    
#if FL_MRC
    [_didAppearCallbacks release];
	[_operationContext release];
    [super dealloc];
#endif
}


- (void) appDidEnterForeground {
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
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    
//    [self bringBarToFront:self.topBarView];
//    [self bringBarToFront:self.bottomBarView];
}
 
- (void) viewWillAppear:(BOOL) animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	[super viewWillAppear:animated];
    [self barWillAppear:self.topBarView];
    [self barWillAppear:self.bottomBarView];
 
	if(self.floatingViewController) {
		self.navigationController.navigationBar.frame = FLRectSetTop(self.navigationController.navigationBar.frame, 0.0);
	}
    
    [self applyThemeIfNeeded];

    if(self.operationContext) {
        [[FLApplication instance].operationContextManager activateContext:self.operationContext];
    }

#if TRACE
    FLLog(@"viewWillAppear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewDidAppear:(BOOL)animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	_viewIsVisible = YES;

    if(self.operationContext) {
        [[FLApplication instance].operationContextManager activateContext:self.operationContext];
    }
    
	[super viewDidAppear:animated];
   
	if(_didAppearCallbacks) {
		NSMutableArray* callbacks = _didAppearCallbacks;
		_didAppearCallbacks = nil;
		
		for(FLCallbackObject* cb in callbacks) {
			[cb invoke:self];
		}
		
		FLRelease(callbacks);
	}

#if TRACE
    FLLog(@"viewDidAppear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewWillDisappear:(BOOL) animated {

	[super viewWillDisappear:animated];

    if(self.operationContext) {
        [[FLApplication instance].operationContextManager deactivateContext:self.operationContext];
    }

#if TRACE
    FLLog(@"viewWillDisappear: %@", NSStringFromClass([self class]));
#endif    
}

- (void) viewDidDisappear:(BOOL)animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	_viewIsVisible = NO;
	[super viewDidDisappear:animated];

    if([self.topBarView respondsToSelector:@selector(viewControllerViewDidDisappear:)]) {
        [self.topBarView viewControllerViewDidDisappear:self];
    }
    if([self.bottomBarView respondsToSelector:@selector(viewControllerViewDidDisappear:)]) {
        [self.bottomBarView viewControllerViewDidDisappear:self];
    }

    if(self.operationContext) {
        [[FLApplication instance].operationContextManager deactivateContext:self.operationContext];
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
        FLAssertIsNil_(s_presentingModalViewController);
    }
    else {
        FLAssertIsNotNil_(s_presentingModalViewController);
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
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    [modalViewController willBePresentedModallyInViewController:self];
    [FLViewController setPresentingModalViewController:self];
	[super presentModalViewController:modalViewController animated:animated];
	[modalViewController wasPresentedModally:self];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
    FLAssert_v([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

	FLAssert_v([FLViewController presentingModalViewController] == self, @"dismissing with wrong view controller");
	
	FLAssertIsNotNil_(self.modalViewController); 
	FLAutorelease(FLReturnRetain(self.modalViewController));
	
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

- (FLOperationContext*) operationContext {
    return nil;
}

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

- (id<FLPromisedResult>) startAction:(FLAction*) action
             finisher:(FLFinisher*) finisher {
    
    return [action startActionInContext:self.operationContext completion:completion];
}

- (id<FLPromisedResult>) startOperation:(FLOperation*) operation
             finisher:(FLFinisher*) finisher {
    
    [self.operationContext addOperation:operation];

    return [[FLDispatchQueue instance] dispatchWorker:operation completion:completion];
}

@end






