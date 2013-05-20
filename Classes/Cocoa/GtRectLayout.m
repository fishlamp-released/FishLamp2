//
//	GtRectLayout.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/13/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRectLayout.h"

#if MARGINS 
const struct GtRectLayout GtRectLayoutNone = {	GtRectLayoutHorizontalNone,	 GtRectLayoutVerticalNone, { 0, 0 , 0, 0}, {0,0} };
const struct GtRectLayout GtRectLayoutFill = {	GtRectLayoutHorizontalFill, GtRectLayoutVerticalFill, { 0, 0 , 0, 0}, {0,0}};
const struct GtRectLayout GtRectLayoutCentered = {	GtRectLayoutHorizontalCentered, GtRectLayoutVerticalCentered, { 0, 0 , 0, 0}, {0,0}};
#else
const struct GtRectLayout GtRectLayoutNone = {	GtRectLayoutHorizontalNone,	 GtRectLayoutVerticalNone };
const struct GtRectLayout GtRectLayoutFill = {	GtRectLayoutHorizontalFill, GtRectLayoutVerticalFill};
const struct GtRectLayout GtRectLayoutCentered = {	GtRectLayoutHorizontalCentered, GtRectLayoutVerticalCentered};
#endif
																				
CGRect GtRectLayoutRectInRectVerticallyWithPadding(
	GtRectLayout layout,
	CGRect containerRect, 
	CGRect containeeRect,
	UIEdgeInsets padding)
{
	switch(layout.vertical)
	{
		case GtRectLayoutVerticalTop:
#if MARGINS 
			containeeRect = GtRectSetTop(containeeRect, layout.margin.top + padding.top);
#else
			containeeRect = GtRectSetTop(containeeRect, padding.top);
#endif
			break;
		
		case GtRectLayoutVerticalFill:
			containeeRect.origin.y = containerRect.origin.y;
			containeeRect.size.height = containerRect.size.height;
#if MARGINS 

			containeeRect = GtRectInsetTop(containeeRect, layout.margin.top + padding.top);
			containeeRect = GtRectInsetBottom(containeeRect, layout.margin.bottom + padding.bottom);
#else
			containeeRect = GtRectInsetTop(containeeRect, padding.top);
			containeeRect = GtRectInsetBottom(containeeRect, padding.bottom);

#endif            
		break;

		case GtRectLayoutVerticalCentered:
			containeeRect = GtRectCenterRectInRectVertically(containerRect, containeeRect);
			break;
		
		case GtRectLayoutVerticalTopThird:
			containeeRect.origin.y = (containerRect.size.height	 * 0.33) - (containeeRect.size.height * 0.5f);
			break;
   
		case GtRectLayoutVerticalBottomThird:
			containeeRect.origin.y = ((containerRect.size.height * 0.33) * 2.0f) - (containeeRect.size.height * 0.5f);
			break;
				 
		case GtRectLayoutVerticalBottom:
#if MARGINS         
			containeeRect.origin.y = containerRect.size.height - containeeRect.size.height - layout.margin.top - padding.bottom;
#else
			containeeRect.origin.y = containerRect.size.height - containeeRect.size.height - padding.bottom;
#endif            
			break;
			
		case GtRectLayoutVerticalNone:
			break;
	
		default:
			GtAssertFailed(@"unknown layout");
			break;
	}	
	
#if MARGINS 
	return GtRectMoveVertically(containeeRect, layout.offset.y);
#else
    return containeeRect;
#endif    
}


CGRect GtRectLayoutRectInRectHorizontallyWithPadding(
	GtRectLayout layout,
	CGRect containerRect, 
	CGRect containeeRect,
	UIEdgeInsets padding)
{
	switch(layout.horizontal)
	{
		case GtRectLayoutHorizontalLeftThird:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.33f) - (containeeRect.size.width * 0.5f));
			break;

		case GtRectLayoutHorizontalLeftQuarter:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.25f) - (containeeRect.size.width * 0.5f));
			break;
		
		case GtRectLayoutHorizontalLeft:
#if MARGINS    
			containeeRect.origin.x = containerRect.origin.x + layout.margin.left + padding.left;
#else
			containeeRect.origin.x = containerRect.origin.x + padding.left;
#endif            
			break;

		case GtRectLayoutHorizontalRightThird:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.66f) - (containeeRect.size.width * 0.5f));
			break;
		case GtRectLayoutHorizontalRightQuarter:
			containeeRect.origin.x = containerRect.origin.x + ((containerRect.size.width * 0.75f) - (containeeRect.size.width * 0.5f));
			break;

		case GtRectLayoutHorizontalRight:
#if MARGINS 
			containeeRect.origin.x = containerRect.size.width - containeeRect.size.width - layout.margin.right - padding.right;
#else
			containeeRect.origin.x = containerRect.size.width - containeeRect.size.width - padding.right;
#endif            
			break;

		case GtRectLayoutHorizontalCentered:
			containeeRect = GtRectCenterRectInRectHorizontally(containerRect, containeeRect);
			break;

		case GtRectLayoutHorizontalNone:
			break;
			
		case GtRectLayoutHorizontalFill:
#if MARGINS 
			containeeRect.size.width = (containerRect.size.width - layout.margin.left - layout.margin.right - padding.left - padding.right);
#else
			containeeRect.size.width = (containerRect.size.width - padding.left - padding.right);
#endif            
			containeeRect = GtRectCenterRectInRectHorizontally(containerRect, containeeRect);
			break;
		
		default:
			GtAssertFailed(@"unknown layout");
			break;
	}

#if MARGINS 
	return GtRectMoveHorizontally(containeeRect, layout.offset.x);
#else
    return containeeRect;
#endif    
}