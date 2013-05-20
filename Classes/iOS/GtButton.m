//
//	GtButton.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtButton.h"

#import "UIImage+GtColorize.h"
#import "UIImage+Resize.h"


@implementation GtButton
#define RECT_PADDING 2.0

@synthesize titleLabel = m_titleLabel;
//@synthesize layoutMode = m_layoutMode;
@synthesize callback = m_buttonWasPressedCallback;
@synthesize cornerRadius = m_cornerRadius;

- (CGSize) defaultSize
{
	return CGSizeMake(100,40);
}

- (void) _initButton
{
	if(CGRectIsEmpty(self.frame))
	{
		self.frame = GtRectMakeWithSize([self defaultSize]);
	}
	m_buttonFlags.isEnabled = YES;
	m_titleLabel = [[GtLabel alloc] initWithFrame:CGRectZero];
	m_titleLabel.opaque = YES;
	m_titleLabel.alpha = 1.0;
	m_titleLabel.backgroundColor = [UIColor clearColor];
	m_titleLabel.enabled = YES;
	[self addSubview:m_titleLabel];
	self.autoresizesSubviews = NO;
	self.exclusiveTouch = YES;
	self.userInteractionEnabled = YES;
	self.cornerRadius = 6.0f;
	
	self.clipsToBounds = NO;
	
//	  self.layer.cornerRadius = 6.0f;
//	  self.layer.masksToBounds = YES;
//	  self.layer.borderColor = [UIColor darkGrayColor].CGColor;
	
//	  [GtRgbColor(100, 103, 107) CGColor];
//	  self.layer.borderWidth = 1.0f;
}

- (void) addImageShadow:(UIColor*) withColor
{
	m_imageView.layer.shadowColor = withColor.CGColor;
	m_imageView.layer.shadowOpacity = 0.5;
	m_imageView.layer.shadowRadius = 5.0;
	m_imageView.layer.shadowOffset = CGSizeMake(0,3);
	m_imageView.clipsToBounds = NO;
}

//- (void) setCornerRadius:(CGFloat) radius
//{
//	  self.layer.cornerRadius = radius;
//}

//- (CGFloat) cornerRadius
//{
//	  return self.layer.cornerRadius;
//}
//
//- (CGFloat) borderWidth
//{
//	  return self.layer.borderWidth;
//}

//- (void) setBorderWidth:(CGFloat) width
//{
//	  self.layer.borderWidth = width;
//}

//- (UIColor*) borderColor
//{
//	  return [UIColor colorWithCGColor:self.layer.borderColor];
//}
//
//- (void) setBorderColor:(UIColor*) color
//{
//	  self.layer.borderColor = color.CGColor;
//}
	

- (CGRect) rectUsedForCenteringSubviews
{
	return self.bounds;
}	

