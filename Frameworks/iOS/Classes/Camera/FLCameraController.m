//
//	FLCameraViewControllerCameraHandler.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCameraController.h"
#if FL_CUSTOM_CAMERA

@implementation FLCameraController

@synthesize delegate = _delegate;
@synthesize cameraDevice = _cameraDevice;
@synthesize cameraFlashMode = _cameraFlashMode;

- (FLCamera*) camera
{
	return nil;
}

- (void) beginCapture
{
}

- (void) startCamera:(AVCaptureDevicePosition) device
{	
	_cameraDevice = device;

	[_delegate cameraControllerWillStartCamera:self];
	
	[self.camera start:self.cameraDevice startedBlock:^(FLCamera* camera, NSError* error) {
		dispatch_async(
		   dispatch_get_main_queue(), ^{ 
			   NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
			   
			   FLLogAssert([NSThread isMainThread], @"not on main thread");
			   
			   [_delegate cameraController:self didStartCamera:error];
			   
			   FLDrainPool(&pool);
		   });
	}];
}

- (void) stopCamera
{
	[_delegate cameraControllerWillStopCamera:self];
   
	[self.camera stop:^(FLCamera* camera, NSError* error) {
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		[_delegate cameraController:self didStopCamera:error];
		FLDrainPool(&pool);
	}];
}
@end

#endif
