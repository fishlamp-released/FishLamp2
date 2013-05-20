//
//	GtGradientButton.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientButton.h"
#import "UIColor+GtMoreColors.h"
#import "GtPathUtilities.h"
#import "GtRoundRectWidget.h"
#import "GtButtonBackgroundWidget.h"
#import "GtBackButtonShapeWidget.h"
#import "UIImage+Resize.h"
#import "UIImage+GtColorize.h"

void GtButtonColorRed(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(240,127,136,1.0) endColor:GtRgbColor(231,53,66,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:/*GtRgbColor(225,1,17,1.0)*/ [UIColor fireEngineRed] endColor:GtRgbColor(236,19,20,1.0)];
	[button setLightText];
}
void GtButtonColorPaleBlue(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(132,156,187,1.0) endColor:GtRgbColor(89,119,162,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:GtRgbColor(72,106,154,1.0) endColor:GtRgbColor(74,108,155,1.0)];
	[button setLightText];
}
void GtButtonColorBrightBlue(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(108,147,232,1.0) endColor:GtRgbColor(57,112,224,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:GtRgbColor(34,96,221,1.0) endColor:GtRgbColor(36,99,222,1.0)];
	[button setLightText];
}
void GtButtonDarkGray(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(112,112,114,1.0) endColor:GtRgbColor(55,55,57,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:GtRgbColor(33,33,35,1.0) endColor:GtRgbColor(71,71,73,1.0)];
	[button setLightText];
}

void GtButtonDarkGrayWithBlueTint(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(106,112,118,1.0) endColor:GtRgbColor(55,63,71,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:GtRgbColor(43,50,59,1.0) endColor:GtRgbColor(65,71,80,1.0)];
	[button setLightText];
}
void GtButtonBlack(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(112,112,112,1.0) endColor:GtRgbColor(54,54,54,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:[UIColor blackColor] endColor:[UIColor blackColor]];
	[button setLightText];
}

void GtButtonColorGray(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(112,112,114,1.0) endColor:GtRgbColor(55,55,57,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:GtRgbColor(33,33,35,1.0) endColor:GtRgbColor(71,71,73,1.0)];
}

void GtButtonColorLightGray(GtGradientButtonBaseClass* button)
{
	[button.backgroundWidget.topGradient setGradientColors:GtRgbColor(112,112,114,1.0) endColor:GtRgbColor(55,55,57,1.0)];
	[button.backgroundWidget.bottomGradient setGradientColors:GtRgbColor(33,33,35,1.0) endColor:GtRgbColor(71,71,73,1.0)];
}

@implementation GtGradientButtonBaseClass

@synthesize buttonColorizer = m_buttonColorizer;
@synthesize backgroundWidget = m_backgroundWidget;
@synthesize shapeWidget = m_shapeWidget;

- (void) _initGradientButton
{
	[super setBackgroundColor:[UIColor clearColor]];
	self.themeAction = @selector(applyThemeToGradientButton:);
	
	GtRoundRectWidget* widget = [GtRoundRectWidget widgetWithFrame:CGRectZero];
	self.shapeWidget = widget;
	self.shapeWidget.borderColor = [UIColor gray15Color];
	
	self.backgroundWidget = [GtButtonBackgroundWidget buttonBackgroundWidget];
}

- (void) setAlpha:(CGFloat) alpha
{
	[super setAlpha:alpha];
	
	self.backgroundWidget.alpha = alpha;
}

- (void) setButtonColorizer:(GtButtonColorizer) colorizer
{
	m_buttonColorizer = colorizer;
	
	if(m_buttonColorizer)
	{
		m_buttonColorizer(self);
	}
}

- (void) drawRect:(CGRect) rect
{
	self.shapeWidget.cornerRadius = self.cornerRadius;
	self.backgroundWidget.alpha = self.isTranslucent ? 0.8f : 1.0;
	[super drawRect:rect];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) 
	{	
		[self _initGradientButton];
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)aRect 
{
	if ((self = [super initWithFrame: aRect])) 
	{
		[self _initGradientButton];
	}

	return self;
}

- (id) initWithColor:(GtButtonColorizer) color	title:(NSString*) title	 image:(UIImage*) image target:(id) target action:(SEL) action
{
	if((self = [super initWithFrame:CGRectZero]))
	{
		[self _initGradientButton];
		if(GtStringIsNotEmpty(title))
		{
			self.title = title;
		}
		self.image = image;
		[self setCallback:target action:action];
		if(color != nil)
		{
			self.themeAction = nil;
		}
		self.buttonColorizer = color;
	}
	
	return self;}

- (id) initWithColor:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action
{
	return [self initWithColor:color title:title image:nil target:target action:action];
}

- (id) initWithTitle:(NSString*) title	image:(UIImage*) image target:(id) target action:(SEL) action
{
	return [self initWithColor:nil title:title image:image target:target action:action];
}

