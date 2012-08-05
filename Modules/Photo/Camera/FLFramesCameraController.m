//
//	FLFramesCameraController.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "FLFramesCameraController.h"
#if FL_CUSTOM_CAMERA

@implementation FLFramesCameraController 

- (FLCamera*) camera
{
	if(!m_camera)
	{
		m_camera = [[FLVideoFrameGrabberCamera alloc] init];
	}
	return m_camera;
}

- (void) dealloc
{
	FLRelease(m_camera);
	FLSuperDealloc();
}


- (void) _beginTakingPhoto
{
	[self.delegate cameraControllerWillStartCapture:self];
	
	//[m_camera captureImage: ^(CMSampleBufferRef buffer, NSError* error)
#if DEBUG	   
	[m_camera captureFrames:3 interval:1 block:^ (FLVideoFrameGrabberCamera* camera, NSError* error) 
	 {	 
		 if(!error)
		 {
			 //				FLCameraPhoto* photo = nil;
			 //				 NSData* imageData = nil;
			 
			 // NSDictionary* bufferExif = [FLStillCamera exifDataFromBuffer:buffer];
			 //			   if(bufferExif)
			 //			   {
			 //				   NSDictionary* newBufferExif = nil;
			 //				   if([self updateExifData:bufferExif outExif:&newBufferExif])
			 //				   {
			 //					   [FLStillCamera setExifDataInBuffer:buffer exif:newBufferExif];
			 //				   }
			 //				   FLRelease(newBufferExif);
			 //			   }
			 
			 //				 [FLStillCamera convertToData:buffer outData:&imageData];
			 //				 NSMutableDictionary* masterExif = [[NSMutableDictionary alloc] init];
			 //				 @try
			 //				 {
			 //					 photo = [[FLCameraPhoto alloc] initWithJpegData:imageData
			 //															  folder:m_folder
			 //														rootFileName:[FLFolder uniqueImageFileName]];
			 //					 
			 //					 
			 //					 CLLocation* lastLocation = m_locationManager.location;
			 //					 if(lastLocation && CLLocationCoordinate2DIsValid(lastLocation.coordinate))
			 //					 {
			 //						 NSMutableDictionary* locDict = [[NSMutableDictionary alloc] init];
			 //						 FLAddLocationToGpsExif(locDict, lastLocation);		 
			 //						 [masterExif setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
			 //						 FLRelease(locDict);
			 //					 }
			 //					 
			 //					 NSString* nowString = FLGpsDateFormattedForExif([NSDate date]);
			 //					 
			 //					 NSMutableDictionary* tiff = [[NSMutableDictionary alloc] init];
			 //					 [tiff setObject:nowString forKey:(NSString*)kCGImagePropertyTIFFDateTime];
			 //					 [tiff setObject:@"Apple" forKey:(NSString*) kCGImagePropertyTIFFMake];
			 //					 [tiff setObject:[UIDevice currentDevice].platformString forKey:(NSString*) kCGImagePropertyTIFFModel];
			 //					 [tiff setObject:[UIDevice currentDevice].systemVersion forKey:(NSString*) kCGImagePropertyTIFFSoftware];
			 //					 [masterExif setObject:tiff forKey:(NSString*) kCGImagePropertyTIFFDictionary];
			 //					 FLRelease(tiff);
			 //					 
			 //					 NSMutableDictionary* exif = [[NSMutableDictionary alloc] init];
			 //					 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeOriginal];
			 //					 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeDigitized];
			 //					 [masterExif setObject:exif forKey:(NSString*)kCGImagePropertyExifDictionary];
			 //					 FLRelease(exif);
			 //					 
			 //					 // writing iptc doesn't work.	  
			 //					 // appears to be a bug.
			 //					 //				   NSMutableDictionary* iptc = [[NSMutableDictionary alloc] init];
			 //					 //				   [iptc setObject:[NSFileManager appName] forKey:(NSString*)kCGImagePropertyIPTCOriginatingProgram];
			 //					 //				   [iptc setObject:[NSFileManager appVersion] forKey:(NSString*)kCGImagePropertyIPTCProgramVersion];
			 //					 //				   [masterExif setObject:iptc forKey:(NSString*) kCGImagePropertyIPTCDictionary];
			 //					 //				   FLReleaseWithNil(iptc);
			 //					 
			 //					 photo.original.properties = masterExif;
			 //					 
			 //					 [photo.original writeToStorage];
			 //					 [m_photos addObject:photo];
			 //				 }
			 //				 @catch(NSException* ex)
			 //				 {
			 //					 // TODO: handle error
			 //				 }
			 //				 FLRelease(masterExif);
			 //				 FLRelease(photo);
			 //				 FLRelease(imageData);
		 }
		 
		 dispatch_async(
						dispatch_get_main_queue(), ^ {
							NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
							FLLogAssert([NSThread isMainThread], @"not on main thread");
							[self.delegate cameraController:self didStopCapture:error];
							
							FLDrainPool(&pool);
						}
						);
		 
		 
	 }
	 ];
#endif	   
}

@end
#endif