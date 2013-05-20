//
//	GtTabBarController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/29/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTabBarController.h"

@implementation GtTabBarController

@synthesize tabBar = m_tabBar;

GtSynthesizeStructProperty(animateOnShow, setAnimateOnShow, BOOL, m_flags);

- (void) didLoadTabBar:(UITabBar*) tabBar
{
}

- (void) loadTabBar
{
	GtAssertNil(m_tabBar);

	m_tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,49)];
	m_tabBar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
	m_tabBar.frame = GtRectJustifyRectInRectBottom(self.view.bounds, m_tabBar.frame);
	m_tabBar.delegate = self;

	[self didLoadTabBar:m_tabBar];
	
//	if(self.selectedIndex == NSIntegerMax)
//	{
//		self.selectedIndex = 0;
//	}
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if(!m_tabBar)
	{
		[self loadTabBar];
	}
}	

- (BOOL) viewControllerIsSelectedInTabBar:(GtViewController*) viewController
{
    return NO; // [self viewControllerIsVisible:viewController];
}

- (void) willBePushedOnNavigationController:(UINavigationController *)controller
{
	[super willBePushedOnNavigationController:controller];
	self.title = controller.title;
}

- (void) dealloc
{	
//    for(id controller in self.viewControllers)
//	{
//		if([controller isKindOfClass:[GtViewController class]])
//		{
//			[controller setTabBarDelegate:nil];
//		}
//	}

	GtRelease(m_tabBar);
	GtSuperDealloc();
}

- (UITabBar*) tabBar
{
	if(!m_tabBar)
	{
		[self loadTabBar];
		GtAssertNotNil(m_tabBar);
	}
	
	return m_tabBar;
}

- (void) viewControllerUpdateTabBar:(GtViewController*) viewController
{
//	if(viewController == self.selectedViewController)
//	{
//		GtAssertNotNil(self.selectedViewController);
//
//		if( self.tabBar.superview == nil ||
//            self.tabBar.superview != self.selectedViewController.view)
//		{
//			if(m_tabBar.superview)
//			{
//				[m_tabBar removeFromSuperview];
//			}
//			
//#if TRACE
//            GtLog(@"added tabBar to %@", NSStringFromClass([viewController class]));
//#endif
//            
//			[self.selectedViewController.view addSubview:m_tabBar];
//			m_tabBar.frame = GtRectSetWidth(GtRectJustifyRectInRectBottom(self.selectedViewController.view.bounds, m_tabBar.frame), self.selectedViewController.view.frame.size.width);
//		}
//		
//		self.tabBar.selectedItem = [self.tabBar tabBarItemForIndex:self.selectedIndex];
//		[self.selectedViewController.view bringSubviewToFront:m_tabBar];
//	}
}

- (UITabBar*) viewControllerGetTabBar:(GtViewController*) viewController
{
	return self.tabBar;
}

- (BOOL) viewControllerHasTabBar:(GtViewController*) viewController
{
	return YES;
}

- (void) _tabBarDismissEvent:(id) sender
{
	[self.navigationController popToViewController:[self.navigationController parentControllerForController:self] animated:YES];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	GtAssertNotNil(m_tabBar);
	GtAssert(m_tabBar == tabBar, @"different tabBar?");

	NSUInteger idx = [m_tabBar indexForTabBarItem:item];
	
	GtAssert(idx >= 0 && idx < tabBar.items.count, @"didn't find item");

	if(idx != NSNotFound)
	{
        [self setSelectedIndex:idx animate:NO];
	}
}

- (void) didSelectViewController:(GtViewController*) viewController animate:(BOOL) animate
{
//    [self.selectedViewController willShowInTab:self.selectedIndex];
//	[self.navigationController pushViewController:self.selectedViewController animated:self.animateOnShow];
//	self.animateOnShow = NO;
//    
////    ((GtViewController*)self.selectedViewController).tabBarDelegate = self;
//    viewController.dismissEvent = GtCallbackMake(self, @selector(_tabBarDismissEvent:));
//	[super didSelectViewController:viewController animate:animate];
}

- (void) didUnselectViewController:(GtViewController *)viewController animate:(BOOL) animate
{
//    [self.navigationController popViewControllerAnimated:NO];
//    [super didUnselectViewController:viewController animate:animate];
}

- (void) didUnloadViewController:(GtViewController*) viewController
{
//    [viewController setTabBarDelegate:nil];
}

@end

@implementation UITabBar (GtTabBarController) 

- (NSUInteger) selectedIndex
{
	return [self indexForTabBarItem:self.selectedItem];
}	

- (void) setSelectedIndex:(NSUInteger) selectedIndex
{
	self.selectedItem = [self.items objectAtIndex:selectedIndex];
}

- (NSUInteger) indexForTabBarItem:(UITabBarItem*) itemToCheck
{
	NSInteger idx = 0;
	for(UITabBarItem* item in self.items)
	{
		if(itemToCheck == item)
		{
			return idx;
		}
		++idx;
	}

	return NSNotFound;
}

- (UITabBarItem*) tabBarItemForIndex:(NSUInteger) idx
{
	return [self.items objectAtIndex:idx];
}

- (void) updateBadge:(NSString*) badge forTabBarItem:(UITabBarItem*) item
{
// hand waving required to set badge on unselected item.
	NSArray* items = GtReturnAutoreleased(GtRetain(self.items));
	UITabBarItem* selectedItem = self.selectedItem;
	self.items = nil;
	if(GtStringIsNotEmpty(badge))
	{
		item.badgeValue = badge;
	}
	else
	{
		item.badgeValue = nil;
	}
	self.items = items;
	self.selectedItem = selectedItem;
}

@end

@implementation UIViewController (GtTabBarController)
- (void) willShowInTab:(NSUInteger) tab
{
}
@end