- (id) initWithTitle:(NSString*) title target:(id) target action:(SEL) action
{
	return [self initWithColor:nil title:title image:nil target:target action:action];
}

- (void) dealloc
{
    GtRelease(m_shapeWidget);
	GtRelease(m_backgroundWidget);
	GtSuperDealloc();
}

- (void) setHighlighted:(BOOL) highlighted
{
	[super setHighlighted:highlighted];
	self.backgroundWidget.highlighted = highlighted;
}

//- (UIFont*) titleFont
//{
//	  switch(self.layoutMode)
//	  {
//		  case GtButtonImageLayoutModeToolbar:
//			  return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
//
//		  case GtButtonImageLayoutModeCenteredSmallText:
//		  case GtButtonImageLayoutModeAlignLeft:
//			  return [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]; 
//	  
//		  case GtButtonImageLayoutModeCentered:
//		  default:
//			  return [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
//	  }
//
//	  return nil; // for compiler
//}

- (void) layoutSubviews
{	 
	if(m_buttonColorizer)
	{
		m_buttonColorizer(self);
	}
	[super layoutSubviews];
}

- (void) setBackgroundWidget:(GtButtonBackgroundWidget*) widget
{
	if(m_backgroundWidget)
	{
		[m_backgroundWidget removeFromParent];
	}
	widget.layoutMode = GtRectLayoutFill;
	GtAssignObject(m_backgroundWidget, widget);
	[self.shapeWidget addSubwidget:m_backgroundWidget];
	[self setNeedsLayout];
}

- (void) setShapeWidget:(GtShapeWidget*) widget
{
	if(m_backgroundWidget)
	{
		[m_backgroundWidget removeFromParent];
	}
	widget.layoutMode = GtRectLayoutFill;
	GtAssignObject(m_shapeWidget, widget);
    [self addWidget:m_shapeWidget];
	
	if(m_backgroundWidget)
	{
		[widget addSubwidget:m_backgroundWidget];
	}
	
	[self setNeedsLayout];
}

#define Height 12.0f
- (void) resizeImageToSmallSize
{
	if(self.image.size.height > Height)
	{
		[self.imageView resizeProportionally:[self.image proportionalBoundsWithMaxSize:CGSizeMake(1024.0f, Height)].size];
	}
	else
	{
		[self.imageView resizeToImageSize];
	}
}

@end

@implementation GtGradientButton

+ (GtGradientButton*) gradientButton:(GtButtonColorizer) color	title:(NSString*) title target:(id) target action:(SEL) action
{
   return GtReturnAutoreleased([[GtGradientButton alloc] initWithColor:color title:title target:target action:action]);
}

+ (GtGradientButton*) gradientButton:(NSString*) title target:(id) target action:(SEL) action
{
   return GtReturnAutoreleased([[GtGradientButton alloc] initWithTitle:title target:target action:action]);
}

@end
#define kToolbarSpaceBetween 8.0f
#define kToolbarImageHeight 18.0f

@implementation GtToolbarButton

- (void) _initGradientButton
{
	[super _initGradientButton];
	self.themeAction = @selector(applyThemeToToolbarButton:);
}

+ (GtToolbarButton*) toolbarButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action
{
   return GtReturnAutoreleased([[GtToolbarButton alloc] initWithColor:color title:title target:target action:action]);
}

+ (GtToolbarButton*) toolbarButton:(NSString*) title target:(id) target action:(SEL) action
{
   return GtReturnAutoreleased([[GtToolbarButton alloc] initWithTitle:title target:target action:action]);
}

- (void) updateImageAndTextViewPositions
{
	CGRect bounds = self.rectUsedForCenteringSubviews;
	
	CGRect imageFrame = self.imageView.frame;
	imageFrame.origin.x = kToolbarSpaceBetween;
	self.imageView.frameOptimizedForSize = GtRectCenterRectInRectVertically(bounds, imageFrame);
	self.titleLabel.frameOptimizedForSize =	 GtRectCenterRectInRectVertically(bounds, GtRectSetLeft(self.titleLabel.frame, GtRectGetRight(imageFrame) + kToolbarSpaceBetween/2));
}

- (void) setImage:(UIImage*) image
{
	[super setImage:image];
	[self resizeImageToSmallSize];
}

- (CGSize) defaultSize
{
	return CGSizeMake(80,32);
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
		
		if(self.image)
		{
			size.width += self.imageView.frame.size.width;
			size.width += kToolbarSpaceBetween/2;
		}
									
		size.width += (kToolbarSpaceBetween*2);
		size.height = 32.0f;
		
		if(DeviceIsPad())
		{
			size.width += 12.0f;
		}
		
		self.newFrame = GtRectSetSizeWithSize(self.frame, size);
						
		[self setNeedsLayout];
	}

	return YES;
}

