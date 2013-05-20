//
//	GtPhotoViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/19/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserNotificationView.h"
#import "GtTouchableScrollView.h"
#import "GtActionContext.h"
#import "GtViewController.h"
#import "GtWeakReference.h"
#import "GtPhotoView.h"
#import "GtTilingScrollView.h"
#import "GtZoomingScrollView.h"
#import "GtAction.h"
#import "GtPhotoThumbnailToolbar.h"
#import "GtSlideShowOptionsViewController.h"
#import "GtSlideShowOptions.h"
#import "GtPhotoExif.h"
#import "GtPhotoMapViewController.h"
#import "GtNotificationView.h"
#import "GtButtonbarToolbar.h"

@interface GtPhotoViewLoadingState : NSObject {
	GtPhotoView* m_photoView;
	id m_photo;
	NSUInteger m_lastKnownPhotoIndex;
	GtPhotoViewImageSize m_imageSize;
	UIImage* m_image;
	struct {
		unsigned int isLoading:1;
		unsigned int isRefreshing:1;
	} m_flags;
}
@property (readwrite, retain, nonatomic) UIImage* image;
@property (readwrite, nonatomic, retain) GtPhotoView* photoView;
@property (readwrite, nonatomic, retain) id photo;
@property (readwrite, nonatomic, assign) NSUInteger lastKnownPhotoIndex;
@property (readwrite, nonatomic, assign) GtPhotoViewImageSize imageSize;
@property (readwrite, nonatomic, assign, getter=isRefreshing) BOOL refreshing;
//@property (readwrite, nonatomic, assign, getter=isLoading) BOOL loading;

@end

typedef enum {
	GtPhotoViewControllerUIElementNone						= 0,
	
	GtPhotoViewControllerUIElementTopCountLabel				= (1 << 1), // not working
	GtPhotoViewControllerUIElementTopBalloon				= (1 << 2),
	GtPhotoViewControllerUIElementTopComposeButton			= (1 << 3),
	GtPhotoViewControllerUIElementTopPlaySlideshowButton	= (1 << 4),
	GtPhotoViewControllerUIElementTopToolsButton			= (1 << 5),
	GtPhotoViewControllerUIElementBottomCountLabel			= (1 << 6),
	GtPhotoViewControllerUIElementCloseButton				= (1 << 7),
	GtPhotoViewControllerUIElementGpsPinButton				= (1 << 8),
	
	GtPhotoViewControllerUIElementAll						= 0xFFFF
} GtPhotoViewControllerUIElement;


@protocol GtPhotoViewControllerDataSource;
@protocol GtPhotoViewControllerDelegate;

@interface GtPhotoViewController : GtViewController<GtTilingScrollViewDelegate, 
													GtZoomingScrollViewDelegate,
													GtImageThumbnailBarViewDelegate,
													GtSlideshowOptionsViewControllerDelegate,
													GtNotificationViewDelegate> {
@private
	IBOutlet GtTilingScrollView* m_scrollView;
	IBOutlet UIView* m_bottomToolbar; 
	IBOutlet UIView* m_topToolbar; 
	
    IBOutlet GtPhotoThumbnailToolbar* m_thumbnailBar;

	IBOutlet id m_playButton;
	IBOutlet UIBarButtonItem* m_prevButton;
	IBOutlet UIBarButtonItem* m_nextButton;

	IBOutlet UIBarButtonItem* m_editButton;
	IBOutlet UIBarButtonItem* m_organizeButton;
	IBOutlet UIBarButtonItem* m_actionButton;

	id<GtPhotoViewControllerDelegate> m_photoViewControllerDelegate;
	
	NSTimer* m_slideShowTimer;

	NSUInteger m_currentPhotoIndex;
	NSUInteger m_slideShowStartIndex;
	
	GtSlideshowOptions* m_slideshowOptions;
	NSMutableArray* m_randomSlideshowIndexes;
	
	GtActionReference* m_thumbnailAction;
	GtActionReference* m_action;
	
	GtWeakReference* m_photoMapController;
		
	GtThumbnailBarCountView* m_thumbnailCountView;
			
	struct {
		unsigned int showingDetailsView:1;
		unsigned int inSlideShow:1;
		unsigned int shutDown:1;
		unsigned int fullScreen:1;
	// these are for rotation
		unsigned int shouldRefreshWhenAppearing:1;
		unsigned int isNetworkAware:1;
		unsigned int autoZoomPhotos:1;
		unsigned int setupNavigationTitleView:1;
		unsigned int isFullScreenTapDisabled: 1;
		unsigned int wantsThumbnailLoad:1;
	} m_photoViewControllerFlags;
	
    GtPhotoViewControllerUIElement m_uiElementMask;
}

@property (readwrite, assign, nonatomic) BOOL autoZoomPhotos;

@property (readwrite, assign, nonatomic, getter=isNetworkAware) BOOL networkAware;

@property (readwrite, assign, nonatomic) id<GtPhotoViewControllerDelegate> photoViewControllerDelegate;

@property (readonly, retain, nonatomic) GtPhotoViewLoadingState* loadingState; 

@property (readwrite, assign, nonatomic) GtPhotoViewControllerUIElement uiElementMask;

// Toolbars (optional)
@property (readwrite, retain, nonatomic) id topToolbar;
@property (readwrite, retain, nonatomic) id bottomToolbar;
@property (readonly, retain, nonatomic) GtPhotoThumbnailToolbar* thumbnailBar;

// Buttons 
@property (readonly, retain, nonatomic) UIBarButtonItem* organizeButton;
@property (readonly, retain, nonatomic) UIBarButtonItem* actionButton;

