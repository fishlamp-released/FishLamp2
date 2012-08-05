//
//	FLImagePickerController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCameraViewController.h"
#import "FLCameraOverlayView.h"
#import "FLGpsUtilities.h"
#import "NSFileManager+FLExtras.h"

#if FL_CUSTOM_CAMERA

@implementation FLCameraViewController

@synthesize tookPhotoBlock = m_tookPhotoBlock;

@synthesize folder = m_folder;
@synthesize locationManager = m_locationManager;
@synthesize cameraConfig = m_cameraConfig;

@synthesize photos = m_photos;

- (id) initWithPhotoFolder:(FLFolder*) folder 
			cameraType:(FLCameraViewControllerCameraType) cameraType
			cameraConfig:(FLCameraConfig*) cameraConfig
{
	if(self = [super initWithNibName:@"FLCamera" bundle:nil])
	{	
		self.cameraConfig = cameraConfig;
		self.folder = folder;
		self.title = @"Camera";
		
		m_cameraControllerFlags.cameraType = cameraType;
		
		switch(cameraType)
		{
			case FLCameraViewControllerCameraTypeStill:
				m_cameraViewStrategy = [[FLPhotoViewControllerStillStrategy alloc] initWithViewController:self];
			break;
			
			case FLCameraViewControllerCameraTypeFrames:
				m_cameraViewStrategy = [[FLPhotoViewControllerVideoFrameStrategy alloc] initWithViewController:self];
			break;
		}
		 
		m_photos = [[NSMutableArray alloc] init];
	
		self.wantsFullScreenLayout = YES;

		[UIAccelerometer sharedAccelerometer].updateInterval = 0.25;
		[UIAccelerometer sharedAccelerometer].delegate = self;
		
		[self startLocationManager];
	}
	
	return self;
}

- (void) setCameraType:(FLCameraViewControllerCameraType) cameraType
			  position:(AVCaptureDevicePosition) position
			 flashMode:(AVCaptureFlashMode) flash
{
	switch(cameraType)
	{
		case FLCameraViewControllerCameraTypeStill:
			m_cameraViewStrategy = [[FLPhotoViewControllerStillStrategy alloc] initWithViewController:self];
			break;
			
		case FLCameraViewControllerCameraTypeFrames:
			m_cameraViewStrategy = [[FLPhotoViewControllerVideoFrameStrategy alloc] initWithViewController:self];
			break;
	}
}

- (FLCameraPhoto*) photo
{
	return [m_photos lastObject];
}

- (void) _cleanupCameraController
{
	FLReleaseWithNil(m_overlay);
}

- (void) startLocationManager
{
	if(OSVersionIsAtLeast4_1() && [CLLocationManager locationServicesEnabled])
	{	
		FLRelease(m_locationManager);
		m_locationManager =[[CLLocationManager alloc] init];
		//		 m_locationManager.delegate=self;
		m_locationManager.desiredAccuracy=kCLLocationAccuracyBest;
		m_locationManager.purpose = @"GPS latitude and longitude will be stored in your photos.";
		[m_locationManager startUpdatingLocation];
	}
}

- (void) dealloc
{
	m_locationManager.delegate = nil;
	[m_locationManager stopUpdatingLocation];
	FLRelease(m_locationManager);
	
	FLRelease(m_cameraViewStrategy);
	FLRelease(m_tookPhotoBlock);
	FLRelease(m_photos);
	FLRelease(m_folder);
	FLRelease(m_cameraConfig);
	[self _cleanupCameraController];
	
	FLSuperDealloc();
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[UIAccelerometer sharedAccelerometer].delegate = self;
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
	if(self.navigationController)
	{
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
	
	[m_cameraViewStrategy viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[UIAccelerometer sharedAccelerometer].delegate = nil;
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
	if(self.navigationController)
	{
		[self.navigationController setNavigationBarHidden:NO animated:YES];
	}
	
	[m_cameraViewStrategy viewWillDisappear:animated];
}

double MoveDelta(double lhs, double rhs)
{
	return fabsf(lhs - rhs);
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)aceler
{
	[m_overlay setShakyIconVisible:MoveDelta(aceler.x, m_lastX) > 0.05 || MoveDelta(aceler.y, m_lastY) > 0.05 || MoveDelta(aceler.z, m_lastZ) > 0.05];

	m_lastX = aceler.x;
	m_lastY = aceler.y;
	m_lastZ = aceler.z;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	m_overlay = [[FLCameraOverlayView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:m_overlay];
	[m_cameraViewStrategy viewDidLoad];
}

- (void) viewDidUnload
{
	[super viewDidUnload];
	[self _cleanupCameraController];
	[m_cameraViewStrategy viewDidUnload];
}

@end

@implementation FLCameraViewController (Internal)

- (FLCameraOverlayView*) overlayView
{
	return m_overlay;
}
@end
	
#endif