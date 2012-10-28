//
//	FLCameraOverlayView.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0

#import "FLCameraOverlayView.h"
#import "FLThumbnailButton.h"
#import "FLRoundRectView.h"
#import "UIImageView.h"
#import "FLCameraConfig.h"

@implementation FLCameraOverlayView

@synthesize buttonView = _buttonView;
@synthesize cameraOverlayDelegate = _cameraOverlayDelegate;

- (void) doneButtonPressed:(id) sender
{
	[_cameraOverlayDelegate cameraOverlayViewDoneButtonPressed:self];
}

- (void) cameraFlipButtonPressed:(id) sender
{
	[_cameraOverlayDelegate cameraOverlayViewFlipCameraButtonPressed:self];
}

- (void) flashButtonPressed:(id) sender
{
	[_cameraOverlayDelegate cameraOverlayViewFlashButtonPressed:self];
}

- (void) shutterButtonPressed:(id) sender
{
	[_cameraOverlayDelegate cameraOverlayViewShutterButtonPressed:self];
}

- (void) buttonCallbackForThumbnail:(id) sender
{
	[_cameraOverlayDelegate cameraOverlayViewThumbnailButtonPressed:self];
}


- (void) zoomChanged:(UISlider*) slider
{
	[_cameraOverlayDelegate cameraOverlayView:self zoomChanged:slider.value];
}

