
#if DEBUG
#undef GT_INLINE
#define GT_INLINE 
#endif

GT_INLINE BOOL GtRectIsIntegral(CGRect r)
{
	GtAssertIsSaneRect(r);
	
	return	GtIsIntegralValue(r.origin.x) && 
			GtIsIntegralValue(r.origin.y) && 
			GtIsIntegralValue(r.size.width) &&
			GtIsIntegralValue(r.size.height);
}

GT_INLINE BOOL GtRectIsOptimizedForView(CGRect r)
{
	return	GtRectIsIntegral(r) && 
			GtRectWidthIsOptimizedForView(r) &&
			GtRectHeightIsOptimizedForView(r);
}
GT_INLINE CGRect GtRectGrowRectToOptimizedSizeIfNeeded(CGRect r)
{
	r = CGRectIntegral(r);
	
	// make sure the midpoint is not fractional.
	if(!GtRectWidthIsOptimizedForView(r)) r.size.width += 1.0f; //outRect.origin.x -= 1.0f;
	if(!GtRectHeightIsOptimizedForView(r)) r.size.height += 1.0f; // outRect.origin.y -= 1.0f;
	
	return r;
}

GT_INLINE CGRect GtRectMoveRectToOptimizedLocationIfNeeded(CGRect r)
{
	r = CGRectIntegral(r);
	
	// make sure the midpoint is not fractional.
	if(!GtRectWidthIsOptimizedForView(r)) r.origin.x -= 1.0f;
	if(!GtRectHeightIsOptimizedForView(r)) r.origin.y -= 1.0f;
	
	return r;
}

GT_INLINE CGSize GtSizeOptimizeForView(CGSize aSize)
{
	CGSize size = CGSizeMake(roundf(aSize.width), roundf(aSize.height));
	if(fmodf(size.width, 2.0f) != 0) size.width += 1.0f;
	if(fmodf(size.height, 2.0f) != 0) size.height += 1.0f;
	return size;
}

GT_INLINE CGRect GtRectCenterOnPoint(CGRect rect, CGPoint point)
{
	GtAssertIsSaneRect(rect);
	GtAssertIsSanePoint(point);
	
	rect.origin.x = point.x - CGRectGetWidth(rect)/ (CGFloat)2.0;
	rect.origin.y = point.y - CGRectGetHeight(rect)/ (CGFloat)2.0;
	return GtReturnAssertIsSaneRect(rect);
}

