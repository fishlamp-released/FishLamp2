//
//	FLImageLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageWidget.h"
#import "UIImage+Resize.h"
#import "UIImage+Colorize.h"

@implementation FLImageWidget

@synthesize image = _image;
@synthesize imageContentMode = _imageContentMode;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.contentMode = FLRectLayoutNone;
		self.imageContentMode = FLWidgetImageContentModeScaleAspectFit;
	}
	
	return self;
}

- (void) clear
{
	FLReleaseWithNil(_image);
	[self setNeedsDisplay];
}

+ (FLImageWidget*) imageWidgetWithFrame:(CGRect) frame
{
	return FLAutorelease([[FLImageWidget alloc] initWithFrame:frame]);
}

- (void) dealloc
{
	FLRelease(_image);
	FLSuperDealloc();
}

- (void) setImage:(UIImage *) image
{
	FLSetObjectWithRetain(_image, image);
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
	if(_image)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);

		CGRect imageRect = self.frame;
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
				CGSize scaledSize = self.frame.size;
				CGSize optimalSize = _image.size;
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
	
	[super drawRect:rect];
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
- (void) resizeToImageSizeWithMaxSize:(CGSize) maxSize
{
	if(_image)
	{
		CGSize imageSize = _image.size;
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

- (void) resizeProportionallyWithMaxSize:(CGSize) maxSize
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

void FLWidgetBlueTintImageHighlighter(id widget, CGRect rect)
{
	[[[widget image] imageTintedWithColor:[UIColor iPhoneBlueColor] fraction:0.5] drawInRect:rect];
}

void FLWidgetGrayTintImageHighlighter(FLImageWidget* widget)
{
}
