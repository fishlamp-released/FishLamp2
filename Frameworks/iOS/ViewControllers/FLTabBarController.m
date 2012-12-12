//
//	FLTabBarController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/29/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTabBarController.h"

@implementation FLTabBarController

@synthesize tabBar = _tabBar;

FLSynthesizeStructProperty(animateOnShow, setAnimateOnShow, BOOL, _flags);

- (void) didLoadTabBar:(UITabBar*) tabBar
{
}

- (void) loadTabBar
{
	FLAssertIsNil_(_tabBar);

	_tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,49)];
	_tabBar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
	_tabBar.frame = FLRectJustifyRectInRectBottom(self.view.bounds, _tabBar.frame);
	_tabBar.delegate = self;
    self.bottomBarView = _tabBar;
    
	[self didLoadTabBar:_tabBar];
    [self setSelectedIndex:0 animate:NO];
    [_tabBar setSelectedIndex:self.selectedIndex];
}

- (void) updateVisibleViews
{
    NSUInteger i = 0;
    UIView* containerView = self.containerView;
    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
    {
        if(i++ == self.selectedIndex)
        {
            [placeholder showViewControllerInSuperView:containerView inViewController:self];
        }
        else
        {
            [placeholder hideViewController];
        }
    }
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if(!_tabBar)
	{
		[self loadTabBar];
	}
}	

- (void) willBePushedOnNavigationController:(UINavigationController *)controller
{
	[super willBePushedOnNavigationController:controller];
	self.title = controller.title;
}

- (void) dealloc
{	
	FLRelease(_tabBar);
	super_dealloc_();
}

- (UITabBar*) tabBar
{
	if(!_tabBar)
	{
		[self loadTabBar];
		FLAssertIsNotNil_(_tabBar);
	}
	
	return _tabBar;
}

//- (void) viewControllerUpdateTabBar:(FLViewController*) viewController
//{
//	if(viewController == self.selectedViewController)
//	{
//		FLAssertIsNotNil_(self.selectedViewController);
//
//		if( self.tabBar.superview == nil ||
//            self.tabBar.superview != self.selectedViewController.view)
//		{
//			if(_tabBar.superview)
//			{
//				[_tabBar removeFromSuperview];
//			}
//			
//#if TRACE
//            FLLog(@"added tabBar to %@", NSStringFromClass([viewController class]));
//#endif
//            
//			[self.selectedViewController.view addSubview:_tabBar];
//			_tabBar.frame = FLRectSetWidth(FLRectJustifyRectInRectBottom(self.selectedViewController.view.bounds, _tabBar.frame), self.selectedViewController.view.frame.size.width);
//		}
//		
//		self.tabBar.selectedItem = [self.tabBar tabBarItemForIndex:self.selectedIndex];
//		[self.selectedViewController.view bringSubviewToFront:_tabBar];
//	}
//}

//- (UITabBar*) viewControllerGetTabBar:(FLViewController*) viewController
//{
//	return self.tabBar;
//}
//
//- (BOOL) viewControllerHasTabBar:(FLViewController*) viewController
//{
//	return YES;
//}

- (void) _tabBarDismissEvent:(id) sender
{
	[self.navigationController popToViewController:[self.navigationController parentControllerForController:self] animated:YES];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	FLAssertIsNotNil_(_tabBar);
	FLAssert_v(_tabBar == tabBar, @"different tabBar?");

	NSUInteger idx = [_tabBar indexForTabBarItem:item];
	
	FLAssert_v(idx >= 0 && idx < tabBar.items.count, @"didn't find item");

	if(idx != NSNotFound)
	{
        [self setSelectedIndex:idx animate:NO];
	}
}

@end

@implementation UITabBar (FLTabBarController) 

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
	NSArray* items = FLAutorelease(FLRetain(self.items));
	UITabBarItem* selectedItem = self.selectedItem;
	self.items = nil;
	if(FLStringIsNotEmpty(badge))
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

@implementation UIViewController (FLTabBarController)
- (void) willShowInTab:(NSUInteger) tab
{
}
@end