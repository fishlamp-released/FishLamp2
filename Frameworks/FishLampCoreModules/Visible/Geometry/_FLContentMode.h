//
//  _FLContentMode.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

FL_SHIP_ONLY_INLINE
BOOL FLContentModesAreEqual(FLContentMode lhs, FLContentMode rhs)
{
	return  lhs.horizontal == rhs.horizontal && 
            lhs.vertical == rhs.vertical &&
            FLEdgeInsetsAreEqual(lhs.insets, rhs.insets);

}

FL_SHIP_ONLY_INLINE
FLContentMode FLContentModeMake(	FLContentModeHorizontal horizontalLayout, 
									FLContentModeVertical verticalLayout)
{
	FLContentMode loc;
	loc.horizontal = horizontalLayout;
	loc.vertical = verticalLayout;
	loc.insets = FLEdgeInsetsZero;
	return loc;
}

FL_SHIP_ONLY_INLINE
FLContentMode FLContentModeMakeWithInsets(	FLContentModeHorizontal horizontalLayout,
                                            FLContentModeVertical verticalLayout,
                                            FLEdgeInsets insets)
{
	FLContentMode loc;
	loc.horizontal = horizontalLayout;
	loc.vertical = verticalLayout;
	loc.insets = insets;
	return loc;
}

FL_SHIP_ONLY_INLINE
FLContentMode FLContentModeSetVertical(FLContentMode contentMode, FLContentModeVertical vertical)
{
	contentMode.vertical = vertical;
	return contentMode;
}

FL_SHIP_ONLY_INLINE
FLContentMode FLContentModeSetHorizontal(FLContentMode loc, FLContentModeHorizontal horizontal)
{
	loc.horizontal = horizontal;
	return loc;
}

FL_SHIP_ONLY_INLINE
BOOL FLContentModeIsValid(FLContentMode loc)
{
	return	loc.horizontal >= FLContentModeHorizontalNone && loc.vertical >= FLContentModeVerticalNone;
}

FL_SHIP_ONLY_INLINE
BOOL FLContentModeNotNone(FLContentMode loc)
{
	return	loc.horizontal > FLContentModeHorizontalNone || loc.vertical > FLContentModeVerticalNone;
}

//FL_SHIP_ONLY_INLINE
//FLRect FLRectPositionRectInRectHorizontallyWithContentMode(
//	FLRect containerRect,
//	FLRect containeeRect,
//    FLContentMode contentMode)
//{
//	return FLRectPositionRectInRectHorizontallyWithContentModeAndPadding(containerRect, containeeRect, contentMode, FLEdgeInsetsZero);
//}
//	
//FL_SHIP_ONLY_INLINE 
//FLRect FLRectPositionRectInRectVerticallyWithContentMode(
//	FLRect containerRect,
//	FLRect containeeRect,
//  	FLContentMode contentMode)
//{
//	return FLRectPositionRectInRectVerticallyWithContentModeAndPadding(containerRect, containeeRect, contentMode, FLEdgeInsetsZero);
//}

FL_SHIP_ONLY_INLINE
FLRect FLRectPositionRectInRectWithContentMode(
	FLRect containerRect,
	FLRect containeeRect,
    FLContentMode contentMode)
{
	return FLRectPositionRectInRectHorizontallyWithContentMode(
		containerRect,
		FLRectPositionRectInRectVerticallyWithContentMode(containerRect, containeeRect, contentMode),
		contentMode);
}


//FL_SHIP_ONLY_INLINE
//FLRect FLRectPositionRectInRectWithContentModeAndPadding(
//	FLRect containerRect,
//	FLRect containeeRect,
//	FLContentMode contentMode,
//	FLEdgeInsets padding)
//{
//	return FLRectPositionRectInRectHorizontallyWithContentModeAndPadding(
//		containerRect,
//		FLRectPositionRectInRectVerticallyWithContentModeAndPadding(containerRect, containeeRect, contentMode, padding),
//		contentMode,
//		padding);
//}
