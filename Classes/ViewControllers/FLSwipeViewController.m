//
//  FLSwipeViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/31/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSwipeViewController.h"
#import "FLGradientView.h"
#import "FLMenuViewController.h"
#import "FLViewControllerStack.h"
#import "FLHorizonalDragBarWidget.h"

@interface FLSwipeViewController ()
@end

@implementation FLSwipeViewController

@synthesize bottomAuxiliaryViewController = _bottomAuxiliaryViewController;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil   {
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    
    return self;
}

- (void) dealloc {   
    FLRelease(_bottomAuxiliaryViewController);
    FLRelease(_scrollView);
    FLRelease(_breadCrumbview);
    FLRelease(_breadcrumbHost);
    FLSuperDealloc();
}

- (void) updateLayout {
    FLRect bounds = self.view.bounds;
    bounds.origin.x = 0;
    
    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator) {
        placeholder.frame = bounds;
        bounds.origin.x += bounds.size.width;
    }
}

- (UIView*) multiViewContainerView {
    return _scrollView;
}

- (UIView*) containerView {
    return _scrollView;
}

- (FLRect) containerViewVisibleBounds {
    FLRect visibleRect;
    visibleRect.origin = _scrollView.contentOffset;
    visibleRect.size = _scrollView.frame.size;
    return CGRectInset(visibleRect, 4, 4);
}

- (void) recalculateScrollView:(BOOL) animate {
    FLRect bounds = self.view.bounds;
    CGFloat visibleWidth = bounds.size.width;
    
    bounds.size.width *= self.viewControllerCount;

    _scrollView.contentSize = bounds.size;
    [_scrollView setContentOffset:CGPointMake(self.selectedIndex * visibleWidth, 0) animated:animate];

    [self updateLayout];
    
    [self updateVisibleViews];

    _breadCrumbview.itemCount = self.viewControllerCount;
    _breadCrumbview.selectedItem = self.selectedIndex;
}

- (void) didSelectViewController:(FLViewControllerPlaceholder*) placeholder animate:(BOOL) animate {
    [super didSelectViewController:placeholder animate:animate];
    
    _breadCrumbview.selectedItem = self.selectedIndex;
}

- (UIViewController*) createMenuViewController {
    FLMenuViewController* aux = [FLMenuViewController menuViewController:nil];
    aux.view.frame = self.view.bounds;
    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator) {
        [aux.menuView addMenuItem:[FLMenuItemView menuItemView:placeholder.title target:self action:@selector(_didChangeMenuItem:)]];
    }
        
    [aux updateLayout];
    return aux;
}


#define kBottomViewHeight 20.0

- (void) createTouchableViews:(FLAuxiliaryViewController*) viewController {
    _breadcrumbHost = [[UIView alloc] initWithFrame:CGRectMake(0,  self.view.bounds.size.height - kBottomViewHeight, self.view.bounds.size.width, kBottomViewHeight)];
    _breadcrumbHost.backgroundColor = [UIColor clearColor];
    _breadcrumbHost.autoresizesSubviews = YES;
    _breadcrumbHost.autoresizingMask = 
        UIViewAutoresizingFlexibleRightMargin | 
        UIViewAutoresizingFlexibleWidth | 
        UIViewAutoresizingFlexibleTopMargin | 
        UIViewAutoresizingFlexibleBottomMargin;
    
    FLGradientView* gradientView = [[FLGradientView alloc] initWithFrame:_breadcrumbHost.bounds];
    gradientView.autoresizesSubviews = YES;
    gradientView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    gradientView.alpha = 0.75f;
    [_breadcrumbHost addSubview:gradientView];
    FLRelease(gradientView);

    _breadCrumbview = [[FLBreadcrumbView alloc] initWithFrame:_breadcrumbHost.bounds];
    _breadCrumbview.autoresizingMask = UIViewAutoresizingFlexibleEverything; 
    _breadCrumbview.delegate = self;
    [_breadcrumbHost addSubview:_breadCrumbview];
    
    FLHorizonalDragBarWidget* widget1 = [FLHorizonalDragBarWidget horizonalDragBarWidget:FLHorizontalDragBarWidgetStyleTop];
    widget1.lineColor = [UIColor lightGrayColor];
    [_breadCrumbview.rootWidget addWidget:widget1];
    
    FLHorizonalDragBarWidget* widget2 = [FLHorizonalDragBarWidget horizonalDragBarWidget:FLHorizontalDragBarWidgetStyleTop];
    widget2.lineColor = [UIColor lightGrayColor];
    [_breadCrumbview.rootWidget addWidget:widget2];
    
    [self.view addSubview:_breadcrumbHost];

    viewController.dragController.touchableView = _breadcrumbHost;
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_breadCrumbview.rootWidget widgetAtIndex:0].frame = CGRectMake(0,4,40,10);
    [_breadCrumbview.rootWidget widgetAtIndex:1].frame = CGRectMake(FLRectGetRight(_breadcrumbHost.bounds) - 40,4,40,10);
}

