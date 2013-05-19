//
//	FLMenuViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/3/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFloatingMenuViewController.h"
#import "FLNavigationControllerViewController.h"
#import "FLGradientButton.h"
#import "FLButtonCell.h"
#import "UIImage+Colorize.h"
#import "FLArrangement.h"
#import "FLGradientView.h"

#import "FLMenuItemView.h"

#import "FLFloatingViewController.h"

#import "FLApplicationDelegate.h"



@implementation FLFloatingMenuViewController

FLAssertDefaultInitNotCalled();

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
    FLRelease(_parentController);
    FLRelease(_subMenu);
    FLSuperDealloc();
}

- (void) showFromView:(UIView*) view
	permittedArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection
{
    [[UIApplication visibleViewController] presentFloatingViewController:self 
                                                 permittedArrowDirection:arrowDirection 
                                                    fromPositionProvider:view
                                                            withBehavior:[UIViewController defaultPresentationBehavior]
                                                           withAnimation:[self transitionAnimation]];

}

- (void) showFromWidget:(FLWidget*) widget
	permittedArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection
{
    [[UIApplication visibleViewController] presentFloatingViewController:self 
                                                 permittedArrowDirection:arrowDirection 
                                                    fromPositionProvider:widget
                                                            withBehavior:[UIViewController defaultPresentationBehavior]
                                                           withAnimation:[self transitionAnimation]];
}

+ (FLFloatingMenuViewController*) menuViewController:(NSString*) title
{
	return FLAutorelease([[FLFloatingMenuViewController alloc] initWithTitle:title]);
}

//- (void) menuViewDidResize:(FLMenuView*) view
//{
//    if(self.isViewLoaded)
//    {
//        self.view.newFrame = FLRectSetSizeWithSize(self.view.frame, view.frame.size);
//        [self.floatingViewController setContentViewSize:self.view.frame.size animated:NO];
//    }
//}

- (void) setParentController:(FLFloatingMenuViewController*) controller
{
    FLSetObjectWithRetain(_parentController, controller);
}

- (void) _dimissSubmenu
{
    if(_subMenu)
    {
        [_subMenu setParentController:nil];
        self.floatingViewController.childFloatingViewController = nil;
        [_subMenu.floatingViewController hideViewController:YES];
        FLReleaseWithNil(_subMenu);
    }
}

- (void) _showSubmenu:(FLMenuItemView*) menuItem
{
    if(_subMenu != menuItem.subMenu)
    {
        [self _dimissSubmenu];
        
        FLSetObjectWithRetain(_subMenu, menuItem.subMenu);
        
        if(menuItem.subMenu)
        {
            [menuItem.subMenu setParentController:self];

            self.floatingViewController.childFloatingViewController = 
                    [self presentFloatingViewController:menuItem.subMenu 
                                                 permittedArrowDirection:FLFloatingViewControllerArrowDirectionRight 
                                                    fromPositionProvider:menuItem.disclosureArrowView
                                                            withBehavior:[UIViewController defaultPresentationBehavior]
                                                           withAnimation:[self transitionAnimation]];
        }
    }
}

- (void) _toggleSubmenu:(FLMenuItemView*) menuItem
{
    if(menuItem.subMenu)
    {
        if(menuItem.subMenu == _subMenu)
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
        if(_subMenu)
        {
            [self _dimissSubmenu];
        }
    }
}

- (void) menuItemViewFinishedSelectAnimation:(FLMenuItemView*) menuItem
{
    FLAutorelease(FLRetain(self));
    
    if(_parentController)
    {
        [_parentController hideViewController:YES];
        FLReleaseWithNil(_parentController);
    }
    else
    {
        [self hideViewController:YES];
    }
    
    menuItem.highlighted = NO;
    FLInvokeCallback(menuItem.callback, menuItem);
}

- (void) menuItemView:(FLMenuItemView*) menuItem touchesEnded:(BOOL) wasSelected
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

- (void) menuItemView:(FLMenuItemView*) menuItem touchesMoved:(BOOL) touchIsInside
{
    menuItem.highlighted = touchIsInside;

    if(touchIsInside)
    {
        [self _showSubmenu:menuItem];
    }
}

- (void)menuViewTouchesBegan:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_subMenu)
    {
        [_subMenu.menuView touchesBegan:touches withEvent:event]; 
    }
}

- (void)menuViewTouchesMoved:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_subMenu)
    {
        [_subMenu.menuView touchesMoved:touches withEvent:event]; 
    }
}

- (void)menuViewTouchesEnded:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_subMenu)
    {
        [_subMenu.menuView touchesEnded:touches withEvent:event]; 
    }
}

- (void)menuViewTouchesCancelled:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_subMenu)
    {
        [_subMenu.menuView touchesCancelled:touches withEvent:event]; 
    }
}

- (void) menuItemViewTouchesCancelled:(FLMenuItemView*) view
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
//        frame.size = [self.menuView layoutSubviewsWithArrangement];
//        self.view.newFrame = frame;
//
//        self.contentSizeForViewInFloatingView = frame.size;
//    }
//}

- (void) updateLayout
{
    if(self.isViewLoaded)
    {
        self.view.frameOptimizedForLocation = FLRectSetWidth(self.view.frame, [self.menuView findOptimalWidth]); 
        [self.menuView layoutSubviewsWithArrangement:self.menuView.arrangement
                                      adjustViewSize:YES];

        self.view.frameOptimizedForLocation = FLRectSetSizeWithSize(self.view.frame, self.menuView.frame.size);

        self.contentSizeForViewInFloatingView = self.view.frame.size;
    }
}

//- (void) willShowInFloatingViewController:(FLFloatingViewController*) controller
//{
//    [self updateLayout];
//    [self willShowInFloatingViewController:controller];
//}
//
//
//- (void) didShowInFloatingViewController:(FLFloatingViewController*) controller
//{
//    [self updateLayout];
//    [super didShowInFloatingViewController:controller];
//}




@end



