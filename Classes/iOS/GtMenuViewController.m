//
//  GtMenuViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuViewController.h"

@implementation GtMenuViewController

@synthesize menuView = m_menuView;

- (id) initWithTitle:(NSString*) title
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
        self.title = title;
        m_menuView = [[GtMenuView alloc] initWithFrame:CGRectMake(0,0,260, 40.0f)];

        m_menuView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        
        if(DeviceIsPad())
        {
            m_menuView.menuItemSize = CGSizeMake(256, 70);
        }
        else
        {
            m_menuView.menuItemSize = CGSizeMake(self.view.frame.size.width == 320 ? 320 : 220, 50);
        }
	}
	
	return self;
}

+ (GtMenuViewController*) menuViewController:(NSString*) title
{
    return GtReturnAutoreleased([[GtMenuViewController alloc] initWithTitle:title]);
}

- (void) dealloc
{
    [m_menuView clearDelegates];
    GtRelease(m_menuView);
    GtSuperDealloc();
}

- (void) updateLayout
{
    if(self.isViewLoaded)
    {
//        if(self.autoSetWidth)
//    {
//        self.frameOptimizedForSize = GtRectSetWidth(self.frame, [self optimalWidth]);
//    }

//        CGSize size = [m_menuView layoutSubviewsWithViewLayout];
//        self.frameOptimizedForLocation = GtRectSetSizeWithSize(self.frame, size);
    
        [m_menuView layoutSubviewsWithViewLayout];
        self.view.newFrame = GtRectSetSizeWithSize(self.view.frame, m_menuView.frame.size);
    }
}
//
//- (void) layoutMenuInFrame:(CGRect) frame layoutMode:(GtMenuViewControllerLayoutMode) layoutMode
//{
//    if(self.isViewLoaded)
//    {
//        m_menuView.menuTitle = self.title;
//        self.view.newFrame = GtRectSetSizeWithSize(self.view.frame, [m_menuView layoutSubviewsWithViewLayout]);
//
////        self.view.frameOptimizedForSize = GtRectSetSizeWithSize(self.view.frame, m_menuView.frame.size);
////        [self.hoverViewController setContentViewSize:self.view.frame.size animated:NO];
//    }
//}

//- (void) willBuildMenu
//{
//}

- (void) addMenuItem:(NSString*) name target:(id) target action:(SEL) action {
    // TODO: reimplement this
}

- (void) addMenuItem:(NSString*) name target:(id) target action:(SEL) action configureMenuItem:(void (^)(GtMenuItemView*)) configureMenuItemBlock{
    // TODO: reimplement this
}

- (void) showFromView:(UIView*) view permittedArrowDirection:(GtHoverViewControllerArrowDirection) direction {
    // TODO: reimplement this
}

- (void) addMenuItem:(NSString*) name submenu:(GtMenuViewController*) submenu {
    // TODO: reimplement this
}

- (void) addMenuItem:(NSString*) name submenu:(GtMenuViewController*) submenu  configureMenuItem:(void (^)(GtMenuItemView*)) configureMenuItemBlock{
    // TODO: reimplement this
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    m_menuView.frame = self.view.bounds;
    [self.view addSubview:m_menuView];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void) viewDidUnload
{   
    [super viewDidUnload];
    [m_menuView removeFromSuperview];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateLayout];
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [m_bottomSwipeView close];
//}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self updateLayout];
}



@end
