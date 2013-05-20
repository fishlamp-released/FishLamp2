//
//	GtRefreshTableHeaderView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GtGradientView.h"

@protocol GtPullToRefreshHeaderViewDelegate;

@interface GtPullToRefreshHeaderView : UIView {
@private	
	GtGradientView* m_backgroundView;
	UILabel* m_statusLabel;
	UILabel* m_lastUpdatedDate;
	CALayer* m_arrowImage;
	UIActivityIndicatorView* m_spinner;
	id<GtPullToRefreshHeaderViewDelegate> m_delegate;
	struct {
		unsigned int state : 4;
	} m_pullFlags;
	CGFloat m_previousInset;

}

@property (readwrite, nonatomic, assign) id<GtPullToRefreshHeaderViewDelegate> delegate; 

- (void) scrollViewDidScroll:(UIScrollView*) scrollView;
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void) setFinishedRefreshing;
- (UIEdgeInsets) willUpdateTableViewContentInset:(UIEdgeInsets) insets;

@end

@protocol GtPullToRefreshHeaderViewDelegate <NSObject>
- (NSDate*) pullToRefreshHeaderViewLastUpdatedDate:(GtPullToRefreshHeaderView*) view;
- (void) pullToRefreshHeaderViewBeginRefreshing:(GtPullToRefreshHeaderView*) view;
- (UIScrollView*) pullToRefreshHeaderViewGetScrollView:(GtPullToRefreshHeaderView*) view;
;
@end