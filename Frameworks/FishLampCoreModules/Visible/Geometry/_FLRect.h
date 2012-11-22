
FL_SHIP_ONLY_INLINE 
BOOL FLRectIsIntegral(FLRect r) {
	return	FLIsIntegralValue(r.origin.x) && 
			FLIsIntegralValue(r.origin.y) && 
			FLIsIntegralValue(r.size.width) &&
			FLIsIntegralValue(r.size.height);
}



FL_SHIP_ONLY_INLINE 
FLRect FLRectCenterOnPoint(FLRect rect, FLPoint point) {
	rect.origin.x = point.x - (rect.size.width * 0.5f);
	rect.origin.y = point.y - (rect.size.height * 0.5f);
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectCenterOnPointHorizontally(FLRect rect, FLPoint point) {
	rect.origin.x = point.x - (rect.size.width * 0.5f);
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectCenterOnPointVertically(FLRect rect, FLPoint point) {
	rect.origin.y = point.y - (rect.size.height * 0.5f);
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLPoint FLRectGetCenter(FLRect rect) {
	return FLPointMake(FLRectGetMidX(rect), FLRectGetMidY(rect));
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectCenterRectInRect(FLRect container, FLRect containee) {
	containee.origin.x = FLRectGetMidX(container) - (containee.size.width * 0.5f);
	containee.origin.y = FLRectGetMidY(container) - (containee.size.height * 0.5f);
    return containee;
}

FL_SHIP_ONLY_INLINE
FLRect FLRectCenterRectInRectVertically(FLRect container, FLRect containee) {
	containee.origin.y = FLRectGetMidY(container) - (containee.size.height * 0.5f);
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectCenterRectInRectHorizontally(FLRect container, FLRect containee) {
	containee.origin.x = FLRectGetMidX(container) - (containee.size.width * 0.5f);
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectRight(FLRect container, FLRect containee) {
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectLeft(FLRect container, FLRect containee) {
	containee.origin.x = container.origin.x;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectTop(FLRect container, FLRect containee) {
	containee.origin.y = container.origin.y;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectBottom(FLRect container, FLRect containee) {
	containee.origin.y = (container.origin.y + container.size.height) - containee.size.height;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectTopLeft(FLRect container, FLRect containee) {
	containee.origin.y = container.origin.y;
	containee.origin.x = container.origin.x;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectTopRight(FLRect container, FLRect containee) {
	containee.origin.y = container.origin.y;
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectBottomRight(FLRect container, FLRect containee) {
	containee.origin.y = container.origin.y + container.size.height - containee.size.height;
	containee.origin.x = container.origin.x + container.size.width - containee.size.width;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectJustifyRectInRectBottomLeft(FLRect container, FLRect containee) {
	containee.origin.y = container.origin.y + container.size.height - containee.size.height;
	containee.origin.x = container.origin.x;
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectInsetTop(FLRect inRect, CGFloat delta) {
	inRect.size.height -= delta;
	inRect.origin.y += delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectInsetBottom(FLRect inRect, CGFloat delta) {
		inRect.size.height -= delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectInsetLeft(FLRect inRect, CGFloat delta) {
	inRect.size.width -= delta;
	inRect.origin.x += delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectInsetRight(FLRect inRect, CGFloat delta) {
	inRect.size.width -= delta;
	return inRect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectAlignRectsHorizonally(FLRect left, FLRect right) {
	right.origin.x = left.origin.x + left.size.width;
	return right;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetHeight(FLRect rect, CGFloat height) {
	rect.size.height = height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectAddHeight(FLRect rect, CGFloat height) {
	rect.size.height += height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetWidth(FLRect rect, CGFloat width) {
	rect.size.width = width;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectAddWidth(FLRect rect, CGFloat width) {
	rect.size.width += width;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetTop(FLRect rect, CGFloat top) {
	rect.origin.y = top;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetLeft(FLRect rect, CGFloat left) {
	rect.origin.x = left;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectAlignRectVertically(FLRect top, FLRect bottom) {
	bottom.origin.y = (top.origin.y + top.size.height);
	return bottom;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectRotate90Degrees(FLRect rect) {
	return FLRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectPositionRectInRectVerticallyBottomThird(FLRect container, FLRect containee) {
	containee.origin.y = ((container.size.height / 3)*2) - (containee.size.height/2);
	return containee;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectPositionRectInRectVerticallyTopThird(FLRect container, FLRect containee) {
	containee.origin.y = (container.size.height / 3) - (containee.size.height/2);
	return containee;
}

FL_SHIP_ONLY_INLINE 
BOOL FLRectEnclosesRect(FLRect container, FLRect containee)  {
	return	containee.origin.x >= container.origin.x &&
			containee.origin.y >= container.origin.y &&
			(containee.origin.x + containee.size.width) <= (container.origin.x + container.size.width) &&
			(containee.origin.y + containee.size.height) <= (container.origin.y + container.size.height);
}

FL_SHIP_ONLY_INLINE 
CGFloat FLRectGetRight(FLRect rect) {
	return rect.origin.x + rect.size.width;
}

FL_SHIP_ONLY_INLINE 
CGFloat FLRectGetBottom(FLRect rect) {
	return rect.origin.y + rect.size.height;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectMoveWithPoint(FLRect rect, FLPoint delta) {
	rect.origin.x += delta.x;
	rect.origin.y += delta.y;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectMoveVertically(FLRect rect, CGFloat delta) {
	rect.origin.y += delta;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectMoveHorizontally(FLRect rect, CGFloat delta) {
	rect.origin.x += delta;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectMove(FLRect rect, CGFloat xDelta, CGFloat yDelta) {
	rect.origin.x += xDelta;
	rect.origin.y += yDelta;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLPoint FLRectGetTopRight(FLRect rect) {
	return FLPointMake(rect.origin.x + rect.size.width, rect.origin.y);
}

FL_SHIP_ONLY_INLINE 
FLPoint FLRectGetBottomRight(FLRect rect) {
	return FLPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}

FL_SHIP_ONLY_INLINE 
FLPoint FLRectGetBottomLeft(FLRect rect) {
	return FLPointMake(rect.origin.x, rect.origin.y + rect.size.height);
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetOrigin(FLRect rect, CGFloat x, CGFloat y) {
	rect.origin.x = x;
	rect.origin.y = y;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetOriginWithPoint(FLRect rect, FLPoint origin) {
	rect.origin = origin;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetSize(FLRect rect, CGFloat width, CGFloat height) {
	rect.size.width = width;
	rect.size.height = height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectAddSize(FLRect rect, CGFloat width, CGFloat height) {
	rect.size.width += width;
	rect.size.height += height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectAddSizeWithSize(FLRect rect, FLSize size) {
	rect.size.width += size.width;
	rect.size.height += size.height;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectSetSizeWithSize(FLRect rect, FLSize size) {
	rect.size = size;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectScale(FLRect rect, CGFloat scaleFactor) {
	rect.size.width *= scaleFactor;
	rect.size.height *= scaleFactor;
	return rect;
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectMakeWithSize(FLSize size) {	
	return FLRectMake(0,0,size.width, size.height);
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectMakeWithWidthAndHeight(CGFloat width, CGFloat height) {	
	return FLRectMake(0,0,width, height);
}




