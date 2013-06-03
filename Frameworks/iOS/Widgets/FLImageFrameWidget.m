//
//	FLImageFrameLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageFrameWidget.h"
#import "UIImage+Resize.h"

@implementation FLImageFrameWidget
@synthesize frameWidth = _frameWidth;
@synthesize frameColor = _frameColor;

FLSynthesizeStructProperty(imageContentMode, setImageContentMode, FLWidgetImageContentMode, _imageFrameFlags);

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.frameWidth = DeviceIsPad() ? FLImageFrameWidgetDefaultFrameWidth_iPad : FLImageFrameWidgetDefaultFrameWidth_iPhone;
		self.imageContentMode = FLWidgetImageContentModeScaleAspectFitOptimalSize;
		self.frameColor = [UIColor whiteColor];
	}
	return self;
}

+ (FLImageFrameWidget*) imageFrameWidget:(CGRect) frame
{
	return FLAutorelease([[FLImageFrameWidget alloc] initWithFrame:frame]);
}

- (void) setFrameColor:(UIColor*) color
{
	FLSetObjectWithRetain(_frameColor, color);
	[self setNeedsDisplay];
}

- (void) dealloc
{
	FLRelease(_frameColor);
	FLRelease(_imageWidget);
	FLSuperDealloc();
}	

- (BOOL) showFrame
{
	return _imageFrameFlags.showFrame;
}

- (void) setShowFrame:(BOOL) showFrame
{
	_imageFrameFlags.showFrame = showFrame;
}

- (BOOL) showStack
{
	return _imageFrameFlags.showStack;
}

- (void) setShowStack:(BOOL) showStack
{
	_imageFrameFlags.showStack = showStack;
}

- (FLImageWidget*) imageWidget
{
	return _imageWidget;
}

- (void) setImageWidget:(FLImageWidget*) imageWidget
{
	[_imageWidget removeFromParent];
	FLSetObjectWithRetain(_imageWidget, imageWidget);
	_imageWidget.imageContentMode = FLWidgetImageContentModeScaleToFill;
	[self addWidget:_imageWidget];
	[self setNeedsLayout];
}

- (UIImage*) image
{
	return self.imageWidget.image;
}

- (void) setImage:(UIImage*) image
{
	self.imageWidget.image = image;
	[self setNeedsLayout];
}

- (CGRect) thumbnailFrame:(FLWidgetImageContentMode) contentMode
{
    CGRect thumbnailFrame = CGRectZero;
	
    switch(contentMode)
    {
        case FLWidgetImageContentModeScaleAspectFill:
        case FLWidgetImageContentModeScaleToFill:
            thumbnailFrame = self.frame;
            if(_imageFrameFlags.showFrame) 
            {
                thumbnailFrame = CGRectInset(thumbnailFrame, _frameWidth, _frameWidth);
            }
            if(_imageFrameFlags.showStack) 
            {
                thumbnailFrame = CGRectInset(thumbnailFrame, _frameWidth/2, _frameWidth/2);
            }
        break;
        
        case FLWidgetImageContentModeScaleAspectFit:
        case FLWidgetImageContentModeScaleAspectFitOptimalSize:
        {
            UIImage* image = _imageWidget.image;
            if(image)
            {
                CGFloat borderSize = 0;
                if(_imageFrameFlags.showFrame) borderSize += ((_frameWidth*1.5)*2);
                if(_imageFrameFlags.showStack) borderSize += (_frameWidth*1.5);
                
                CGSize scaledSize = self.frame.size;
                scaledSize.height -= borderSize;
                scaledSize.width -= borderSize;
                
                CGSize optimalSize = image.size;
                if( optimalSize.width <= scaledSize.width && 
                    optimalSize.height <= scaledSize.height &&
                    self.imageContentMode == FLWidgetImageContentModeScaleAspectFitOptimalSize)
                {
                    thumbnailFrame.size = optimalSize;
                }
                else
                {	
                    thumbnailFrame = [image proportionalBoundsWithMaxSize:scaledSize];
                } 
            }	
        }
    }

    thumbnailFrame = FLRectCenterRectInRect(self.frame, thumbnailFrame);
    
    if(_imageFrameFlags.showStack)
    {
        thumbnailFrame.origin.y += ((_frameWidth*1.5) / 2.0f);
        thumbnailFrame.origin.x -= ((_frameWidth*1.5) / 2.0f);
    }

    return thumbnailFrame;

}

- (void) layoutSubWidgets
{
	if(_imageWidget && !CGSizeEqualToSize(CGSizeZero, self.frame.size)){
		_imageWidget.frameOptimizedForSize = [self thumbnailFrame:self.imageContentMode];
	}
	
	[super layoutSubWidgets];
}

- (void) drawRect:(CGRect) rect
{
	if(self.showFrame)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);

		[[UIColor blackColor] setStroke];
		[self.frameColor setFill];
		
		CGRect frameRect = _imageWidget.frame;
		frameRect.origin.x -= (_frameWidth);
		frameRect.origin.y -= (_frameWidth);
		frameRect.size.width += (_frameWidth*2);
		frameRect.size.height += (_frameWidth*2);
		
		if(_imageFrameFlags.showStack)
		{
			CGRect stackFrame = frameRect;
			stackFrame.origin.x += _frameWidth;
			stackFrame.origin.y -= _frameWidth;
			CGContextFillRect( context , stackFrame );
			CGContextStrokeRectWithWidth( context , stackFrame , 1.0 );
		}
		
		CGContextFillRect( context , frameRect );
		CGContextStrokeRectWithWidth( context , frameRect , 1.0 );

	   CGContextRestoreGState(context);
	}
	
	[super drawRect:rect];
}


@end