- (UIFont*) titleFont
{
	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

- (void) setTitle:(NSString*) string
{
	self.titleLabel.text = string;
	
	[self setViewSizeToContentSize];
	[self.superview setNeedsLayout];
	[self setNeedsLayout];
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self setViewSizeToContentSize];
	}
}

- (void) setButtonColorizer:(GtButtonColorizer) colorizer
{
	[super setButtonColorizer:colorizer];
	if(self.superview)
	{
		[self setViewSizeToContentSize];
	}
}
@end

@implementation GtBackButton

- (void) _initGradientButton
{
	[super _initGradientButton];
	self.themeAction = @selector(applyThemeToToolbarButton:);
	self.shapeWidget = [GtBackButtonShapeWidget backButtonShapeWidget:12.0];
	self.shapeWidget.borderColor = [UIColor gray15Color];
	self.shapeWidget.borderLineWidth = 1.0;
}

- (BOOL) setViewSizeToContentSize
{
	[super setViewSizeToContentSize];
	self.frame = GtRectAddWidth(self.frame, 10.0f);
	return YES;
}

- (CGRect) rectUsedForCenteringSubviews
{
	return GtRectInsetLeft(self.bounds, 8.0f);
} 

+ (GtBackButton*) backButton:(GtButtonColorizer) color	title:(NSString*) title target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtBackButton alloc] initWithColor:color title:title target:target action:action]);
}

+ (GtBackButton*) backButton:(NSString*) title target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtBackButton alloc] initWithTitle:title target:target action:action]);
}
@end

@implementation GtMenuButton

- (void) updateImageAndTextViewPositions
{
	CGRect bounds = self.rectUsedForCenteringSubviews;
		
	self.imageView.frameOptimizedForSize = GtRectCenterRectInRectVertically(bounds, 
		GtRectSetLeft(self.imageView.frame /*GtRectScale(m_imageView.frame, 0.84f)*/, 
		bounds.size.width * 0.10f));
		
	self.titleLabel.frameOptimizedForSize =	 
		GtRectCenterRectInRectVertically(bounds, 
			GtRectSetLeft(self.titleLabel.frame, bounds.size.width * 0.20));
}

- (UIFont*) titleFont
{
	return self.image == nil ? [super titleFont] : [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

+ (GtMenuButton*) menuButton:(GtButtonColorizer) color	title:(NSString*) title target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtMenuButton alloc] initWithColor:color title:title target:target action:action]);
}

+ (GtMenuButton*) menuButton:(NSString*) title target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtMenuButton alloc] initWithTitle:title target:target action:action]);
}

- (void) setImage:(UIImage*) image
{
	[super setImage:image];
	[self resizeImageToSmallSize];
}

- (CGSize) defaultSize
{
	return CGSizeMake(80,40);
}

@end

@implementation GtSmallButton

- (CGSize) defaultSize
{
	return CGSizeMake(80,32);
}

- (void) setImage:(UIImage*) image
{
	[super setImage:image];
	[self resizeImageToSmallSize];
}

- (UIFont*) titleFont
{
	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

+ (GtSmallButton*) smallButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtSmallButton alloc] initWithColor:color title:title target:target action:action]);
}

+ (GtSmallButton*) smallButton:(NSString*) title target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtSmallButton alloc] initWithTitle:title target:target action:action]);
}

@end

@implementation GtFatButton

- (void) _initGradientButton
{
	[super _initGradientButton];
	self.themeAction = @selector(applyThemeToFatButton:);
}

- (void) updateImageAndTextViewPositions
{
	CGRect bounds = self.rectUsedForCenteringSubviews;
		
	self.imageView.frameOptimizedForSize = 
			GtRectGrowRectToOptimizedSizeIfNeeded(
			GtRectCenterOnPoint(
				GtRectMakeWithSize(self.image.size), 
				CGPointMake(bounds.size.width/2.0f, bounds.size.height * 0.33f)));

	self.titleLabel.frameOptimizedForSize = GtRectGrowRectToOptimizedSizeIfNeeded(
			GtRectCenterOnPoint(
					GtRectMakeWithSize(self.titleLabel.frame.size),
					CGPointMake(bounds.size.width/2.0f, bounds.size.height * 0.75f)));
}

- (UIFont*) titleFont
{
	return [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
}

+ (GtFatButton*) fatButton:(GtButtonColorizer) color title:(NSString*) title image:(UIImage*) image target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[GtFatButton alloc] initWithColor:color title:title image:image target:target action:action]);
}
+ (GtFatButton*) fatButton:(NSString*) title image:(UIImage*) image target:(id) target action:(SEL) action;
{
	return GtReturnAutoreleased([[GtFatButton alloc] initWithColor:nil title:title image:image target:target action:action]);
}
@end
