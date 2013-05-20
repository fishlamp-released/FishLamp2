//
//	GtImageRowWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageRowWidget.h"


@implementation GtImageRowWidget

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		memset(m_images, 0, sizeof(UIImage*) * GtImageRowViewMaxImageCount);
	}
	return self;
}

- (void) dealloc
{
	[self clearImages];
	GtSuperDealloc();
}

- (void) setImage:(UIImage*) image atIndex:(NSUInteger) idx
{
	if(GtAssignObject(m_images[idx], image))
	{
		[self setNeedsDisplay];
	}
}

- (void) clearImages
{
	for(int i = 0; i < GtImageRowViewMaxImageCount; i++)
	{
		if(m_images[i])
		{
			GtReleaseWithNil(m_images[i]);
		}
	}	
}

- (void)drawRect:(CGRect)rect
{
	CGFloat rightSide = GtRectGetRight(self.frame);
	for(int i = GtImageRowViewMaxImageCount - 1; i >= 0; i--)
	{	
		if(m_images[i])
		{
			CGRect frame = GtRectMakeWithSize(m_images[i].size);
			frame.origin.x = rightSide - frame.size.width;
			frame = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterRectInRectVertically(self.frame, frame));
			if(CGRectIntersectsRect(rect, frame))
			{
				[m_images[i] drawInRect:frame];
			}
			rightSide = frame.origin.x - 4.0f;
		}
	}

	[super drawRect:rect];
}

- (void) removeImageAtIndex:(NSUInteger)idx
{
	GtReleaseWithNil(m_images[idx]);
}


@end
