//
//  UIViewController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

#import "UIView+OSX.h"

#define UIViewController NSViewController
#define FLCompatibleViewController NSViewController

@protocol UIViewControllerCompatibility <NSObject>
@property (readwrite, strong, nonatomic) NSArray *childViewControllers;
@property (readwrite, assign, nonatomic) UIViewController* parentViewController;
@property (readwrite, assign, nonatomic, getter=isViewLoaded) BOOL viewLoaded;

- (void) didLoadViewForCompatibility:(NSView*) view;
- (void) didUnloadViewForCompatibility:(NSView*) view;
@end

@interface NSViewController (UIKit)

@property(nonatomic,readonly) NSArray *childViewControllers;
@property(readonly, assign, nonatomic) UIViewController* parentViewController;

- (void) addChildViewController:(UIViewController*) viewController;
- (void) removeFromParentViewController;
- (void) willMoveToParentViewController:(UIViewController *)parent;
- (void) didMoveToParentViewController:(UIViewController *)parent;

- (BOOL) isViewLoaded;
- (void) viewDidLoad;
- (void) viewDidUnload;

- (void) viewWillLayoutSubviews;
- (void) viewDidLayoutSubviews;

- (void) viewWillDisappear:(BOOL) animated;
- (void) viewDidDisappear:(BOOL) animated;

- (void) viewWillAppear:(BOOL) animated;
- (void) viewDidAppear:(BOOL) animated;

//@property(readonly, assign, nonatomic) UIViewController* presentedViewController;
//@property(readonly, assign, nonatomic) UIViewController* presentingViewController;
//@property(nonatomic,assign) BOOL definesPresentationContext;
//@property(nonatomic,assign) BOOL providesPresentationContextTransitionStyle;
//- (BOOL)isBeingPresented;
//- (BOOL)isBeingDismissed;
//- (BOOL)isMovingToParentViewController;
//- (BOOL)isMovingFromParentViewController;
//
//- (void)presentViewController:(UIViewController *)viewControllerToPresent
//                     animated:(BOOL)flag
//                   completion:(void (^)(void))completion;
//
//- (void)hideViewController:(BOOL)flag
//                           completion: (void (^)(void))completion;
//
//- (void)transitionFromViewController:(UIViewController *)fromViewController
//                    toViewController:(UIViewController *)toViewController
//                            duration:(NSTimeInterval)duration
//                             options:(UIViewAnimationOptions)options
//                          animations:(void (^)(void))animations
//                          completion:(void (^)(BOOL finished))completion;
//
//- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated;
//
//- (void)endAppearanceTransition;

- (void)didReceiveMemoryWarning;

+ (void) initUIKitCompatibility;

@end


#endif

