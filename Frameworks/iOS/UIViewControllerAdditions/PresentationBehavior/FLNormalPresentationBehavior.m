//
//  FLNormalPresentationBehavior.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNormalPresentationBehavior.h"

@implementation FLNormalPresentationBehavior
FLSynthesizeSingleton(FLNormalPresentationBehavior);

// FLSingletonProperty(FLNormalPresentationBehavior);

+ (FLNormalPresentationBehavior*) normalPresentationBehavior
{
    return [self instance];
}

- (void) willPresentViewController:(UIViewController*) viewController
            inParentViewController:(UIViewController*) parentViewController
{
    [parentViewController addChildViewController:viewController];
    [parentViewController.view addSubview:viewController.view];
}

- (void) didDismissViewController:(UIViewController*) viewController
           fromParentViewController:(UIViewController*) parentViewController
{
    [[viewController view] removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void) didPresentViewController:(UIViewController*) viewController
           inParentViewController:(UIViewController*) parentViewController
{
}

- (void) willHideViewController:(UIViewController*) viewController
          fromParentViewController:(UIViewController*) parentViewController
{
}

- (BOOL) canAutoDismissDontUseThis
{
    return YES;
}

@end