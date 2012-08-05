//
//	FLGeometry.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLRect.h"

#if DEBUG
#include "_FLRect.h"
#include "_FLRectOptimize.h"
#endif

FLRect FLRectFillRectInRectProportionally(FLRect container, FLRect containee) {
	CGFloat horizScale = container.size.width / containee.size.width;
	CGFloat vertScale = container.size.height / containee.size.height;
	
	CGFloat scale = MAX(horizScale, vertScale);
	
	containee.size.width *= scale;
	containee.size.height *= scale;
	
	return containee;
}

FLRect FLRectFitInRectInRectProportionally(FLRect container, FLRect containee) {
	CGFloat horizScale = container.size.width / containee.size.width;
	CGFloat vertScale = container.size.height / containee.size.height;
	
	CGFloat scale = MIN(vertScale, horizScale);
	
	containee.size.width *= scale;
	containee.size.height *= scale;
	
	return containee;
}

FLRect FLRectEnsureRectInRect(FLRect container, FLRect containee) {
	if(containee.origin.x < container.origin.x) {
		containee.origin.x = container.origin.x;
	}
	else if(FLRectGetRight(containee) > FLRectGetRight(container)) {
		containee.origin.x = FLRectGetRight(container) - containee.size.width;
	}
	
	if(containee.origin.y < container.origin.y) {
		containee.origin.y = container.origin.y;
	}
	else if(FLRectGetBottom(containee) > FLRectGetBottom(container)) {
		containee.origin.y = FLRectGetBottom(container) - containee.size.height;
	}
	
	return containee;
}

#if DEBUG

#if IOS
    #undef CGRectInset
#else
    #undef NSRectInset
#endif
 
FLRect FLRectInset(FLRect rect, CGFloat dx, CGFloat dy) {
    FLCAssert(rect.size.width >= (dx * 2), @"trying to inset too narrow of a rect");
    FLCAssert(rect.size.height >= (dy * 2), @"trying to inset too short of a rect");
    
#if IOS
    return CGRectInset(rect, dx, dy);
#else
    return NSInsetRect(rect, dx, dy);
#endif

}

#endif

