//
//  FLScrollViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/3/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLViewController.h"
#import "FLPullToRefreshHeaderView.h"

@interface FLScrollViewController : FLViewController<FLPullToRefreshHeaderViewDelegate, UIScrollViewDelegate> {
@private
    UIScrollView* _scrollView;
	FLPullToRefreshHeaderView* _pullToRefreshView;
	struct {
		unsigned int wantsPullToRefresh:1;
	} _scrollViewControllerFlags;
}

@property (readwrite, retain, nonatomic) IBOutlet UIScrollView* scrollView;

@property (readwrite, assign, nonatomic) BOOL wantsPullToRefresh;
@property (readonly, retain, nonatomic) UIView* pullToRefreshView;

- (void) updateContentInsets;

- (UIEdgeInsets) willUpdateContentInsets:(UIEdgeInsets) insets;

//- (CGFloat) contentInsetTop;
//- (CGFloat) contentInsetBottom;

- (void) beginRefreshing:(BOOL) userRequestedRefresh;
- (void) setFinishedRefreshing;

- (void) beginRefreshingStartedByUser:(id) sender; // calls [self beginRefreshing:YES]. Suitable for callbacks.
- (void) beginAutomaticRefreshing:(id) sender;

// override point.
- (UIScrollView*) createScrollView;

@end
