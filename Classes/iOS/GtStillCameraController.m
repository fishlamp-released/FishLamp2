//
//	GtStillCameraController.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStillCameraController.h"
#import "GtGpsUtilities.h"
#if GT_CUSTOM_CAMERA
@implementation GtStillCameraController 

- (id<GtCameraControllerDelegate, GtStillCameraControllerDelegate>) delegate
{
	return (id<GtCameraControllerDelegate, GtStillCameraControllerDelegate>) [super delegate];
}

- (void) setDelegate:(id<GtCameraControllerDelegate, GtStillCameraControllerDelegate>) delegate
{
	[super setDelegate:delegate];
}

- (GtCamera*) camera
{
	if(!m_camera)
	{
		m_camera = [[GtStillCamera alloc] init];
	}
	return m_camera;
}

- (void) setCamera:(GtCamera*) camera
{
	GtAssignObject(m_camera, camera);
}

- (void) dealloc
{
	GtRelease(m_camera);
	GtSuperDealloc();
}

- (void) beginCapture
{
	[m_camera captureImage: ^(CMSampleBufferRef buffer, NSError* error)
	{	
		 if(!error)
		 {
			 GtCameraPhoto* photo = nil;
			 NSData* imageData = nil;
			 
			 [GtStillCamera convertToData:buffer outData:&imageData];
			 NSMutableDictionary* masterExif = [[NSMutableDictionary alloc] init];
			 @try
			 {
				 photo = [[GtCameraPhoto alloc] initWithJpegData:imageData
														  folder:[self.delegate cameraControllerGetPhotoFolder:self]
													rootFileName:[GtFolder uniqueImageFileName]];
				 
				 CLLocation* lastLocation = [self.delegate cameraControllerGetLastLocation:self];
				 if(lastLocation && CLLocationCoordinate2DIsValid(lastLocation.coordinate))
				 {
					 NSMutableDictionary* locDict = [[NSMutableDictionary alloc] init];
					 GtAddLocationToGpsExif(locDict, lastLocation);		 
					 [masterExif setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
					 GtRelease(locDict);
				 }
				 
				 NSString* nowString = GtGpsDateFormattedForExif([NSDate date]);
				 
				 NSMutableDictionary* tiff = [[NSMutableDictionary alloc] init];
				 [tiff setObject:nowString forKey:(NSString*)kCGImagePropertyTIFFDateTime];
				 [tiff setObject:@"Apple" forKey:(NSString*) kCGImagePropertyTIFFMake];
				 [tiff setObject:[UIDevice currentDevice].platformString forKey:(NSString*) kCGImagePropertyTIFFModel];
				 [tiff setObject:[UIDevice currentDevice].systemVersion forKey:(NSString*) kCGImagePropertyTIFFSoftware];
				 [masterExif setObject:tiff forKey:(NSString*) kCGImagePropertyTIFFDictionary];
				 GtRelease(tiff);
				 
				 NSMutableDictionary* exif = [[NSMutableDictionary alloc] init];
				 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeOriginal];
				 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeDigitized];
				 [masterExif setObject:exif forKey:(NSString*)kCGImagePropertyExifDictionary];
				 GtRelease(exif);
				 
				 // writing iptc doesn't work.	  
				 // appears to be a bug.
				 //				   NSMutableDictionary* iptc = [[NSMutableDictionary alloc] init];
				 //				   [iptc setObject:[NSFileManager appName] forKey:(NSString*)kCGImagePropertyIPTCOriginatingProgram];
				 //				   [iptc setObject:[NSFileManager appVersion] forKey:(NSString*)kCGImagePropertyIPTCProgramVersion];
				 //				   [masterExif setObject:iptc forKey:(NSString*) kCGImagePropertyIPTCDictionary];
				 //				   GtReleaseWithNil(iptc);
				 
				 photo.original.properties = masterExif;
				 [self.delegate stillCameraController:self didCapturePhoto:photo];
			 }
			 @catch(NSException* ex)
			 {
				 // TODO: handle error
			 }
			 GtRelease(masterExif);
			 GtRelease(photo);
			 GtRelease(imageData);
		 }
		 
		 dispatch_async(
			dispatch_get_main_queue(), ^ {
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				GtLogAssert([NSThread isMainThread], @"not on main thread");
				
				[self.delegate cameraController:self didStopCapture:error];
				
				GtDrainPool(&pool);
			}
			);
	 }
	 ];
}

@end

#endif
