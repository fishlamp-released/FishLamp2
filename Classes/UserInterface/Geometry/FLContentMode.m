//
//	FLContentMode.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/13/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLContentMode.h"
#import "FLRect.h"

#if DEBUG
#import "_FLContentMode.h"
#endif

const struct FLContentMode FLContentModeNone = {	FLContentModeHorizontalNone,	 FLContentModeVerticalNone, {0,0,0,0} };
const struct FLContentMode FLContentModeFill = {	FLContentModeHorizontalFill, FLContentModeVerticalFill, {0,0,0,0}};
const struct FLContentMode FLContentModeCentered = { FLContentModeHorizontalCentered, FLContentModeVerticalCentered, {0,0,0,0}};
const struct FLContentMode FLContentModeAspectFit = {	FLContentModeHorizontalFit, FLContentModeVerticalFit, {0,0,0,0} };
const struct FLContentMode FLContentModeCenteredTop = {	FLContentModeHorizontalCentered, FLContentModeVerticalTop, {0,0,0,0} };
const struct FLContentMode FLContentModeCenteredBottom = {	FLContentModeHorizontalCentered, FLContentModeVerticalBottom, {0,0,0,0} };

FLRect FLRectPositionRectInRectVerticallyWithContentMode(
        FLRect containerRect,
        FLRect containeeRect,
		FLContentMode contentMode ) {
	
    switch(contentMode.vertical) {
		case FLContentModeVerticalTop:
			containeeRect = FLRectSetTop(containeeRect, contentMode.insets.top);
			break;
		
		case FLContentModeVerticalFill:
			containeeRect.origin.y = containerRect.origin.y;
			containeeRect.size.height = containerRect.size.height;

			containeeRect = FLRectInsetTop(containeeRect, contentMode.insets.top);
			containeeRect = FLRectInsetBottom(containeeRect, contentMode.insets.bottom);
		break;

		case FLContentModeVerticalCentered:
			containeeRect = FLRectCenterRectInRectVertically(containerRect, containeeRect);
			break;
		
		case FLContentModeVerticalTopThird:
			containeeRect.origin.y = (containerRect.size.height	 * 0.33) - (containeeRect.size.height * 0.5f);
			break;
   
		case FLContentModeVerticalBottomThird:
			containeeRect.origin.y = ((containerRect.size.height * 0.33) * 2.0f) - (containeeRect.size.height * 0.5f);
			break;
				 
		case FLContentModeVerticalBottom:
			containeeRect.origin.y = containerRect.size.height - containeeRect.size.height - contentMode.insets.top;
			break;
			
		case FLContentModeVerticalNone:
			break;
            
        case FLContentModeVerticalFit:
            FLCAssertIsFixed_v(@"vertical fit");
            break;
	
	}	
	
    return containeeRect;
}


FLRect FLRectPositionRectInRectHorizontallyWithContentMode(
	FLRect containerRect,
	FLRect containeeRect,
	FLContentMode contentMode)
{
	switch(contentMode.horizontal) {
		case FLContentModeHorizontalLeftThird:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.33f) - (containeeRect.size.width * 0.5f));
			break;

		case FLContentModeHorizontalLeftQuarter:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.25f) - (containeeRect.size.width * 0.5f));
			break;
		
		case FLContentModeHorizontalLeft:
			containeeRect.origin.x = containerRect.origin.x + contentMode.insets.left;
			break;

		case FLContentModeHorizontalRightThird:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.66f) - (containeeRect.size.width * 0.5f));
			break;

		case FLContentModeHorizontalRightQuarter:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.75f) - (containeeRect.size.width * 0.5f));
			break;

		case FLContentModeHorizontalRight:
			containeeRect.origin.x = FLRectGetRight(containerRect) - containeeRect.size.width - contentMode.insets.right;
			break;

		case FLContentModeHorizontalCentered:
			containeeRect = FLRectCenterRectInRectHorizontally(containerRect, containeeRect);
			break;

		case FLContentModeHorizontalNone:
			break;
			
		case FLContentModeHorizontalFill:
			containeeRect.size.width = (containerRect.size.width - contentMode.insets.left - contentMode.insets.right);
			containeeRect = FLRectCenterRectInRectHorizontally(containerRect, containeeRect);
			break;
            
        case FLContentModeHorizontalFit:
            FLCAssertIsFixed_v(@"horizontal fit");
        break;
		
	}

    return containeeRect;
}
																				
