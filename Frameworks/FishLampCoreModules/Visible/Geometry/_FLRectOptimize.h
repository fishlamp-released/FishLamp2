
#if IOS

FL_SHIP_ONLY_INLINE
BOOL FLRectWidthIsOptimizedForView(FLRect r) {
    return r.size.width == 0.0f || (FLRectIsIntegral(r) && (FLFloatMod(r.origin.x + r.size.width, 2.0f) == 0.0f));
}

FL_SHIP_ONLY_INLINE
BOOL FLRectHeightIsOptimizedForView(FLRect r) {
    return r.size.height == 0.0f || (FLRectIsIntegral(r) && (FLFloatMod(r.origin.y + r.size.height, 2.0f) == 0.0f));
}

FL_SHIP_ONLY_INLINE 
BOOL FLRectIsOptimizedForView(FLRect r) {
	return	FLRectIsIntegral(r) && 
			FLRectWidthIsOptimizedForView(r) &&
			FLRectHeightIsOptimizedForView(r);
}

FL_SHIP_ONLY_INLINE 
FLRect FLRectOptimizedForViewSize(FLRect r) {
	r = FLRectIntegral(r);
	
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
FLRect FLRectOptimizedForViewLocation(FLRect r) {
	r = FLRectIntegral(r);
	
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
FLSize FLSizeOptimizeForView(FLSize aSize) {
	FLSize size = FLSizeMake(round(aSize.width), round(aSize.height));
	if(FLFloatMod(size.width, 2.0f) != 0.0f) size.width += 1.0f;
	if(FLFloatMod(size.height, 2.0f) != 0.0f) size.height += 1.0f;
	return size;
}

#endif