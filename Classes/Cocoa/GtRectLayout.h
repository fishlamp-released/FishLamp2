//
//	GtRectLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/13/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

typedef enum {
	GtRectLayoutVerticalNone		  = 0,
	GtRectLayoutVerticalTop			= 10,
	GtRectLayoutVerticalTopThird,
	GtRectLayoutVerticalBottomThird,
	GtRectLayoutVerticalCentered,
	GtRectLayoutVerticalBottom,
	GtRectLayoutVerticalFill,
	GtRectLayoutVerticalCustomPoint
} GtRectLayoutVertical;

typedef enum { 
	GtRectLayoutHorizontalNone		  = 0,
	GtRectLayoutHorizontalLeft,
	GtRectLayoutHorizontalLeftThird,
	GtRectLayoutHorizontalLeftQuarter,
	GtRectLayoutHorizontalCentered,
	GtRectLayoutHorizontalRight,
	GtRectLayoutHorizontalRightThird,
	GtRectLayoutHorizontalRightQuarter,
	GtRectLayoutHorizontalFill
} GtRectLayoutHorizontal;

//#define MARGINS

typedef struct GtRectLayout { 
	GtRectLayoutHorizontal horizontal:16;
	GtRectLayoutVertical vertical:16;
#if MARGINS
	UIEdgeInsets margin;
	CGPoint offset;
#endif    
} GtRectLayout;

extern const GtRectLayout GtRectLayoutNone;
extern const GtRectLayout GtRectLayoutFill;
extern const GtRectLayout GtRectLayoutCentered;

NS_INLINE
BOOL GtRectLayoutEqualToRectLayout(GtRectLayout lhs, GtRectLayout rhs)
{
	return  lhs.horizontal == rhs.horizontal && 
            lhs.vertical == rhs.vertical 
#if MARGINS            
            && 
            UIEdgeInsetsEqualToEdgeInsets(rhs.margin, lhs.margin) && 
            CGPointEqualToPoint(lhs.offset, rhs.offset)
#endif            
            ;

}

NS_INLINE
GtRectLayout GtRectLayoutMake(	GtRectLayoutHorizontal horizontalLayout, 
									GtRectLayoutVertical verticalLayout)
{
	GtRectLayout loc;
	loc.horizontal = horizontalLayout;
	loc.vertical = verticalLayout;
#if MARGINS 
	loc.margin = UIEdgeInsetsZero;
	loc.offset = CGPointZero;
#endif
	return loc;
}

NS_INLINE
GtRectLayout GtRectLayoutSetVertical(GtRectLayout location, GtRectLayoutVertical vertical)
{
	location.vertical = vertical;
	return location;
}


#if MARGINS 

NS_INLINE
GtRectLayout GtRectLayoutSetHorizontal(GtRectLayout loc, GtRectLayoutHorizontal horizontal, UInt8 spacing)
{
	loc.horizontal = horizontal;
	loc.margin.left = spacing;
	loc.margin.right = spacing;
	return loc;
}

NS_INLINE
GtRectLayout GtRectLayoutMakeWithSpacing(	GtRectLayoutHorizontal horizontalLayout,
												GtRectLayoutVertical verticalLayout, 
												CGFloat verticalSpacing,
												CGFloat horizontalSpacing)
{
	GtRectLayout loc;
	loc.horizontal = horizontalLayout;
	loc.vertical = verticalLayout;
	loc.margin = UIEdgeInsetsMake(verticalSpacing, horizontalSpacing, verticalSpacing, horizontalSpacing);
	loc.offset = CGPointZero;
	return loc;
}

NS_INLINE
GtRectLayout GtRectLayoutMakeWithCustomPoint(	CGPoint customPoint)
{
	GtRectLayout loc;
	loc.horizontal = GtRectLayoutHorizontalNone;
	loc.vertical = GtRectLayoutVerticalNone;
	loc.margin = UIEdgeInsetsMake(customPoint.y, customPoint.x, 0,0);
	loc.offset = CGPointZero;
	return loc;
}

