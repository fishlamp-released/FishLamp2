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

@synthesize topToolbar = m_topToolbar;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    m_topToolbar = [[FLAsyncThumbnailToolBar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
    [self addButtonsToTopToolbar:m_topToolbar];
    [self.view addSubview:m_topToolbar];
}

- (void) viewDidUnload
{
    FLReleaseWithNil(m_topToolbar);
    [super viewDidUnload];
}

- (void) dealloc
{
    FLRelease(m_topToolbar);
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
