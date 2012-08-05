//
//	FLTabBarController.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/29/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLViewController.h"
#import "FLNavigationController.h"
#import "FLMultiViewController.h"

@interface FLTabBarController : FLSelectableViewControllerMultiViewController<UITabBarDelegate /*, FLViewControllerTabBarDelegate*/> {
@private
	IBOutlet UITabBar* _tabBar;
	struct {
		unsigned int animateOnShow: 1;
	}_flags;
}
@property (readwrite, assign, nonatomic) BOOL animateOnShow;

@property (readonly, retain, nonatomic) UITabBar* tabBar;

- (void) didLoadTabBar:(UITabBar*) tabBar; // when creating manually, not with nib.

@end

@interface UITabBar (FLTabBarController) 
@property(readwrite, assign, nonatomic) NSUInteger selectedIndex;
- (NSUInteger) indexForTabBarItem:(UITabBarItem*) item;
- (UITabBarItem*) tabBarItemForIndex:(NSUInteger) idx;

- (void) updateBadge:(NSString*) badge forTabBarItem:(UITabBarItem*) item;

@end

@interface UIViewController (FLTabBarController)
- (void) willShowInTab:(NSUInteger) tab;
@end