- (id)initWithCoder:(NSCoder *)aDecoder
{
	[self _initButton];
	if ((self = [super initWithCoder:aDecoder])) 
	{	
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)aRect 
{
	if ((self = [super initWithFrame: aRect])) 
	{
		[self _initButton];
	}

	return self;
}

- (void) dealloc
{
	GtRelease(m_disabledImage);
	GtRelease(m_image);
	GtRelease(m_titleLabel);
	GtRelease(m_imageView);
	GtSuperDealloc();
}

- (BOOL) isTranslucent
{
	return m_buttonFlags.isTranslucent;
}

- (BOOL) isHighlighted
{
	return m_buttonFlags.isHighlighted;
}

- (BOOL) isEnabled
{
	return m_buttonFlags.isEnabled;
}

- (void) setTranslucent:(BOOL) transluscent
{
	m_buttonFlags.isTranslucent = transluscent;
	[self setNeedsDisplay];
}

//- (void) _updateBackgroundViews
//{
//	  if(m_highlightedBackgroundView)
//	  {
//		  m_highlightedBackgroundView.hidden = !self.isHighlighted;
//	  }
//	  if(m_backgroundView)
//	  {
//		  m_backgroundView.hidden = self.isHighlighted;
//	  }
//}

- (void) setHighlighted:(BOOL) highlighted
{
	m_titleLabel.highlighted = highlighted;
	m_buttonFlags.isHighlighted = highlighted;
	[self setNeedsDisplay];
//	  [self _updateBackgroundViews];
}

- (void) setEnabled:(BOOL) enabled
{
	m_titleLabel.enabled = enabled;
	m_buttonFlags.isEnabled = enabled;

	if(m_image)
	{
		if(enabled)
		{
			m_imageView.image = m_image;
		}
		else
		{
			if(!m_disabledImage)
			{
				m_disabledImage = [[m_image imageTintedWithColor:[UIColor grayColor] fraction:0] retain];
			}
			m_imageView.image = m_disabledImage;
		}
	
	}

	if(enabled)
	{
//		  m_disabledView.hidden = YES;
	}
	else 
	{
//		  if(self.backgroundColor.isLightColor)
//		  {
//			  m_disabledView.backgroundColor = [UIColor blackColor];
//		  }
//		  else
//		  {
//			  m_disabledView.backgroundColor = [UIColor grayColor];
//		  }
 //	  m_disabledView.hidden = NO;
 //	  [self bringSubviewToFront:m_disabledView];
 //	  m_disabledView.frame = self.bounds;
	}
	
	[self setNeedsLayout];
}

- (UIImageView*) imageView
{
	if(!m_imageView)
	{
		m_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		m_imageView.autoresizingMask = UIViewAutoresizingNone;
		m_imageView.contentMode = UIViewContentModeScaleAspectFit;
		m_imageView.clipsToBounds = NO;
		[self addSubview:m_imageView];
	}
	return m_imageView;
}

- (void)setCallback:(id)target action:(SEL)action
{
	m_buttonWasPressedCallback.target = target;
	m_buttonWasPressedCallback.action = action;
}

- (NSString*) title
{
	return m_titleLabel.text;
}

- (void) setTitle:(NSString*) string
{
	m_titleLabel.text = string;
	[m_titleLabel sizeToFitText];
	[self setNeedsLayout];
}

- (UIImage*) image
{
	return m_image;
}

- (void) setImage:(UIImage*) image
{
	GtReleaseWithNil(m_disabledImage);
	GtAssignObject(m_image, image);
	self.imageView.image = m_image;
	[self.imageView resizeToImageSize];
	[self setNeedsLayout];
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	self.highlighted = NO;
}

#define kVerticalOffset 0.0f

- (void) updateImageAndTextViewPositions
{
	CGRect rectUsedForCenteringSubviews = self.rectUsedForCenteringSubviews;
	CGFloat border = (rectUsedForCenteringSubviews.size.width - (m_imageView.frame.size.width + m_titleLabel.frame.size.width + 10.f)) / 2.0f;
	m_imageView.frameOptimizedForLocation = 
		GtRectMoveVertically(
		GtRectCenterRectInRectVertically(rectUsedForCenteringSubviews, GtRectSetLeft(m_imageView.frame, border)), kVerticalOffset);

	m_titleLabel.frameOptimizedForLocation = GtRectCenterRectInRectVertically(rectUsedForCenteringSubviews, GtRectSetLeft(self.titleLabel.frame, GtRectGetRight(m_imageView.frame) + 10.f));
}

- (void)layoutSubviews 
{
	[super layoutSubviews];
	
	CGRect rectUsedForCenteringSubviews = [self rectUsedForCenteringSubviews];

	if(GtStringIsNotEmpty(m_titleLabel.text))
	{
		[m_titleLabel sizeToFitText];
		
		if(self.image)
		{
			[self updateImageAndTextViewPositions];
		}
		else
		{
			m_titleLabel.frameOptimizedForLocation = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterRectInRect(rectUsedForCenteringSubviews, m_titleLabel.frame));
		}
	
	}
	else if(m_image)
	{
		m_imageView.frameOptimizedForLocation = GtRectCenterRectInRect(rectUsedForCenteringSubviews, m_imageView.frame);
	}
		
//	  GtAssert(m_imageView.isFrameOptimized, @"image view frame not optimized");	
//	  GtAssert(m_titleLabel.isFrameOptimized, @"title view frame not optimized");	 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(self.isEnabled)
	{
		m_buttonFlags.isTouching = YES;
		m_startTap = [NSDate timeIntervalSinceReferenceDate];
		self.highlighted = YES;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(self.isEnabled && m_buttonFlags.isTouching)
	{
		UITouch* touch = [touches anyObject];
		self.highlighted = [self pointInside:[touch locationInView:self] withEvent:event];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	m_buttonFlags.isTouching = NO;
	self.highlighted = NO;

	[super touchesCancelled:touches withEvent:event];
}

- (void) _sendEvent:(id) sender
{
	self.highlighted = NO;
	GtInvokeCallback(m_buttonWasPressedCallback, self);
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
	m_buttonFlags.isTouching = NO;
	
//	[super touchesEnded:touches withEvent:event];
	
	if(self.isEnabled)
	{
		UITouch* touch = [touches anyObject];
		if([self pointInside:[touch locationInView:self] withEvent:event])
		{
			NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - m_startTap;
			if(delay < 0.10)
			{
				[self performSelector:@selector(_sendEvent:) 
						   withObject:nil afterDelay:delay];
			}
			else
			{
				[self _sendEvent:nil];
			}
		}
		else
		{
			self.highlighted = NO;
		}
	}
}


- (BOOL) setViewSizeToContentSize
{
	if(self.superview)
	{
		CGSize size = self.frame.size;
		if(GtStringIsNotEmpty(self.titleLabel.text))
		{
			[self.titleLabel sizeToFitText];
			size = self.titleLabel.frame.size;
		}
		
		size.width += 80;
		size.height *= 2;
		
		self.newFrame = GtRectSetSizeWithSize(self.frame, size);
		[self setNeedsLayout];
	}

	return YES;
}

- (UIFont*) titleFont
{
	return [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
}

- (void) setDarkText
{
	m_titleLabel.textDescriptor = [GtTextDescriptor textDescriptor:[self titleFont] 
		enabledColor:[UIColor blackColor] 
		enabledShadowColor:[UIColor whiteColor] 
		disabledColor:[UIColor grayColor] 
		disabledShadowColor:[UIColor whiteColor] 
		highlightedColor:[UIColor whiteColor] 
		highlightedShadowColor:[UIColor blackColor] 
		selectedColor:nil 
		selectedShadowColor:nil 
		shadowOffset:CGSizeZero];
}

- (void) setLightText
{
	m_titleLabel.textDescriptor = [GtTextDescriptor textDescriptor:[self titleFont] 
		enabledColor:[UIColor whiteColor] 
		enabledShadowColor:[UIColor blackColor] 
		disabledColor:[UIColor grayColor] 
		disabledShadowColor:[UIColor blackColor] 
		highlightedColor:[UIColor whiteColor] 
		highlightedShadowColor:[UIColor darkGrayColor] 
		selectedColor:nil 
		selectedShadowColor:nil 
		shadowOffset:CGSizeZero];
 
}

- (void) autoSetTextColor
{
	if(self.backgroundColor.isLightColor)
	{
		[self setDarkText];
	}
	else
	{
		[self setLightText];
	}	 
}


@end


