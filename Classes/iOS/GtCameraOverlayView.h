//
//	GtCameraOverlayView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0

#import <Foundation/Foundation.h>
#import "GtCameraViewControllerBottomButtonView.h"
#import "GtCountView.h"
#import "GtThumbnailButton.h"
#import "GtCameraConfig.h"

@class GtRoundRectView;
@protocol GtCameraOverlayViewDelegate;

@interface GtCameraOverlayView : GtWidgetView {
@private
	UIButton* m_flashButton;
	UIButton* m_flipCameraButton;
	UISegmentedControl* m_flashSegmentedControl;
	UIActivityIndicatorView* m_spinner;
	IBOutlet id<GtCameraOverlayViewDelegate> m_cameraOverlayDelegate;
	UIImageView* m_imageView;
	UIImageView* m_shakeyImageView;
	UISlider* m_zoomSlider;
	GtRoundRectView* m_focusView;
	UIButton* m_leftButton;
	GtThumbnailButton* m_rightButton;
	UIButton* m_centerButton;
	GtCountView* m_countView;
	BOOL m_dragging;
}

@property (readwrite, assign, nonatomic) id<GtCameraOverlayViewDelegate> cameraOverlayDelegate; 

@property (readonly, retain, nonatomic) GtCameraViewControllerBottomButtonView* buttonView;

- (void) updateFlipCameraButton:(GtCameraConfig*) cameraConfig;
- (void) updateFlashButton:(GtCameraConfig*) cameraConfig;
- (void) showFullFlashControl:(GtCameraConfig*) cameraConfig;

- (void) setShakyIconVisible:(BOOL) isVisible;

- (void) showFocusGraphicAt:(CGPoint) pt isVisible:(BOOL) isVisible;

- (void) setThumbnail:(UIImage*) image newCount:(NSInteger) newCount;
- (void) removeThumbnail;

- (void) flashScreen;

- (void) setButtonsEnabled:(BOOL) enabled;

- (void) startSpinner;
- (void) stopSpinner;

- (void) setFocusRectVisible:(BOOL) visible;

@end

@protocol GtCameraOverlayViewDelegate <NSObject>

- (void) cameraOverlayViewFlashButtonPressed:(GtCameraOverlayView*) overlayView;
- (void) cameraOverlayViewShutterButtonPressed:(GtCameraOverlayView*) overlayView;
- (void) cameraOverlayViewFlipCameraButtonPressed:(GtCameraOverlayView*) overlayView;
- (void) cameraOverlayViewDoneButtonPressed:(GtCameraOverlayView*) overlayView;
- (void) cameraOverlayViewThumbnailButtonPressed:(GtCameraOverlayView*) overlayView;
- (void) cameraOverlayView:(GtCameraOverlayView*) overlayView flashModeWasChanged:(UIImagePickerControllerCameraFlashMode) newMode;
- (void) cameraOverlayView:(GtCameraOverlayView*) overlayView zoomChanged:(float) newZoom;

- (void) cameraOverlayView:(GtCameraOverlayView*) overlayView userTouchScreenAtPoint:(CGPoint) point;


@end

#endif
#endif