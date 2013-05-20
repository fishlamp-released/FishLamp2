//
//	GtCameraViewControllerCameraHandler.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraController.h"
#if GT_CUSTOM_CAMERA

@implementation GtCameraController

@synthesize delegate = m_delegate;
@synthesize cameraDevice = m_cameraDevice;
@synthesize cameraFlashMode = m_cameraFlashMode;

- (GtCamera*) camera
{
	return nil;
}

- (void) beginCapture
{
}

- (void) startCamera:(AVCaptureDevicePosition) device
{	
	m_cameraDevice = device;

	[m_delegate cameraControllerWillStartCamera:self];
	
	[self.camera start:self.cameraDevice startedBlock:^(GtCamera* camera, NSError* error) {
		dispatch_async(
		   dispatch_get_main_queue(), ^{ 
			   NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
			   
			   GtLogAssert([NSThread isMainThread], @"not on main thread");
			   
			   [m_delegate cameraController:self didStartCamera:error];
			   
			   GtDrainPool(&pool);
		   });
	}];
}

- (void) stopCamera
{
	[m_delegate cameraControllerWillStopCamera:self];
   
	[self.camera stop:^(GtCamera* camera, NSError* error) {
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		[m_delegate cameraController:self didStopCamera:error];
		GtDrainPool(&pool);
	}];
}
@end

#endif
