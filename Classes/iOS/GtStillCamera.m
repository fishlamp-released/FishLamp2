//
//	GtStillCamera.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0

#import "GtStillCamera.h"

@implementation GtStillCamera

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
	GtLog(@"got output");
}

- (void) _addOutput
{
	m_output = [[AVCaptureStillImageOutput alloc] init];
	[m_output setOutputSettings:[NSDictionary dictionaryWithObject:AVVideoCodecJPEG forKey:AVVideoCodecKey]];
	
 // output.minFrameDuration = CMTimeMake(1, 15);
	[self.session addOutput:m_output];
	GtRelease(m_output);
}

- (void) _configureSession:(AVCaptureSession*) session
{
	self.session.sessionPreset = AVCaptureSessionPresetPhoto;
}

- (void) _cleanupCamera
{
	[super _cleanupCamera];
	m_output = nil;
}

+ (void) convertToData:(CMSampleBufferRef) buffer outData:(NSData**) outData
{
	NSData* data = nil;
	if (buffer != NULL)
	{	
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		@try
		{
			data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:buffer];
			
			if(outData)
			{
				*outData = GtRetain(data);
			}
			GtDrainPool(&pool);
		}
		@catch(NSException* ex)
		{
			GtDrainPoolAndRethrow(&pool, ex);
		}
	}
}

+ (NSDictionary*) exifDataFromBuffer:(CMSampleBufferRef) buffer
{
	return (NSDictionary*) CMGetAttachment(buffer, (CFStringRef) @"MetadataDictionary", NULL);
}

+ (void) setExifDataInBuffer:(CMSampleBufferRef) buffer exif:(NSDictionary*) exif
{
	CMSetAttachment(buffer, (CFStringRef)@"MetadataDictionary", (CFDictionaryRef) exif, kCMAttachmentMode_ShouldPropagate);
	
	GtLog([[GtStillCamera exifDataFromBuffer:buffer] description]);
}

- (void) captureImage:(GtCameraCapturePhotoBlock) block
{
	AVCaptureConnection *videoConnection = [m_output.connections objectAtIndex:0];
	if ([videoConnection isVideoOrientationSupported])
	{
		[videoConnection setVideoOrientation:[UIDevice currentDevice].orientation]; // TODO: orientation is unreliable.
	}

	[m_output captureStillImageAsynchronouslyFromConnection:videoConnection
			 completionHandler:^(CMSampleBufferRef buffer, NSError *error) 
			 {		
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				block(buffer, error); 
				GtDrainPool(&pool);
			}];
}

//- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer 
//{
//	  CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
//	  // Lock the base address of the pixel buffer
//	  CVPixelBufferLockBaseAddress(imageBuffer,0);
//
//	  // Get the number of bytes per row for the pixel buffer
//	  size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
//	  // Get the pixel buffer width and height
//	  size_t width = CVPixelBufferGetWidth(imageBuffer); 
//	  size_t height = CVPixelBufferGetHeight(imageBuffer); 
//
//	  // Create a device-dependent RGB color space
//	  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
//	  if (!colorSpace) 
//	  {
//		  NSLog(@"CGColorSpaceCreateDeviceRGB failure");
//		  return nil;
//	  }
//
//	  // Get the base address of the pixel buffer
//	  void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
//	  // Get the data size for contiguous planes of the pixel buffer.
//	  size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer); 
//
//	  // Create a Quartz direct-access data provider that uses data we supply
//	  CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, 
//															  NULL);
//	  // Create a bitmap image from data supplied by our data provider
//	  CGImageRef cgImage = 
//		  CGImageCreate(width,
//						  height,
//						  8,
//						  32,
//						  bytesPerRow,
//						  colorSpace,
//						  kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
//						  provider,
//						  NULL,
//						  true,
//						  kCGRenderingIntentDefault);
//	  CGDataProviderRelease(provider);
//	  CGColorSpaceRelease(colorSpace);
//
//	  // Create and return an image object representing the specified Quartz image
//	  UIImage *image = [UIImage imageWithCGImage:cgImage];
//	  CGImageRelease(cgImage);
//
//	  CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
//
//	  return image;
//}

@end

/**
[[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
													 completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
														 if (imageDataSampleBuffer != NULL) {
															 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
															 UIImage *image = [[UIImage alloc] initWithData:imageData];																	
															 ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
															 [library writeImageToSavedPhotosAlbum:[image CGImage]
																					   orientation:(ALAssetOrientation)[image imageOrientation]
																				   completionBlock:^(NSURL *assetURL, NSError *error){
																					   if (error) {
																						   id delegate = [self delegate];
																						   if ([delegate respondsToSelector:@selector(captureStillImageFailedWithError:)]) {
																							   [delegate captureStillImageFailedWithError:error];
																						   }																							   
																					   }
																				   }];
															 GtRelease(library);
															 GtRelease(image);
														 } else if (error) {
															 id delegate = [self delegate];
															 if ([delegate respondsToSelector:@selector(captureStillImageFailedWithError:)]) {
																 [delegate captureStillImageFailedWithError:error];
															 }
														 }
													 }];
*/
#endif
#endif