//
//  NSViewController+FLCompatibility.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX

#import <Cocoa/Cocoa.h>
@interface NSViewController (FLCompatibility)

@property (readonly, assign, nonatomic) NSViewController* parentViewController;

- (void) addChildViewController:(NSViewController*) viewController;
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