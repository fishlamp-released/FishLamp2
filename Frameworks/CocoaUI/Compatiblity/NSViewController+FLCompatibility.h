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
- (void) addChildViewController:(NSViewController*) viewController;
- (BOOL) isViewLoaded;
- (void) viewDidLoad;
- (void) viewDidUnload;
- (void) removeFromParentViewController;
- (void) viewDidLayoutSubviews;

@property (readonly, assign, nonatomic) NSViewController* parentViewController;
@end
#endif