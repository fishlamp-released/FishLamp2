//
//  GtImageView.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/5/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtImageView.h"
#import "GtColors.h"
#import "GtGeometry.h"
#import "GtImageUtilities.h"

@implementation GtImageView

static UIDeviceOrientation s_lastLandscapeOrientation = UIDeviceOrientationUnknown;

GtSynthesizeStructProperty(autoRotateImage, setAutoRotateImage, BOOL, m_flags);
GtSynthesizeStructProperty(imageOrientation, setImageOrientation, UIImageOrientation, m_flags);
GtSynthesizeStructProperty(hasImage, setHasImage, BOOL, m_flags);

- (void) initImageView
{
	m_flags.orientation = UIDeviceOrientationUnknown;

	switch([[UIApplication sharedApplication] statusBarOrientation])
	{
		case UIInterfaceOrientationPortrait:
			m_flags.orientation = UIDeviceOrientationPortrait;
			break;
			
		case UIInterfaceOrientationLandscapeLeft:	
			m_flags.orientation = UIDeviceOrientationLandscapeRight;
			break;
			
		case UIInterfaceOrientationLandscapeRight:
			m_flags.orientation = UIDeviceOrientationLandscapeLeft;
			break;

	}

	GtAssert(m_flags.orientation != UIDeviceOrientationUnknown, @"unknown orientation");
	
	self.backgroundColor = [UIColor almostBlackGrayColor];

	self.contentMode = UIViewContentModeScaleAspectFit;

	self.autoresizesSubviews = YES;
	self.autoresizingMask =	UIViewAutoresizingFlexibleWidth | 
								UIViewAutoresizingFlexibleHeight |
								UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleRightMargin |
								UIViewAutoresizingFlexibleHeight |
								UIViewAutoresizingFlexibleBottomMargin; 
	
	self.userInteractionEnabled = NO;
	
	self.opaque = YES;
	
}

