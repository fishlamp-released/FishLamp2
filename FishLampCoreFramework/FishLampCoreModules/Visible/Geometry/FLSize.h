//
//  FLSize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/12/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#if IOS
    #define FLSize                   CGSize
    #define FLSizeMake               CGSizeMake
    #define NSStringFromFLSize       NSStringFromCGSize
    #define FLSizeFromString         CGSizeFromString
    #define FLSizeZero               CGSizeZero
    #define FLSizeEqualToSize        CGSizeEqualToSize
    #define FLEqualSizes             CGSizeEqualToSize
#else
    #define FLSize                   NSSize
    #define FLSizeMake               NSMakeSize
    #define NSStringFromFLSize       NSStringFromSize
    #define FLSizeFromString         NSSizeFromString     
    #define FLSizeZero               NSZeroSize
    #define FLSizeEqualToSize        NSEqualSizes
    #define FLEqualSizes             NSEqualSizes
    
#endif

extern const FLSize FLSizeMax;

NS_INLINE
FLSize FLSizeScale(FLSize size, CGFloat scaleFactor) {
	size.width *= scaleFactor;
	size.height *= scaleFactor;
	return size;
}

NS_INLINE
FLSize FLSizeSwapValues(FLSize size) {
	return FLSizeMake(size.height, size.width);
}

NS_INLINE
FLSize FLSizeAddSizeToSize(FLSize addTo, FLSize delta) {
	addTo.height += delta.height;
	addTo.width += delta.width;
	return addTo;
}

NS_INLINE
FLSize FLPointSubtractSizeFromSize(FLSize subtractFrom, FLSize delta) {
	subtractFrom.width -= delta.width;
	subtractFrom.height -= delta.height;
	return subtractFrom;
}

NS_INLINE
BOOL FLSizeIsEmpty(FLSize size) {
	return FLFloatEqualToZero(size.width) && FLFloatEqualToZero(size.height);
}
