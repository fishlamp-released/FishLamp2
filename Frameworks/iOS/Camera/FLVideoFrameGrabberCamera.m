//
//	FLVideoFrameGrabberCamera.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLVideoFrameGrabberCamera.h"

#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0

@implementation FLVideoFrameGrabberCamera

- (id) init
{
	if(self = [super init])
	{
	}
	
	return self;
}	

- (void) dealloc
{
	FLRelease(_frames);
	FLSuperDealloc();
}

- (void) _addOutput
{
	AVCaptureVideoDataOutput* captureOutput = FLAutorelease([[AVCaptureVideoDataOutput alloc] init]);
	
	NSDictionary *settings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
	[captureOutput setVideoSettings:settings];
	captureOutput.alwaysDiscardsLateVideoFrames = YES; 

	dispatch_queue_t queue = dispatch_queue_create("com.myapp.tasks.grabcameraframes", NULL);

	[captureOutput setSampleBufferDelegate:self queue:queue];
	
	dispatch_release(queue); // Will not work when uncommented -- apparently reference count is altered by 
	
	[self.context addOutput:captureOutput];

}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
	if(_capturing)
	{
		NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
		if([NSDate timeIntervalSinceReferenceDate] >= _nextFrame)
		{
			NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
			CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
			CVPixelBufferLockBaseAddress(imageBuffer,0); 
			uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer); 
			size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
			size_t width = CVPixelBufferGetWidth(imageBuffer); 
			size_t height = CVPixelBufferGetHeight(imageBuffer); 
			
			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
			CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst); 
			CGImageRef newImage = CGBitmapContextCreateImage(context); 
			CVPixelBufferUnlockBaseAddress(imageBuffer,0);
			
			[_frames addObject: [UIImage imageWithCGImage:newImage scale:1.0 orientation:UIImageOrientationRight]];
			
			CGContextRelease(context); 
			CGColorSpaceRelease(colorSpace);
			CGImageRelease(newImage);
			
			_nextFrame = now + _interval;
			if(++_frame >= _frameCount)
			{
				_capturing = NO;
				_block(self, nil);
				FLRelease(_block);
				_block = nil;
				
				FLReleaseWithNil(_frames);
			}
			
			FLDrainPool(&pool);
			
		}
	}
}

- (void) captureFrames:(NSUInteger) count 
					interval:(NSTimeInterval) interval
					block:(FLVideoFrameGrabberCameraBlock) block
{
	_frames = [[NSMutableArray alloc] init];
	_frame = 0;
	_frameCount = count;
	_nextFrame = [NSDate timeIntervalSinceReferenceDate];
	_interval = interval;
	_block = FLRetain(block);
	_capturing = YES;
}

- (void) _configureSession:(AVCaptureSession*) session
{
//	  self.context.sessionPreset = AVCaptureSessionPresetPhoto;
}

@end
#endif
#endif