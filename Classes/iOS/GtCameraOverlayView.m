//
//	GtCameraOverlayView.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0

#import "GtCameraOverlayView.h"
#import "GtThumbnailButton.h"
#import "GtRoundRectView.h"
#import "UIImageView.h"
#import "GtCameraConfig.h"

@implementation GtCameraOverlayView

@synthesize buttonView = m_buttonView;
@synthesize cameraOverlayDelegate = m_cameraOverlayDelegate;

- (void) doneButtonPressed:(id) sender
{
	[m_cameraOverlayDelegate cameraOverlayViewDoneButtonPressed:self];
}

- (void) cameraFlipButtonPressed:(id) sender
{
	[m_cameraOverlayDelegate cameraOverlayViewFlipCameraButtonPressed:self];
}

- (void) flashButtonPressed:(id) sender
{
	[m_cameraOverlayDelegate cameraOverlayViewFlashButtonPressed:self];
}

- (void) shutterButtonPressed:(id) sender
{
	[m_cameraOverlayDelegate cameraOverlayViewShutterButtonPressed:self];
}

- (void) buttonCallbackForThumbnail:(id) sender
{
	[m_cameraOverlayDelegate cameraOverlayViewThumbnailButtonPressed:self];
}


- (void) zoomChanged:(UISlider*) slider
{
	[m_cameraOverlayDelegate cameraOverlayView:self zoomChanged:slider.value];
}

