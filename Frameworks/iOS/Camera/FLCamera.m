//
//	FLCamera.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	FLRelease(_error);
	
	FLAssertWithComment(_session == nil, @"must call stop before deleting camera"); 
	
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
	AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:&error];
	@try
	{
        if(error)
        {
            FLThrowError(FLAutorelease(err));
        }

	
		[self.context addInput:input];
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
	FLSetObjectWithRetain(_error, [sender.userInfo objectForKey:AVCaptureSessionErrorKey]);

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
		_previewLayer= [[AVCaptureVideoPreviewLayer alloc] initWithSession: self.context];
		_previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	}
	
	return _previewLayer;
}

//- (void) addCaptureLayerToView:(UIView*) inView
//{
//	[inView.layer addSublayer: self.previewLayer];
//}
//
//- (UIView *) previewWithBounds: (CGRect) bounds
//{
//	UIView *view = FLAutorelease([[UIView alloc] initWithFrame:bounds]);
//	
//	AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession: self.context];
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
           FLThrowError(FLAutorelease(err));
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
           FLThrowError(FLAutorelease(err));
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
		
		FLReleaseWithNil(_error);
		
   
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
			 
				
					[self.context startOperation];
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
	FLReleaseWithNil(_session);
}

- (void) stop:(FLCameraStartedBlock) stoppedBlock
{
	if(_session)
	{
		NSAutoreleasePool* deleteSessionPool = [[NSAutoreleasePool alloc] init];
		_previewLayer.session = nil;
		[_previewLayer removeFromSuperlayer];
		[deleteSessionPool drain];
		
		FLReleaseWithNil(_error);
		
//		  dispatch_async(
//			  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
//			  ^{
				NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
				@try
				{
					[_session stopRunning];
					FLReleaseWithNil(_previewLayer);
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