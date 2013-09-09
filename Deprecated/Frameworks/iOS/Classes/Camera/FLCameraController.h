//
//	FLCameraViewControllerCameraHandler.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLCamera.h"

#if FL_CUSTOM_CAMERA
@protocol FLCameraControllerDelegate;

@interface FLCameraController : NSObject {
@private
	id<FLCameraControllerDelegate> _delegate;
	AVCaptureDevicePosition _cameraDevice;
	AVCaptureFlashMode _cameraFlashMode;
}

@property (readwrite, nonatomic, assign) id<FLCameraControllerDelegate> delegate;

@property(readonly, nonatomic, assign) AVCaptureDevicePosition cameraDevice;
@property(readwrite, nonatomic, assign) AVCaptureFlashMode cameraFlashMode;

- (FLCamera*) camera;
- (void) beginCapture;

- (void) startCamera:(AVCaptureDevicePosition) device;
- (void) stopCamera;

@end

@protocol FLCameraControllerDelegate <NSObject>

- (void) cameraControllerWillStartCapture:(FLCameraController*) cameraController;
- (void) cameraController:(FLCameraController*) cameraController didStopCapture:(NSError*) error;

- (void) cameraControllerWillStartCamera:(FLCameraController*) cameraController;
- (void) cameraController:(FLCameraController*) cameraController didStartCamera:(NSError*) error;

- (void) cameraControllerWillStopCamera:(FLCameraController*) cameraController;
- (void) cameraController:(FLCameraController*) cameraController didStopCamera:(NSError*) error;

- (CLLocation*) cameraControllerGetLastLocation:(FLCameraController*) controller;

- (FLFolder*) cameraControllerGetPhotoFolder:(FLCameraController*) controller;

@end


#endif
