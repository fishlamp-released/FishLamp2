//
//	GtImagePickerController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraViewController.h"
#import "GtCameraOverlayView.h"
#import "GtGpsUtilities.h"
#import "NSFileManager+GtExtras.h"

#if GT_CUSTOM_CAMERA

@implementation GtCameraViewController

@synthesize tookPhotoBlock = m_tookPhotoBlock;

@synthesize folder = m_folder;
@synthesize locationManager = m_locationManager;
@synthesize cameraConfig = m_cameraConfig;

@synthesize photos = m_photos;

- (id) initWithPhotoFolder:(GtFolder*) folder 
			cameraType:(GtCameraViewControllerCameraType) cameraType
			cameraConfig:(GtCameraConfig*) cameraConfig
{
	if(self = [super initWithNibName:@"GtCamera" bundle:nil])
	{	
		self.cameraConfig = cameraConfig;
		self.folder = folder;
		self.title = @"Camera";
		
		m_cameraControllerFlags.cameraType = cameraType;
		
		switch(cameraType)
		{
			case GtCameraViewControllerCameraTypeStill:
				m_cameraViewStrategy = [[GtPhotoViewControllerStillStrategy alloc] initWithViewController:self];
			break;
			
			case GtCameraViewControllerCameraTypeFrames:
				m_cameraViewStrategy = [[GtPhotoViewControllerVideoFrameStrategy alloc] initWithViewController:self];
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

- (void) setCameraType:(GtCameraViewControllerCameraType) cameraType
			  position:(AVCaptureDevicePosition) position
			 flashMode:(AVCaptureFlashMode) flash
{
	switch(cameraType)
	{
		case GtCameraViewControllerCameraTypeStill:
			m_cameraViewStrategy = [[GtPhotoViewControllerStillStrategy alloc] initWithViewController:self];
			break;
			
		case GtCameraViewControllerCameraTypeFrames:
			m_cameraViewStrategy = [[GtPhotoViewControllerVideoFrameStrategy alloc] initWithViewController:self];
			break;
	}
}

- (GtCameraPhoto*) photo
{
	return [m_photos lastObject];
}

- (void) _cleanupCameraController
{
	GtReleaseWithNil(m_overlay);
}

- (void) startLocationManager
{
	if(OSVersionIsAtLeast4_1() && [CLLocationManager locationServicesEnabled])
	{	
		GtRelease(m_locationManager);
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
	GtRelease(m_locationManager);
	
	GtRelease(m_cameraViewStrategy);
	GtRelease(m_tookPhotoBlock);
	GtRelease(m_photos);
	GtRelease(m_folder);
	GtRelease(m_cameraConfig);
	[self _cleanupCameraController];
	
	GtSuperDealloc();
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
	m_overlay = [[GtCameraOverlayView alloc] initWithFrame:self.view.bounds];
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

@implementation GtCameraViewController (Internal)

- (GtCameraOverlayView*) overlayView
{
	return m_overlay;
}
@end
	
#endif