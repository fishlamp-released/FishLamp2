//
//	GtTabBarController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/29/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtViewController.h"
#import "GtNavigationController.h"
#import "GtMultiViewController.h"

@interface GtTabBarController : GtSelectableViewControllerMultiViewController<UITabBarDelegate /*, GtViewControllerTabBarDelegate*/> {
@private
	IBOutlet UITabBar* m_tabBar;
	struct {
		unsigned int animateOnShow: 1;
	}m_flags;
}
@property (readwrite, assign, nonatomic) BOOL animateOnShow;

@property (readonly, retain, nonatomic) UITabBar* tabBar;

- (void) didLoadTabBar:(UITabBar*) tabBar; // when creating manually, not with nib.

@end

@interface UITabBar (GtTabBarController) 
@property(readwrite, assign, nonatomic) NSUInteger selectedIndex;
- (NSUInteger) indexForTabBarItem:(UITabBarItem*) item;
- (UITabBarItem*) tabBarItemForIndex:(NSUInteger) idx;

- (void) updateBadge:(NSString*) badge forTabBarItem:(UITabBarItem*) item;

@end

@interface UIViewController (GtTabBarController)
- (void) willShowInTab:(NSUInteger) tab;
@end