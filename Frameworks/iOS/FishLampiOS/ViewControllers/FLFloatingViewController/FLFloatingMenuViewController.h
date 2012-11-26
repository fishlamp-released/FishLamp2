//
//	FLMenuViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/3/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLViewController.h"
#import "FLMenuView.h"
#import "FLColor+FLMoreColors.h"
#import "FLMenuItemView.h"
#import "FLFloatingViewController.h"
#import "FLMenuViewController.h"

@class FLWidget;

#define FLMenuViewDeleteColor FLRgbColor(236,19,20,1.0)

@interface FLFloatingMenuViewController : FLMenuViewController<FLMenuViewDelegate, FLMenuItemViewDelegate> {
@private
    FLFloatingMenuViewController* _parentController;
    FLFloatingMenuViewController* _subMenu;
}

- (id) initWithTitle:(NSString*) title;

+ (FLFloatingMenuViewController*) menuViewController:(NSString*) title;

- (void) showFromView:(UIView*) view
	permittedArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection;

- (void) showFromWidget:(FLWidget*) view
	permittedArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection;

@end

// NOTE: to add a submenu, create a FLFloatingMenuViewController and set it as the menuItemView.submenu object.