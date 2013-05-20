//
//	FLPhotoViewControllerStrategy.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/6/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoViewControllerStrategy.h"
#import "FLFramesCameraController.h"
#import "FLCameraViewController.h"
#import "FLCameraOverlayView.h"
#if FL_CUSTOM_CAMERA

#define CAMERA_SCALAR (480.0 / (480.0-94.0)) // 1.12412 // scalar = (480 / (2048 / 480))
											 //transform values for full screen support
											 //#define CAMERA_TRANSFORM_X 1
											 //#define CAMERA_TRANSFORM_Y (480.0 / (480.0-94.0))

@implementation FLPhotoViewControllerStrategy

@synthesize cameraController = _cameraController;
FLSynthesizeStructProperty(registeredForFocusEvents, setRegisteredForFocusEvents, BOOL, _flags);
@synthesize viewController = _viewController;

- (id) initWithViewController:(FLCameraViewController*) viewController
{
	if(self = [super init])
	{
		_viewController = viewController;
	}	
	
	return self;
}

- (FLCamera*) camera
{
	return _cameraController.camera;
}

- (void) createReviewView:(BOOL) animated
{
	FLCameraPhotoViewController* controller = [[FLCameraPhotoViewController alloc] initWithArrayOfCameraPhotos:self.viewController.photos folder:self.viewController.folder];
	[self.viewController.navigationController pushViewController:controller animated:animated];
	FLRelease(controller);
}

- (void) dealloc
{
	[self unregisterForFocusEvents];

	_cameraController.delegate = nil;
	[_cameraController stopCamera];
	FLRelease(_cameraController);
	FLSuperDealloc();
}

