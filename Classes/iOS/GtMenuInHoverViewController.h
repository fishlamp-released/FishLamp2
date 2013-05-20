//
//	GtMenuViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/3/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtViewController.h"
#import "GtMenuView.h"
#import "UIColor+GtMoreColors.h"
#import "GtMenuItemView.h"
#import "GtHoverViewController.h"
#import "GtMenuViewController.h"

@class GtWidget;

#define GtMenuViewDeleteColor GtRgbColor(236,19,20,1.0)

@interface GtMenuInHoverViewController : GtMenuViewController<GtMenuViewDelegate, GtMenuItemViewDelegate> {
@private
    GtMenuInHoverViewController* m_parentController;
    GtMenuInHoverViewController* m_subMenu;
}

- (id) initWithTitle:(NSString*) title;

+ (GtMenuInHoverViewController*) menuViewController:(NSString*) title;

- (void) showFromView:(UIView*) view
	permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection;

- (void) showFromWidget:(GtWidget*) view
	permittedArrowDirection:(GtHoverViewControllerArrowDirection)arrowDirection;

@end

// NOTE: to add a submenu, create a GtMenuInHoverViewController and set it as the menuItemView.submenu object.