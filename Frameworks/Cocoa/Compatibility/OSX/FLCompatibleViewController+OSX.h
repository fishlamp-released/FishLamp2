//
//  FLCompatibleViewController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#if OSX

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

#define UIViewController    NSViewController
#define SDKViewController   NSViewController

@interface NSViewController (FLCompatibleViewController)

@property (readwrite, strong, nonatomic) NSArray *childViewControllers;
@property (readwrite, assign, nonatomic) NSViewController* parentViewController;

// this pretty much returns YES on OSX
@property (readwrite, assign, nonatomic, getter=isViewLoaded) BOOL viewLoaded;

- (void) addChildViewController:(NSViewController*) viewController;
- (void) removeFromParentViewController;
- (void) willMoveToParentViewController:(NSViewController *)parent;
- (void) didMoveToParentViewController:(NSViewController *)parent;

@end

@interface FLCompatibleViewController : NSViewController {
@private
    BOOL _viewLoaded;
    __unsafe_unretained NSViewController* _parentViewController;
    NSMutableArray* _childViewControllers;
}

- (void) viewDidLoad;
- (void) viewDidUnload;

- (void) viewWillLayoutSubviews;
- (void) viewDidLayoutSubviews;

- (void) viewWillDisappear:(BOOL) animated;
- (void) viewDidDisappear:(BOOL) animated;

- (void) viewWillAppear:(BOOL) animated;
- (void) viewDidAppear:(BOOL) animated;

- (void) didReceiveMemoryWarning;

- (void) viewControllerWillAppear;

@end



#endif