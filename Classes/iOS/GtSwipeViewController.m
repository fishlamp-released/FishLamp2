//
//  GtSwipeViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSwipeViewController.h"
#import "GtGradientView.h"
#import "GtMenuViewController.h"
#import "GtViewControllerStack.h"

@interface GtSwipeViewController ()
@end

@implementation GtSwipeViewController

@synthesize bottomAuxiliaryViewController = m_bottomAuxiliaryViewController;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil   
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
    }
    
    return self;
}

- (void) dealloc
{   
    GtRelease(m_bottomAuxiliaryViewController);
    GtRelease(m_scrollView);
    GtRelease(m_breadCrumbview);
    GtRelease(m_breadcrumbHost);
    GtSuperDealloc();
}

- (void) updateLayout
{
    CGRect bounds = self.view.bounds;
    bounds.origin.x = 0;
    
    for(GtViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
    {
        placeholder.frame = bounds;
        bounds.origin.x += bounds.size.width;
    }
}

- (UIView*) multiViewContainerView
{
    return m_scrollView;
}

- (UIView*) containerView
{
    return m_scrollView;
}

- (CGRect) containerViewVisibleBounds
{
    CGRect visibleRect;
    visibleRect.origin = m_scrollView.contentOffset;
    visibleRect.size = m_scrollView.frame.size;
    return CGRectInset(visibleRect, 4, 4);
}

- (void) recalculateScrollView:(BOOL) animate
{
    CGRect bounds = self.view.bounds;
    CGFloat visibleWidth = bounds.size.width;
    
    bounds.size.width *= self.viewControllerCount;

    m_scrollView.contentSize = bounds.size;
    [m_scrollView setContentOffset:CGPointMake(self.selectedIndex * visibleWidth, 0) animated:animate];

    [self updateLayout];
    
    [self updateVisibleViews];

    m_breadCrumbview.itemCount = self.viewControllerCount;
    m_breadCrumbview.selectedItem = self.selectedIndex;
}

- (void) didSelectViewController:(GtViewControllerPlaceholder*) placeholder animate:(BOOL) animate
{
    [super didSelectViewController:placeholder animate:animate];
    
    m_breadCrumbview.selectedItem = self.selectedIndex;
}

- (UIViewController*) createMenuViewController:(GtAuxiliaryViewController*) manager
{
    GtMenuViewController* aux = [GtMenuViewController menuViewController:nil];
    aux.view.frame = self.view.bounds;
    for(GtViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
    {
        [aux.menuView addMenuItem:[GtMenuItemView menuItemView:placeholder.title target:self action:@selector(_didChangeMenuItem:)]];
    }
        
    [aux updateLayout];
    return aux;
}


#define kBottomViewHeight 20.0

- (UIView*) createTouchableView:(id) sender
{
    m_breadcrumbHost = [[UIView alloc] initWithFrame:CGRectMake(0,  self.view.bounds.size.height - kBottomViewHeight, self.view.bounds.size.width, kBottomViewHeight)];
    m_breadcrumbHost.backgroundColor = [UIColor clearColor];
    m_breadcrumbHost.autoresizesSubviews = YES;
    m_breadcrumbHost.autoresizingMask = 
        UIViewAutoresizingFlexibleRightMargin | 
        UIViewAutoresizingFlexibleWidth | 
        UIViewAutoresizingFlexibleTopMargin | 
        UIViewAutoresizingFlexibleBottomMargin;
    
    GtGradientView* gradientView = [[GtGradientView alloc] initWithFrame:m_breadcrumbHost.bounds];
    gradientView.autoresizesSubviews = YES;
    gradientView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    gradientView.alpha = 0.6f;
    [m_breadcrumbHost addSubview:gradientView];

    m_breadCrumbview = [[GtBreadcrumbView alloc] initWithFrame:m_breadcrumbHost.bounds];
    m_breadCrumbview.autoresizingMask = UIViewAutoresizingFlexibleEverything; 
    m_breadCrumbview.delegate = self;
    [m_breadcrumbHost addSubview:m_breadCrumbview];

    [self.view addSubview:m_breadcrumbHost];

    return m_breadcrumbHost;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    m_scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    m_scrollView.pagingEnabled = YES;
    m_scrollView.bounces = YES;
    m_scrollView.directionalLockEnabled = YES;
    m_scrollView.scrollEnabled = YES;
    m_scrollView.showsVerticalScrollIndicator = NO;
    m_scrollView.showsHorizontalScrollIndicator = NO;
    m_scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    m_scrollView.delegate = self;
    m_scrollView.delaysContentTouches = NO;
    [self.view addSubview:m_scrollView];
    
    self.bottomAuxiliaryViewController = [GtAuxiliaryViewController auxiliaryViewController:GtAuxiliaryViewControllerPinnedSideBottom
        behavior:[GtAuxiliaryViewController hiddenBehavior]];
    self.bottomAuxiliaryViewController.createViewControllerCallback = GtCallbackMake(self, @selector(createMenuViewController:));
    self.bottomAuxiliaryViewController.createTouchableViewCallback = GtCallbackMake(self, @selector(createTouchableView:));
    
    [self.viewControllerStack addAuxiliaryViewController:self.bottomAuxiliaryViewController];
    
    [self recalculateScrollView:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger newIndex = scrollView.contentOffset.x / scrollView.frame.size.width;

    [self setSelectedIndex:newIndex animate:NO];
    
    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateVisibleViews];
}

- (void) viewDidUnload
{
    GtReleaseWithNil(m_bottomAuxiliaryViewController);
    GtReleaseWithNil(m_scrollView);
    GtReleaseWithNil(m_breadcrumbHost);
    GtReleaseWithNil(m_breadCrumbview);
    [super viewDidUnload];
}

- (void) didChooseMenuItem:(NSInteger) menuItem
{
    [self setSelectedIndex:menuItem animate:NO];
//    [m_bottomSwipeView close];
    
    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
    
    [self recalculateScrollView:NO];
}

- (void) _didChangeMenuItem:(GtMenuItemView*) menuItem
{
    [self didChooseMenuItem:menuItem.indexInMenu];

    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//    [self resetBottomMenu];
    [self recalculateScrollView:NO];
}

- (void) breadcrumbViewWasTapped:(GtBreadcrumbView*) view
{
//    GtMenuViewController* menu = [GtMenuViewController menuViewController:nil];
//    menu.view.frame = self.view.bounds;
//    for(GtViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
//    {
//        [menu addMenuItem:placeholder.title target:self action:@selector(_didChangeMenuItem:)];
//    }
//    
//    [self.masterViewController revealViewController:menu style:GtViewControllerRevealStyleBelow side:GtViewControllerRevealSideBottom animated:YES closeBlock:^{} ];
}

- (void) viewWillAppear:(BOOL)animated
{   
    [self recalculateScrollView:NO];
    [super viewWillAppear:animated];
    [self.bottomAuxiliaryViewController.dragController startDragWatcher];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.bottomAuxiliaryViewController.dragController stopDragWatcher];
}

@end
    