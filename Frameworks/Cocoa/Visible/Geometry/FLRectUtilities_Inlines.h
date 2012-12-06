
FL_SHIP_ONLY_INLINE 
BOOL FLRectIsIntegral(SDKRect r) {
	return	FLIsIntegralValue(r.origin.x) && 
			FLIsIntegralValue(r.origin.y) && 
			FLIsIntegralValue(r.size.width) &&
			FLIsIntegralValue(r.size.height);
}



FL_SHIP_ONLY_INLINE 
SDKRect FLRectCenterOnPoint(SDKRect rect, SDKPoint point) {
	rect.origin.x = point.x - (rect.size.width * 0.5f);
	rect.origin.y = point.y - (rect.size.height * 0.5f);
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectCenterOnPointHorizontally(SDKRect rect, SDKPoint point) {
	rect.origin.x = point.x - (rect.size.width * 0.5f);
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectCenterOnPointVertically(SDKRect rect, SDKPoint point) {
	rect.origin.y = point.y - (rect.size.height * 0.5f);
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKPoint FLRectGetCenter(SDKRect rect) {
	return FLPointMake(FLRectGetMidX(rect), FLRectGetMidY(rect));
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectCenterRectInRect(SDKRect container, SDKRect containee) {
	containee.origin.x = FLRectGetMidX(container) - (containee.size.width * 0.5f);
	containee.origin.y = FLRectGetMidY(container) - (containee.size.height * 0.5f);
    return containee;
}

FL_SHIP_ONLY_INLINE
SDKRect FLRectCenterRectInRectVertically(SDKRect container, SDKRect containee) {
	containee.origin.y = FLRectGetMidY(container) - (containee.size.height * 0.5f);
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectCenterRectInRectHorizontally(SDKRect container, SDKRect containee) {
	containee.origin.x = FLRectGetMidX(container) - (containee.size.width * 0.5f);
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectRight(SDKRect container, SDKRect containee) {
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectLeft(SDKRect container, SDKRect containee) {
	containee.origin.x = container.origin.x;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectTop(SDKRect container, SDKRect containee) {
	containee.origin.y = container.origin.y;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectBottom(SDKRect container, SDKRect containee) {
	containee.origin.y = (container.origin.y + container.size.height) - containee.size.height;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectTopLeft(SDKRect container, SDKRect containee) {
	containee.origin.y = container.origin.y;
	containee.origin.x = container.origin.x;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectTopRight(SDKRect container, SDKRect containee) {
	containee.origin.y = container.origin.y;
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectBottomRight(SDKRect container, SDKRect containee) {
	containee.origin.y = container.origin.y + container.size.height - containee.size.height;
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectJustifyRectInRectBottomLeft(SDKRect container, SDKRect containee) {
	containee.origin.y = container.origin.y + container.size.height - containee.size.height;
	containee.origin.x = container.origin.x;
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectInsetWithEdgeInsets(SDKRect inRect, SDKEdgeInsets insets) {
	inRect.size.height -= (insets.top + insets.bottom);
    inRect.size.width -= (insets.left + insets.right);
    inRect.origin.x += insets.left;
    inRect.origin.y += insets.top;
    return inRect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectInsetTop(SDKRect inRect, CGFloat delta) {
	inRect.size.height -= delta;
	inRect.origin.y += delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectInsetBottom(SDKRect inRect, CGFloat delta) {
		inRect.size.height -= delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectInsetLeft(SDKRect inRect, CGFloat delta) {
	inRect.size.width -= delta;
	inRect.origin.x += delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectInsetRight(SDKRect inRect, CGFloat delta) {
	inRect.size.width -= delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectAlignRectsHorizonally(SDKRect left, SDKRect right) {
	right.origin.x = left.origin.x + left.size.width;
	return right;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetHeight(SDKRect rect, CGFloat height) {
	rect.size.height = height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectAddHeight(SDKRect rect, CGFloat height) {
	rect.size.height += height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetWidth(SDKRect rect, CGFloat width) {
	rect.size.width = width;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectAddWidth(SDKRect rect, CGFloat width) {
	rect.size.width += width;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetTop(SDKRect rect, CGFloat top) {
	rect.origin.y = top;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetLeft(SDKRect rect, CGFloat left) {
	rect.origin.x = left;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectAlignRectVertically(SDKRect top, SDKRect bottom) {
	bottom.origin.y = (top.origin.y + top.size.height);
	return bottom;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectRotate90Degrees(SDKRect rect) {
	return FLRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectPositionRectInRectVerticallyBottomThird(SDKRect container, SDKRect containee) {
	containee.origin.y = ((container.size.height / 3)*2) - (containee.size.height/2);
	return containee;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectPositionRectInRectVerticallyTopThird(SDKRect container, SDKRect containee) {
	containee.origin.y = (container.size.height / 3) - (containee.size.height/2);
	return containee;
}

FL_SHIP_ONLY_INLINE 
BOOL FLRectEnclosesRect(SDKRect container, SDKRect containee)  {
	return	containee.origin.x >= container.origin.x &&
			containee.origin.y >= container.origin.y &&
			(containee.origin.x + containee.size.width) <= (container.origin.x + container.size.width) &&
			(containee.origin.y + containee.size.height) <= (container.origin.y + container.size.height);
}

FL_SHIP_ONLY_INLINE 
CGFloat FLRectGetRight(SDKRect rect) {
	return rect.origin.x + rect.size.width;
}

FL_SHIP_ONLY_INLINE 
CGFloat FLRectGetBottom(SDKRect rect) {
	return rect.origin.y + rect.size.height;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectMoveWithPoint(SDKRect rect, SDKPoint delta) {
	rect.origin.x += delta.x;
	rect.origin.y += delta.y;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectMoveVertically(SDKRect rect, CGFloat delta) {
	rect.origin.y += delta;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectMoveHorizontally(SDKRect rect, CGFloat delta) {
	rect.origin.x += delta;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectMove(SDKRect rect, CGFloat xDelta, CGFloat yDelta) {
	rect.origin.x += xDelta;
	rect.origin.y += yDelta;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKPoint FLRectGetTopRight(SDKRect rect) {
	return FLPointMake(rect.origin.x + rect.size.width, rect.origin.y);
}

FL_SHIP_ONLY_INLINE 
SDKPoint FLRectGetBottomRight(SDKRect rect) {
	return FLPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}

FL_SHIP_ONLY_INLINE 
SDKPoint FLRectGetBottomLeft(SDKRect rect) {
	return FLPointMake(rect.origin.x, rect.origin.y + rect.size.height);
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetOrigin(SDKRect rect, CGFloat x, CGFloat y) {
	rect.origin.x = x;
	rect.origin.y = y;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetOriginWithPoint(SDKRect rect, SDKPoint origin) {
	rect.origin = origin;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetSize(SDKRect rect, CGFloat width, CGFloat height) {
	rect.size.width = width;
	rect.size.height = height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectAddSize(SDKRect rect, CGFloat width, CGFloat height) {
	rect.size.width += width;
	rect.size.height += height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectAddSizeWithSize(SDKRect rect, SDKSize size) {
	rect.size.width += size.width;
	rect.size.height += size.height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectSetSizeWithSize(SDKRect rect, SDKSize size) {
	rect.size = size;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectScale(SDKRect rect, CGFloat scaleFactor) {
	rect.size.width *= scaleFactor;
	rect.size.height *= scaleFactor;
	return rect;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectMakeWithSize(SDKSize size) {	
	return FLRectMake(0,0,size.width, size.height);
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectMakeWithWidthAndHeight(CGFloat width, CGFloat height) {	
	return FLRectMake(0,0,width, height);
}




