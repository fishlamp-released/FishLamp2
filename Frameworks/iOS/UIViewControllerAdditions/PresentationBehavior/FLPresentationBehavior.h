//
//  FLViewControllerPresentationLayer.h
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/12/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCore.h"

@protocol FLPresentationBehavior <NSObject>

// TODO: remove this. This is a hack used by floating view controller. Floating
// should actually be a presentation behavior itself. When it is, remove this flag.
@property (readonly, assign, nonatomic) BOOL canAutoDismissDontUseThis;

- (void) willPresentViewController:(UIViewController*) viewController
            inParentViewController:(UIViewController*) parentViewController;

- (void) didPresentViewController:(UIViewController*) viewController
           inParentViewController:(UIViewController*) parentViewController;

- (void) willDismissViewController:(UIViewController*) viewController
          fromParentViewController:(UIViewController*) parentViewController;

- (void) didDismissViewController:(UIViewController*) viewController
         fromParentViewController:(UIViewController*) parentViewController;

@end





