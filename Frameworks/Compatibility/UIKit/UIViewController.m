//
//  FLViewController.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "UIViewController.h"

@implementation NSViewController (UIKit)

- (void) addChildViewController:(NSViewController*) viewController {
}

- (BOOL) isViewLoaded {
    return self.view != nil; // always returns YES.
}

- (NSViewController*) parentViewController {
    return nil;
}

- (void) viewDidLoad {
}

- (void) viewDidUnload {
}

- (void) removeFromParentViewController {
}

- (void) viewDidLayoutSubviews {
}

- (void) viewWillDisappear:(BOOL) animated {
}

- (void) viewDidDisappear:(BOOL) animated {
}

- (void) viewWillAppear:(BOOL) animated {
}

- (void) viewDidAppear:(BOOL) animated {
}


@end
#endif

