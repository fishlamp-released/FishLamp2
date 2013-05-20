//
//	FLCamera.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0


@class FLCamera;

typedef void (^FLCameraStartedBlock)(FLCamera* camera, NSError* error);
typedef void (^FLCameraStoppedBlock)(FLCamera* camera, NSError* error);

@interface FLCamera : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate> {
	AVCaptureSession* _session;
	AVCaptureVideoPreviewLayer* _previewLayer;
	AVCaptureDevice* _device;
	AVCaptureFlashMode _flashMode;
	NSError* _error;
}

@property (readwrite, retain, nonatomic) AVCaptureSession *session;
@property (readwrite, assign, nonatomic) AVCaptureDevicePosition position;
@property (readwrite, assign, nonatomic) AVCaptureFlashMode flashMode;
@property (readwrite, assign, nonatomic) AVCaptureFocusMode focusMode;
@property (readonly, retain, nonatomic) AVCaptureDevice* device;
@property (readonly, retain, nonatomic) AVCaptureVideoPreviewLayer* previewLayer;

//- (UIView*) previewWithBounds:(CGRect) bounds;
//- (void) addCaptureLayerToView:(UIView*) inView;
- (void) start:(AVCaptureDevicePosition) whichDevice startedBlock:(FLCameraStartedBlock) startedBlock;
- (void) stop:(FLCameraStartedBlock) stoppedBlock;

- (void) _configureSession:(AVCaptureSession*) session;
- (void) _addOutput;
- (void) _addInput;
- (void) _cleanupCamera;


@end

#endif
#endif