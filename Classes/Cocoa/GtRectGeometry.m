//
//	GtGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRectGeometry.h"

#if DEBUG
#include "_GtRectGeometry.h"
#endif

const CGSize CGSizeMax = { CGFLOAT_MAX, CGFLOAT_MAX };

CGRect GtRectFillRectInRectProportionally(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);
	
	CGFloat horizScale = container.size.width / containee.size.width;
	CGFloat vertScale = container.size.height / containee.size.height;
	
	CGFloat scale = MAX(horizScale, vertScale);
	
	containee.size.width *= scale;
	containee.size.height *= scale;
	
	return GtReturnAssertIsSaneRect(containee);
}

CGRect GtRectFitInRectInRectProportionally(CGRect container, CGRect containee)
{
	float horizScale = container.size.width / containee.size.width;
	float vertScale = container.size.height / containee.size.height;
	
	float scale = MIN(vertScale, horizScale);
	
	containee.size.width *= scale;
	containee.size.height *= scale;
	
	return containee;
}

CGRect GtRectEnsureRectInRect(CGRect container, CGRect containee)
{
	if(containee.origin.x < container.origin.x)
	{
		containee.origin.x = container.origin.x;
	}
	else if(GtRectGetRight(containee) > GtRectGetRight(container))
	{
		containee.origin.x = GtRectGetRight(container) - containee.size.width;
	}
	
	if(containee.origin.y < container.origin.y)
	{
		containee.origin.y = container.origin.y;
	}
	else if(GtRectGetBottom(containee) > GtRectGetBottom(container))
	{
		containee.origin.y = GtRectGetBottom(container) - containee.size.height;
	}
	
	return containee;
}

#if GT_CHECK_RECT_SANITY
#define MAX_SIZE 5000

CGRect GtAssertIsSaneRect(CGRect r)
{
	@try
	{
		GtAssert(	r.size.width >= -MAX_SIZE && 
					r.size.width <= MAX_SIZE &&
					r.size.height >= -MAX_SIZE && 
					r.size.height <= MAX_SIZE,
					@"size is whacked: %@", NSStringFromCGRect(r));
					
		GtAssert(	r.origin.x >= -MAX_SIZE && 
					r.origin.x <= MAX_SIZE &&
					r.origin.y >= -MAX_SIZE && 
					r.origin.y <= MAX_SIZE,
					@"origin is whacked: %@", NSStringFromCGRect(r));
	}
	@catch(NSException* ex)
	{
	}
	
	return r;
}

CGPoint GtAssertIsSanePoint(CGPoint pt)
{
	@try
	{
		GtAssert(	pt.x >= -MAX_SIZE && 
					pt.x <= MAX_SIZE &&
					pt.y >= -MAX_SIZE && 
					pt.y <= MAX_SIZE,
					@"point is whacked: %@", NSStringFromCGPoint(pt));
	}
	@catch(NSException* ex)
	{
	}

	return pt;

}
#endif