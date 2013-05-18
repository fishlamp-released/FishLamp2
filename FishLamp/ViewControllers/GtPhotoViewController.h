//
//  GtPhotoViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtCallback.h"
#import "GtUserNotificationView.h"
#import "GtTouchableScrollView.h"
#import "GtActionContext.h"
#import "GtViewController.h"
#import "GtWeakReference.h"
#import "GtPhotoView.h"
#import "GtPhotoViewControllerViewArrangement.h"

@interface GtPhotoViewController : GtViewController<UIScrollViewDelegate> {
@private
	IBOutlet UIView* m_rotatingSubview;
	IBOutlet UIScrollView* m_scrollView;
	IBOutlet UIToolbar* m_topToolbar;
	IBOutlet UIToolbar* m_bottomToolbar;
	IBOutlet UIBarButtonItem* m_editButton;
	IBOutlet UIBarButtonItem* m_playButton;
	IBOutlet UIBarButtonItem* m_prevButton;
	IBOutlet UIBarButtonItem* m_nextButton;
    IBOutlet UILabel* m_titleView;
    IBOutlet UIBarButtonItem* m_organizeButton;
    IBOutlet UIBarButtonItem* m_actionButton;
    
    IBOutlet UIBarButtonItem* m_counterItem;
    IBOutlet UIBarButtonItem* m_titleItem;
    
	UILabel* m_topLabel;
    UILabel* m_countLabel;

	id m_delegate;
	
	NSTimer* m_fullScreenTimer;
	NSTimer* m_slideShowTimer;
	
	BOOL m_inSlideShow;
	BOOL m_firstLoad;
	BOOL m_autoRotate;
	
	CGPoint m_lastOffset;
	
	NSUInteger m_photoCount;
	NSUInteger m_currentIndex;
	NSUInteger m_slideShowStartIndex;
	NSUInteger m_slideShowSpeed;
	NSUInteger m_fullScreenTimerSpeed;
	
	UIDeviceOrientation m_autoRotateOrientation;
	UIDeviceOrientation m_orientation;
	UIDeviceOrientation m_previousOrientation;
	
	CGFloat m_rotateAngle;
	
	GtPhotoViewControllerViewArrangement* m_arrangement;
	
	CGFloat m_topBarAlpha;
	CGFloat m_bottomBarAlpha;
}

@property (readwrite, assign, nonatomic) id delegate;

// Toolbars (optional)
@property (readonly, assign, nonatomic) UIToolbar* bottomToolbar;
@property (readonly, assign, nonatomic) UIToolbar* topToolbar;

// Buttons 
@property (readonly, assign, nonatomic) UIBarButtonItem* organizeButton;
@property (readonly, assign, nonatomic) UIBarButtonItem* actionButton;

// TODO add rest of buttons

// initialization
- (id) initWithPhotoCount:(NSUInteger) photoCount currentIndex:(NSUInteger) currentIndex;
- (id) initWithNibNameAndPhotoCount:(NSString*) nibName photoCount:(NSUInteger) photoCount currentIndex:(NSUInteger) currentIndex;

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

// Photo Loading
- (void) fadeInViewAndBeginLoadingPhotos;
- (void) reloadCurrentPhoto;

// Photo Views
- (GtPhotoView*) centerView;
- (GtPhotoView*) nextView;
- (GtPhotoView*) previousView;
- (void) clearPhotos;
- (void) handleUserDeletedPhoto;

@property (readonly, assign, nonatomic) GtPhotoViewControllerViewArrangement* arrangement;

// Indexing into photo array
@property (readwrite, assign, nonatomic) NSUInteger photoCount;
@property (readonly, assign, nonatomic) NSUInteger currentIndex;
@property (readonly, assign, nonatomic) NSUInteger nextIndex;
@property (readonly, assign, nonatomic) NSUInteger prevIndex;

// Rotation
- (void) rotateToOrientation:(UIDeviceOrientation) newOrientation animate:(BOOL) animate;
@property (readwrite, assign, nonatomic) BOOL autoRotate;
@property (readwrite, assign, nonatomic) UIDeviceOrientation autoRotateOrientation;

// Slide Show
- (void) stopSlideShow;
- (void) startSlideShow;
- (void) startSlideShowTimer;
- (void) stopSlideShowTimer;
@property (readonly, assign, nonatomic) BOOL inSlideShow;
@property (readwrite, assign, nonatomic) NSUInteger slideShowSpeed;

// Full Screen
- (void) enterFullScreen:(BOOL) animate;
- (void) leaveFullScreen:(BOOL) animate;
- (void) toggleFullScreen:(BOOL) animate;

@property (readonly, assign, nonatomic) BOOL isFullScreen;
@property (readwrite, assign, nonatomic) NSUInteger fullScreenTimerSpeed;

@end

@interface GtPhotoViewController (Protected)
- (void) onPhotoLoaded:(GtPhotoView*) photo img:(UIImage*) img; 
- (void) insertNewNextPhoto;
- (void) insertNewPrevPhoto;
- (void) beginLoadingPhotos;
- (UIScrollView*) scrollView;
- (void) onTappedToolbar:(id) sender;
@end

@interface GtPhotoViewController (RequiredOverrides)
- (id) currentPhoto;
- (id) prevPhoto;
- (id) nextPhoto;
- (void) beginLoadPhoto:(GtPhotoView*) photoView;
- (void) onCancelLoadPhoto:(GtPhotoView*) photoView;
- (void) onRemovePhotoAtIndex:(NSUInteger) index;

- (void) onCenterPhotoLoading;
- (void) onCenterPhotoLoaded;

- (NSString*) getDetailsForPhoto:(id) photo;
- (NSString*) onGetPhotoTitle:(id) photo;
- (BOOL) areTheSamePhoto:(id) firstPhoto 
             secondPhoto:(id) secondPhoto;
- (NSString*) emptyDetailsViewString;

@end

@protocol PhotoViewControllerDelegate <NSObject>
@optional
- (void) onPhotoViewClosed:(GtPhotoViewController*) photoViewController;
@end
