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
	NSMutableArray* _thumbnails;
	__unsafe_unretained id<FLImageThumbnailBarViewDelegate> _delegate;
	FLThumbnailBarCell* _selectedThumbnail;
	
	BOOL _enabled;
	
	NSUInteger _thumbCount;
	CGRect _widgetFrame;
	NSUInteger _maxThumbCount;
	CGFloat _indexScale;
	CGFloat _leftSide;
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
	UILabel* _label;
	FLRoundRectView* _view;
}

- (void) updateCount:(NSUInteger) count total:(NSUInteger) total;

@end