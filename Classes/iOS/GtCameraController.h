//
//	GtCameraViewControllerCameraHandler.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCamera.h"

#if GT_CUSTOM_CAMERA
@protocol GtCameraControllerDelegate;

@interface GtCameraController : NSObject {
@private
	id<GtCameraControllerDelegate> m_delegate;
	AVCaptureDevicePosition m_cameraDevice;
	AVCaptureFlashMode m_cameraFlashMode;
}

@property (readwrite, nonatomic, assign) id<GtCameraControllerDelegate> delegate;

@property(readonly, nonatomic, assign) AVCaptureDevicePosition cameraDevice;
@property(readwrite, nonatomic, assign) AVCaptureFlashMode cameraFlashMode;

- (GtCamera*) camera;
- (void) beginCapture;

- (void) startCamera:(AVCaptureDevicePosition) device;
- (void) stopCamera;

@end

@protocol GtCameraControllerDelegate <NSObject>

- (void) cameraControllerWillStartCapture:(GtCameraController*) cameraController;
- (void) cameraController:(GtCameraController*) cameraController didStopCapture:(NSError*) error;

- (void) cameraControllerWillStartCamera:(GtCameraController*) cameraController;
- (void) cameraController:(GtCameraController*) cameraController didStartCamera:(NSError*) error;

- (void) cameraControllerWillStopCamera:(GtCameraController*) cameraController;
- (void) cameraController:(GtCameraController*) cameraController didStopCamera:(NSError*) error;

- (CLLocation*) cameraControllerGetLastLocation:(GtCameraController*) controller;

- (GtFolder*) cameraControllerGetPhotoFolder:(GtCameraController*) controller;

@end


#endif