- (void) setCommonTraitsForButtons:(UIButton*) button
{
	button.alpha = 0.6;
	button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	[button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.titleLabel.shadowOffset = FLSizeMake(0, 1.0);
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}


- (void) changedFlash:(id) sender
{
	AVCaptureFlashMode newMode = 0;

	switch(_flashSegmentedControl.selectedSegmentIndex)
	{
		case UISegmentedControlNoSegment:
		// do nothing.
		break;
			
		case 0:
			newMode = AVCaptureFlashModeOn;
			break;
		
		case 1:
			newMode = AVCaptureFlashModeOff;
			break;
	
		case 2:
			newMode = AVCaptureFlashModeAuto;
			break;

	}
	
	_flashButton.hidden = NO;
	_flashSegmentedControl.hidden = YES;
	
	[_flashSegmentedControl removeTarget:self action:@selector(changedFlash:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventValueChanged|UIControlEventTouchCancel];
	
	[self updateFlashButton :newMode];
	
	[_cameraOverlayDelegate cameraOverlayView:self flashModeWasChanged:newMode];
}

- (id) initWithFrame:(FLRect) frame
{
	if(self = [super initWithFrame:frame])
	{
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.autoresizesSubviews = NO;
		self.viewContentsDescriptor = FLViewContentsDescriptorMake(FLViewContentItemNone, FLViewContentItemNone);
			 
		_leftButton = FLReturnRetained([UIButton buttonWithType:UIButtonTypeRoundedRect]);
		[self setCommonTraitsForButtons:_leftButton];
		[_leftButton setTitle:@"Done" forState:UIControlStateNormal];
		_leftButton.frame = FLRectSetSize(_leftButton.frame, 60, 36);
		[_leftButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_leftButton];
		
		_centerButton = FLReturnRetained([UIButton buttonWithType:UIButtonTypeRoundedRect]);
		[self setCommonTraitsForButtons:_centerButton];
		_centerButton.frame = FLRectSetSize(_centerButton.frame, 160, 54);
		[_centerButton setImage:[UIImage imageNamed:@"cameraIcon.png"] forState:UIControlStateNormal];
		[_centerButton addTarget:self action:@selector(shutterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_centerButton];
		
		_rightButton = [[FLThumbnailButton alloc] initWithFrame:CGRectMake(0,0,_leftButton.frame.size.height,_leftButton.frame.size.height)];
		[_rightButton addTarget:self action:@selector(buttonCallbackForThumbnail:)];
		_rightButton.hidden = YES;
		[self addSubview:_rightButton];
		
		_shakeyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redno.png"]];
		_shakeyImageView.backgroundColor = [UIColor clearColor];
		_shakeyImageView.hidden = YES;
		[self addSubview:_shakeyImageView];
		
		_zoomSlider = [[UISlider alloc] initWithFrame:CGRectZero];
		[_zoomSlider addTarget:self action:@selector(zoomChanged:) forControlEvents:UIControlEventValueChanged];
		_zoomSlider.minimumValue = 1.0;
		_zoomSlider.maximumValue = 3.0;
		_zoomSlider.value = 1.0;
		_zoomSlider.alpha = 0.6;
		_zoomSlider.frame = FLRectSetSize(_zoomSlider.frame, 300, 20);
		_zoomSlider.transform = CGAffineTransformMakeRotation(FLDegreesToRadians(90));
		[self addSubview:_zoomSlider];
		
		_focusView = [[FLRoundRectView alloc] initWithFrame:CGRectMake(0,0,80,60)];
		_focusView.fillColor = [UIColor clearColor];
		_focusView.borderColor = [UIColor whiteColor];
		_focusView.borderLineWidth = 1.0;
		_focusView.borderAlpha = 0.8;
		_focusView.fillAlpha = 0.0;
		
		UIImageView* crosshairs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reticle_small.png"]];
		[crosshairs setViewSizeToImageSize];
		crosshairs.backgroundColor = [UIColor clearColor];
		crosshairs.alpha = 0.8;
		crosshairs.frame = FLRectCenterRectInRect(_focusView.bounds, crosshairs.frame);
		[_focusView addSubview:crosshairs];
		FLRelease(crosshairs);
		
//		  _focusView.hidden = YES;
		[self addSubview:_focusView];
		
		_countView = [[FLCountView alloc] initWithFrame:CGRectZero];
		_countView.count = 0;
		_countView.hidden = YES;
		[self addSubview:_countView];
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_spinner.hidesWhenStopped = YES;
		[_spinner stopAnimating];
		[self addSubview:_spinner];
		
		_flipCameraButton = FLReturnRetained([UIButton buttonWithType:UIButtonTypeRoundedRect]);
		[self setCommonTraitsForButtons:_flipCameraButton];
		[_flipCameraButton setImage:[UIImage imageNamed:@"sync.png"] forState:UIControlStateNormal];
		[_flipCameraButton addTarget:self action:@selector(cameraFlipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[_flipCameraButton setTitle:@"Rear" forState:UIControlStateNormal];
		_flipCameraButton.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
		[self addSubview:_flipCameraButton];
		
		_flashButton = FLReturnRetained([UIButton buttonWithType:UIButtonTypeRoundedRect]);
		[_flashButton setImage:[UIImage imageNamed:@"64-zap.png"] forState:UIControlStateNormal];
		[_flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[_flashButton setTitle:@"Auto" forState:UIControlStateNormal];
		_flashButton.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
		[self setCommonTraitsForButtons:_flashButton];
		[self addSubview:_flashButton];
	 
		NSArray* items = [[NSArray alloc] initWithObjects:@"On", @"Off", @"Auto", nil];
		_flashSegmentedControl = [[UISegmentedControl alloc] initWithItems:items];
		_flashSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
		_flashSegmentedControl.alpha = _flashButton.alpha;
		_flashSegmentedControl.selectedSegmentIndex = 1;
		_flashSegmentedControl.hidden = YES;
		FLRelease(items);
		[self addSubview:_flashSegmentedControl];
	}
	return self;
}



- (void) setFocusRectVisible:(BOOL) visible
{
	_focusView.hidden = !visible;
}

- (void) showFocusGraphicAt:(FLPoint) pt isVisible:(BOOL) isVisible
{
//	  _focusView.hidden = NO;
	if(!_dragging)
	{
		_focusView.frame = FLRectCenterOnPoint(_focusView.frame, pt);
		_focusView.borderColor = isVisible ? [UIColor blueColor] : [UIColor whiteColor];
		[_focusView setNeedsDisplay];
	}
}

- (void) dealloc
{
	FLReleaseWithNil(_leftButton);
	FLReleaseWithNil(_rightButton);
	FLReleaseWithNil(_centerButton);
	FLReleaseWithNil(_countView);
	FLReleaseWithNil(_focusView);
	FLReleaseWithNil(_imageView);
	FLReleaseWithNil(_shakeyImageView);
	FLReleaseWithNil(_zoomSlider);
	FLReleaseWithNil(_flashSegmentedControl);
	FLReleaseWithNil(_flashButton);
	FLReleaseWithNil(_flipCameraButton);
	FLReleaseWithNil(_spinner);
	FLSuperDealloc();
}	

- (void) setButtonsEnabled:(BOOL) enabled
{
	_flashButton.enabled = enabled; 
	_flipCameraButton.enabled = enabled; 
	_leftButton.enabled = enabled; 
	_rightButton.enabled = enabled; 
	_centerButton.enabled = enabled; 
	_zoomSlider.enabled = enabled;
}

- (void) setThumbnail:(UIImage*) image newCount:(NSInteger) newCount;
{
	_rightButton.hidden = NO;
	_rightButton.image = image;
	_countView.count = newCount;
	_countView.hidden = NO;
}

- (void) removeThumbnail
{
	_rightButton.image = nil;
	_rightButton.hidden = YES;
	_countView.hidden = YES;
}

- (void) startSpinner
{
	[_spinner startAnimating];
}

- (void) stopSpinner
{
	[_spinner stopAnimating];
}

- (void) showFullFlashControl:(FLCameraConfig*) cameraConfig;
{
	_flashSegmentedControl.hidden = NO;
	_flashButton.hidden = YES;
	
	switch(cameraConfig.captureFlashMode)
	{
		case AVCaptureFlashModeOff:
			_flashSegmentedControl.selectedSegmentIndex = 1;
		break;
		
		case AVCaptureFlashModeAuto:
			_flashSegmentedControl.selectedSegmentIndex = 2;
		break;
		
		case AVCaptureFlashModeOn:
			_flashSegmentedControl.selectedSegmentIndex = 0;
		break;
	}
	
	[_flashSegmentedControl addTarget:self action:@selector(changedFlash:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventValueChanged|UIControlEventTouchCancel];
}

- (void) updateFlipCameraButton:(FLCameraConfig*) cameraConfig
{
	switch(cameraConfig.captureDevicePosition)
	{
		case AVCaptureDevicePositionBack:
			[_flipCameraButton setTitle:@"Rear" forState:UIControlStateNormal];
			break;
		case AVCaptureDevicePositionFront:
			[_flipCameraButton setTitle:@"Front" forState:UIControlStateNormal];
			break;
	}
	
	[self setNeedsLayout];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	UIView* view = (UIView*) context;
	[view removeFromSuperview];
}

- (void) flashScreen
{
	UIView* flashView = [[UIView alloc] initWithFrame:self.bounds];
	flashView.backgroundColor = [UIColor whiteColor];
	flashView.alpha = 1.0;
	[self addSubview:flashView];
	FLRelease(flashView);
	
	[UIView beginAnimations:@"viewin" context:flashView];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	flashView.alpha = 0.0;
	[UIView commitAnimations];
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	self.newFrame = self.superview.bounds;

	float bottomRowCenter = self.bounds.size.height - 30;

	_leftButton.newFrame = FLRectCenterOnPoint(_leftButton.frame, 
		CGPointMake((_leftButton.frame.size.width/2.0) + 10, bottomRowCenter));
		
	_centerButton.newFrame = FLRectCenterOnPoint(_centerButton.frame,
		CGPointMake(self.bounds.size.width / 2.0, bottomRowCenter));
		
	_rightButton.newFrame = FLRectCenterOnPoint(_rightButton.frame,
		CGPointMake(self.bounds.size.width - (_rightButton.frame.size.width/2.0) - 10, bottomRowCenter));
	
	_shakeyImageView.newFrame = FLRectCenterRectInRectHorizontally(self.bounds, FLRectSetTop(_shakeyImageView.frame, 100));

	_zoomSlider.newFrame = FLRectCenterRectInRectVertically(self.bounds, FLRectSetLeft(_zoomSlider.frame, self.bounds.size.width - 40) );
	
	_spinner.newFrame = FLRectCenterRectInRect(self.bounds, _spinner.frame);
	
	[_flipCameraButton sizeToFit];
	FLRect flipFrame = FLRectAddWidth(_flipCameraButton.frame, 10);
	_flipCameraButton.newFrame = FLRectSetOrigin(flipFrame, self.bounds.size.width - flipFrame.size.width - 10, 10);	
	
	[_flashButton sizeToFit];
	_flashButton.newFrame = FLRectSetOrigin(FLRectAddWidth(_flashButton.frame, 10), 10, 10);
   
	_flashSegmentedControl.newFrame = FLRectSetOriginWithPoint( 
		FLRectSetHeight(_flashSegmentedControl.frame, CGRectGetHeight(_flashButton.frame)), _flashButton.frame.origin);
   
	_countView.newFrame = FLRectCenterOnPoint(_countView.frame, FLRectGetTopRight(_rightButton.frame));	  
}

- (void) updateFlashButtonWithFlashMode:(FLCameraConfig*) cameraConfig
{
	switch(cameraConfig.captureFlashMode)
	{
		case AVCaptureFlashModeOff:
			[_flashButton setTitle:@"Off" forState:UIControlStateNormal];
		break;
		
		case AVCaptureFlashModeAuto:
			[_flashButton setTitle:@"Auto" forState:UIControlStateNormal];
		break;
		
		case AVCaptureFlashModeOn:
			[_flashButton setTitle:@"On" forState:UIControlStateNormal];
		break;
	}
	
	[self setNeedsLayout];
}
- (void) setShakyIconVisible:(BOOL) isVisible
{
	 _shakeyImageView.hidden = !isVisible;
}

void DrawVerticalLine(CGContextRef ctx, CGFloat x, CGFloat height)
{
	CGContextMoveToPoint(ctx, x, 0);
	CGContextAddLineToPoint(ctx , x, height);
	CGContextStrokePath(ctx);
}

void DrawHorizontalLine(CGContextRef ctx, CGFloat y, CGFloat width)
{
	CGContextMoveToPoint(ctx, 0, y);
	CGContextAddLineToPoint(ctx , width, y);
	CGContextStrokePath(ctx);
}

- (void) drawRect:(FLRect) rect 
{
	[super drawRect:rect];
	CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
//	CGContextSetLineWidth(ctx, 0.25);
	CGContextSetRGBStrokeColor(ctx, 0.3, 0.3, 0.3, 1); 
//	CGContextStrokePath(ctx);

	DrawVerticalLine(ctx, self.bounds.size.width*0.33, self.bounds.size.height);
	DrawVerticalLine(ctx, self.bounds.size.width*0.66, self.bounds.size.height);

	DrawHorizontalLine(ctx, self.bounds.size.height*0.33, self.bounds.size.width);
	DrawHorizontalLine(ctx, self.bounds.size.height*0.66, self.bounds.size.width);
//	  DrawHorizontalLine(ctx, self.bounds.size.height*0.75, self.bounds.size.width);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{	
	_dragging = YES;
	_focusView.borderColor = [UIColor blueColor];
	_focusView.frame = FLRectCenterOnPoint(_focusView.frame, [touches.anyObject locationInView:self]);
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	_dragging = YES;
	_focusView.borderColor = [UIColor blueColor];
	_focusView.frame = FLRectCenterOnPoint(_focusView.frame, [touches.anyObject locationInView:self]);
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	_dragging = NO;
	_focusView.borderColor = [UIColor whiteColor];
	_focusView.frame = FLRectCenterOnPoint(_focusView.frame, [touches.anyObject locationInView:self]);
	[_cameraOverlayDelegate cameraOverlayView:self userTouchScreenAtPoint:[touches.anyObject locationInView:self]]; 
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	_dragging = NO;
	_focusView.borderColor = [UIColor whiteColor];
	_focusView.frame = FLRectCenterOnPoint(_focusView.frame, [touches.anyObject locationInView:self]);
	[_cameraOverlayDelegate cameraOverlayView:self userTouchScreenAtPoint:[touches.anyObject locationInView:self]]; 
	[super touchesBegan:touches withEvent:event];
}

@end
#endif
#endif
