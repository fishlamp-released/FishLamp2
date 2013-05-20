//
//	GtImageFrameLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageFrameWidget.h"
#import "UIImage+Resize.h"

@implementation GtImageFrameWidget
@synthesize frameWidth = m_frameWidth;
@synthesize frameColor = m_frameColor;

GtSynthesizeStructProperty(contentMode, setContentMode, GtWidgetContentMode, m_imageFrameFlags);

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.frameWidth = DeviceIsPad() ? GtImageFrameWidgetDefaultFrameWidth_iPad : GtImageFrameWidgetDefaultFrameWidth_iPhone;
		self.contentMode = GtWidgetContentModeScaleAspectFitOptimalSize;
		self.frameColor = [UIColor whiteColor];
	}
	return self;
}

+ (GtImageFrameWidget*) imageFrameWidget:(CGRect) frame
{
	return GtReturnAutoreleased([[GtImageFrameWidget alloc] initWithFrame:frame]);
}

- (void) setFrameColor:(UIColor*) color
{
	GtAssignObject(m_frameColor, color);
	[self setNeedsDisplay];
}

- (void) dealloc
{
	GtRelease(m_frameColor);
	GtRelease(m_imageWidget);
	GtSuperDealloc();
}	

- (BOOL) showFrame
{
	return m_imageFrameFlags.showFrame;
}

- (void) setShowFrame:(BOOL) showFrame
{
	m_imageFrameFlags.showFrame = showFrame;
}

- (BOOL) showStack
{
	return m_imageFrameFlags.showStack;
}

- (void) setShowStack:(BOOL) showStack
{
	m_imageFrameFlags.showStack = showStack;
}

- (GtImageWidget*) imageWidget
{
	return m_imageWidget;
}

- (void) setImageWidget:(GtImageWidget*) imageWidget
{
	[m_imageWidget removeFromParent];
	GtAssignObject(m_imageWidget, imageWidget);
	m_imageWidget.contentMode = GtWidgetContentModeScaleToFill;
	[self addSubwidget:m_imageWidget];
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

- (CGRect) thumbnailFrame:(GtWidgetContentMode) contentMode
{
    CGRect thumbnailFrame = CGRectZero;
	
    switch(contentMode)
    {
        case GtWidgetContentModeScaleAspectFill:
        case GtWidgetContentModeScaleToFill:
            thumbnailFrame = self.frame;
            if(m_imageFrameFlags.showFrame) 
            {
                thumbnailFrame = CGRectInset(thumbnailFrame, m_frameWidth, m_frameWidth);
            }
            if(m_imageFrameFlags.showStack) 
            {
                thumbnailFrame = CGRectInset(thumbnailFrame, m_frameWidth/2, m_frameWidth/2);
            }
        break;
        
        case GtWidgetContentModeScaleAspectFit:
        case GtWidgetContentModeScaleAspectFitOptimalSize:
        {
            UIImage* image = m_imageWidget.image;
            if(image)
            {
                CGFloat borderSize = 0;
                if(m_imageFrameFlags.showFrame) borderSize += ((m_frameWidth*1.5)*2);
                if(m_imageFrameFlags.showStack) borderSize += (m_frameWidth*1.5);
                
                CGSize scaledSize = self.frame.size;
                scaledSize.height -= borderSize;
                scaledSize.width -= borderSize;
                
                CGSize optimalSize = image.size;
                if( optimalSize.width <= scaledSize.width && 
                    optimalSize.height <= scaledSize.height &&
                    self.contentMode == GtWidgetContentModeScaleAspectFitOptimalSize)
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

    thumbnailFrame = GtRectCenterRectInRect(self.frame, thumbnailFrame);
    
    if(m_imageFrameFlags.showStack)
    {
        thumbnailFrame.origin.y += ((m_frameWidth*1.5) / 2.0f);
        thumbnailFrame.origin.x -= ((m_frameWidth*1.5) / 2.0f);
    }

    return thumbnailFrame;

}

- (void) layoutSubwidgets
{
	if(m_imageWidget && !CGSizeEqualToSize(CGSizeZero, self.frame.size))
	{
		m_imageWidget.frameOptimizedForSize = [self thumbnailFrame:self.contentMode];
	}
	
	[super layoutSubwidgets];
}

- (void) drawRect:(CGRect) rect
{
	if(self.showFrame)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSaveGState(context);

		[[UIColor blackColor] setStroke];
		[self.frameColor setFill];
		
		CGRect frameRect = m_imageWidget.frame;
		frameRect.origin.x -= (m_frameWidth);
		frameRect.origin.y -= (m_frameWidth);
		frameRect.size.width += (m_frameWidth*2);
		frameRect.size.height += (m_frameWidth*2);
		
		if(m_imageFrameFlags.showStack)
		{
			CGRect stackFrame = frameRect;
			stackFrame.origin.x += m_frameWidth;
			stackFrame.origin.y -= m_frameWidth;
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

