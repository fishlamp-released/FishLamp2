
#if IOS

FL_SHIP_ONLY_INLINE
BOOL FLRectWidthIsOptimizedForView(SDKRect r) {
    return r.size.width == 0.0f || (FLRectIsIntegral(r) && (FLFloatMod(r.origin.x + r.size.width, 2.0f) == 0.0f));
}

FL_SHIP_ONLY_INLINE
BOOL FLRectHeightIsOptimizedForView(SDKRect r) {
    return r.size.height == 0.0f || (FLRectIsIntegral(r) && (FLFloatMod(r.origin.y + r.size.height, 2.0f) == 0.0f));
}

FL_SHIP_ONLY_INLINE 
BOOL FLRectIsOptimizedForView(SDKRect r) {
	return	FLRectIsIntegral(r) && 
			FLRectWidthIsOptimizedForView(r) &&
			FLRectHeightIsOptimizedForView(r);
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectOptimizedForViewSize(SDKRect r) {
	r = SDKRectIntegral(r);
	
	// make sure the midpoint is not fractional.
	if(!FLRectWidthIsOptimizedForView(r)) {
        r.size.width += 1.0f; 
    }
	if(!FLRectHeightIsOptimizedForView(r)) {
        r.size.height += 1.0f; // outRect.origin.y -= 1.0f;
	}
	return r;
}

FL_SHIP_ONLY_INLINE 
SDKRect FLRectOptimizedForViewLocation(SDKRect r) {
	r = SDKRectIntegral(r);
	
	// make sure the midpoint is not fractional.
	if(!FLRectWidthIsOptimizedForView(r)) {
        r.origin.x -= 1.0f;
    }
	if(!FLRectHeightIsOptimizedForView(r)) {
        r.origin.y -= 1.0f;
    }
	
	return r;
}

FL_SHIP_ONLY_INLINE 
SDKSize FLSizeOptimizeForView(SDKSize aSize) {
	SDKSize size = FLSizeMake(round(aSize.width), round(aSize.height));
	if(FLFloatMod(size.width, 2.0f) != 0.0f) size.width += 1.0f;
	if(FLFloatMod(size.height, 2.0f) != 0.0f) size.height += 1.0f;
	return size;
}

#endif