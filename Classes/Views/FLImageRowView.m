//
//	FLImageRowView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/21/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLImageRowView.h"

@implementation FLImageRowView

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		memset(_images, 0, sizeof(UIImage*) * FLImageRowViewMaxImageCount);
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
	for(int i = 0; i < FLImageRowViewMaxImageCount; i++)
	{
		if(!_images[i])
		{
			_images[i] = FLReturnRetained(image);
		}
	}
}

- (void) setImage:(UIImage*) image atIndex:(NSUInteger) idx
{
	FLAssignObject(_images[idx], image);
	[self setNeedsDisplay];
}

- (void) clearImages
{
	for(int i = 0; i < FLImageRowViewMaxImageCount; i++)
	{
		if(_images[i])
		{
			FLReleaseWithNil(_images[i]);
		}
	}	
 }

- (void) dealloc
{
	[self clearImages];
	
	FLSuperDealloc();
}
 
- (void)drawRect:(FLRect)rect
{
	[super drawRect:rect];

	CGFloat rightSide = FLRectGetRight(self.bounds);
	for(int i = FLImageRowViewMaxImageCount - 1; i >= 0; i--)
	{	
		if(_images[i])
		{
			FLRect frame = FLRectMakeWithSize(_images[i].size);
			frame.origin.x = rightSide - frame.size.width;
			rightSide = frame.origin.x - 4.0f;
			frame = FLRectOptimizedForViewSize(FLRectCenterRectInRectVertically(self.bounds, frame));
			if(CGRectIntersectsRect(rect, frame))
			{
				[_images[i] drawInRect:frame];
			}
		}
	}
	
// FLRect imageRect = CGRectMake(self.bounds.size.width, 0, 0, 0);
//	  if(self.image1)
//	{	
//		imageRect.size = self.image1.size;
//		  imageRect = FLRectCenterRectInRectVertically(self.bounds, imageRect);
//		imageRect.origin.x -= imageRect.size.width;
//		if(CGRectIntersectsRect(rect, imageRect))
//		  {
//			  [self.image1 drawInRect:imageRect];
//		  }
//	}
//	  
//	  if(self.image)
//	{	
//		imageRect.size = FLSizeMake(12,12);
//		  imageRect = FLRectCenterRectInRectVertically(self.bounds, imageRect);
//		imageRect.origin.x -= (imageRect.size.width + (self.image1 != nil ? 4 : 0));
//		if(CGRectIntersectsRect(rect, imageRect))
//		  {
//			  [self.image drawInRect:imageRect];
//		  }
//	}
}

@end
