//
//  FLViewController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "UIKitRequired.h"

#if OSX
#import "UIView.h"
#define UIViewController NSViewController

@interface NSViewController (UIKit)

@property (readonly, assign, nonatomic) UIViewController* parentViewController;

- (void) addChildViewController:(UIViewController*) viewController;
- (BOOL) isViewLoaded;
- (void) viewDidLoad;
- (void) viewDidUnload;
- (void) removeFromParentViewController;
- (void) viewDidLayoutSubviews;

- (void) viewWillDisappear:(BOOL) animated;
- (void) viewDidDisappear:(BOOL) animated;

- (void) viewWillAppear:(BOOL) animated;
- (void) viewDidAppear:(BOOL) animated;

@end


#endif