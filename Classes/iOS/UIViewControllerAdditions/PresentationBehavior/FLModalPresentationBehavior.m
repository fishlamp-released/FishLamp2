//
//  FLModalPresentationBehavior.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLModalPresentationBehavior.h"
#import "_FLModalPresentationBehavior.h"

#import "FLModalShieldViewController.h"

@implementation FLModalPresentationBehavior
    
FLSynthesizeSingleton(FLModalPresentationBehavior);
    
- (void) addShadow:(UIColor*) color 
            toView:(UIView*) view
{
	view.layer.shadowColor = color.CGColor;
	view.layer.shadowOpacity = .8;
	view.layer.shadowRadius = 20.0;
	view.layer.shadowOffset = CGSizeMake(0,5);
    view.clipsToBounds = NO;
}

- (void) dealloc
{
    FLRelease(_shieldViewController);
    FLSuperDealloc();
}
    
- (BOOL) canAutoDismissDontUseThis
{
    return NO;
}

- (UIViewController*) createShieldViewController
{
    return FLAutorelease([[FLModalShieldViewController alloc] init]);
}

- (void) willPresentViewController:(UIViewController*) viewController
            inParentViewController:(UIViewController*) parentViewController
{
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"not in main thread");

    if(!_shieldViewController) {
        _shieldViewController = [self createShieldViewController];
        mrc_retain_(_shieldViewController);
        [parentViewController addChildViewController:_shieldViewController];
        [parentViewController.view addSubview:_shieldViewController.view];
        _shieldViewController.view.frame = parentViewController.view.frame;
    }

    // TODO: correct parent view controller in all cases here?

    [_shieldViewController addChildViewController:viewController];
    [_shieldViewController.view addSubview:viewController.view];

    FLAssertIsFixedWithComment(@"needs to be themed");
    [self addShadow:[UIColor grayColor] toView:viewController.view];
}

- (void) didPresentViewController:(UIViewController*) viewController
           inParentViewController:(UIViewController*) parentViewController
{
}

- (void) willHideViewController:(UIViewController*) viewController
          fromParentViewController:(UIViewController*) parentViewController
{
    FLAssertWithComment(parentViewController == _shieldViewController, @"expecting parent to be shield view");

    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"not in main thread");

    mrc_retain_(viewController);
    [[viewController view] removeFromSuperview];
    [viewController removeFromParentViewController];
    FLAutorelease(viewController);

    if([_shieldViewController view].subviews.count == 0) {
        [[_shieldViewController view] removeFromSuperview];
        [_shieldViewController removeFromParentViewController];
        FLReleaseWithNil(_shieldViewController);
    }
}

- (void) didDismissViewController:(UIViewController*) viewController
         fromParentViewController:(UIViewController*) parentViewController {
}


@end
