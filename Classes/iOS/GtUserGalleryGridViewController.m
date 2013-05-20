//
//  GtUserGalleryGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserGalleryGridViewController.h"
#import "GtViewControllerStack.h"

@implementation GtUserGalleryGridViewController

@synthesize topToolbar = m_topToolbar;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    m_topToolbar = [[GtAsyncThumbnailToolBar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
    [self addButtonsToTopToolbar:m_topToolbar];
    [self.view addSubview:m_topToolbar];
}

- (void) viewDidUnload
{
    GtReleaseWithNil(m_topToolbar);
    [super viewDidUnload];
}

- (void) dealloc
{
    GtRelease(m_topToolbar);
    GtSuperDealloc();
}

- (void) closeSelf:(id) sender
{
    [self.viewControllerStack popViewControllerAnimated:YES];
}

- (void) addButtonsToTopToolbar:(GtAsyncThumbnailToolBar*) topToolbar
{
   [topToolbar addButtonForKey:@"close" imageName:@"x.png" iconColor:GtIconColorGray target:self action:@selector(closeSelf:)];
}


@end