GT_INLINE CGPoint GtRectGetCenter(CGRect rect)
{
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

#if DEBUG

#ifdef CGRectInset
#undef CGRectInset
#endif
 
GT_INLINE CGRect GtRectInset(CGRect rect, CGFloat dx, CGFloat dy)
{
	GtAssert(rect.size.width >= (dx * 2), @"trying to inset too narrow of a rect");
	GtAssert(rect.size.height >= (dy * 2), @"trying to inset too short of a rect");
	
	return CGRectInset(rect, dx, dy);
}
#define CGRectInset GtRectInset
#endif

GT_INLINE CGRect GtRectCenterRectInRect(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.x = CGRectGetMidX(container) - (CGRectGetWidth(containee)/ (CGFloat)2.0);
	containee.origin.y = CGRectGetMidY(container) - (CGRectGetHeight(containee)/ (CGFloat)2.0);
	
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectCenterRectInRectVertically(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = CGRectGetMidY(container) - (CGRectGetHeight(containee)/ (CGFloat)2.0);
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectCenterRectInRectHorizontally(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.x = CGRectGetMidX(container) - (CGRectGetWidth(containee)/ (CGFloat)2.0);
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectRight(CGRect container, CGRect containee)
{
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectLeft(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.x = container.origin.x;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectTop(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = container.origin.y;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectBottom(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = (container.origin.y + container.size.height) - containee.size.height;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectTopLeft(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = container.origin.y;
	containee.origin.x = container.origin.x;
	return GtReturnAssertIsSaneRect(containee);
}


GT_INLINE CGRect GtRectJustifyRectInRectTopRight(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = container.origin.y;
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectBottomRight(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = container.origin.y + container.size.height - containee.size.height;
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectJustifyRectInRectBottomLeft(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = container.origin.y + container.size.height - containee.size.height;
	containee.origin.x = container.origin.x;
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectInsetTop(CGRect inRect, CGFloat delta)
{
	GtAssertIsSaneRect(inRect);

	inRect.size.height -= delta;
	inRect.origin.y += delta;
	return GtReturnAssertIsSaneRect(inRect);
}

GT_INLINE CGRect GtRectInsetBottom(CGRect inRect, CGFloat delta)
{
	GtAssertIsSaneRect(inRect);
	inRect.size.height -= delta;
	return GtReturnAssertIsSaneRect(inRect);
}

GT_INLINE CGRect GtRectInsetWithEdgeInsets(CGRect inRect, UIEdgeInsets insets)
{
	inRect.size.height -= (insets.top + insets.bottom);
	inRect.size.width -= (insets.left + insets.right);
	inRect.origin.y += insets.top;
	inRect.origin.x += insets.left;
	return inRect;
}

GT_INLINE CGRect GtRectInsetLeft(CGRect inRect, CGFloat delta)
{
	GtAssertIsSaneRect(inRect);

	inRect.size.width -= delta;
	inRect.origin.x += delta;
	return GtReturnAssertIsSaneRect(inRect);
}

GT_INLINE CGRect GtRectInsetRight(CGRect inRect, CGFloat delta)
{
	GtAssertIsSaneRect(inRect);

	inRect.size.width -= delta;
	return GtReturnAssertIsSaneRect(inRect);
}

GT_INLINE CGRect GtRectAlignRectsHorizonally(CGRect left, CGRect right)
{
	GtAssertIsSaneRect(left);
	GtAssertIsSaneRect(right);

	right.origin.x = left.origin.x + left.size.width;
	return GtReturnAssertIsSaneRect(right);
}

GT_INLINE CGRect GtRectSetHeight(CGRect rect, CGFloat height)
{
	rect.size.height = height;
	return rect;
}

GT_INLINE CGRect GtRectAddHeight(CGRect rect, CGFloat height)
{
	rect.size.height += height;
	return rect;
}

GT_INLINE CGRect GtRectSetWidth(CGRect rect, CGFloat width)
{
	rect.size.width = width;
	return rect;
}

GT_INLINE CGRect GtRectAddWidth(CGRect rect, CGFloat width)
{
	rect.size.width += width;
	return rect;
}

GT_INLINE CGRect GtRectSetTop(CGRect rect, CGFloat top)
{
	rect.origin.y = top;
	return rect;
}

GT_INLINE CGRect GtRectSetLeft(CGRect rect, CGFloat left)
{
	rect.origin.x = left;
	return rect;
}

GT_INLINE CGRect GtRectAlignRectVertically(CGRect top, CGRect bottom)
{
	GtAssertIsSaneRect(top);
	GtAssertIsSaneRect(bottom);

	bottom.origin.y = (top.origin.y + top.size.height);
	return GtReturnAssertIsSaneRect(bottom);
}

GT_INLINE CGRect GtRectRotate90Degrees(CGRect rect)
{
	GtAssertIsSaneRect(rect);

	return GtReturnAssertIsSaneRect(CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width));
}

GT_INLINE CGRect GtRectPositionRectInRectVerticallyBottomThird(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = ((container.size.height / 3)*2) - (containee.size.height/2);
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE CGRect GtRectPositionRectInRectVerticallyTopThird(CGRect container, CGRect containee)
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	containee.origin.y = (container.size.height / 3) - (containee.size.height/2);
	return GtReturnAssertIsSaneRect(containee);
}

GT_INLINE BOOL GtRectEnclosesRect(CGRect container, CGRect containee) 
{
	GtAssertIsSaneRect(container);
	GtAssertIsSaneRect(containee);

	return	containee.origin.x >= container.origin.x &&
			containee.origin.y >= container.origin.y &&
			(containee.origin.x + containee.size.width) <= (container.origin.x + container.size.width) &&
			(containee.origin.y + containee.size.height) <= (container.origin.y + container.size.height);
}

GT_INLINE CGFloat GtRectGetRight(CGRect rect)
{
	GtAssertIsSaneRect(rect);
	
	return rect.origin.x + rect.size.width;
}

GT_INLINE CGFloat GtRectGetBottom(CGRect rect)
{
	GtAssertIsSaneRect(rect);
	
	return rect.origin.y + rect.size.height;
}

GT_INLINE CGRect GtRectMoveWithPoint(CGRect rect, CGPoint delta)
{
	GtAssertIsSaneRect(rect);
	
	rect.origin.x += delta.x;
	rect.origin.y += delta.y;
	return GtReturnAssertIsSaneRect(rect);
}

GT_INLINE CGRect GtRectMoveVertically(CGRect rect, CGFloat delta)
{
	rect.origin.y += delta;
	return rect;
}


GT_INLINE CGRect GtRectMoveHorizontally(CGRect rect, CGFloat delta)
{
	rect.origin.x += delta;
	return rect;
}

GT_INLINE CGRect GtRectMove(CGRect rect, CGFloat xDelta, CGFloat yDelta)
{
	rect.origin.x += xDelta;
	rect.origin.y += yDelta;
	return rect;
}

GT_INLINE CGPoint GtRectGetTopRight(CGRect rect)
{
	GtAssertIsSaneRect(rect);

	return GtReturnAssertIsSaneRect(CGPointMake(rect.origin.x + rect.size.width, rect.origin.y));
}

GT_INLINE CGPoint GtRectGetBottomRight(CGRect rect)
{
	GtAssertIsSaneRect(rect);
	return GtReturnAssertIsSaneRect(CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height));
}

GT_INLINE CGPoint GtRectGetBottomLeft(CGRect rect)
{
	GtAssertIsSaneRect(rect);

	return GtReturnAssertIsSaneRect(CGPointMake(rect.origin.x, rect.origin.y + rect.size.height));
}

GT_INLINE CGRect GtRectSetOrigin(CGRect rect, CGFloat x, CGFloat y)
{
	rect.origin.x = x;
	rect.origin.y = y;
	return rect;
}

GT_INLINE CGRect GtRectSetOriginWithPoint(CGRect rect, CGPoint origin)
{
	rect.origin = origin;
	return rect;
}

GT_INLINE CGRect GtRectSetSize(CGRect rect, CGFloat width, CGFloat height)
{
	rect.size.width = width;
	rect.size.height = height;
	return rect;
}

GT_INLINE CGRect GtRectAddSize(CGRect rect, CGFloat width, CGFloat height)
{
	rect.size.width += width;
	rect.size.height += height;
	return rect;
}

GT_INLINE CGRect GtRectAddSizeWithSize(CGRect rect, CGSize size)
{
	rect.size.width += size.width;
	rect.size.height += size.height;
	return rect;
}

GT_INLINE CGRect GtRectSetSizeWithSize(CGRect rect, CGSize size)
{
	rect.size = size;
	return rect;
}

GT_INLINE CGRect GtRectScale(CGRect rect, CGFloat scaleFactor)
{
	rect.size.width *= scaleFactor;
	rect.size.height *= scaleFactor;
	return rect;
}

GT_INLINE CGRect GtRectMakeWithSize(CGSize size)
{	
	return CGRectMake(0,0,size.width, size.height);
}

GT_INLINE CGRect GtRectMakeWithWidthAndHeight(CGFloat width, CGFloat height)
{	
	return CGRectMake(0,0,width, height);
}

