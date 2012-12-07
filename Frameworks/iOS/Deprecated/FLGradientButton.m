//
//	FLGradientButton.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLGradientButton.h"
#import "FLColor+FLMoreColors.h"
#import "FLPathUtilities.h"
#import "FLRoundRectWidget.h"
#import "FLButtonBackgroundWidget.h"
#import "FLBackButtonShapeWidget.h"
#import "FLImage+Resize.h"
#import "FLImage+Colorize.h"
#import "FLColorRange.h"


void FLGradientButtonColorRed(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(240,127,136,1.0) endColor:FLRgbColor(231,53,66,1.0)] forControlState:UIControlStateNormal] ;
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:/*FLRgbColor(225,1,17,1.0)*/ [UIColor fireEngineRed] endColor:FLRgbColor(236,19,20,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
}
void FLGradientButtonColorPaleBlue(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(132,156,187,1.0) endColor:FLRgbColor(89,119,162,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLRgbColor(72,106,154,1.0) endColor:FLRgbColor(74,108,155,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
}
void FLGradientButtonColorBrightBlue(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(108,147,232,1.0) endColor:FLRgbColor(57,112,224,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLRgbColor(34,96,221,1.0) endColor:FLRgbColor(36,99,222,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
}
void FLGradientButtonDarkGray(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(112,112,114,1.0) endColor:FLRgbColor(55,55,57,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLRgbColor(33,33,35,1.0) endColor:FLRgbColor(71,71,73,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
}

void FLGradientButtonDarkGrayWithBlueTint(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(106,112,118,1.0) endColor:FLRgbColor(55,63,71,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLRgbColor(43,50,59,1.0) endColor:FLRgbColor(65,71,80,1.0)] forControlState:UIControlStateNormal];
	[button setLightText];
}
void FLGradientButtonBlack(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(112,112,112,1.0) endColor:FLRgbColor(54,54,54,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:[UIColor blackColor] endColor:[UIColor blackColor]] forControlState:UIControlStateNormal];
	[button setLightText];
}

void FLGradientButtonColorGray(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(112,112,114,1.0) endColor:FLRgbColor(55,55,57,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLRgbColor(33,33,35,1.0) endColor:FLRgbColor(71,71,73,1.0)] forControlState:UIControlStateNormal];
}

void FLGradientButtonColorLightGray(id button)
{
	[[button backgroundWidget].topGradient setColorRange:[FLColorRange colorRange:FLRgbColor(112,112,114,1.0) endColor:FLRgbColor(55,55,57,1.0)] forControlState:UIControlStateNormal];
	[[button backgroundWidget].bottomGradient setColorRange:[FLColorRange colorRange:FLRgbColor(33,33,35,1.0) endColor:FLRgbColor(71,71,73,1.0)] forControlState:UIControlStateNormal];
}

@implementation FLGradientButtonBaseClass

@synthesize buttonColorizer = _buttonColorizer;
@synthesize backgroundWidget = _backgroundWidget;
@synthesize shapeWidget = _shapeWidget;

- (void) applyTheme:(FLTheme*) theme
{
	[self setButtonColorizer:FLGradientButtonDarkGray];
}

- (void) _initGradientButton
{
	[super setBackgroundColor:[UIColor clearColor]];
	
	FLRoundRectWidget* widget = [FLRoundRectWidget widgetWithFrame:CGRectZero];
	self.shapeWidget = widget;
	self.shapeWidget.innerBorderColor = [UIColor gray15Color];
    
	self.backgroundWidget = [FLButtonBackgroundWidget buttonBackgroundWidget];
}

- (void) setAlpha:(CGFloat) alpha
{
	[super setAlpha:alpha];
	
	self.backgroundWidget.alpha = alpha;
}

- (void) setButtonColorizer:(FLButtonColorizerDeprecated) colorizer
{
	_buttonColorizer = colorizer;
	
	if(_buttonColorizer)
	{
		_buttonColorizer(self);
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

- (id) initWithColor:(FLButtonColorizerDeprecated) color	title:(NSString*) title	 image:(UIImage*) image target:(id) target action:(SEL) action
{
	if((self = [super initWithFrame:CGRectZero]))
	{
		[self _initGradientButton];
		if(FLStringIsNotEmpty(title))
		{
			self.title = title;
		}
		self.image = image;
		[self setCallback:target action:action];
		if(color != nil)
		{
			self.wantsApplyTheme = NO;
		}
		self.buttonColorizer = color;
	}
	
	return self;
}

- (id) initWithColor:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action
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
    FLRelease(_shapeWidget);
	FLRelease(_backgroundWidget);
	super_dealloc_();
}

- (void) setHighlighted:(BOOL) highlighted
{
	[super setHighlighted:highlighted];
	self.backgroundWidget.highlighted = highlighted;
}

//- (UIFont*) titleFont
//{
//	  switch(self.contentMode)
//	  {
//		  case FLButtonImageLayoutModeToolbar:
//			  return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
//
//		  case FLButtonImageLayoutModeCenteredSmallText:
//		  case FLButtonImageLayoutModeAlignLeft:
//			  return [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]; 
//	  
//		  case FLButtonImageLayoutModeCentered:
//		  default:
//			  return [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
//	  }
//
//	  return nil; // for compiler
//}

- (void) layoutSubviews
{	 
	if(_buttonColorizer)
	{
		_buttonColorizer(self);
	}
    _backgroundWidget.frame = self.bounds;
	_shapeWidget.frame = _backgroundWidget.frame;
    [super layoutSubviews];
}

- (void) setBackgroundWidget:(FLButtonBackgroundWidget*) widget
{
	if(_backgroundWidget)
	{
		[_backgroundWidget removeFromParent];
	}
	widget.contentMode = FLContentModeFill;
	FLRetainObject_(_backgroundWidget, widget);
	[self.shapeWidget addWidget:_backgroundWidget];
	[self setNeedsLayout];
}

- (void) setShapeWidget:(FLShapeWidget*) widget
{
    FLAssertIsNotNil_(widget);

	if(_backgroundWidget)
	{
		[_backgroundWidget removeFromParent];
	}
	widget.contentMode = FLContentModeFill;
	FLRetainObject_(_shapeWidget, widget);
    FLAssertIsNotNil_(self.rootWidget);

    [self.rootWidget addWidget:_shapeWidget];
	
	if(_backgroundWidget)
	{
		[widget addWidget:_backgroundWidget];
	}
	
	[self setNeedsLayout];
}

#define Height 12.0f
- (void) resizeImageToSmallSize
{
	if(self.image.size.height > Height)
	{
		[self.imageView resizeProportionally:[self.image proportionalBoundsWithMaxSize:FLSizeMake(1024.0f, Height)].size];
	}
	else
	{
		[self.imageView resizeToImageSize];
	}
}

@end

@implementation FLGradientButton

+ (FLGradientButton*) gradientButton:(FLButtonColorizerDeprecated) color	title:(NSString*) title target:(id) target action:(SEL) action
{
   return FLAutorelease([[FLGradientButton alloc] initWithColor:color title:title target:target action:action]);
}

+ (FLGradientButton*) gradientButton:(NSString*) title target:(id) target action:(SEL) action
{
   return FLAutorelease([[FLGradientButton alloc] initWithTitle:title target:target action:action]);
}

@end
#define kToolbarSpaceBetween 8.0f
#define kToolbarImageHeight 18.0f

@implementation FLToolbarButtonDeprecated

- (void) applyTheme:(FLTheme*) theme
{
    [super applyTheme:theme];
	self.buttonColorizer = FLGradientButtonBlack; 
}


+ (FLToolbarButtonDeprecated*) toolbarButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action
{
   return FLAutorelease([[FLToolbarButtonDeprecated alloc] initWithColor:color title:title target:target action:action]);
}

+ (FLToolbarButtonDeprecated*) toolbarButton:(NSString*) title target:(id) target action:(SEL) action
{
   return FLAutorelease([[FLToolbarButtonDeprecated alloc] initWithTitle:title target:target action:action]);
}

- (void) updateImageAndTextViewPositions
{
	CGRect bounds = self.rectUsedForCenteringSubviews;
	
	CGRect imageFrame = self.imageView.frame;
	imageFrame.origin.x = kToolbarSpaceBetween;
	self.imageView.frameOptimizedForSize = FLRectCenterRectInRectVertically(bounds, imageFrame);
	self.titleLabel.frameOptimizedForSize =	 FLRectCenterRectInRectVertically(bounds, FLRectSetLeft(self.titleLabel.frame, FLRectGetRight(imageFrame) + kToolbarSpaceBetween/2));
}

- (void) setImage:(UIImage*) image
{
	[super setImage:image];
	[self resizeImageToSmallSize];
}

- (FLSize) defaultSize
{
	return FLSizeMake(80,32);
}

- (BOOL) setViewSizeToContentSize
{
	if(self.superview)
	{
		FLSize size = self.frame.size;
		if(FLStringIsNotEmpty(self.titleLabel.text))
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
		
		self.newFrame = FLRectSetSizeWithSize(self.frame, size);
						
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

- (void) setButtonColorizer:(FLButtonColorizerDeprecated) colorizer
{
	[super setButtonColorizer:colorizer];
	if(self.superview)
	{
		[self setViewSizeToContentSize];
	}
}
@end

@implementation FLBackButtonDeprecated


- (void) applyTheme:(FLTheme*) theme
{
    [super applyTheme:theme];
	self.buttonColorizer = FLGradientButtonBlack; 
}

- (void) _initGradientButton
{
	[super _initGradientButton];
	self.shapeWidget = [FLBackButtonShapeWidget backButtonShapeWidget:12.0];
	self.shapeWidget.innerBorderColor = [UIColor gray15Color];
	self.shapeWidget.borderLineWidth = 1.0;
}

- (BOOL) setViewSizeToContentSize
{
	[super setViewSizeToContentSize];
	self.frame = FLRectAddWidth(self.frame, 10.0f);
	return YES;
}

- (CGRect) rectUsedForCenteringSubviews
{
	return FLRectInsetLeft(self.bounds, 8.0f);
} 

+ (FLBackButtonDeprecated*) backButton:(FLButtonColorizerDeprecated) color	title:(NSString*) title target:(id) target action:(SEL) action
{
	return FLAutorelease([[FLBackButtonDeprecated alloc] initWithColor:color title:title target:target action:action]);
}

+ (FLBackButtonDeprecated*) backButton:(NSString*) title target:(id) target action:(SEL) action
{
	return FLAutorelease([[FLBackButtonDeprecated alloc] initWithTitle:title target:target action:action]);
}
@end

@implementation FLMenuButtonDeprecated

- (void) updateImageAndTextViewPositions
{
	CGRect bounds = self.rectUsedForCenteringSubviews;
		
	self.imageView.frameOptimizedForSize = FLRectCenterRectInRectVertically(bounds, 
		FLRectSetLeft(self.imageView.frame /*FLRectScale(_imageView.frame, 0.84f)*/, 
		bounds.size.width * 0.10f));
		
	self.titleLabel.frameOptimizedForSize =	 
		FLRectCenterRectInRectVertically(bounds, 
			FLRectSetLeft(self.titleLabel.frame, bounds.size.width * 0.20));
}

- (UIFont*) titleFont
{
	return self.image == nil ? [super titleFont] : [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

+ (FLMenuButtonDeprecated*) menuButton:(FLButtonColorizerDeprecated) color	title:(NSString*) title target:(id) target action:(SEL) action
{
	return FLAutorelease([[FLMenuButtonDeprecated alloc] initWithColor:color title:title target:target action:action]);
}

+ (FLMenuButtonDeprecated*) menuButton:(NSString*) title target:(id) target action:(SEL) action
{
	return FLAutorelease([[FLMenuButtonDeprecated alloc] initWithTitle:title target:target action:action]);
}

- (void) setImage:(UIImage*) image
{
	[super setImage:image];
	[self resizeImageToSmallSize];
}

- (FLSize) defaultSize
{
	return FLSizeMake(80,40);
}

@end

@implementation FLSmallButtonDeprecated

- (FLSize) defaultSize {
	return FLSizeMake(80,32);
}

- (void) setImage:(UIImage*) image {
	[super setImage:image];
	[self resizeImageToSmallSize];
}

- (UIFont*) titleFont {
	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

+ (FLSmallButtonDeprecated*) smallButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action {
	return FLAutorelease([[FLSmallButtonDeprecated alloc] initWithColor:color title:title target:target action:action]);
}

+ (FLSmallButtonDeprecated*) smallButton:(NSString*) title target:(id) target action:(SEL) action {
	return FLAutorelease([[FLSmallButtonDeprecated alloc] initWithTitle:title target:target action:action]);
}

@end

@implementation FLFatButtonDeprecated

- (void) applyTheme:(FLTheme*) theme {
    self.buttonColorizer = FLGradientButtonDarkGray;
}

- (void) updateImageAndTextViewPositions {
	CGRect bounds = self.rectUsedForCenteringSubviews;
		
	self.imageView.frameOptimizedForSize = 
			FLRectOptimizedForViewSize(
			FLRectCenterOnPoint(
				FLRectMakeWithSize(self.image.size), 
				CGPointMake(bounds.size.width/2.0f, bounds.size.height * 0.33f)));

	self.titleLabel.frameOptimizedForSize = FLRectOptimizedForViewSize(
			FLRectCenterOnPoint(
					FLRectMakeWithSize(self.titleLabel.frame.size),
					CGPointMake(bounds.size.width/2.0f, bounds.size.height * 0.75f)));
}

- (UIFont*) titleFont {
	return [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
}

+ (FLFatButtonDeprecated*) fatButton:(FLButtonColorizerDeprecated) color
                               title:(NSString*) title
                               image:(UIImage*) image
                              target:(id) target
                              action:(SEL) action {
	return FLAutorelease([[FLFatButtonDeprecated alloc] initWithColor:color title:title image:image target:target action:action]);
}

+ (FLFatButtonDeprecated*) fatButton:(NSString*) title
                               image:(UIImage*) image
                              target:(id) target
                              action:(SEL) action {
	return FLAutorelease([[FLFatButtonDeprecated alloc] initWithColor:nil title:title image:image target:target action:action]);
}
@end
