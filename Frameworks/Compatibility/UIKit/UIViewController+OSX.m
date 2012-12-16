//
//  FLViewController.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "UIViewController+OSX.h"
#import "FLObjcRuntime.h"
#import "UIView+OSX_Internal.h"

@interface UIViewControllerState : NSObject {
@private
    NSMutableArray* _viewControllers;
    UIView* _view;
    __unsafe_unretained UIViewController* _parentViewController;
}
@property (readwrite, strong, nonatomic) UIView* view;
@property (readwrite, assign, nonatomic) UIViewController* parentViewController;
@property (readwrite, strong, nonatomic) NSMutableArray* viewControllers;

@end

@implementation UIViewControllerState

+ (id) viewControllerState {
    return FLAutorelease([[[self class] alloc] init]);
}

@synthesize parentViewController = _parentViewController;
@synthesize viewControllers = _viewControllers;
@synthesize view = _view;

#if FL_MRC
- (void) dealloc {
    [_view release];
    [_viewControllers release];
    [super dealloc];
}
#endif

@end

@implementation NSViewController (UIKit)

FLSynthesizeAssociatedProperty(retain_nonatomic, _stateObject, setStateObject, UIViewControllerState*)

- (UIViewControllerState*) stateObject {
    UIViewControllerState* state = self._stateObject;
    if(state) {
        return state;
    }
    
    self.stateObject = [UIViewControllerState viewControllerState];
    return self._stateObject;
}

- (UIViewController*) parentViewController {
    return self.stateObject.parentViewController;
}

- (void) setParentViewController:(UIViewController*) viewController {
    self.stateObject.parentViewController = viewController;
}

#pragma mark -- child view controllers

- (NSArray*) childViewControllers {
    return  self.stateObject.viewControllers;
}

- (NSMutableArray*) viewControllers {
    if(!self.stateObject.viewControllers) {
        self.stateObject.viewControllers = [NSMutableArray array];
    }
    
    return self.stateObject.viewControllers;
}

- (void) addChildViewController:(NSViewController*) viewController {
    [viewController removeFromParentViewController];
    
    [viewController willMoveToParentViewController:self];
    [self.viewControllers addObject:viewController];
    [viewController didMoveToParentViewController:self];
}

- (void) removeViewController:(UIViewController*) viewController {
    if(viewController.parentViewController == self) {
        [viewController willMoveToParentViewController:nil];
        
        [self.viewControllers removeObject:viewController];
        viewController.parentViewController = nil;

        [viewController didMoveToParentViewController:nil];
    }
}

- (void) removeFromParentViewController {
    if(self.parentViewController) {
        [self.parentViewController removeViewController:self];
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
}

#pragma mark -- view layout

- (void) viewDidLayoutSubviews {
}

- (void) viewWillLayoutSubviews {
}


#pragma mark -- view appear/disappear

- (void) viewWillDisappear:(BOOL) animated {
}

- (void) viewDidDisappear:(BOOL) animated {
}

- (void) viewWillAppear:(BOOL) animated {
}

- (void) viewDidAppear:(BOOL) animated {
}

#pragma mark -- loading

- (BOOL) isViewLoaded {
    return self.stateObject.view != nil;
}

- (void) viewDidLoad {
}

- (void) viewDidUnload {
}

- (void) viewWillUnload {
}
- (void) setViewUnloaded {
    if(self.stateObject.view) {
        [self viewWillUnload];
        self.stateObject.view.viewController = nil;
        self.stateObject.view = nil;
        
        [self viewDidUnload];
    }
}

- (void)didReceiveMemoryWarning {

}

- (void) setViewLoaded {
    UIView* theView = self.view;
    if(theView) {
        self.stateObject.view = theView;
        theView.viewController = self;
        [self viewDidLoad];
    }
}

#pragma mark -- transitions

- (UIViewController*) presentedViewController {
    return nil;
}

- (UIViewController*) presentingViewController {
    return nil;
}

- (BOOL)isBeingPresented {
    return NO;
}

- (BOOL)isBeingDismissed {
    return NO;
}

- (BOOL)isMovingToParentViewController {
    return NO;
}

- (BOOL)isMovingFromParentViewController {
    return NO;
}

- (void)transitionFromViewController:(UIViewController *)fromViewController
                    toViewController:(UIViewController *)toViewController
                            duration:(NSTimeInterval)duration
                             options:(UIViewAnimationOptions)options
                          animations:(void (^)(void))animations
                          completion:(void (^)(BOOL finished))completion {
    
}

- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated {

}

- (void)endAppearanceTransition {
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^)(void))completion {
    
}

- (void)hideViewController:(BOOL)flag
                           completion: (void (^)(void))completion {
    
}



#pragma mark -- swizzled for compatibility

- (void) compatibleSetView:(NSView*) aView {
    
    [self setViewUnloaded];
    [self setView:aView];
    [self setViewLoaded];
}

- (void) compatibleLoadView {
    [self setViewUnloaded];
    [self loadView];
    [self setViewLoaded];
}

+ (void) initUIKitCompatibility {
    FLSelectorSwizzle([UIViewController class], @selector(compatibleLoadView), @selector(loadView));
    FLSelectorSwizzle([UIViewController class], @selector(compatibleSetView:), @selector(setView:));
}


@end
#endif

