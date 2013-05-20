//
//	GtVideoFrameGrabberCamera.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtVideoFrameGrabberCamera.h"

#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0

@implementation GtVideoFrameGrabberCamera

- (id) init
{
	if(self = [super init])
	{
	}
	
	return self;
}	

- (void) dealloc
{
	GtRelease(m_frames);
	GtSuperDealloc();
}

- (void) _addOutput
{
	AVCaptureVideoDataOutput* captureOutput = GtReturnAutoreleased([[AVCaptureVideoDataOutput alloc] init]);
	
	NSDictionary *settings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
	[captureOutput setVideoSettings:settings];
	captureOutput.alwaysDiscardsLateVideoFrames = YES; 

	dispatch_queue_t queue = dispatch_queue_create("com.myapp.tasks.grabcameraframes", NULL);

	[captureOutput setSampleBufferDelegate:self queue:queue];
	
	dispatch_release(queue); // Will not work when uncommented -- apparently reference count is altered by 
	
	[self.session addOutput:captureOutput];

}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
	if(m_capturing)
	{
		NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
		if([NSDate timeIntervalSinceReferenceDate] >= m_nextFrame)
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
			
			[m_frames addObject: [UIImage imageWithCGImage:newImage scale:1.0 orientation:UIImageOrientationRight]];
			
			CGContextRelease(context); 
			CGColorSpaceRelease(colorSpace);
			CGImageRelease(newImage);
			
			m_nextFrame = now + m_interval;
			if(++m_frame >= m_frameCount)
			{
				m_capturing = NO;
				m_block(self, nil);
				GtRelease(m_block);
				m_block = nil;
				
				GtReleaseWithNil(m_frames);
			}
			
			GtDrainPool(&pool);
			
		}
	}
}

- (void) captureFrames:(NSUInteger) count 
					interval:(NSTimeInterval) interval
					block:(GtVideoFrameGrabberCameraBlock) block
{
	m_frames = [[NSMutableArray alloc] init];
	m_frame = 0;
	m_frameCount = count;
	m_nextFrame = [NSDate timeIntervalSinceReferenceDate];
	m_interval = interval;
	m_block = GtRetain(block);
	m_capturing = YES;
}

- (void) _configureSession:(AVCaptureSession*) session
{
//	  self.session.sessionPreset = AVCaptureSessionPresetPhoto;
}

@end
#endif
#endif