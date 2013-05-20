//
//	GtThumbnailView.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThumbnailView.h"

@implementation GtThumbnailView

@synthesize backgroundImage = m_backgroundImage;
@synthesize foregroundImage = m_image;
@synthesize enabled = m_enabled;

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.userInteractionEnabled = NO;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone; 
		self.backgroundColor = [UIColor whiteColor];
		self.alpha = 1.0;
		self.opaque = YES;
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.clipsToBounds = YES;
		self.enabled = YES;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_disabledView);
	GtRelease(m_image);
	GtRelease(m_backgroundImage);
	GtSuperDealloc();
}

- (CGSize)sizeThatFits:(CGSize)size
{
	if(m_image)
	{
		return m_image.size;
	}
	else if(m_backgroundImage)
	{
		return m_backgroundImage.size;
	}
	
	return CGSizeZero;
}

- (void) updateImage
{
	if(m_image)
	{
		[super setImage:m_image];
	}
	else if(m_backgroundImage)
	{
		[super setImage:m_backgroundImage];
	}
	else
	{
		[super setImage:nil];
	}
}

- (void) setForegroundImage:(UIImage*) image
 {
	if(GtAssignObject(m_image, image))
	{
		[self updateImage];
	} 
}

- (void) setBackgroundImage:(UIImage *) image
{
	if(GtAssignObject(m_backgroundImage, image))
	{
		[self updateImage];
	}
}

- (void) setImage:(UIImage*) image
{
	[self setForegroundImage:image];
}

- (void) clearImages
{
	self.foregroundImage = nil;
	self.backgroundImage = nil;
}

- (void) setEnabled:(BOOL) enabled
{
	if(m_enabled != enabled)
	{
		m_enabled = enabled;
	
		if(m_enabled && m_disabledView)
		{
			[m_disabledView removeFromSuperview];
			GtReleaseWithNil(m_disabledView);
		}
		else if(!m_enabled && !m_disabledView)
		{
			m_disabledView = [[UIView alloc] initWithFrame:self.bounds];
			m_disabledView.alpha = 0.8;
			m_disabledView.backgroundColor = [UIColor grayColor];
			[self addSubview:m_disabledView];
		}
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(m_disabledView)
	{
		m_disabledView.newFrame = self.bounds;
		[self bringSubviewToFront:m_disabledView];
	}
}
@end

