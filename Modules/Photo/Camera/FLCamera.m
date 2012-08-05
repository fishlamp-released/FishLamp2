//
//	FLCamera.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0

#import "FLCamera.h"

@implementation FLCamera

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
	FLRelease(m_error);
	
	FLAssert(m_session == nil, @"must call stop before deleting camera"); 
	
	FLSuperDealloc();
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
            FLThrowError(FLReturnAutoreleased(err));
        }

	
		[self.session addInput:input];
	}
	@finally
	{
		FLReleaseWithNil(input);
	}
}

- (void) _addOutput
{
}

- (void) onError:(NSNotification*) sender
{
	FLAssignObject(m_error, [sender.userInfo objectForKey:AVCaptureSessionErrorKey]);

	FLLog(@"Error: %@", [[sender.userInfo objectForKey:AVCaptureSessionErrorKey] description]);
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
//	UIView *view = FLReturnAutoreleased([[UIView alloc] initWithFrame:bounds]);
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
           FLThrowError(FLReturnAutoreleased(err));
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
           FLThrowError(FLReturnAutoreleased(err));
        }

	}
}

- (void) start:(AVCaptureDevicePosition) position startedBlock:(FLCameraStartedBlock) startedBlock
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
		
		FLReleaseWithNil(m_error);
		
   
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
				
				FLDrainPool(&pool);
//				  
//			  });
	
	}
}

- (void) _cleanupCamera
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	m_device = nil;
	FLReleaseWithNil(m_session);
}

- (void) stop:(FLCameraStartedBlock) stoppedBlock
{
	if(m_session)
	{
		NSAutoreleasePool* deleteSessionPool = [[NSAutoreleasePool alloc] init];
		m_previewLayer.session = nil;
		[m_previewLayer removeFromSuperlayer];
		[deleteSessionPool drain];
		
		FLReleaseWithNil(m_error);
		
//		  dispatch_async(
//			  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//			  ^{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					[m_session stopRunning];
					FLReleaseWithNil(m_previewLayer);
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
				FLDrainPool(&pool);
//			  });
	}
}


@end
#endif
#endif