- (void) updateFocusRect
{
	CGPoint pt = [_cameraController.camera.device focusPointOfInterest];
	pt.x *= 320.0;
	pt.y *= 480.0;
	pt.y = 480.0 - pt.y;
	[self.viewController.overlayView showFocusGraphicAt:pt isVisible:[_cameraController.camera.device isAdjustingFocus]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	[self updateFocusRect];
}

- (void) cameraControllerWillStartCapture:(FLCameraController*) cameraController
{
	for(FLCameraPhoto* photo in self.viewController.photos)
	{
		[photo.original releaseImageAndJpegData];
	}
}

- (void) cameraController:(FLCameraController*) cameraController didStopCapture:(NSError*) error
{
	[self.viewController.overlayView setButtonsEnabled:YES];
	[self.viewController.overlayView stopSpinner];
	[self.viewController.overlayView setFocusRectVisible:YES];
	//			[self setLastPhotoPreview:[self.viewController.photos lastObject]]; // pass error in here?
	
	[self setLastPhotoPreview:[self.viewController.photos lastObject]]; // pass error in here?
}

- (void) cameraControllerWillStartCamera:(FLCameraController*) cameraController
{
	[self.viewController.overlayView updateFlipCameraButtonWithCameraDevice:self.viewController.cameraDevice];
	[self.viewController.overlayView updateFlashButtonWithFlashMode:self.viewController.cameraFlashMode];
	[self.viewController.overlayView setButtonsEnabled:NO];
	[self.viewController.overlayView startSpinner];
	[self.viewController.overlayView setFocusRectVisible:NO];
	
	self.camera.flashMode = self.viewController.cameraFlashMode;
}

- (void) registerForFocusEvents
{
	if(self.cameraController.camera.device.focusPointOfInterestSupported && !self.registeredForFocusEvents)
	{
		self.registeredForFocusEvents = YES;
		[self.cameraController.camera.device addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionInitial context:nil];
		[self.viewController.overlayView setFocusRectVisible:YES];
		[self updateFocusRect];
	}
}

- (void) unregisterForFocusEvents
{
	if(self.registeredForFocusEvents)
	{
		self.registeredForFocusEvents = NO;
		[self.viewController.overlayView setFocusRectVisible:NO];
		[_cameraController.camera.device removeObserver:self forKeyPath:@"adjustingFocus"];
	}
}

- (void) cameraController:(FLCameraController*) cameraController didStartCamera:(NSError*) error
{
	[self.viewController.overlayView updateFlipCameraButtonWithCameraDevice:_cameraController.camera.position];
	[self.viewController.overlayView updateFlashButtonWithFlashMode:_cameraController.camera.flashMode];
	
	[self registerForFocusEvents];
	
	self.cameraController.camera.previewLayer.frame = self.viewController.view.bounds;
	[self.viewController.view.layer addSublayer:self.cameraController.camera.previewLayer];
	[self.viewController.view bringSubviewToFront:self.viewController.overlayView];
	[self.viewController.overlayView setButtonsEnabled:YES];
	[self.viewController.overlayView stopSpinner];
}

- (void) cameraControllerWillStopCamera:(FLCameraController*) cameraController
{
	[self.viewController.overlayView setButtonsEnabled:NO];
	[self.viewController.overlayView startSpinner];
	[self unregisterForFocusEvents];
}

- (void) cameraController:(FLCameraController*) cameraController didStopCamera:(NSError*) error
{
	[self.viewController.overlayView stopSpinner];
	if(_flags.closeWhenCameraStopped)
	{
	   [self.viewController.navigationController popViewControllerWithAnimation:self.viewController.navigationControllerCloseAnimation];
	}
}

- (void) viewWillAppear:(BOOL)animated
{
	if(self.viewController.photos.count)
	{
		[self setLastPhotoPreview:[self.viewController.photos lastObject]];
	}
}

- (void) viewWillDisappear:(BOOL)animated
{
}

- (void) viewDidLoad
{
	self.viewController.overlayView.cameraOverlayDelegate = self;
	[self.cameraController startCamera:self.viewController.cameraDevice];
}

- (void) viewDidUnload
{
	[self.cameraController stopCamera];
}

- (void) beginTakingPhoto
{	
	[self.cameraController beginCapture];
}

- (void) removeLastPhotoPreview
{
	[self.viewController.overlayView removeThumbnail];
}

- (void) setLastPhotoPreview:(FLCameraPhoto*) photo
{
	if(photo.original.jpegData == nil)
	{
		[photo.original readFromStorage];
	}
	[self.viewController.overlayView setThumbnail:photo.original.image newCount:self.viewController.photos.count];
}

- (void) cameraOverlayViewShutterButtonPressed:(FLCameraOverlayView*) overlayView
{
	[overlayView flashScreen];
	[overlayView startSpinner];
	[overlayView setButtonsEnabled:NO];
	[overlayView setFocusRectVisible:NO];
	[self beginTakingPhoto];
}

- (void) cameraOverlayViewFlipCameraButtonPressed:(FLCameraOverlayView*) overlayView 
{
//	  self.viewController.cameraDevice = self.cameraDevice == AVCaptureDevicePositionBack ? 
//AVCaptureDevicePositionFront: 
//	  AVCaptureDevicePositionBack ;
//	  
//	  //	[self _stopCamera:YES];
//	  
//	  [overlayView updateFlipCameraButtonWithCameraDevice:self.cameraDevice];
}

- (void) cameraOverlayViewDoneButtonPressed:(FLCameraOverlayView*) overlayView
{
	_flags.closeWhenCameraStopped = YES;
	[_cameraController stopCamera];
}

- (void) cameraOverlayView:(FLCameraOverlayView*) overlayView 
	   flashModeWasChanged:(AVCaptureFlashMode) newMode
{
	self.cameraController.camera.flashMode = newMode;
	self.cameraController.cameraFlashMode = newMode;
}

- (void) cameraOverlayView:(FLCameraOverlayView*) overlayView userTouchScreenAtPoint:(CGPoint) point
{
	//	  if( point.x > 80 && point.x < (self.view.bounds.size.width - 80) &&
	//		  point.y > 100 && point.y < (self.view.bounds.size.height - 100))
	{
		AVCaptureDevice* currentDevice = self.camera.device;
		if(currentDevice.focusPointOfInterestSupported)
		{
			if([currentDevice lockForConfiguration:nil])
			{
				point.y = 480.0 - point.y;
				CGPoint cameraPoint = CGPointMake(point.x/320.0, point.y/480.0);
				currentDevice.focusPointOfInterest = cameraPoint;
				[currentDevice unlockForConfiguration];
			}
			
			[self updateFocusRect];
		}
	}
}

- (void) cameraOverlayViewThumbnailButtonPressed:(FLCameraOverlayView*) overlayView
{
	[self createReviewView:YES];
}

- (void) cameraOverlayViewFlashButtonPressed:(FLCameraOverlayView*) overlayView
{
	[self.viewController.overlayView showFullFlashControl:self.viewController.cameraFlashMode];
}

- (void) cameraOverlayView:(FLCameraOverlayView*) overlayView zoomChanged:(float) newZoom
{
	self.camera.previewLayer.affineTransform = CGAffineTransformMakeScale(newZoom, newZoom);
}

- (CLLocation*) cameraControllerGetLastLocation:(FLCameraController*) controller
{
	return _viewController.locationManager.location;
}

- (FLFolder*) cameraControllerGetPhotoFolder:(FLCameraController*) controller
{
	return _viewController.folder;
}


@end

@implementation FLPhotoViewControllerVideoFrameStrategy

- (id) initWithViewController:(FLCameraViewController*) viewController
{
	if(self = [super initWithViewController:viewController])
	{
		FLFramesCameraController* cameraController = [[FLFramesCameraController alloc] init];
		self.cameraController = cameraController;
		FLRelease(cameraController);
		self.cameraController.delegate = self;
	}
	
	return self;
}

@end

@implementation FLPhotoViewControllerStillStrategy

- (id) initWithViewController:(FLCameraViewController*) viewController
{
	if(self = [super initWithViewController:viewController])
	{
		FLStillCameraController* cameraController = [[FLStillCameraController alloc] init];
		self.cameraController = cameraController;
		FLRelease(cameraController);

		self.cameraController.delegate = self;
	}
	
	return self;
}

- (void) stillCameraController:(FLStillCameraController*) controller 
			   didCapturePhoto:(FLCameraPhoto*) photo
{
	[photo.original writeToStorage];
	[self.viewController.photos addObject:photo];
}


@end

#endif