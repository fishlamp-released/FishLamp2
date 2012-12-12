//
//  FLDataProviderPhotoViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDataProviderPhotoViewController.h"
#import "FLDeprecatedButtonbarToolbar.h"
#import "SDKImage+Colorize.h"
#import "FLViewControllerStack.h"

@implementation FLDataProviderPhotoViewController

@synthesize dataModel = _dataProvider;

- (id) initWithDataModel:(id<FLPhotoViewControllerDataModel>) dataModel 
{
    if((self = [super init]))
    {
        _dataProvider = FLRetain(dataModel);
        self.photoViewControllerDelegate = _dataProvider;
    }
    
    return self;
}

- (void) dealloc
{
    FLRelease(_dataProvider);
    super_dealloc_();
}

- (void) closeSelf:(id) sender
{
    [self.viewControllerStack popViewControllerAnimated:YES];
}

- (void) createTopToolbar
{
    UIView* button = [FLDeprecatedButtonbarView createImageButtonByName:@"x.png" imageColor:FLImageColorBlack target:self action:@selector(closeSelf:)];
	[self.buttonbar addViewToLeftSide:button forKey:@"close" animated:NO];

    [super createTopToolbar];

    self.topToolbar = FLAutorelease([[FLDeprecatedButtonbarToolbar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44) buttonbarView:self.buttonbar]);
    [self.view addSubview:self.topToolbar];
    
}


@end


