//
//	FLLegacyButton.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLLegacyButton.h"

#import "UIImage+Colorize.h"
#import "UIImage+Resize.h"


@implementation FLLegacyButton
#define RECT_PADDING 2.0

@synthesize titleLabel = _titleLabel;
@synthesize callback = _buttonWasPressedCallback;
@synthesize cornerRadius = _cornerRadius;
@synthesize image = _image;
@synthesize imageView = _imageView;

- (CGSize) defaultSize
{
	return FLSizeMake(100,40);
}

- (void) _initButton
{
	if(CGRectIsEmpty(self.frame))
	{
		self.frame = FLRectMakeWithSize([self defaultSize]);
	}
	_buttonFlags.isEnabled = YES;
	_titleLabel = [[FLLabel alloc] initWithFrame:CGRectZero];
	_titleLabel.opaque = YES;
	_titleLabel.alpha = 1.0;
	_titleLabel.backgroundColor = [UIColor clearColor];
	_titleLabel.enabled = YES;
	[self addSubview:_titleLabel];
	self.autoresizesSubviews = NO;
	self.exclusiveTouch = YES;
	self.userInteractionEnabled = YES;
	self.cornerRadius = 6.0f;
	
	self.clipsToBounds = NO;
	
//	  self.layer.cornerRadius = 6.0f;
//	  self.layer.masksToBounds = YES;
//	  self.layer.borderColor = [UIColor darkGrayColor].CGColor;
	
//	  [FLRgbColor(100, 103, 107) CGColor];
//	  self.layer.borderWidth = 1.0f;
}

- (void) addImageShadow:(UIColor*) withColor
{
	_imageView.layer.shadowColor = withColor.CGColor;
	_imageView.layer.shadowOpacity = 0.5;
	_imageView.layer.shadowRadius = 5.0;
	_imageView.layer.shadowOffset = FLSizeMake(0,3);
	_imageView.clipsToBounds = NO;
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
	FLRelease(_disabledImage);
	FLRelease(_image);
	FLRelease(_titleLabel);
	FLRelease(_imageView);
	super_dealloc_();
}

- (BOOL) isTranslucent
{
	return _buttonFlags.isTranslucent;
}

- (BOOL) isHighlighted
{
	return _buttonFlags.isHighlighted;
}

- (BOOL) isEnabled
{
	return _buttonFlags.isEnabled;
}

- (void) setTranslucent:(BOOL) transluscent
{
	_buttonFlags.isTranslucent = transluscent;
	[self setNeedsDisplay];
}

//- (void) _updateBackgroundViews
//{
//	  if(_highlightedBackgroundView)
//	  {
//		  _highlightedBackgroundView.hidden = !self.isHighlighted;
//	  }
//	  if(_backgroundView)
//	  {
//		  _backgroundView.hidden = self.isHighlighted;
//	  }
//}

- (void) setHighlighted:(BOOL) highlighted
{
	_titleLabel.highlighted = highlighted;
	_buttonFlags.isHighlighted = highlighted;
	[self setNeedsDisplay];
//	  [self _updateBackgroundViews];
}

- (void) setEnabled:(BOOL) enabled
{
	_titleLabel.enabled = enabled;
	_buttonFlags.isEnabled = enabled;

	if(_image)
	{
		if(enabled)
		{
			_imageView.image = _image;
		}
		else
		{
			if(!_disabledImage)
			{
				_disabledImage = [_image imageTintedWithColor:[UIColor grayColor] fraction:0];
                mrc_retain_(_disabledImage);
			}
			_imageView.image = _disabledImage;
		}
	
	}

	if(enabled)
	{
//		  _disabledView.hidden = YES;
	}
	else 
	{
//		  if(self.backgroundColor.isLightColor)
//		  {
//			  _disabledView.backgroundColor = [UIColor blackColor];
//		  }
//		  else
//		  {
//			  _disabledView.backgroundColor = [UIColor grayColor];
//		  }
 //	  _disabledView.hidden = NO;
 //	  [self bringSubviewToFront:_disabledView];
 //	  _disabledView.frame = self.bounds;
	}
	
	[self setNeedsLayout];
}