@property (readwrite, assign, nonatomic) BOOL shouldRefreshWhenAppearing;
- (void) beginLoadingPhotosIfNeeded;


// Button presses
- (IBAction) handleDonePress:(id) sender;
- (IBAction) handleInfoPress:(id) sender;
- (IBAction) handleReloadPress:(id) sender;
- (IBAction) handlePrevPress:(id) sender;
- (IBAction) handleNextPress:(id) sender;
- (IBAction) handlePlayPress:(id) sender;
- (IBAction) handleDeletePress:(id) sender;
- (IBAction) handleMovePress:(id) sender;
- (IBAction) handleActionPress:(id) sender;
- (IBAction) handleToolPress:(id) sender;
- (IBAction) handleSlideShowPress:(id) sender;
// Photo Loading
- (void) resetErrors;
- (void) reloadCurrentPhoto:(id) sender;

// Photo Views

@property (readonly, retain, nonatomic) GtPhotoView* centerView;
//- (void) removeAllPhotos;
- (void) handleUserDeletedPhotoAtCurrentPhotoIndex;

- (void) updatePhotoView:(GtPhotoView*) photoView 
	withImage:(UIImage*) image
	forImageSize:(GtPhotoViewImageSize) imageSize;
	
- (GtPhotoViewImageSize) imageSizeForZoomScale:(CGFloat) zoomScale;
- (void) stopZooming:(BOOL) animated
	target:(id) target
	action:(SEL) action;
	
// Indexing into photo array
@property (readonly, assign, nonatomic) NSUInteger photoCount;
- (void) photoCountDidChange;

@property (readonly, assign, nonatomic) NSUInteger currentPhotoIndex;
- (NSUInteger) relativePhotoIndex:(NSInteger) fromCurrent;

- (void) showPhotoAtIndex:(NSUInteger) index;
- (void) setCurrentPhotoIndex:(NSUInteger) index animated:(BOOL) animated;


@property (readonly, retain, nonatomic) id currentPhoto;

#if AUTO_ROTATE
@property (readwrite, assign, nonatomic) BOOL autoRotate;
#endif

- (UIScrollView*) scrollView;
- (void) onTappedToolbar:(id) sender;
- (void) showHideAllDetailViews:(BOOL) show;

- (void) updateVisibleViewElements;

// Full Screen
@property (readwrite, assign, nonatomic, getter=isFullScreenTapDisabled) BOOL fullScreenTapDisabled;
- (void) enterFullScreen:(BOOL) animate;
- (void) leaveFullScreen:(BOOL) animate;
- (void) toggleFullScreen:(BOOL) animate;

@property (readonly, assign, nonatomic) BOOL isFullScreen;

@property (readonly, assign, nonatomic) CGFloat zoomScale; 

- (void) updateTitleBar:(NSString*) title;

- (void) showErrorMessageInPhotoView:(GtPhotoView*) photoView 
	errorMessage: (NSString*) errorMessage
	userCanDismissErrorView:(BOOL) canDismiss;

- (void) setThumbnailBarImage:(UIImage*) image atIndex:(NSUInteger) atIndex;

- (void) createTopToolbar;
- (void) createBottomToolbar;


//- (void) setGpsExifForPhoto:(id) photo 
//	title:(NSString*) title 
//	exif:(GtGpsExif*) exif	   
//	thumbnail:(UIImage*) thumbnail
//	atIndex:(NSUInteger) photoIndex;


// slide show
@property (readwrite, retain, nonatomic) id slideShowPlayButton;
@property (readonly, assign, nonatomic) BOOL inSlideShow;
@property (readwrite, retain, nonatomic) GtSlideshowOptions* slideshowOptions;
- (void) stopSlideShow:(BOOL) animate;
- (void) startSlideShow;
- (void) startSlideShowTimer;
- (void) stopSlideShowTimer;
- (void) updateSlideShowButtons;

@end

@protocol GtPhotoViewControllerDelegate <NSObject>

- (NSUInteger) photoViewControllerGetPhotoCount:(GtPhotoViewController*) photoViewController; 

- (GtAction*) photoViewController:(GtPhotoViewController*) photoViewController 
	createLoadAction:(GtPhotoViewLoadingState*) loadingState;
	
- (void) photoViewController:(GtPhotoViewController*) photoViewController 
	actionDidComplete:(GtAction*) action
	loadingState:(GtPhotoViewLoadingState*) loadingState;
	
- (id) photoViewController:(GtPhotoViewController*) controller 
	photoAtIndex:(NSUInteger) idx;
	
//- (NSUInteger) photoViewController:(GtPhotoViewController*) controller 
//	indexForPhoto:(id) photo;

- (GtAction*) photoViewController:(GtPhotoViewController*) controller 
	beginLoadingThumbnailAtIndex:(NSUInteger) idx;

- (NSString*) photoViewController:(GtPhotoViewController*) controller
	detailsForPhotoAtIndex:(NSUInteger) idx;

- (NSString*) photoViewController:(GtPhotoViewController*) controller
	titleForPhotoAtIndex:(NSUInteger) idx;

- (GtSlideshowOptions*) photoViewControllerGetDefaultSlideshowOptions:(GtPhotoViewController*) controller;

- (GtGpsExif*) photoViewController:(GtPhotoViewController*) controller 
	gpsExifForPhotoAtIndex:(NSUInteger) photoIndex;

@optional

- (void) photoViewController:(GtPhotoViewController*) photoViewController 
	didLoadCenterView:(GtPhotoView*) view;

@end