- (void) setCommonTraitsForButtons:(UIButton*) button
{
	button.alpha = 0.6;
	button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	[button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.titleLabel.shadowOffset = CGSizeMake(0, 1.0);
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}


- (void) changedFlash:(id) sender
{
	AVCaptureFlashMode newMode = 0;

	switch(m_flashSegmentedControl.selectedSegmentIndex)
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
	
	m_flashButton.hidden = NO;
	m_flashSegmentedControl.hidden = YES;
	
	[m_flashSegmentedControl removeTarget:self action:@selector(changedFlash:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventValueChanged|UIControlEventTouchCancel];
	
	[self updateFlashButton :newMode];
	
	[m_cameraOverlayDelegate cameraOverlayView:self flashModeWasChanged:newMode];
}

- (id) initWithFrame:(CGRect) frame
{
	if(self = [super initWithFrame:frame])
	{
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.autoresizesSubviews = NO;
		self.viewContentsDescriptor = GtViewContentsDescriptorMake(GtViewContentItemNone, GtViewContentItemNone);
			 
		m_leftButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[self setCommonTraitsForButtons:m_leftButton];
		[m_leftButton setTitle:@"Done" forState:UIControlStateNormal];
		m_leftButton.frame = GtRectSetSize(m_leftButton.frame, 60, 36);
		[m_leftButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_leftButton];
		
		m_centerButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[self setCommonTraitsForButtons:m_centerButton];
		m_centerButton.frame = GtRectSetSize(m_centerButton.frame, 160, 54);
		[m_centerButton setImage:[UIImage imageNamed:@"cameraIcon.png"] forState:UIControlStateNormal];
		[m_centerButton addTarget:self action:@selector(shutterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_centerButton];
		
		m_rightButton = [[GtThumbnailButton alloc] initWithFrame:CGRectMake(0,0,m_leftButton.frame.size.height,m_leftButton.frame.size.height)];
		[m_rightButton addTarget:self action:@selector(buttonCallbackForThumbnail:)];
		m_rightButton.hidden = YES;
		[self addSubview:m_rightButton];
		
		m_shakeyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redno.png"]];
		m_shakeyImageView.backgroundColor = [UIColor clearColor];
		m_shakeyImageView.hidden = YES;
		[self addSubview:m_shakeyImageView];
		
		m_zoomSlider = [[UISlider alloc] initWithFrame:CGRectZero];
		[m_zoomSlider addTarget:self action:@selector(zoomChanged:) forControlEvents:UIControlEventValueChanged];
		m_zoomSlider.minimumValue = 1.0;
		m_zoomSlider.maximumValue = 3.0;
		m_zoomSlider.value = 1.0;
		m_zoomSlider.alpha = 0.6;
		m_zoomSlider.frame = GtRectSetSize(m_zoomSlider.frame, 300, 20);
		m_zoomSlider.transform = CGAffineTransformMakeRotation(GtDegreesToRadians(90));
		[self addSubview:m_zoomSlider];
		
		m_focusView = [[GtRoundRectView alloc] initWithFrame:CGRectMake(0,0,80,60)];
		m_focusView.fillColor = [UIColor clearColor];
		m_focusView.borderColor = [UIColor whiteColor];
		m_focusView.borderLineWidth = 1.0;
		m_focusView.borderAlpha = 0.8;
		m_focusView.fillAlpha = 0.0;
		
		UIImageView* crosshairs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reticle_small.png"]];
		[crosshairs setViewSizeToImageSize];
		crosshairs.backgroundColor = [UIColor clearColor];
		crosshairs.alpha = 0.8;
		crosshairs.frame = GtRectCenterRectInRect(m_focusView.bounds, crosshairs.frame);
		[m_focusView addSubview:crosshairs];
		GtRelease(crosshairs);
		
//		  m_focusView.hidden = YES;
		[self addSubview:m_focusView];
		
		m_countView = [[GtCountView alloc] initWithFrame:CGRectZero];
		m_countView.count = 0;
		m_countView.hidden = YES;
		[self addSubview:m_countView];
		
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		m_spinner.hidesWhenStopped = YES;
		[m_spinner stopAnimating];
		[self addSubview:m_spinner];
		
		m_flipCameraButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[self setCommonTraitsForButtons:m_flipCameraButton];
		[m_flipCameraButton setImage:[UIImage imageNamed:@"sync.png"] forState:UIControlStateNormal];
		[m_flipCameraButton addTarget:self action:@selector(cameraFlipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[m_flipCameraButton setTitle:@"Rear" forState:UIControlStateNormal];
		m_flipCameraButton.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
		[self addSubview:m_flipCameraButton];
		
		m_flashButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[m_flashButton setImage:[UIImage imageNamed:@"64-zap.png"] forState:UIControlStateNormal];
		[m_flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[m_flashButton setTitle:@"Auto" forState:UIControlStateNormal];
		m_flashButton.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
		[self setCommonTraitsForButtons:m_flashButton];
		[self addSubview:m_flashButton];
	 
		NSArray* items = [[NSArray alloc] initWithObjects:@"On", @"Off", @"Auto", nil];
		m_flashSegmentedControl = [[UISegmentedControl alloc] initWithItems:items];
		m_flashSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
		m_flashSegmentedControl.alpha = m_flashButton.alpha;
		m_flashSegmentedControl.selectedSegmentIndex = 1;
		m_flashSegmentedControl.hidden = YES;
		GtRelease(items);
		[self addSubview:m_flashSegmentedControl];
	}
	return self;
}



- (void) setFocusRectVisible:(BOOL) visible
{
	m_focusView.hidden = !visible;
}

- (void) showFocusGraphicAt:(CGPoint) pt isVisible:(BOOL) isVisible
{
//	  m_focusView.hidden = NO;
	if(!m_dragging)
	{
		m_focusView.frame = GtRectCenterOnPoint(m_focusView.frame, pt);
		m_focusView.borderColor = isVisible ? [UIColor blueColor] : [UIColor whiteColor];
		[m_focusView setNeedsDisplay];
	}
}

- (void) dealloc
{
	GtReleaseWithNil(m_leftButton);
	GtReleaseWithNil(m_rightButton);
	GtReleaseWithNil(m_centerButton);
	GtReleaseWithNil(m_countView);
	GtReleaseWithNil(m_focusView);
	GtReleaseWithNil(m_imageView);
	GtReleaseWithNil(m_shakeyImageView);
	GtReleaseWithNil(m_zoomSlider);
	GtReleaseWithNil(m_flashSegmentedControl);
	GtReleaseWithNil(m_flashButton);
	GtReleaseWithNil(m_flipCameraButton);
	GtReleaseWithNil(m_spinner);
	GtSuperDealloc();
}	

- (void) setButtonsEnabled:(BOOL) enabled
{
	m_flashButton.enabled = enabled; 
	m_flipCameraButton.enabled = enabled; 
	m_leftButton.enabled = enabled; 
	m_rightButton.enabled = enabled; 
	m_centerButton.enabled = enabled; 
	m_zoomSlider.enabled = enabled;
}

- (void) setThumbnail:(UIImage*) image newCount:(NSInteger) newCount;
{
	m_rightButton.hidden = NO;
	m_rightButton.image = image;
	m_countView.count = newCount;
	m_countView.hidden = NO;
}

- (void) removeThumbnail
{
	m_rightButton.image = nil;
	m_rightButton.hidden = YES;
	m_countView.hidden = YES;
}

- (void) startSpinner
{
	[m_spinner startAnimating];
}

- (void) stopSpinner
{
	[m_spinner stopAnimating];
}

- (void) showFullFlashControl:(GtCameraConfig*) cameraConfig;
{
	m_flashSegmentedControl.hidden = NO;
	m_flashButton.hidden = YES;
	
	switch(cameraConfig.captureFlashMode)
	{
		case AVCaptureFlashModeOff:
			m_flashSegmentedControl.selectedSegmentIndex = 1;
		break;
		
		case AVCaptureFlashModeAuto:
			m_flashSegmentedControl.selectedSegmentIndex = 2;
		break;
		
		case AVCaptureFlashModeOn:
			m_flashSegmentedControl.selectedSegmentIndex = 0;
		break;
	}
	
	[m_flashSegmentedControl addTarget:self action:@selector(changedFlash:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventValueChanged|UIControlEventTouchCancel];
}

- (void) updateFlipCameraButton:(GtCameraConfig*) cameraConfig
{
	switch(cameraConfig.captureDevicePosition)
	{
		case AVCaptureDevicePositionBack:
			[m_flipCameraButton setTitle:@"Rear" forState:UIControlStateNormal];
			break;
		case AVCaptureDevicePositionFront:
			[m_flipCameraButton setTitle:@"Front" forState:UIControlStateNormal];
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
	GtRelease(flashView);
	
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

	m_leftButton.newFrame = GtRectCenterOnPoint(m_leftButton.frame, 
		CGPointMake((m_leftButton.frame.size.width/2.0) + 10, bottomRowCenter));
		
	m_centerButton.newFrame = GtRectCenterOnPoint(m_centerButton.frame,
		CGPointMake(self.bounds.size.width / 2.0, bottomRowCenter));
		
	m_rightButton.newFrame = GtRectCenterOnPoint(m_rightButton.frame,
		CGPointMake(self.bounds.size.width - (m_rightButton.frame.size.width/2.0) - 10, bottomRowCenter));
	
	m_shakeyImageView.newFrame = GtRectCenterRectInRectHorizontally(self.bounds, GtRectSetTop(m_shakeyImageView.frame, 100));

	m_zoomSlider.newFrame = GtRectCenterRectInRectVertically(self.bounds, GtRectSetLeft(m_zoomSlider.frame, self.bounds.size.width - 40) );
	
	m_spinner.newFrame = GtRectCenterRectInRect(self.bounds, m_spinner.frame);
	
	[m_flipCameraButton sizeToFit];
	CGRect flipFrame = GtRectAddWidth(m_flipCameraButton.frame, 10);
	m_flipCameraButton.newFrame = GtRectSetOrigin(flipFrame, self.bounds.size.width - flipFrame.size.width - 10, 10);	
	
	[m_flashButton sizeToFit];
	m_flashButton.newFrame = GtRectSetOrigin(GtRectAddWidth(m_flashButton.frame, 10), 10, 10);
   
	m_flashSegmentedControl.newFrame = GtRectSetOriginWithPoint( 
		GtRectSetHeight(m_flashSegmentedControl.frame, CGRectGetHeight(m_flashButton.frame)), m_flashButton.frame.origin);
   
	m_countView.newFrame = GtRectCenterOnPoint(m_countView.frame, GtRectGetTopRight(m_rightButton.frame));	  
}

- (void) updateFlashButtonWithFlashMode:(GtCameraConfig*) cameraConfig
{
	switch(cameraConfig.captureFlashMode)
	{
		case AVCaptureFlashModeOff:
			[m_flashButton setTitle:@"Off" forState:UIControlStateNormal];
		break;
		
		case AVCaptureFlashModeAuto:
			[m_flashButton setTitle:@"Auto" forState:UIControlStateNormal];
		break;
		
		case AVCaptureFlashModeOn:
			[m_flashButton setTitle:@"On" forState:UIControlStateNormal];
		break;
	}
	
	[self setNeedsLayout];
}
- (void) setShakyIconVisible:(BOOL) isVisible
{
	 m_shakeyImageView.hidden = !isVisible;
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

- (void) drawRect:(CGRect) rect 
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
	m_dragging = YES;
	m_focusView.borderColor = [UIColor blueColor];
	m_focusView.frame = GtRectCenterOnPoint(m_focusView.frame, [touches.anyObject locationInView:self]);
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	m_dragging = YES;
	m_focusView.borderColor = [UIColor blueColor];
	m_focusView.frame = GtRectCenterOnPoint(m_focusView.frame, [touches.anyObject locationInView:self]);
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	m_dragging = NO;
	m_focusView.borderColor = [UIColor whiteColor];
	m_focusView.frame = GtRectCenterOnPoint(m_focusView.frame, [touches.anyObject locationInView:self]);
	[m_cameraOverlayDelegate cameraOverlayView:self userTouchScreenAtPoint:[touches.anyObject locationInView:self]]; 
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	m_dragging = NO;
	m_focusView.borderColor = [UIColor whiteColor];
	m_focusView.frame = GtRectCenterOnPoint(m_focusView.frame, [touches.anyObject locationInView:self]);
	[m_cameraOverlayDelegate cameraOverlayView:self userTouchScreenAtPoint:[touches.anyObject locationInView:self]]; 
	[super touchesBegan:touches withEvent:event];
}

@end
#endif
#endif
