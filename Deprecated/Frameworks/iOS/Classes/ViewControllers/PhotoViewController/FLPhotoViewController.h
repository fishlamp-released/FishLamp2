//
//	FLPhotoViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/19/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOldUserNotificationView.h"
#import "FLTouchableScrollView.h"
#import "FLViewController.h"
#import "FLWeakReference.h"
#import "FLPhotoView.h"
#import "FLTilingScrollView.h"
#import "FLZoomingScrollView.h"
#import "FLAction.h"
#import "FLPhotoThumbnailToolbar.h"
#import "FLSlideShowOptionsViewController.h"
#import "FLSlideShowOptions.h"
#import "FLPhotoExif.h"
#import "FLPhotoMapViewController.h"
#import "FLOldNotificationView.h"
#import "FLDeprecatedButtonbarToolbar.h"

@interface FLPhotoViewLoadingState : NSObject {
	FLPhotoView* _photoView;
	id _photo;
	NSUInteger _lastKnownPhotoIndex;
	FLPhotoViewImageSize _imageSize;
	UIImage* _image;
	struct {
		unsigned int isLoading:1;
		unsigned int isRefreshing:1;
	} _flags;
}
@property (readwrite, retain, nonatomic) UIImage* image;
@property (readwrite, nonatomic, retain) FLPhotoView* photoView;
@property (readwrite, nonatomic, retain) id photo;
@property (readwrite, nonatomic, assign) NSUInteger lastKnownPhotoIndex;
@property (readwrite, nonatomic, assign) FLPhotoViewImageSize imageSize;
@property (readwrite, nonatomic, assign, getter=isRefreshing) BOOL refreshing;
//@property (readwrite, nonatomic, assign, getter=isLoading) BOOL loading;

@end

typedef enum {
	FLPhotoViewControllerUIElementNone						= 0,
	
	FLPhotoViewControllerUIElementTopCountLabel				= (1 << 1), // not working
	FLPhotoViewControllerUIElementTopBalloon				= (1 << 2),
	FLPhotoViewControllerUIElementTopComposeButton			= (1 << 3),
	FLPhotoViewControllerUIElementTopPlaySlideshowButton	= (1 << 4),
	FLPhotoViewControllerUIElementTopToolsButton			= (1 << 5),
	FLPhotoViewControllerUIElementBottomCountLabel			= (1 << 6),
	FLPhotoViewControllerUIElementCloseButton				= (1 << 7),
	FLPhotoViewControllerUIElementGpsPinButton				= (1 << 8),
	
	FLPhotoViewControllerUIElementAll						= 0xFFFF
} FLPhotoViewControllerUIElement;


@protocol FLPhotoViewControllerDataSource;
@protocol FLPhotoViewControllerDelegate;

@interface FLPhotoViewController : FLViewController<FLTilingScrollViewDelegate, 
													FLZoomingScrollViewDelegate,
													FLImageThumbnailBarViewDelegate,
													FLSlideshowOptionsViewControllerDelegate,
													FLOldNotificationViewDelegate> {
@private
	IBOutlet FLTilingScrollView* _scrollView;
	IBOutlet UIView* _bottomToolbar; 
	IBOutlet UIView* _topToolbar; 
	
    IBOutlet FLPhotoThumbnailToolbar* _thumbnailBar;

	IBOutlet id _playButton;
	IBOutlet UIBarButtonItem* _prevButton;
	IBOutlet UIBarButtonItem* _nextButton;

	IBOutlet UIBarButtonItem* _editButton;
	IBOutlet UIBarButtonItem* _organizeButton;
	IBOutlet UIBarButtonItem* _actionButton;

	__unsafe_unretained id<FLPhotoViewControllerDelegate> _photoViewControllerDelegate;
	
	NSTimer* _slideShowTimer;

	NSUInteger _currentPhotoIndex;
	NSUInteger _slideShowStartIndex;
	
	FLSlideshowOptions* _slideshowOptions;
	NSMutableArray* _randomSlideshowIndexes;
	
//	FLActionReference* _thumbnailAction;
//	FLActionReference* _action;
	
	FLWeakReference* _photoMapController;
		
	FLThumbnailBarCountView* _thumbnailCountView;
			
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
	} _photoViewControllerFlags;
	
    FLPhotoViewControllerUIElement _uiElementMask;
    NSInteger _busyCount;
}

