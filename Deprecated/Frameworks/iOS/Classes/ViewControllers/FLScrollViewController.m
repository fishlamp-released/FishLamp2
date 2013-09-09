//
//  FLScrollViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/3/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLScrollViewController.h"
#import "FLViewContentsDescriptor.h"

@implementation FLScrollViewController

FLSynthesizeStructProperty(wantsPullToRefresh, setWantsPullToRefresh, BOOL, _scrollViewControllerFlags);

@synthesize pullToRefreshView = _pullToRefreshView;
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.wantsFullScreenLayout = YES;
	}
	
	return self;
}

- (void) cleanupScrollViewController {
	_scrollView.delegate = nil;
	FLReleaseWithNil(_scrollView);
	FLReleaseWithNil(_pullToRefreshView);
}

- (void) dealloc {
    [self cleanupScrollViewController];
    FLSuperDealloc();
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh {
    [self setFinishedRefreshing];
}

- (void) beginRefreshingStartedByUser:(id) sender {
	[self beginRefreshing:YES];
}

- (void) beginAutomaticRefreshing:(id) sender {
	[self beginRefreshing:YES];
}

- (void) setFinishedRefreshing {
	[self performBlockWithDelay:1.0f block:^{
        [_pullToRefreshView setFinishedRefreshing];
        }];
}

- (UIEdgeInsets) willUpdateContentInsets:(UIEdgeInsets) insets {
	return _pullToRefreshView ? [_pullToRefreshView willUpdateTableViewContentInset:insets] : insets;
}

- (void) updateContentInsets {
	self.scrollView.contentInset = [self willUpdateContentInsets:self.contentViewInsets];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {	
	if (_pullToRefreshView)  {
		[_pullToRefreshView scrollViewDidScroll:scrollView];
	}
}

- (NSDate*) pullToRefreshHeaderViewLastUpdatedDate:(FLPullToRefreshHeaderView*) view {
    return nil; // [NSDate date];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if(_pullToRefreshView) {
		[_pullToRefreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	}
}

- (void) pullToRefreshHeaderViewBeginRefreshing:(FLPullToRefreshHeaderView*) view {
	[self beginRefreshing:YES];
}

- (UIScrollView*) pullToRefreshHeaderViewGetScrollView:(FLPullToRefreshHeaderView*) view {
	return self.scrollView;
}

- (UIScrollView*) createScrollView {
    return nil;
}

- (void) loadView {
    [super loadView];
    
    if(!_scrollView) {
        self.scrollView = [self createScrollView];
        [self.view addSubview:_scrollView];
        _scrollView.delegate = self;        
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if(self.wantsPullToRefresh) {
		_pullToRefreshView = [[FLPullToRefreshHeaderView alloc] initWithFrame:CGRectZero];
		_pullToRefreshView.delegate = self;
		[self.scrollView addSubview:_pullToRefreshView];
	}

	[self updateContentInsets];
    self.scrollView.frame = self.view.bounds;
}

- (void) _updateScrollViewSizeIfNeeded {
    if(!CGRectEqualToRect(self.scrollView.frame, self.view.bounds)) {
        self.scrollView.frame = self.view.bounds;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self updateContentInsets];
    [self _updateScrollViewSizeIfNeeded];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _updateScrollViewSizeIfNeeded];
}

@end