- (void) viewDidLoad {
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
//    _scrollView.directionalLockEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    _scrollView.delegate = self;
    _scrollView.delaysContentTouches = NO;
    [self.view addSubview:_scrollView];
    
    self.bottomAuxiliaryViewController = [FLAuxiliaryViewController auxiliaryViewController:FLAuxiliaryViewControllerPinnedSideBottom
        behavior:[FLAuxiliaryViewController belowBehavior]];
    
    __block id myself = self;

    self.bottomAuxiliaryViewController.onCreateViewController = ^(FLAuxiliaryViewController* theController) {
        return [myself createMenuViewController];
    };
      
    self.bottomAuxiliaryViewController.onAddTouchableViews  = ^(FLAuxiliaryViewController* theController) {
        [myself createTouchableViews:theController];
    };
    
    [self.viewControllerStack addAuxiliaryViewController:self.bottomAuxiliaryViewController];
    
    [self recalculateScrollView:NO];
    
    [self setSelectedIndex:0 animate:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger newIndex = scrollView.contentOffset.x / scrollView.frame.size.width;

    [self setSelectedIndex:newIndex animate:NO];
    
    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateVisibleViews];
}

- (void) viewDidUnload {
    FLReleaseWithNil(_bottomAuxiliaryViewController);
    FLReleaseWithNil(_scrollView);
    FLReleaseWithNil(_breadcrumbHost);
    FLReleaseWithNil(_breadCrumbview);
    [super viewDidUnload];
}

- (void) updateVisibleViews {
    FLRect visibleBounds = self.containerViewVisibleBounds;
    UIView* containerView = self.containerView;
    
    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator) {
        if(CGRectIntersectsRect(visibleBounds, placeholder.frame)) {
            [placeholder showViewControllerInSuperView:containerView inViewController:self];
        }
        else {
            [placeholder hideViewController];
        }
    }
}

- (void) didChooseMenuItem:(NSInteger) menuItem {
    [self setSelectedIndex:menuItem animate:NO];

// TODO: ??
//    [_bottomSwipeView close];
    
    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
    
    [self recalculateScrollView:NO];
}

- (void) _didChangeMenuItem:(FLMenuItemView*) menuItem {
    [self didChooseMenuItem:menuItem.indexInMenu];

    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.bottomAuxiliaryViewController hideViewControllerAnimated:YES];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//    [self resetBottomMenu];
    [self recalculateScrollView:NO];
}

- (void) breadcrumbViewWasTapped:(FLBreadcrumbView*) view
{
// TODO: use it or lose it

//    FLMenuViewController* menu = [FLMenuViewController menuViewController:nil];
//    menu.view.frame = self.view.bounds;
//    for(FLViewControllerPlaceholder* placeholder in self.placeholders.forwardObjectEnumerator)
//    {
//        [menu addMenuItem:placeholder.title target:self action:@selector(_didChangeMenuItem:)];
//    }
//    
//    [self.masterViewController revealViewController:menu style:FLViewControllerRevealStyleBelow side:FLViewControllerRevealSideBottom animated:YES closeBlock:^{} ];
}

- (void) viewWillAppear:(BOOL)animated {   
    [self recalculateScrollView:NO];
    [super viewWillAppear:animated];
    [self.bottomAuxiliaryViewController.dragController startDragWatcher];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bottomAuxiliaryViewController.dragController stopDragWatcher];
}

@end
    