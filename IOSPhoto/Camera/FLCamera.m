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

@synthesize position = _position;
@synthesize flashMode = _flashMode;
@synthesize device = _device;

@synthesize session = _session;

// Autorelease pool added thanks to suggestion by Josh Snyder
- (void)captureOutput:(AVCaptureOutput *)captureOutput 
	didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer 
	fromConnection:(AVCaptureConnection *)connection
{
}

- (void) dealloc
{
	mrc_release_(_error);
	
	FLAssert_v(_session == nil, @"must call stop before deleting camera"); 
	
	mrc_super_dealloc_();
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
	AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:&error];
	@try
	{
        if(error)
        {
            FLThrowError_(autorelease_(err));
        }

	
		[self.session addInput:input];
	}
	@finally
	{
		FLReleaseWithNil_(input);
	}
}

- (void) _addOutput
{
}

- (void) onError:(NSNotification*) sender
{
	FLRetainObject_(_error, [sender.userInfo objectForKey:AVCaptureSessionErrorKey]);

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
	return _device.position;
}

- (AVCaptureVideoPreviewLayer*) previewLayer
{
	if(!_previewLayer)
	{
		_previewLayer= [[AVCaptureVideoPreviewLayer alloc] initWithSession: self.session];
		_previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	}
	
	return _previewLayer;
}

//- (void) addCaptureLayerToView:(UIView*) inView
//{
//	[inView.layer addSublayer: self.previewLayer];
//}
//
//- (UIView *) previewWithBounds: (FLRect) bounds
//{
//	UIView *view = autorelease_([[UIView alloc] initWithFrame:bounds]);
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
	return _flashMode;
}

- (AVCaptureFocusMode) focusMode
{
	return _device.focusMode;
}

- (void) setFocusMode:(AVCaptureFocusMode) focusMode
{
	NSError* err = nil;
	if([_device lockForConfiguration:&err])
	{
		_device.focusMode = focusMode;
		
		[_device unlockForConfiguration];
	}
	        if(err)
        {
           FLThrowError_(autorelease_(err));
        }

}

- (void) setFlashMode:(AVCaptureFlashMode) mode
{	
	_flashMode = mode;
	if(_device)
	{
		NSError* err = nil;
		if([_device lockForConfiguration:&err])
		{
			_device.flashMode = mode;
			
			[_device unlockForConfiguration];
		}
		        if(err)
        {
           FLThrowError_(autorelease_(err));
        }

	}
}

- (void) start:(AVCaptureDevicePosition) position startedBlock:(FLCameraStartedBlock) startedBlock
{
	if(!_session)
	{
		NSArray* array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];

		if(array.count)
		{
			for(AVCaptureDevice* device in array)
			{
				if(position == device.position) 
				{
					_device = device;
				}
			}
		}	 
		
		if(!_device)
		{
			// throw
		}
		
		FLReleaseWithNil_(_error);
		
   
//		  dispatch_async(
//			  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//			  ^{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					_session = [[AVCaptureSession alloc] init];

					[self _configureSession:_session];
					[self _addInput];
					[self _addOutput];
			 
				
					[self.session startOperation];
					startedBlock(self, _error);	
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
	_device = nil;
	FLReleaseWithNil_(_session);
}

- (void) stop:(FLCameraStartedBlock) stoppedBlock
{
	if(_session)
	{
		NSAutoreleasePool* deleteSessionPool = [[NSAutoreleasePool alloc] init];
		_previewLayer.session = nil;
		[_previewLayer removeFromSuperlayer];
		[deleteSessionPool drain];
		
		FLReleaseWithNil_(_error);
		
//		  dispatch_async(
//			  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//			  ^{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					[_session stopRunning];
					FLReleaseWithNil_(_previewLayer);
					[self _cleanupCamera];
				
					if(stoppedBlock)
					{	
						stoppedBlock(self, _error);	
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