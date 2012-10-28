//
//	FLImageRowWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLImageRowWidget.h"


@implementation FLImageRowWidget

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		memset(_images, 0, sizeof(UIImage*) * FLImageRowViewMaxImageCount);
	}
	return self;
}

- (void) dealloc
{
	[self clearImages];
	FLSuperDealloc();
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

- (void)drawSelf:(FLRect)rect
{
	CGFloat rightSide = FLRectGetRight(self.frame);
	for(int i = FLImageRowViewMaxImageCount - 1; i >= 0; i--)
	{	
		if(_images[i])
		{
			FLRect frame = FLRectMakeWithSize(_images[i].size);
			frame.origin.x = rightSide - frame.size.width;
			frame = FLRectOptimizedForViewSize(FLRectCenterRectInRectVertically(self.frame, frame));
			if(CGRectIntersectsRect(rect, frame))
			{
				[_images[i] drawInRect:frame];
			}
			rightSide = frame.origin.x - 4.0f;
		}
	}

	[super drawSelf:rect];
}

- (void) removeImageAtIndex:(NSUInteger)idx
{
	FLReleaseWithNil(_images[idx]);
}


@end
