//
//	GtMenuViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/3/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuInHoverViewController.h"
#import "GtNavigationControllerViewController.h"
#import "GtGradientButton.h"
#import "GtButtonCell.h"
#import "UIImage+GtColorize.h"
#import "GtViewLayout.h"
#import "GtGradientView.h"

#import "GtMenuItemView.h"

#import "GtHoverViewController.h"

#import "GtApplicationDelegate.h"

@implementation GtMenuInHoverViewController

GtAssertDefaultInitNotCalled();

- (id) initWithTitle:(NSString*) title
{
	if((self = [super initWithTitle:title]))
	{
        self.title = title;
        self.menuView.frame = CGRectMake(0,0,260, 40.0f);
        self.menuView.delegate = self;
	}
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_parentController);
    GtRelease(m_subMenu);
    GtSuperDealloc();
}

- (void) showFromView:(UIView*) view
	permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection
{
    GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:self];
    [hoverView presentInViewController:[GtHoverViewController defaultParentViewController]
        permittedArrowDirection:arrowDirection
        fromPositionProvider:view
        style:GtHoverViewStyleNormal
        animated:YES];        
}

- (void) showFromWidget:(GtWidget*) view
	permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection
{
    GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:self];
    [hoverView presentInViewController:[GtHoverViewController defaultParentViewController]
        permittedArrowDirection:arrowDirection
        fromPositionProvider:view
        style:GtHoverViewStyleNormal
        animated:YES];  
}

+ (GtMenuInHoverViewController*) menuViewController:(NSString*) title
{
	return GtReturnAutoreleased([[GtMenuInHoverViewController alloc] initWithTitle:title]);
}

//- (void) menuViewDidResize:(GtMenuView*) view
//{
//    if(self.isViewLoaded)
//    {
//        self.view.newFrame = GtRectSetSizeWithSize(self.view.frame, view.frame.size);
//        [self.hoverViewController setContentViewSize:self.view.frame.size animated:NO];
//    }
//}

- (void) setParentController:(GtMenuInHoverViewController*) controller
{
    GtAssignObject(m_parentController, controller);
}

- (void) _dimissSubmenu
{
    if(m_subMenu)
    {
        [m_subMenu setParentController:nil];
        self.hoverViewController.childHoverViewController = nil;
        [m_subMenu.hoverViewController dismissHoverViewAnimated:YES];
        GtReleaseWithNil(m_subMenu);
    }
}

- (void) _showSubmenu:(GtMenuItemView*) menuItem
{
    if(m_subMenu != menuItem.subMenu)
    {
        [self _dimissSubmenu];
        
        GtAssignObject(m_subMenu, menuItem.subMenu);
        
        if(menuItem.subMenu)
        {
            [menuItem.subMenu setParentController:self];

            GtHoverViewController* child = [GtHoverViewController hoverViewController:menuItem.subMenu];
            [child presentInViewController:[GtHoverViewController defaultParentViewController]
                permittedArrowDirection:GtHoverViewControllerArrowDirectionRight
                fromPositionProvider:menuItem.disclosureArrowView
                style:GtHoverViewStyleNormal
                animated:YES];  
                                                        
            self.hoverViewController.childHoverViewController = child;
        }
    }
}

- (void) _toggleSubmenu:(GtMenuItemView*) menuItem
{
    if(menuItem.subMenu)
    {
        if(menuItem.subMenu == m_subMenu)
        {
            [self _dimissSubmenu];
        }
        else
        {
            [self _showSubmenu:menuItem];
        }   
    }
    else
    {
        if(m_subMenu)
        {
            [self _dimissSubmenu];
        }
    }
}

- (void) menuItemViewFinishedSelectAnimation:(GtMenuItemView*) menuItem
{
    GtReturnAutoreleased(GtRetain(self));
    
    if(m_parentController)
    {
        [m_parentController dismissViewControllerAnimated:YES];
        GtReleaseWithNil(m_parentController);
    }
    else
    {
        [self dismissViewControllerAnimated:YES];
    }
    
    menuItem.highlighted = NO;
    GtInvokeCallback(menuItem.callback, menuItem);
}

- (void) menuItemView:(GtMenuItemView*) menuItem touchesEnded:(BOOL) wasSelected
{
    if(menuItem.subMenu)
    {
        if(wasSelected)
        {
            [self _showSubmenu:menuItem];
        }
    }
    else
    {
        if(wasSelected)
        {
            [menuItem beginSelectedAnimation];
        }
        else
        {
            menuItem.highlighted = NO;
        }
    }
}

- (void) menuItemView:(GtMenuItemView*) menuItem touchesMoved:(BOOL) touchIsInside
{
    menuItem.highlighted = touchIsInside;

    if(touchIsInside)
    {
        [self _showSubmenu:menuItem];
    }
}

- (void)menuViewTouchesBegan:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_subMenu)
    {
        [m_subMenu.menuView touchesBegan:touches withEvent:event]; 
    }
}

- (void)menuViewTouchesMoved:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_subMenu)
    {
        [m_subMenu.menuView touchesMoved:touches withEvent:event]; 
    }
}

- (void)menuViewTouchesEnded:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_subMenu)
    {
        [m_subMenu.menuView touchesEnded:touches withEvent:event]; 
    }
}

- (void)menuViewTouchesCancelled:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_subMenu)
    {
        [m_subMenu.menuView touchesCancelled:touches withEvent:event]; 
    }
}

- (void) menuItemViewTouchesCancelled:(GtMenuItemView*) view
{
    view.highlighted = NO;
}
   
//- (void) _updateMenuSize
//{
//    if(self.isViewLoaded)
//    {
//        self.menuView.menuTitle = self.title;
//        
//        CGRect frame = self.view.frame;
//        frame.size = [self.menuView layoutSubviewsWithViewLayout];
//        self.view.newFrame = frame;
//
//        self.contentSizeForViewInHoverView = frame.size;
//    }
//}

- (void) updateLayout
{
    if(self.isViewLoaded)
    {
        self.view.frameOptimizedForLocation = GtRectSetWidth(self.view.frame, [self.menuView findOptimalWidth]); 
        [self.menuView layoutSubviewsWithViewLayout];
        self.view.frameOptimizedForLocation = GtRectSetSizeWithSize(self.view.frame, self.menuView.frame.size);
        self.contentSizeForViewInHoverView = self.view.frame.size;
    }
}

- (void) willShowInHoverViewController:(GtHoverViewController*) controller
{
    [self updateLayout];
    [self willShowInHoverViewController:controller];
}


- (void) didShowInHoverViewController:(GtHoverViewController*) controller
{
    [self updateLayout];
    [super didShowInHoverViewController:controller];
}

//- (void) viewDidLoad
//{
//	[super viewDidLoad];
//    [self _updateMenuSize];
////    [self willBuildMenu];
//}

//- (GtViewContentsDescriptor) describeViewContents
//{
//	GtViewContentsDescriptor contents = [super describeViewContents];
//	if(GtStringIsEmpty(self.title))
//	{
//		contents.top = GtBitClear(contents.top, GtViewContentItemNavigationBar);
//	}
//	return contents;
//}


@end



