//
//	GtImagePickerController.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtCameraOverlayView.h"
#import "GtViewController.h"
#import "GtJpegFileImageAsset.h"
#import "GtStillCamera.h"
#import "GtViewController.h"
#import "GtCameraPhotoViewController.h"
#import "GtJpegFileImageAsset.h"
#import "GtVideoFrameGrabberCamera.h"

#import "GtCameraController.h"

#import "GtStillCameraController.h"
#import "GtFramesCameraController.h"
#import "GtPhotoViewControllerStrategy.h"
#import "GtCameraConfig.h"

#if GT_CUSTOM_CAMERA

typedef void (^GtCameraViewControllerDidTakePhotoBlock)(GtCameraPhoto* image);

typedef enum { 
	GtCameraViewControllerCameraTypeStill,
	GtCameraViewControllerCameraTypeFrames
} GtCameraViewControllerCameraType;

@class GtCameraPhoto;

@interface GtCameraViewController : GtViewController<
	UIAccelerometerDelegate> {
@private
	
	IBOutlet GtCameraOverlayView* m_overlay;
	UIAccelerationValue m_lastX;
	UIAccelerationValue m_lastY;
	UIAccelerationValue m_lastZ;
	
	GtFolder* m_folder;
	
	GtCameraConfig* m_cameraConfig;
		 
	GtPhotoViewControllerStrategy* m_cameraViewStrategy;
	
	GtCameraViewControllerDidTakePhotoBlock m_tookPhotoBlock;
	
	CLLocationManager* m_locationManager;
		
	struct {
		GtCameraViewControllerCameraType cameraType:2;
	} m_cameraControllerFlags;
}

- (id) initWithPhotoFolder:(GtFolder*) folder
	 cameraType:(GtCameraViewControllerCameraType) cameraType
	 cameraConfig:(GtCameraConfig*) cameraConfig;

@property (readonly, retain, nonatomic) GtCameraConfig* cameraConfig;

@property (readwrite, retain) GtCameraViewControllerDidTakePhotoBlock tookPhotoBlock;
@property (readwrite, retain, nonatomic) GtFolder* folder;

@property (readonly, nonatomic, retain) NSMutableArray* photos;

@property (readonly, nonatomic, retain) CLLocationManager* locationManager;

- (void) startLocationManager;

- (void) setCameraType:(GtCameraViewControllerCameraType) cameraType
			  position:(AVCaptureDevicePosition) position
			 flashMode:(AVCaptureFlashMode) flash;
@end

@interface GtCameraViewController (Internal)

@property (readonly, assign, retain) GtCameraOverlayView* overlayView;


@end


#endif
