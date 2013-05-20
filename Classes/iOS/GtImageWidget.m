//
//	GtImageLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageWidget.h"
#import "UIImage+Resize.h"
#import "UIImage+GtColorize.h"

@implementation GtImageWidget

@synthesize image = m_image;
@synthesize contentMode = m_contentMode;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.layoutMode = GtRectLayoutNone;
		self.contentMode = GtWidgetContentModeScaleAspectFit;
	}
	
	return self;
}

- (void) clear
{
	GtReleaseWithNil(m_image);
	[self setNeedsDisplay];
}

+ (GtImageWidget*) imageWidgetWithFrame:(CGRect) frame
{
	return GtReturnAutoreleased([[GtImageWidget alloc] initWithFrame:frame]);
}

- (void) dealloc
{
	GtRelease(m_image);
	GtSuperDealloc();
}

- (void) setImage:(UIImage *) image
{
	GtAssignObject(m_image, image);
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
	if(m_image)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);

		CGRect imageRect = self.frame;
		switch(self.contentMode)
		{
			case GtWidgetContentModeScaleToFill:
			case GtWidgetContentModeScaleAspectFill:
				imageRect = GtRectFillRectInRectProportionally(self.frame, GtRectMakeWithSize(self.image.size));
				imageRect = GtRectCenterRectInRect(self.frame, imageRect);
			    CGContextClipToRect(context, self.frame);
			break;
						
			case GtWidgetContentModeScaleAspectFitOptimalSize:
			case GtWidgetContentModeScaleAspectFit:
			{	
				CGSize scaledSize = self.frame.size;
				CGSize optimalSize = m_image.size;
				if( optimalSize.width <= scaledSize.width && 
					optimalSize.height <= scaledSize.height &&
					self.contentMode == GtWidgetContentModeScaleAspectFitOptimalSize)
				{
					imageRect.size = optimalSize;
				}
				else
				{	
					imageRect.size = [m_image proportionalBoundsWithMaxSize:scaledSize].size;
				} 
			
				//imageRect.size = [m_image proportionalBoundsWithMaxSize:self.frame.size].size;
				imageRect = GtRectLayoutRectInRect(self.layoutMode, self.frame, imageRect);
			}
			break;
		}
#if DEBUG		 
		if(!CGRectContainsRect(self.frame, CGRectIntegral(imageRect)))
		{
//			  GtLog(@"Drawing image outside frame. Image rect: %@ in widget frame: %@", NSStringFromCGRect(imageRect), NSStringFromCGRect(self.frame));
		}
#endif		  
		imageRect = GtRectGrowRectToOptimizedSizeIfNeeded(imageRect);
		if(self.isHighlighted)
		{
			if(self.highlighter)
			{
				self.highlighter(self, imageRect);
			}
            else
            {
                [[self.image imageTintedWithColor:[UIColor iPhoneBlueColor] fraction:0.5] drawInRect:imageRect];
            }
		}
		else if(self.isDisabled)
		{
			[[self.image imageTintedWithColor:[UIColor grayColor] fraction:0.33] drawInRect:imageRect];
		}
		else
		{
			[self.image drawInRect:imageRect];
		}
		CGContextRestoreGState(context);
	}
	
	[super drawRect:rect];
}

- (void) resizeToImageSize
{
	if(m_image)
	{
		if(!CGSizeEqualToSize(self.frame.size, m_image.size))
		{
			self.frame = GtRectSetSizeWithSize(self.frame, m_image.size);
		}
	}
}
- (void) resizeToImageSizeWithMaxSize:(CGSize) maxSize
{
	if(m_image)
	{
		CGSize imageSize = m_image.size;
		if( imageSize.width <= maxSize.width && 
			imageSize.height <= maxSize.height)
		{
			self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, imageSize);
		}
		else
		{
			self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, [m_image proportionalBoundsWithMaxSize:maxSize].size);
		
		}
	}
}

- (void) resizeProportionallyWithMaxSize:(CGSize) maxSize
{
	if(m_image)
	{
		self.frameOptimizedForSize = GtRectSetSizeWithSize(self.frame, [m_image proportionalSizeWithMaxSize:maxSize]);
	}
}

- (NSMutableString*) moreDescription
{
	return [NSMutableString stringWithFormat:@"Image size: %@", self.image ? NSStringFromCGSize(self.image.size) : @"nil image"];
}

@end

void GtWidgetBlueTintImageHighlighter(id widget, CGRect rect)
{
	[[[widget image] imageTintedWithColor:[UIColor iPhoneBlueColor] fraction:0.5] drawInRect:rect];
}

void GtWidgetGrayTintImageHighlighter(GtImageWidget* widget)
{
}
