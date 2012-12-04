//
//  FLAbstractAlertViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAutoPositionedViewController.h"

// default contentMode is centered.

@interface FLDialog : FLAutoPositionedViewController {
@private
    UIViewController* _contentViewController;
}

@property (readonly, strong, nonatomic) UIViewController* contentViewController;

- (id) initWithViewController:(UIViewController*) viewController;

+ (id) dialog:(UIViewController*) viewController;

@end

@interface UIViewController (FLDialog)
- (void) viewWillAppearInDialog:(FLDialog*) dialog;
- (void) viewDidAppearInDialog:(FLDialog*) dialog;
- (void) viewDidLoadInDialog:(FLDialog*) dialog;
@end