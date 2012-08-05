//
//	FLImageThumbnailBarView.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/18/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidgetView.h"

@class FLThumbnailBarCell;
@protocol FLImageThumbnailBarViewDelegate;

@interface FLImageThumbnailBarView : FLWidgetView {
@private
	NSMutableArray* m_thumbnails;
	id<FLImageThumbnailBarViewDelegate> m_delegate;
	FLThumbnailBarCell* m_selectedThumbnail;
	
	BOOL m_enabled;
	
	NSUInteger m_thumbCount;
	CGRect m_widgetFrame;
	NSUInteger m_maxThumbCount;
	CGFloat m_indexScale;
	CGFloat m_leftSide;
}

@property (readwrite, assign, nonatomic) NSUInteger selectedThumbnailIndex;
@property (readwrite, assign, nonatomic) BOOL enabled;

@property (readonly, assign, nonatomic) BOOL hasAllThumbnails;
@property (readonly, assign, nonatomic) NSInteger nextThumbnailIndex;

@property (readwrite, assign, nonatomic) id<FLImageThumbnailBarViewDelegate> delegate;

- (void) setThumbnail:(UIImage*) image atIndex:(NSUInteger) atIndex;

- (void) resetThumbnails;

- (void) selectNextThumbnail:(id) sender;
- (void) selectPrevThumbnail:(id) sender;

@end

@protocol FLImageThumbnailBarViewDelegate
- (void) thumbnailBarViewNextButtonPressed:(FLImageThumbnailBarView*) thumbnailBar;
- (void) thumbnailBarViewPreviousButtonPressed:(FLImageThumbnailBarView*) thumbnailBar;
- (void) thumbnailBarView:(FLImageThumbnailBarView*) thumbnailBar didChangeSelectedThumbnail:(NSUInteger) newIndex;
- (void) thumbnailBarViewTouchesStarted:(FLImageThumbnailBarView*) thumbnailBar;
- (void) thumbnailBarViewTouchesStopped:(FLImageThumbnailBarView*) thumbnailBar;

- (NSUInteger) thumbnailBarViewGetThumbnailCount:(FLImageThumbnailBarView*) thumbnailBar;
- (NSUInteger) thumbnailBarViewGetSelectedThumbnailIndex:(FLImageThumbnailBarView*) thumbnailBar;
@end

#import "FLRoundRectView.h"

@interface FLThumbnailBarCountView : UIView {
@private
	UILabel* m_label;
	FLRoundRectView* m_view;
}

- (void) updateCount:(NSUInteger) count total:(NSUInteger) total;

@end