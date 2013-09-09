//
//  FLMenuViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMenuViewController.h"


@implementation FLMenuViewController

@synthesize menuView = _menuView;

- (id) initWithTitle:(NSString*) title
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
        self.title = title;
        _menuView = [[FLMenuView alloc] initWithFrame:CGRectMake(0,0,260, 40.0f)];

        _menuView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        
        if(DeviceIsPad())
        {
            _menuView.menuItemSize = CGSizeMake(256, 70);
        }
        else
        {
            _menuView.menuItemSize = CGSizeMake(self.view.frame.size.width >= 320.0 ? 320 : 220, 50);
        }
	}
	
	return self;
}

+ (FLMenuViewController*) menuViewController:(NSString*) title
{
    return FLAutorelease([[FLMenuViewController alloc] initWithTitle:title]);
}

- (void) dealloc
{
    [_menuView clearDelegates];
    FLRelease(_menuView);
    FLSuperDealloc();
}

- (void) updateLayout
{
    if(self.isViewLoaded)
    {
//        if(self.autoSetWidth)
//    {
//        self.frameOptimizedForSize = FLRectSetWidth(self.frame, [self optimalWidth]);
//    }

//        CGSize size = [_menuView layoutSubviewsWithArrangement];
//        self.frameOptimizedForLocation = FLRectSetSizeWithSize(self.frame, size);
    
        [_menuView layoutSubviewsWithArrangement:_menuView.arrangement
                                  adjustViewSize:YES];

        self.view.newFrame = FLRectSetSizeWithSize(self.view.frame, _menuView.frame.size);
    }
}
//
//- (void) layoutMenuInFrame:(CGRect) frame contentMode:(FLMenuViewControllerLayoutMode) contentMode
//{
//    if(self.isViewLoaded)
//    {
//        _menuView.menuTitle = self.title;
//        self.view.newFrame = FLRectSetSizeWithSize(self.view.frame, [_menuView layoutSubviewsWithArrangement]);
//
////        self.view.frameOptimizedForSize = FLRectSetSizeWithSize(self.view.frame, _menuView.frame.size);
////        [self.floatingViewController setContentViewSize:self.view.frame.size animated:NO];
//    }
//}

//- (void) willBuildMenu
//{
//}

-(void) viewDidLoad
{
    [super viewDidLoad];
    _menuView.frame = self.view.bounds;
    [self.view addSubview:_menuView];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void) viewDidUnload
{   
    [super viewDidUnload];
    [_menuView removeFromSuperview];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateLayout];
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [_bottomSwipeView close];
//}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self updateLayout];
}



@end
