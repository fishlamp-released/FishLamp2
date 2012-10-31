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
	if(!_camera)
	{
		_camera = [[FLVideoFrameGrabberCamera alloc] init];
	}
	return _camera;
}

- (void) dealloc
{
	mrc_release_(_camera);
	mrc_super_dealloc_();
}


- (void) _beginTakingPhoto
{
	[self.delegate cameraControllerWillStartCapture:self];
	
	//[_camera captureImage: ^(CMSampleBufferRef buffer, NSError* error)
#if DEBUG	   
	[_camera captureFrames:3 interval:1 block:^ (FLVideoFrameGrabberCamera* camera, NSError* error) 
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
			 //				   mrc_release_(newBufferExif);
			 //			   }
			 
			 //				 [FLStillCamera convertToData:buffer outData:&imageData];
			 //				 NSMutableDictionary* masterExif = [[NSMutableDictionary alloc] init];
			 //				 @try
			 //				 {
			 //					 photo = [[FLCameraPhoto alloc] initWithJpegData:imageData
			 //															  folder:_folder
			 //														rootFileName:[FLFolder uniqueImageFileName]];
			 //					 
			 //					 
			 //					 CLLocation* lastLocation = _locationManager.location;
			 //					 if(lastLocation && CLLocationCoordinate2DIsValid(lastLocation.coordinate))
			 //					 {
			 //						 NSMutableDictionary* locDict = [[NSMutableDictionary alloc] init];
			 //						 FLAddLocationToGpsExif(locDict, lastLocation);		 
			 //						 [masterExif setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
			 //						 mrc_release_(locDict);
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
			 //					 mrc_release_(tiff);
			 //					 
			 //					 NSMutableDictionary* exif = [[NSMutableDictionary alloc] init];
			 //					 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeOriginal];
			 //					 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeDigitized];
			 //					 [masterExif setObject:exif forKey:(NSString*)kCGImagePropertyExifDictionary];
			 //					 mrc_release_(exif);
			 //					 
			 //					 // writing iptc doesn't work.	  
			 //					 // appears to be a bug.
			 //					 //				   NSMutableDictionary* iptc = [[NSMutableDictionary alloc] init];
			 //					 //				   [iptc setObject:[NSFileManager appName] forKey:(NSString*)kCGImagePropertyIPTCOriginatingProgram];
			 //					 //				   [iptc setObject:[NSFileManager appVersion] forKey:(NSString*)kCGImagePropertyIPTCProgramVersion];
			 //					 //				   [masterExif setObject:iptc forKey:(NSString*) kCGImagePropertyIPTCDictionary];
			 //					 //				   FLReleaseWithNil_(iptc);
			 //					 
			 //					 photo.original.properties = masterExif;
			 //					 
			 //					 [photo.original writeToStorage];
			 //					 [_photos addObject:photo];
			 //				 }
			 //				 @catch(NSException* ex)
			 //				 {
			 //					 // TODO: handle error
			 //				 }
			 //				 mrc_release_(masterExif);
			 //				 mrc_release_(photo);
			 //				 mrc_release_(imageData);
		 }
		 
		 dispatch_async(
						dispatch_get_main_queue(), ^{
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