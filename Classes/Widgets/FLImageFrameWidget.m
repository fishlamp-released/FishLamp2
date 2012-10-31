//
//	FLImageFrameLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLImageFrameWidget.h"
#import "FLImage+Resize.h"

@implementation FLImageFrameWidget
@synthesize frameWidth = _frameWidth;
@synthesize frameColor = _frameColor;

FLSynthesizeStructProperty(imageContentMode, setImageContentMode, FLWidgetImageContentMode, _imageFrameFlags);

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.frameWidth = DeviceIsPad() ? FLImageFrameWidgetDefaultFrameWidth_iPad : FLImageFrameWidgetDefaultFrameWidth_iPhone;
		self.imageContentMode = FLWidgetImageContentModeScaleAspectFitOptimalSize;
		self.frameColor = [UIColor whiteColor];
	}
	return self;
}

+ (FLImageFrameWidget*) imageFrameWidget:(FLRect) frame
{
	return autorelease_([[FLImageFrameWidget alloc] initWithFrame:frame]);
}

- (void) setFrameColor:(UIColor*) color
{
	FLRetainObject_(_frameColor, color);
	[self setNeedsDisplay];
}

- (void) dealloc
{
	mrc_release_(_frameColor);
	mrc_release_(_imageWidget);
	mrc_super_dealloc_();
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
	FLRetainObject_(_imageWidget, imageWidget);
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

- (FLRect) thumbnailFrame:(FLWidgetImageContentMode) contentMode
{
    FLRect thumbnailFrame = CGRectZero;
	
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
                
                FLSize scaledSize = self.frame.size;
                scaledSize.height -= borderSize;
                scaledSize.width -= borderSize;
                
                FLSize optimalSize = image.size;
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

- (void) layoutWidgets
{
	if(_imageWidget && !CGSizeEqualToSize(CGSizeZero, self.frame.size)){
		_imageWidget.frameOptimizedForSize = [self thumbnailFrame:self.imageContentMode];
	}
	
	[super layoutWidgets];
}

- (void) drawSelf:(FLRect) rect
{
	if(self.showFrame)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);

		[[UIColor blackColor] setStroke];
		[self.frameColor setFill];
		
		FLRect frameRect = _imageWidget.frame;
		frameRect.origin.x -= (_frameWidth);
		frameRect.origin.y -= (_frameWidth);
		frameRect.size.width += (_frameWidth*2);
		frameRect.size.height += (_frameWidth*2);
		
		if(_imageFrameFlags.showStack)
		{
			FLRect stackFrame = frameRect;
			stackFrame.origin.x += _frameWidth;
			stackFrame.origin.y -= _frameWidth;
			CGContextFillRect( context , stackFrame );
			CGContextStrokeRectWithWidth( context , stackFrame , 1.0 );
		}
		
		CGContextFillRect( context , frameRect );
		CGContextStrokeRectWithWidth( context , frameRect , 1.0 );

	   CGContextRestoreGState(context);
	}
	
	[super drawSelf:rect];
}


@end

