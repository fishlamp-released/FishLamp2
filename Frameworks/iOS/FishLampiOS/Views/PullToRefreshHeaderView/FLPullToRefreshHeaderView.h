//
//	FLRefreshTableHeaderView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FLGradientView.h"

@protocol FLPullToRefreshHeaderViewDelegate;

@interface FLPullToRefreshHeaderView : UIView {
@private	
	FLGradientView* _backgroundView;
	UILabel* _statusLabel;
	UILabel* _lastUpdatedDate;
	CALayer* _arrowImage;
	UIActivityIndicatorView* _spinner;
	__unsafe_unretained id<FLPullToRefreshHeaderViewDelegate> _delegate;
	struct {
		unsigned int state : 4;
	} _pullFlags;
	CGFloat _previousInset;

}

@property (readwrite, nonatomic, assign) id<FLPullToRefreshHeaderViewDelegate> delegate; 

- (void) scrollViewDidScroll:(UIScrollView*) scrollView;
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void) setFinishedRefreshing;
- (UIEdgeInsets) willUpdateTableViewContentInset:(UIEdgeInsets) insets;

@end

@protocol FLPullToRefreshHeaderViewDelegate <NSObject>
- (NSDate*) pullToRefreshHeaderViewLastUpdatedDate:(FLPullToRefreshHeaderView*) view;
- (void) pullToRefreshHeaderViewBeginRefreshing:(FLPullToRefreshHeaderView*) view;
- (UIScrollView*) pullToRefreshHeaderViewGetScrollView:(FLPullToRefreshHeaderView*) view;
;
@end