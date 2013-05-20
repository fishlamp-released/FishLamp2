//
//	GtImageRowView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageRowView.h"

@implementation GtImageRowView

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		memset(m_images, 0, sizeof(UIImage*) * GtImageRowViewMaxImageCount);
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	[self setNeedsDisplay];
}

- (void) addImage:(UIImage*) image
{
	for(int i = 0; i < GtImageRowViewMaxImageCount; i++)
	{
		if(!m_images[i])
		{
			m_images[i] = GtRetain(image);
		}
	}
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

- (void) dealloc
{
	[self clearImages];
	
	GtSuperDealloc();
}
 
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

	CGFloat rightSide = GtRectGetRight(self.bounds);
	for(int i = GtImageRowViewMaxImageCount - 1; i >= 0; i--)
	{	
		if(m_images[i])
		{
			CGRect frame = GtRectMakeWithSize(m_images[i].size);
			frame.origin.x = rightSide - frame.size.width;
			rightSide = frame.origin.x - 4.0f;
			frame = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterRectInRectVertically(self.bounds, frame));
			if(CGRectIntersectsRect(rect, frame))
			{
				[m_images[i] drawInRect:frame];
			}
		}
	}
	
// CGRect imageRect = CGRectMake(self.bounds.size.width, 0, 0, 0);
//	  if(self.image1)
//	{	
//		imageRect.size = self.image1.size;
//		  imageRect = GtRectCenterRectInRectVertically(self.bounds, imageRect);
//		imageRect.origin.x -= imageRect.size.width;
//		if(CGRectIntersectsRect(rect, imageRect))
//		  {
//			  [self.image1 drawInRect:imageRect];
//		  }
//	}
//	  
//	  if(self.image)
//	{	
//		imageRect.size = CGSizeMake(12,12);
//		  imageRect = GtRectCenterRectInRectVertically(self.bounds, imageRect);
//		imageRect.origin.x -= (imageRect.size.width + (self.image1 != nil ? 4 : 0));
//		if(CGRectIntersectsRect(rect, imageRect))
//		  {
//			  [self.image drawInRect:imageRect];
//		  }
//	}
}

@end
