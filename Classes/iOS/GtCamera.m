//
//	GtCamera.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0

#import "GtCamera.h"

@implementation GtCamera

@synthesize position = m_position;
@synthesize flashMode = m_flashMode;
@synthesize device = m_device;

@synthesize session = m_session;

// Autorelease pool added thanks to suggestion by Josh Snyder
- (void)captureOutput:(AVCaptureOutput *)captureOutput 
	didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer 
	fromConnection:(AVCaptureConnection *)connection
{
}

- (void) dealloc
{
	GtRelease(m_error);
	
	GtAssert(m_session == nil, @"must call stop before deleting camera"); 
	
	GtSuperDealloc();
}

//- (AVCaptureDevice*) findDevice
//{
//	  NSArray* array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//
//	  if(array.count)
//	  {
//		  for(AVCaptureDevice* device in array)
//		  {
//			  if(self.position == device.position) 
//			  {
//				  return device;
//			  }
//		  }
//	  }
//	  
//	  return nil;
//}

- (void) _addInput
{
	NSError* error = nil;
	AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc] initWithDevice:m_device error:&error];
	@try
	{
        if(error)
        {
            GtThrowError(GtReturnAutoreleased(err));
        }

	
		[self.session addInput:input];
	}
	@finally
	{
		GtReleaseWithNil(input);
	}
}

- (void) _addOutput
{
}

- (void) onError:(NSNotification*) sender
{
	GtAssignObject(m_error, [sender.userInfo objectForKey:AVCaptureSessionErrorKey]);

	GtLog(@"Error: %@", [[sender.userInfo objectForKey:AVCaptureSessionErrorKey] description]);
}

- (void) _configureSession:(AVCaptureSession*) session
{
}

- (id) init
{
	if (self = [super init])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onError:) name:AVCaptureSessionRuntimeErrorNotification object:nil];
	}
	return self;
}

- (AVCaptureDevicePosition) position
{
	return m_device.position;
}

- (AVCaptureVideoPreviewLayer*) previewLayer
{
	if(!m_previewLayer)
	{
		m_previewLayer= [[AVCaptureVideoPreviewLayer alloc] initWithSession: self.session];
		m_previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	}
	
	return m_previewLayer;
}

//- (void) addCaptureLayerToView:(UIView*) inView
//{
//	[inView.layer addSublayer: self.previewLayer];
//}
//
//- (UIView *) previewWithBounds: (CGRect) bounds
//{
//	UIView *view = GtReturnAutoreleased([[UIView alloc] initWithFrame:bounds]);
//	
//	AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
//	preview.frame = bounds;
//	preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//	[view.layer addSublayer: preview];
//	
//	return view;
//}

- (AVCaptureFlashMode) flashMode
{
	return m_flashMode;
}

- (AVCaptureFocusMode) focusMode
{
	return m_device.focusMode;
}

- (void) setFocusMode:(AVCaptureFocusMode) focusMode
{
	NSError* err = nil;
	if([m_device lockForConfiguration:&err])
	{
		m_device.focusMode = focusMode;
		
		[m_device unlockForConfiguration];
	}
	        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }

}

- (void) setFlashMode:(AVCaptureFlashMode) mode
{	
	m_flashMode = mode;
	if(m_device)
	{
		NSError* err = nil;
		if([m_device lockForConfiguration:&err])
		{
			m_device.flashMode = mode;
			
			[m_device unlockForConfiguration];
		}
		        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }

	}
}

- (void) start:(AVCaptureDevicePosition) position startedBlock:(GtCameraStartedBlock) startedBlock
{
	if(!m_session)
	{
		NSArray* array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];

		if(array.count)
		{
			for(AVCaptureDevice* device in array)
			{
				if(position == device.position) 
				{
					m_device = device;
				}
			}
		}	 
		
		if(!m_device)
		{
			// throw
		}
		
		GtReleaseWithNil(m_error);
		
   
//		  dispatch_async(
//			  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//			  ^{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					m_session = [[AVCaptureSession alloc] init];

					[self _configureSession:m_session];
					[self _addInput];
					[self _addOutput];
			 
				
					[self.session startRunning];
					startedBlock(self, m_error);	
				}
				@catch(NSException*ex)
				{
					startedBlock(self, ex.error);	
				}
				
				GtDrainPool(&pool);
//				  
//			  });
	
	}
}

- (void) _cleanupCamera
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	m_device = nil;
	GtReleaseWithNil(m_session);
}

- (void) stop:(GtCameraStartedBlock) stoppedBlock
{
	if(m_session)
	{
		NSAutoreleasePool* deleteSessionPool = [[NSAutoreleasePool alloc] init];
		m_previewLayer.session = nil;
		[m_previewLayer removeFromSuperlayer];
		[deleteSessionPool drain];
		
		GtReleaseWithNil(m_error);
		
//		  dispatch_async(
//			  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//			  ^{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					[m_session stopRunning];
					GtReleaseWithNil(m_previewLayer);
					[self _cleanupCamera];
				
					if(stoppedBlock)
					{	
						stoppedBlock(self, m_error);	
					}
				}
				@catch(NSException*ex)
				{
					[self _cleanupCamera];
					if(stoppedBlock)
					{
						stoppedBlock(self, ex.error);	
					}
				}
				GtDrainPool(&pool);
//			  });
	}
}


@end
#endif
#endif