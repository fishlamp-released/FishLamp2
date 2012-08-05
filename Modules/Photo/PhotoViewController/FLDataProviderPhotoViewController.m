//
//  FLDataProviderPhotoViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDataProviderPhotoViewController.h"
#import "FLButtonbarToolbar.h"
#import "UIImage+FLColorize.h"
#import "FLViewControllerStack.h"

@implementation FLDataProviderPhotoViewController

@synthesize dataProvider = m_dataProvider;

- (id) initWithDataProvider:(id<FLPhotoViewControllerDataProvider>) dataProvider 
{
    if((self = [super init]))
    {
        m_dataProvider = FLReturnRetained(dataProvider);
        self.photoViewControllerDelegate = m_dataProvider;
    }
    
    return self;
}

- (void) dealloc
{
    FLRelease(m_dataProvider);
    FLSuperDealloc();
}

- (void) closeSelf:(id) sender
{
    [self.viewControllerStack popViewControllerAnimated:YES];
}

- (void) createTopToolbar
{
    UIView* button = [FLButtonbarView createImageButtonByName:@"x.png" imageColor:FLImageColorBlack target:self action:@selector(closeSelf:)];
	[self.buttonbar addViewToLeftSide:button forKey:@"close" animated:NO];

    [super createTopToolbar];

    self.topToolbar = FLReturnAutoreleased([[FLButtonbarToolbar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44) buttonbarView:self.buttonbar]);
    [self.view addSubview:self.topToolbar];
    
}


@end


