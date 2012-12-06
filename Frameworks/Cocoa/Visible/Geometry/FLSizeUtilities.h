//
//  SDKSize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/12/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "SDKSize.h"

extern const SDKSize FLSizeMax;

NS_INLINE
SDKSize FLSizeScale(SDKSize size, CGFloat scaleFactor) {
	size.width *= scaleFactor;
	size.height *= scaleFactor;
	return size;
}

NS_INLINE
SDKSize FLSizeSwapValues(SDKSize size) {
	return FLSizeMake(size.height, size.width);
}

NS_INLINE
SDKSize FLSizeAddSizeToSize(SDKSize addTo, SDKSize delta) {
	addTo.height += delta.height;
	addTo.width += delta.width;
	return addTo;
}

NS_INLINE
SDKSize FLPointSubtractSizeFromSize(SDKSize subtractFrom, SDKSize delta) {
	subtractFrom.width -= delta.width;
	subtractFrom.height -= delta.height;
	return subtractFrom;
}

NS_INLINE
BOOL FLSizeIsEmpty(SDKSize size) {
	return FLFloatEqualToZero(size.width) && FLFloatEqualToZero(size.height);
}