- (id)initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame])
	{
		[self initImageView];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image
{
	if(self = [super initWithImage:image])
	{
		[self initImageView];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
	if(self = [super initWithImage:image highlightedImage:highlightedImage])
	{
		[self initImageView];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	[self initImageView];
	if(self = [super initWithCoder:aDecoder])
	{
	}
	return self;
}

- (void) rotateImageToLongSide
{
	switch(m_flags.orientation)
	{
		case UIDeviceOrientationLandscapeLeft:
			if(!m_flags.isLandscapeImage)
			{
				[self rotateImageToOrientation:UIImageOrientationDown];
			}
		break;	
		
		case UIDeviceOrientationLandscapeRight:
			if(!m_flags.isLandscapeImage)
			{
				[self rotateImageToOrientation:UIImageOrientationDown];
			}
		break;
		
		case UIDeviceOrientationPortrait:
			if(m_flags.isLandscapeImage)
			{
				UIImageOrientation orientation = UIImageOrientationRight;
				
				if(s_lastLandscapeOrientation == UIDeviceOrientationLandscapeRight)
				{
					orientation = UIImageOrientationLeft;
				}
				
				[self rotateImageToOrientation:orientation];
			}
		break;
	}
}

+ (UIDeviceOrientation) lastLandscapeOrientation
{
	return s_lastLandscapeOrientation;
}

+ (void) setLastLandscapeOrientation:(UIDeviceOrientation) last
{
	if(	last == UIDeviceOrientationLandscapeLeft ||
		last == UIDeviceOrientationLandscapeRight )
	{
		s_lastLandscapeOrientation = last;
	}
}

- (void) setImage:(UIImage*) image
{
	m_flags.hasImage = image != nil;

	m_flags.imageOrientation = UIImageOrientationUp;
	
	switch(m_flags.orientation)
	{
		case UIDeviceOrientationLandscapeLeft:
			m_flags.imageOrientation = UIImageOrientationLeft;
			break;
		case UIDeviceOrientationLandscapeRight:
			m_flags.imageOrientation = UIImageOrientationRight;
			break;
	}

	m_flags.isLandscapeImage = image && (image.size.width > image.size.height);
	
	[super setImage:image];
	
	if(m_flags.autoRotateImage)
	{
		[self rotateImageToLongSide];
	}
}

- (void) adjustImageRotation:(BOOL) clockwise
{
	switch(m_flags.imageOrientation)
	{
		case UIImageOrientationUp:
			m_flags.imageOrientation = clockwise ? UIImageOrientationRight : UIImageOrientationLeft;
		break;
		
		case UIImageOrientationDown:
			m_flags.imageOrientation = clockwise ? UIImageOrientationLeft : UIImageOrientationRight;
		break;
		
		case UIImageOrientationLeft:
			m_flags.imageOrientation = clockwise ? UIImageOrientationUp : UIImageOrientationDown;
		break;
		
		case UIImageOrientationRight:
			m_flags.imageOrientation = clockwise ? UIImageOrientationDown : UIImageOrientationUp;
		break;
	}
}

- (void) adjustToImageFlip
{
	switch(m_flags.imageOrientation)
	{
		case UIImageOrientationUp:
			m_flags.imageOrientation = UIImageOrientationDown;
		break;
		
		case UIImageOrientationDown:
			m_flags.imageOrientation = UIImageOrientationUp;
		break;
		
		case UIImageOrientationLeft:
			m_flags.imageOrientation = UIImageOrientationRight;
		break;
		
		case UIImageOrientationRight:
			m_flags.imageOrientation = UIImageOrientationLeft;
		break;
	}
}

- (UIDeviceOrientation) orientation
{
	return m_flags.orientation;
}

- (void) setOrientation:(UIDeviceOrientation) orientation
{
	UIDeviceOrientation oldOrientation = m_flags.orientation;
	m_flags.orientation = orientation;
	
	[GtImageView setLastLandscapeOrientation:m_flags.orientation];
	
	if(m_flags.autoRotateImage)
	{
		switch(oldOrientation)
		{
			case UIDeviceOrientationPortrait:
				switch(m_flags.orientation)
				{
					case UIDeviceOrientationLandscapeLeft:
						if(m_flags.isLandscapeImage)
						{
							[self rotateImage:m_flags.imageOrientation == UIImageOrientationLeft];
						}
						else
						{
							[self rotateImage:NO];
						}
					break;
					
					case UIDeviceOrientationLandscapeRight:
						if(m_flags.isLandscapeImage)
						{
							[self rotateImage:m_flags.imageOrientation == UIImageOrientationLeft];
						}
						else
						{
							[self rotateImage:YES];
						}
					break;
				}
			break;
			
			case UIDeviceOrientationLandscapeLeft:
				switch(m_flags.orientation)
				{
					case UIDeviceOrientationPortrait:
						[self rotateImage:YES];
					break;
					
					case UIDeviceOrientationLandscapeRight:
						if(!m_flags.isLandscapeImage)
						{	
							[self flipImage];
						}
					break;
				}
			break;
			
			case UIDeviceOrientationLandscapeRight:
				switch(m_flags.orientation)
				{
					case UIDeviceOrientationPortrait:
						[self rotateImage:NO];
					break;
					
					case UIDeviceOrientationLandscapeLeft:
						if(!m_flags.isLandscapeImage)
						{
							[self flipImage];
						}
					break;
				}
			break;
		}
	/*
		if(	(m_flags.orientation == UIDeviceOrientationLandscapeLeft && 
			m_flags.imageOrientation == UIImageOrientationLeft) || 
			(m_flags.orientation == UIDeviceOrientationLandscapeRight && 
			m_flags.imageOrientation == UIImageOrientationRight))
		{
			[self flipImage];
		}
	*/
	}

}

- (void) rotateImage:(BOOL) clockwise
{
	NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];
	UIImage* image = self.image;
	UIImage* newImage = nil;
	[image rotate90Degrees:clockwise outImage:&newImage];
	[super setImage:newImage]; // don't set self's image, it will screw up state info
	GtRelease(newImage);
	GtRelease(pool);

	[self adjustImageRotation: clockwise];
}

- (void) rotateImageToOrientation:(UIImageOrientation) orientation
{
	if(orientation != m_flags.imageOrientation)
	{
		switch(m_flags.imageOrientation)
		{
			case UIImageOrientationUp:
				switch(orientation)
				{
					case UIImageOrientationDown:
						[self flipImage];
					break;
					
					case UIImageOrientationLeft:
						[self rotateImage:NO];
					break;
					
					case UIImageOrientationRight:
						[self rotateImage:YES];
					break;
				}
			break;
			
			case UIImageOrientationDown:
				switch(orientation)
				{
					case UIImageOrientationUp:
						[self flipImage];
					break;
					
					case UIImageOrientationLeft:
						[self rotateImage:YES];
					break;
					
					case UIImageOrientationRight:
						[self rotateImage:NO];
					break;
				}
			break;
			
			case UIImageOrientationLeft:
				switch(orientation)
				{
					case UIImageOrientationUp:
						[self rotateImage:YES];
					break;
					
					case UIImageOrientationDown:
						[self rotateImage:NO];
					break;
					
					case UIImageOrientationRight:
						[self flipImage];
					break;
				}
			break;
			
			case UIImageOrientationRight:
				switch(orientation)
				{
					case UIImageOrientationUp:
						[self rotateImage:NO];
					break;
					
					case UIImageOrientationDown:
						[self rotateImage:YES];
					break;
					
					case UIImageOrientationLeft:
						[self flipImage];
					break;
				}
			break;
		}
	}
}

- (void) flipImage
{
	NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];
	UIImage* image = self.image;
	UIImage* newImage = nil;
	[image flip:&newImage];
	[super setImage:newImage]; // don't set self's image, it will screw up state info
	GtRelease(newImage);
	GtRelease(pool);
	
	[self adjustToImageFlip];
}



- (void) rotateToOrientation:(UIDeviceOrientation) orientation 
	animate:(BOOL) animate
{
	if(m_flags.orientation == orientation )
	{
		return;
	}
	
	CGFloat angle = 0.0;
	
	switch(orientation)
	{
		case UIDeviceOrientationLandscapeLeft: 
			angle = 90.0; 
			break;

		case UIDeviceOrientationLandscapeRight: 
			angle = -90.0; 
			break;

		case UIDeviceOrientationPortrait: 
			angle = 0.0; 
			break;
			
		default:
			return;
	}
		
	if(animate)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.30];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	}
	self.transform = CGAffineTransformMakeRotation(GtDegreesToRadian(angle));
	self.frame = self.superview.bounds; // TODO: this might be wrong
	
	if(animate)
	{
		[UIView commitAnimations];
	}
	
	self.orientation = orientation;
}


@end
