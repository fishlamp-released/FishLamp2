//
//  FLViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLViewController.h"


@interface FLViewController ()
#if OSX
//@property (readwrite, assign, nonatomic) NSArray *childViewControllers;
//@property (readwrite, assign, nonatomic) UIViewController* parentViewController;
//@property (readwrite, assign, nonatomic, getter=isViewLoaded) BOOL viewLoaded;
#endif

@end

@implementation FLViewController

#if OSX
@synthesize parentViewController = _parentViewController;
@synthesize childViewControllers = _childViewControllers;
@synthesize viewLoaded = _viewLoaded;

- (void) didLoadViewForCompatibility:(NSView*) view {
}

- (void) didUnloadViewForCompatibility:(NSView *)view {
}

+ (void) load {
//    [NSViewController initUIKitCompatibility];
}
#endif

@end


