//
//  GtDataProviderPhotoViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDataProviderPhotoViewController.h"
#import "GtButtonbarToolbar.h"
#import "UIImage+GtColorize.h"
#import "GtViewControllerStack.h"

@implementation GtDataProviderPhotoViewController

@synthesize dataProvider = m_dataProvider;

- (id) initWithDataProvider:(id<GtPhotoViewControllerDataProvider>) dataProvider 
{
    if((self = [super init]))
    {
        m_dataProvider = GtRetain(dataProvider);
        self.photoViewControllerDelegate = m_dataProvider;
    }
    
    return self;
}

- (void) dealloc
{
    GtRelease(m_dataProvider);
    GtSuperDealloc();
}

- (void) closeSelf:(id) sender
{
    [self.viewControllerStack popViewControllerAnimated:YES];
}

- (void) createTopToolbar
{
    UIView* button = [GtButtonbarView createImageButtonByName:@"x.png" target:self action:@selector(closeSelf:)];
	[self.buttonbar addViewToLeftSide:button forKey:@"close" animated:NO];

    [super createTopToolbar];

    self.topToolbar = GtReturnAutoreleased([[GtButtonbarToolbar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44) buttonbarView:self.buttonbar]);
    [self.view addSubview:self.topToolbar];
    
}

@end

@implementation GtGridViewPhotoViewControllerSelectionHandler

- (GtDataProviderPhotoViewController*) createPhotoViewControllerInViewController:(GtGridViewController*) controller
{
    return nil;
}   

- (void) gridViewCellWasSelected:(GtGridViewCellController*) cell
{
    GtGridViewController* controller = cell.viewController;

    GtDataProviderPhotoViewController* newController = [self createPhotoViewControllerInViewController:controller];

    NSInteger photoIndex = [controller.cellCollection indexForKey:[cell.gridViewObject gridViewObjectID]];
    [newController setCurrentPhotoIndex:photoIndex animated:NO];
    
    GtAssertNotNil(controller.viewControllerStack);
    
    [controller.viewControllerStack pushViewController:newController];
}

@end

