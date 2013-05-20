//
//  GtScrollViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/3/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtScrollViewController.h"

@implementation GtScrollViewController

GtSynthesizeStructProperty(wantsPullToRefresh, setWantsPullToRefresh, BOOL, m_scrollViewControllerFlags);

@synthesize pullToRefreshView = m_pullToRefreshView;
@synthesize scrollView = m_scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.wantsFullScreenLayout = YES;
	}
	
	return self;
}

- (void) cleanupScrollViewController
{
	m_scrollView.delegate = nil;
	GtReleaseWithNil(m_scrollView);
	GtReleaseWithNil(m_pullToRefreshView);
}

- (void) dealloc
{
    [self cleanupScrollViewController];
    GtSuperDealloc();
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
    [self setFinishedRefreshing];
}

- (void) beginRefreshingStartedByUser:(id) sender
{
	[self beginRefreshing:YES];
}

- (void) beginAutomaticRefreshing:(id) sender
{
	[self beginRefreshing:YES];
}

- (void) setFinishedRefreshing
{
	[self performBlockWithDelay:1.0f block:^{
        [m_pullToRefreshView setFinishedRefreshing];
        }];
}

- (CGFloat) contentInsetTop
{
	return GtViewContentsDescriptorCalculateTop(self.viewContentsDescriptor);
}

- (CGFloat) contentInsetBottom
{
	return GtViewContentsDescriptorCalculateBottom(self.viewContentsDescriptor);
}

- (UIEdgeInsets) willUpdateContentInsets:(UIEdgeInsets) insets
{
	return m_pullToRefreshView ? [m_pullToRefreshView willUpdateTableViewContentInset:insets] : insets;
}

- (void) updateContentInsets
{
	UIEdgeInsets insets = self.scrollView.contentInset;
	insets.top = [self contentInsetTop];
	insets.bottom = [self contentInsetBottom];
	self.scrollView.contentInset = [self willUpdateContentInsets:insets];
}

- (void) viewWillAppear:(BOOL)animated
{
	[self updateContentInsets];
	[super viewWillAppear:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	if (m_pullToRefreshView) 
	{
		[m_pullToRefreshView scrollViewDidScroll:scrollView];
	}
}

- (NSDate*) pullToRefreshHeaderViewLastUpdatedDate:(GtPullToRefreshHeaderView*) view
{
    return nil; // [NSDate date];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if(m_pullToRefreshView)
	{
		[m_pullToRefreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	}
}

- (void) pullToRefreshHeaderViewBeginRefreshing:(GtPullToRefreshHeaderView*) view
{
	[self beginRefreshing:YES];
}

- (UIScrollView*) pullToRefreshHeaderViewGetScrollView:(GtPullToRefreshHeaderView*) view
{
	return self.scrollView;
}

- (UIScrollView*) createScrollView
{
    return nil;
}

- (void) loadView
{
    [super loadView];
    
    GtAssignObject(m_scrollView, [self createScrollView]);
    GtAssertNotNil(m_scrollView);
    
    [self.view addSubview:m_scrollView];
	self.scrollView.delegate = self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if(self.wantsPullToRefresh)
	{
		m_pullToRefreshView = [[GtPullToRefreshHeaderView alloc] initWithFrame:CGRectZero];
		m_pullToRefreshView.delegate = self;
		[self.scrollView addSubview:m_pullToRefreshView];
	}
}
@end