NS_INLINE
GtRectLayout GtRectLayoutMakeWithCustomCoordinates(		CGFloat x,
															CGFloat y)
{
	GtRectLayout loc;
	loc.horizontal = GtRectLayoutHorizontalNone;
	loc.vertical = GtRectLayoutVerticalNone;
	loc.margin = UIEdgeInsetsMake(y, x, 0,0);
	loc.offset = CGPointZero;
	return loc;
}

NS_INLINE
GtRectLayout GtRectLayoutSetMargins(GtRectLayout location, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
	location.margin = UIEdgeInsetsMake(top,left,bottom,right);
	return location;
}
#endif

NS_INLINE
GtRectLayout GtRectLayoutMakeBottom()
{
	GtRectLayout loc;
	loc.horizontal = GtRectLayoutHorizontalCentered;
	loc.vertical = GtRectLayoutVerticalBottom;
#if MARGINS 
	loc.margin = UIEdgeInsetsZero;
	loc.offset = CGPointZero;
#endif
	return loc;
}

NS_INLINE
GtRectLayout GtRectLayoutMakeTop()
{
	GtRectLayout loc;
	loc.horizontal = GtRectLayoutHorizontalCentered;
	loc.vertical = GtRectLayoutVerticalTop;
#if MARGINS 
	loc.margin = UIEdgeInsetsZero;
	loc.offset = CGPointZero;
#endif
	return loc;
}

//NS_INLINE
//CGFloat GtRectLayoutWidthForRect(CGRect rect, GtRectLayout location)
//{
//	  return rect.size.width + location.margin.left + location.margin.right;
//}

NS_INLINE
BOOL GtRectLayoutIsValid(GtRectLayout loc)
{
	return	loc.horizontal >= GtRectLayoutHorizontalNone && loc.vertical >= GtRectLayoutVerticalNone;
}

NS_INLINE
BOOL GtRectLayoutNotNone(GtRectLayout loc)
{
	return	loc.horizontal > GtRectLayoutHorizontalNone || loc.vertical > GtRectLayoutVerticalNone;
}

extern CGRect GtRectLayoutRectInRectHorizontallyWithPadding(
	GtRectLayout location,
	CGRect containerRect, 
	CGRect containeeRect,
	UIEdgeInsets padding);

NS_INLINE
CGRect GtRectLayoutRectInRectHorizontally(
	GtRectLayout location,
	CGRect containerRect, 
	CGRect containeeRect)
{
	return GtRectLayoutRectInRectHorizontallyWithPadding(location, containerRect, containeeRect, UIEdgeInsetsZero);
}
	
extern CGRect GtRectLayoutRectInRectVerticallyWithPadding(
	GtRectLayout location,
	CGRect containerRect, 
	CGRect containeeRect,
	UIEdgeInsets padding);

NS_INLINE 
CGRect GtRectLayoutRectInRectVertically(
	GtRectLayout location,
	CGRect containerRect, 
	CGRect containeeRect)
{
	return GtRectLayoutRectInRectVerticallyWithPadding(location, containerRect, containeeRect, UIEdgeInsetsZero);
}

NS_INLINE
CGRect GtRectLayoutRectInRect(
	GtRectLayout location,
	CGRect containerRect, 
	CGRect containeeRect)
{
	return GtRectLayoutRectInRectHorizontallyWithPadding(
		location,
		containerRect, 
		GtRectLayoutRectInRectVerticallyWithPadding(location, containerRect, containeeRect, UIEdgeInsetsZero),
		UIEdgeInsetsZero);
}

NS_INLINE
CGRect GtRectLayoutRectInRectWithPadding(
	GtRectLayout location,
	CGRect containerRect, 
	CGRect containeeRect,
	UIEdgeInsets padding)
{
	return GtRectLayoutRectInRectHorizontallyWithPadding(
		location,
		containerRect, 
		GtRectLayoutRectInRectVerticallyWithPadding(location, containerRect, containeeRect, padding),
		padding);
}

//NS_INLINE
//BOOL GtRectLayoutIsEmpty(GtRectLayout loc)
//{
//	  return loc.horizontal <= GtRectLayoutHorizontalNone && loc.vertical <= GtRectLayoutVerticalNone;
//}

