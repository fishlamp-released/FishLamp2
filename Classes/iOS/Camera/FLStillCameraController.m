//
//	FLStillCameraController.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStillCameraController.h"
#import "FLGpsUtilities.h"
#if FL_CUSTOM_CAMERA
@implementation FLStillCameraController 

- (id<FLCameraControllerDelegate, FLStillCameraControllerDelegate>) delegate
{
	return (id<FLCameraControllerDelegate, FLStillCameraControllerDelegate>) [super delegate];
}

- (void) setDelegate:(id<FLCameraControllerDelegate, FLStillCameraControllerDelegate>) delegate
{
	[super setDelegate:delegate];
}

- (FLCamera*) camera
{
	if(!_camera)
	{
		_camera = [[FLStillCamera alloc] init];
	}
	return _camera;
}

- (void) setCamera:(FLCamera*) camera
{
	FLSetObjectWithRetain(_camera, camera);
}

- (void) dealloc
{
	FLRelease(_camera);
	FLSuperDealloc();
}

- (void) beginCapture
{
	[_camera captureImage: ^(CMSampleBufferRef buffer, NSError* error)
	{	
		 if(!error)
		 {
			 FLCameraPhoto* photo = nil;
			 NSData* imageData = nil;
			 
			 [FLStillCamera convertToData:buffer outData:&imageData];
			 NSMutableDictionary* masterExif = [[NSMutableDictionary alloc] init];
			 @try
			 {
				 photo = [[FLCameraPhoto alloc] initWithJpegData:imageData
														  folder:[self.delegate cameraControllerGetPhotoFolder:self]
													rootFileName:[FLFolder uniqueImageFileName]];
				 
				 CLLocation* lastLocation = [self.delegate cameraControllerGetLastLocation:self];
				 if(lastLocation && CLLocationCoordinate2DIsValid(lastLocation.coordinate))
				 {
					 NSMutableDictionary* locDict = [[NSMutableDictionary alloc] init];
					 FLAddLocationToGpsExif(locDict, lastLocation);		 
					 [masterExif setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
					 FLRelease(locDict);
				 }
				 
				 NSString* nowString = FLGpsDateFormattedForExif([NSDate date]);
				 
				 NSMutableDictionary* tiff = [[NSMutableDictionary alloc] init];
				 [tiff setObject:nowString forKey:(NSString*)kCGImagePropertyTIFFDateTime];
				 [tiff setObject:@"Apple" forKey:(NSString*) kCGImagePropertyTIFFMake];
				 [tiff setObject:[UIDevice currentDevice].platformString forKey:(NSString*) kCGImagePropertyTIFFModel];
				 [tiff setObject:[UIDevice currentDevice].systemVersion forKey:(NSString*) kCGImagePropertyTIFFSoftware];
				 [masterExif setObject:tiff forKey:(NSString*) kCGImagePropertyTIFFDictionary];
				 FLRelease(tiff);
				 
				 NSMutableDictionary* exif = [[NSMutableDictionary alloc] init];
				 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeOriginal];
				 [exif setObject:nowString forKey:(NSString*) kCGImagePropertyExifDateTimeDigitized];
				 [masterExif setObject:exif forKey:(NSString*)kCGImagePropertyExifDictionary];
				 FLRelease(exif);
				 
				 // writing iptc doesn't work.	  
				 // appears to be a bug.
				 //				   NSMutableDictionary* iptc = [[NSMutableDictionary alloc] init];
				 //				   [iptc setObject:[NSFileManager appName] forKey:(NSString*)kCGImagePropertyIPTCOriginatingProgram];
				 //				   [iptc setObject:[NSFileManager appVersion] forKey:(NSString*)kCGImagePropertyIPTCProgramVersion];
				 //				   [masterExif setObject:iptc forKey:(NSString*) kCGImagePropertyIPTCDictionary];
				 //				   FLReleaseWithNil(iptc);
				 
				 photo.original.properties = masterExif;
				 [self.delegate stillCameraController:self didCapturePhoto:photo];
			 }
			 @catch(NSException* ex)
			 {
				 // TODO: handle error
			 }
			 FLRelease(masterExif);
			 FLRelease(photo);
			 FLRelease(imageData);
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
}

@end

#endif