@property (readwrite, assign, nonatomic) BOOL autoZoomPhotos;

@property (readwrite, assign, nonatomic, getter=isNetworkAware) BOOL networkAware;

@property (readwrite, assign, nonatomic) id<FLPhotoViewControllerDelegate> photoViewControllerDelegate;

//@property (readonly, retain, nonatomic) FLPhotoViewLoadingState* loadingState;

@property (readwrite, assign, nonatomic) FLPhotoViewControllerUIElement uiElementMask;

// Toolbars (optional)
@property (readwrite, retain, nonatomic) UIView* topToolbar;
@property (readwrite, retain, nonatomic) UIView* bottomToolbar;
@property (readonly, retain, nonatomic) FLPhotoThumbnailToolbar* thumbnailBar;

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

@property (readonly, retain, nonatomic) FLPhotoView* centerView;
//- (void) removeAllPhotos;
- (void) handleUserDeletedPhotoAtCurrentPhotoIndex;

- (void) updatePhotoView:(FLPhotoView*) photoView 
	withImage:(UIImage*) image
	forImageSize:(FLPhotoViewImageSize) imageSize;
	
- (FLPhotoViewImageSize) imageSizeForZoomScale:(CGFloat) zoomScale;
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

- (void) showErrorMessageInPhotoView:(FLPhotoView*) photoView 
	errorMessage: (NSString*) errorMessage
	userCanDismissErrorView:(BOOL) canDismiss;

- (void) setThumbnailBarImage:(UIImage*) image atIndex:(NSUInteger) atIndex;

- (void) createTopToolbar;
- (void) createBottomToolbar;


//- (void) setGpsExifForPhoto:(id) photo 
//	title:(NSString*) title 
//	exif:(FLGpsExif*) exif	   
//	thumbnail:(UIImage*) thumbnail
//	atIndex:(NSUInteger) photoIndex;


// slide show
@property (readwrite, retain, nonatomic) id slideShowPlayButton;
@property (readonly, assign, nonatomic) BOOL inSlideShow;
@property (readwrite, retain, nonatomic) FLSlideshowOptions* slideshowOptions;
- (void) stopSlideShow:(BOOL) animate;
- (void) startSlideShow;
- (void) startSlideShowTimer;
- (void) stopSlideShowTimer;
- (void) updateSlideShowButtons;

@end

@protocol FLPhotoViewControllerDelegate <NSObject>

- (NSUInteger) photoViewControllerGetPhotoCount:(FLPhotoViewController*) photoViewController; 

- (FLAction*) photoViewController:(FLPhotoViewController*) photoViewController 
	createLoadAction:(FLPhotoViewLoadingState*) loadingState;
	
- (void) photoViewController:(FLPhotoViewController*) photoViewController 
	actionDidComplete:(FLAction*) action
	loadingState:(FLPhotoViewLoadingState*) loadingState;
	
- (id) photoViewController:(FLPhotoViewController*) controller 
	photoAtIndex:(NSUInteger) idx;
	
//- (NSUInteger) photoViewController:(FLPhotoViewController*) controller 
//	indexForPhoto:(id) photo;

- (FLAction*) photoViewController:(FLPhotoViewController*) controller 
	beginLoadingThumbnailAtIndex:(NSUInteger) idx;

- (NSString*) photoViewController:(FLPhotoViewController*) controller
	detailsForPhotoAtIndex:(NSUInteger) idx;

- (NSString*) photoViewController:(FLPhotoViewController*) controller
	titleForPhotoAtIndex:(NSUInteger) idx;

- (FLSlideshowOptions*) photoViewControllerGetDefaultSlideshowOptions:(FLPhotoViewController*) controller;

- (FLGpsExif*) photoViewController:(FLPhotoViewController*) controller 
	gpsExifForPhotoAtIndex:(NSUInteger) photoIndex;

@optional

- (void) photoViewController:(FLPhotoViewController*) photoViewController 
	didLoadCenterView:(FLPhotoView*) view;

@end



