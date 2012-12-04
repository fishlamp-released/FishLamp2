//
//	FLImageLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLImageWidget.h"
#import "FLImage+Resize.h"
#import "FLImage+Colorize.h"

@implementation FLImageWidget

@synthesize image = _image;
@synthesize imageContentMode = _imageContentMode;

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.contentMode = FLContentModeNone;
		self.imageContentMode = FLWidgetImageContentModeScaleAspectFit;
	}
	
	return self;
}

- (void) clear
{
	FLReleaseWithNil_(_image);
	[self setNeedsDisplay];
}

+ (FLImageWidget*) imageWidgetWithFrame:(FLRect) frame
{
	return autorelease_([[FLImageWidget alloc] initWithFrame:frame]);
}

- (void) dealloc
{
	release_(_image);
	super_dealloc_();
}

- (void) setImage:(UIImage *) image
{
	FLRetainObject_(_image, image);
	[self setNeedsDisplay];
}

- (void) drawSelf:(FLRect)rect
{
	if(_image)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);

		FLRect imageRect = self.frame;
		switch(self.imageContentMode)
		{
			case FLWidgetImageContentModeScaleToFill:
			case FLWidgetImageContentModeScaleAspectFill:
				imageRect = FLRectFillRectInRectProportionally(self.frame, FLRectMakeWithSize(self.image.size));
				imageRect = FLRectCenterRectInRect(self.frame, imageRect);
			    CGContextClipToRect(context, self.frame);
			break;
						
			case FLWidgetImageContentModeScaleAspectFitOptimalSize:
			case FLWidgetImageContentModeScaleAspectFit:
			{	
				FLSize scaledSize = self.frame.size;
				FLSize optimalSize = _image.size;
				if( optimalSize.width <= scaledSize.width && 
					optimalSize.height <= scaledSize.height &&
					self.imageContentMode == FLWidgetImageContentModeScaleAspectFitOptimalSize)
				{
					imageRect.size = optimalSize;
				}
				else
				{	
					imageRect.size = [_image proportionalBoundsWithMaxSize:scaledSize].size;
				} 
			
				//imageRect.size = [_image proportionalBoundsWithMaxSize:self.frame.size].size;
				imageRect = FLRectPositionRectInRectWithContentMode(self.frame, imageRect, self.contentMode);
			}
			break;
		}
#if DEBUG		 
		if(!CGRectContainsRect(self.frame, CGRectIntegral(imageRect)))
		{
//			  FLLog(@"Drawing image outside frame. Image rect: %@ in widget frame: %@", NSStringFromCGRect(imageRect), NSStringFromCGRect(self.frame));
		}
#endif		  
		imageRect = FLRectOptimizedForViewSize(imageRect);
		if(self.isHighlighted)
		{
//			if(self.highlighter)
//			{
//				self.highlighter(self, imageRect);
//			}
//            else
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
	
	[super drawSelf:rect];
}

- (void) resizeToImageSize
{
	if(_image)
	{
		if(!CGSizeEqualToSize(self.frame.size, _image.size))
		{
			self.frame = FLRectSetSizeWithSize(self.frame, _image.size);
		}
	}
}
- (void) resizeToImageSizeWithMaxSize:(FLSize) maxSize
{
	if(_image)
	{
		FLSize imageSize = _image.size;
		if( imageSize.width <= maxSize.width && 
			imageSize.height <= maxSize.height)
		{
			self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, imageSize);
		}
		else
		{
			self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, [_image proportionalBoundsWithMaxSize:maxSize].size);
		
		}
	}
}

- (void) resizeProportionallyWithMaxSize:(FLSize) maxSize
{
	if(_image)
	{
		self.frameOptimizedForSize = FLRectSetSizeWithSize(self.frame, [_image proportionalSizeWithMaxSize:maxSize]);
	}
}

- (NSMutableString*) moreDescription
{
	return [NSMutableString stringWithFormat:@"Image size: %@", self.image ? NSStringFromCGSize(self.image.size) : @"nil image"];
}

@end

void FLWidgetBlueTintImageHighlighter(id widget, FLRect rect)
{
	[[[widget image] imageTintedWithColor:[UIColor iPhoneBlueColor] fraction:0.5] drawInRect:rect];
}

void FLWidgetGrayTintImageHighlighter(FLImageWidget* widget)
{
}
