//
//  FLRectOptimize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 
	Regarding FLRectOptimize

	There are two issues here:
	1.	you don't want your origin on a subpixel boundary, e.g. frame.origin.x = 10.5. You want it
		on integral bounderies, e.g. 10.0. Images and Text will render "fuzzy" if you do.
	2.	you don't want the center point of the view to be on a subpixel, which means the width an 
		height need to be evenly divisible by 2. Note that I opted to grow the frame by 1 pixel
		so that finely sized views aren't clipped (like text with decenders).
*/ 


#if IOS

#if DEBUG

extern FLSize FLSizeOptimizeForView(FLSize aSize);

// optimizing location and size for view frames
extern BOOL FLRectWidthIsOptimizedForView(FLRect r);
extern BOOL FLRectHeightIsOptimizedForView(FLRect r);
extern BOOL FLRectIsOptimizedForView(FLRect r);
extern FLRect FLRectOptimizedForViewSize(FLRect r);
extern FLRect FLRectOptimizedForViewLocation(FLRect r);


#define FLWarnIfRectIsNotOptimizedForView(r) if(!FLRectIsOptimizedForView(r)) FLDebugLog(@"%s is not optimized for view", #r)
#define FLAssertRectOptimizedForView_v(r) FLAssert_v(FLRectIsOptimizedForView(r), @"%s is not optimized for view", #r) 

#else

#define FLWarnIfRectIsNotOptimizedForView(r)
#define FLAssertRectOptimizedForView_v(r)


#import "_FLRectOptimize.h"

#endif

#else 

#define FLSizeOptimizeForView(aSize) aSize
#define FLRectWidthIsOptimizedForView(r) YES
#define FLRectHeightIsOptimizedForView(r) YES
#define FLRectIsOptimizedForView(r) YES
#define FLRectOptimizedForViewSize(r) r
#define FLRectOptimizedForViewLocation(r) r
#define FLWarnIfRectIsNotOptimizedForView(r)
#define FLAssertRectOptimizedForView_v(r)
#endif