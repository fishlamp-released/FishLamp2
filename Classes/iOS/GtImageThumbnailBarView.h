//
//	GtImageThumbnailBarView.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/18/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtThumbnailBarCell;
@protocol GtImageThumbnailBarViewDelegate;

@interface GtImageThumbnailBarView : UIView {
@private
	NSMutableArray* m_thumbnails;
	id<GtImageThumbnailBarViewDelegate> m_delegate;
	GtThumbnailBarCell* m_selectedThumbnail;
	
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

@property (readwrite, assign, nonatomic) id<GtImageThumbnailBarViewDelegate> delegate;

- (void) setThumbnail:(UIImage*) image atIndex:(NSUInteger) atIndex;

- (void) resetThumbnails;

- (void) selectNextThumbnail:(id) sender;
- (void) selectPrevThumbnail:(id) sender;

@end

@protocol GtImageThumbnailBarViewDelegate
- (void) thumbnailBarViewNextButtonPressed:(GtImageThumbnailBarView*) thumbnailBar;
- (void) thumbnailBarViewPreviousButtonPressed:(GtImageThumbnailBarView*) thumbnailBar;
- (void) thumbnailBarView:(GtImageThumbnailBarView*) thumbnailBar didChangeSelectedThumbnail:(NSUInteger) newIndex;
- (void) thumbnailBarViewTouchesStarted:(GtImageThumbnailBarView*) thumbnailBar;
- (void) thumbnailBarViewTouchesStopped:(GtImageThumbnailBarView*) thumbnailBar;

- (NSUInteger) thumbnailBarViewGetThumbnailCount:(GtImageThumbnailBarView*) thumbnailBar;
- (NSUInteger) thumbnailBarViewGetSelectedThumbnailIndex:(GtImageThumbnailBarView*) thumbnailBar;
@end

#import "GtRoundRectView.h"

@interface GtThumbnailBarCountView : UIView {
@private
	UILabel* m_label;
	GtRoundRectView* m_view;
}

- (void) updateCount:(NSUInteger) count total:(NSUInteger) total;

@end