- (UIImageView*) imageView
{
	if(!_imageView)
	{
		_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_imageView.autoresizingMask = UIViewAutoresizingNone;
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.clipsToBounds = NO;
		[self addSubview:_imageView];
	}
	return _imageView;
}

- (void)setCallback:(id)target action:(SEL)action {
	_buttonWasPressedCallback.target = target;
	_buttonWasPressedCallback.action = action;
}

- (NSString*) title
{
	return _titleLabel.text;
}

- (void) setTitle:(NSString*) string
{
	_titleLabel.text = string;
	[_titleLabel sizeToFitText];
	[self setNeedsLayout];
}


- (void) setImage:(UIImage*) image
{
	FLReleaseWithNil(_disabledImage);
	FLAssignObjectWithRetain(_image, image);
	self.imageView.image = _image;
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
	CGFloat border = (rectUsedForCenteringSubviews.size.width - (_imageView.frame.size.width + _titleLabel.frame.size.width + 10.f)) / 2.0f;
	_imageView.frameOptimizedForLocation = 
		FLRectMoveVertically(
		FLRectCenterRectInRectVertically(rectUsedForCenteringSubviews, FLRectSetLeft(_imageView.frame, border)), kVerticalOffset);

	_titleLabel.frameOptimizedForLocation = FLRectCenterRectInRectVertically(rectUsedForCenteringSubviews, FLRectSetLeft(self.titleLabel.frame, FLRectGetRight(_imageView.frame) + 10.f));
}

- (void)layoutSubviews 
{
	[super layoutSubviews];
	
	CGRect rectUsedForCenteringSubviews = [self rectUsedForCenteringSubviews];

	if(FLStringIsNotEmpty(_titleLabel.text))
	{
		[_titleLabel sizeToFitText];
		
		if(self.image)
		{
			[self updateImageAndTextViewPositions];
		}
		else
		{
			_titleLabel.frameOptimizedForLocation = FLRectOptimizedForViewSize(FLRectCenterRectInRect(rectUsedForCenteringSubviews, _titleLabel.frame));
		}
	
	}
	else if(_image)
	{
		_imageView.frameOptimizedForLocation = FLRectCenterRectInRect(rectUsedForCenteringSubviews, _imageView.frame);
	}
		
//	  FLAssert_v(_imageView.isFrameOptimized, @"image view frame not optimized");	
//	  FLAssert_v(_titleLabel.isFrameOptimized, @"title view frame not optimized");	 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(self.isEnabled)
	{
		_buttonFlags.isTouching = YES;
		_startTap = [NSDate timeIntervalSinceReferenceDate];
		self.highlighted = YES;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(self.isEnabled && _buttonFlags.isTouching)
	{
		UITouch* touch = [touches anyObject];
		self.highlighted = [self pointInside:[touch locationInView:self] withEvent:event];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	_buttonFlags.isTouching = NO;
	self.highlighted = NO;

	[super touchesCancelled:touches withEvent:event];
}

- (void) _sendEvent:(id) sender
{
    FLAutorelease(FLRetain(self));

	self.highlighted = NO;
	FLInvokeCallback(_buttonWasPressedCallback, self);
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
	_buttonFlags.isTouching = NO;
	
//	[super touchesEnded:touches withEvent:event];
	
	if(self.isEnabled)
	{
		UITouch* touch = [touches anyObject];
		if([self pointInside:[touch locationInView:self] withEvent:event])
		{
			NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - _startTap;
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
		if(FLStringIsNotEmpty(self.titleLabel.text))
		{
			[self.titleLabel sizeToFitText];
			size = self.titleLabel.frame.size;
		}
		
		size.width += 80;
		size.height *= 2;
		
		self.newFrame = FLRectSetSizeWithSize(self.frame, size);
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
	_titleLabel.textDescriptor = [FLTextDescriptor textDescriptor:[self titleFont] 
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
	_titleLabel.textDescriptor = [FLTextDescriptor textDescriptor:[self titleFont] 
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


