//
//	FLCameraOverlayView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/16/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0

#import <Foundation/Foundation.h>
#import "FLCameraViewControllerBottomButtonView.h"
#import "FLCountView.h"
#import "FLThumbnailButton.h"
#import "FLCameraConfig.h"

@class FLRoundRectView;
@protocol FLCameraOverlayViewDelegate;

@interface FLCameraOverlayView : FLView {
@private
	UIButton* _flashButton;
	UIButton* _flipCameraButton;
	UISegmentedControl* _flashSegmentedControl;
	UIActivityIndicatorView* _spinner;
	IBOutlet id<FLCameraOverlayViewDelegate> _cameraOverlayDelegate;
	UIImageView* _imageView;
	UIImageView* _shakeyImageView;
	UISlider* _zoomSlider;
	FLRoundRectView* _focusView;
	UIButton* _leftButton;
	FLThumbnailButton* _rightButton;
	UIButton* _centerButton;
	FLCountView* _countView;
	BOOL _dragging;
}

@property (readwrite, assign, nonatomic) id<FLCameraOverlayViewDelegate> cameraOverlayDelegate; 

@property (readonly, retain, nonatomic) FLCameraViewControllerBottomButtonView* buttonView;

- (void) updateFlipCameraButton:(FLCameraConfig*) cameraConfig;
- (void) updateFlashButton:(FLCameraConfig*) cameraConfig;
- (void) showFullFlashControl:(FLCameraConfig*) cameraConfig;

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

@protocol FLCameraOverlayViewDelegate <NSObject>

- (void) cameraOverlayViewFlashButtonPressed:(FLCameraOverlayView*) overlayView;
- (void) cameraOverlayViewShutterButtonPressed:(FLCameraOverlayView*) overlayView;
- (void) cameraOverlayViewFlipCameraButtonPressed:(FLCameraOverlayView*) overlayView;
- (void) cameraOverlayViewDoneButtonPressed:(FLCameraOverlayView*) overlayView;
- (void) cameraOverlayViewThumbnailButtonPressed:(FLCameraOverlayView*) overlayView;
- (void) cameraOverlayView:(FLCameraOverlayView*) overlayView flashModeWasChanged:(UIImagePickerControllerCameraFlashMode) newMode;
- (void) cameraOverlayView:(FLCameraOverlayView*) overlayView zoomChanged:(float) newZoom;

- (void) cameraOverlayView:(FLCameraOverlayView*) overlayView userTouchScreenAtPoint:(CGPoint) point;


@end

#endif
#endif