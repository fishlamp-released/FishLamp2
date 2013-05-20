//
//  GtPhotoViewControllerViewArrangement.m
//  MyZen
//
//  Created by Mike Fullerton on 11/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtPhotoViewControllerViewArrangement.h"


@implementation GtPhotoViewControllerViewArrangement

- (id) init
{
	if(self = [super init])
	{
		for(int i = 0; i < _GT_ARRANGEMENT_SIZE; i++)
		{
			m_arrangement[i] = nil;
		}
	}
	
	return self;
}

- (void) dealloc
{
	[self clearPhotos];
	
	[super dealloc];
}

- (void) removeView:(WhichPhoto) which
{
	if(m_arrangement[which])
	{
#if LOG_PHOTO_VIEW	
		GtLog(@"removed");
#endif
		[m_arrangement[which] cancel];
	
		[m_arrangement[which] removeFromSuperview];
		GtReleaseWithNil(m_arrangement[which]);
	}
}

- (void) setView:(WhichPhoto) which 
            view:(GtPhotoView*) view
{
	if(view != m_arrangement[which])
	{
		[self removeView:which];
		m_arrangement[which] = [view retain];
	}
}

- (GtPhotoView*) viewAtIndex:(WhichPhoto) which
{
	return m_arrangement[which];
}

- (GtPhotoView*) centerView
{
	return m_arrangement[kCurrentPhoto];
}

- (GtPhotoView*) nextView
{
	return m_arrangement[kNextPhoto];
}

- (GtPhotoView*) previousView
{
	return m_arrangement[kPrevPhoto];
}

- (void) clearPhotos
{
	for(int i = 0; i < _GT_ARRANGEMENT_SIZE; i++)
	{
		[m_arrangement[i] removeFromSuperview];
		GtReleaseWithNil(m_arrangement[i]);
	}
}

- (void) shiftArrangementToLeft
{
	// remove previous prev image. it's getting replaced
	// by previous current image	
	[self removeView:kPrevPhoto];
	
	// rotate the views to the left, leaving the old
	// next in place. It will be replaced below.
	for(int i = 0; i < (_GT_ARRANGEMENT_SIZE-1); i++)
	{
		m_arrangement[i] = m_arrangement[i+1];
	}
	
	m_arrangement[_GT_ARRANGEMENT_SIZE-1] = nil;
}


- (void) shiftArrangementToRight
{
	// remove old next from subviews, it's being replaced
	// by previous current photo
	[self removeView:kNextPhoto];
	
	// rotate the views to the right, leaving old prev
	// in place. it will be replaced belows
	for(int i = _GT_ARRANGEMENT_SIZE-1; i > 0; i--)
	{
		m_arrangement[i] = m_arrangement[i-1];
	}
	
	m_arrangement[0] = nil;
}

#if LOG_PHOTO_VIEW

- (id) printPhotoView:(GtPhotoView*) photoView 
                index:(int) i
{
	GtLog([photoView.photo description]);

	return self;
}
- (void) printSubViews
{
	for(int i = 0; i < _GT_ARRANGEMENT_SIZE; i++)
	{
		[self printPhotoView:m_arrangement[i] index:i];
	}
}

#endif

- (NSUInteger) viewCount
{
	return _GT_ARRANGEMENT_SIZE;
}

@end
