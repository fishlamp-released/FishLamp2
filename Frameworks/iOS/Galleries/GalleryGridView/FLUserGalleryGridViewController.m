//
//  FLUserGalleryGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLUserGalleryGridViewController.h"
#import "FLViewControllerStack.h"

@implementation FLUserGalleryGridViewController

@synthesize topToolbar = _topToolbar;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _topToolbar = [[FLAsyncThumbnailToolBar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
    [self addButtonsToTopToolbar:_topToolbar];
    [self.view addSubview:_topToolbar];
}

- (void) viewDidUnload
{
    FLReleaseWithNil(_topToolbar);
    [super viewDidUnload];
}

- (void) dealloc
{
    FLRelease(_topToolbar);
    FLSuperDealloc();
}

- (void) closeSelf:(id) sender
{
    [self.viewControllerStack popViewControllerAnimated:YES];
}

- (void) addButtonsToTopToolbar:(FLAsyncThumbnailToolBar*) topToolbar
{
   [topToolbar addButtonForKey:@"close" imageName:@"x.png" iconColor:FLIconColorGray target:self action:@selector(closeSelf:)];
}


@end
