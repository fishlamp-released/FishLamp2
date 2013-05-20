//
//	GtViewContentsDescriptor.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtRectLayout.h"

typedef enum { 
	GtViewContentItemInvalid						= 0,
	GtViewContentItemNone							= (1 << 1),
	GtViewContentItemStatusBar						= (1 << 2),
	GtViewContentItemToolbar						= (1 << 3),
	GtViewContentItemTabBar							= (1 << 4),
	GtViewContentItemNavigationBar					= (1 << 5),
	GtViewContentItemToolbarAndStatusBar			= GtViewContentItemToolbar + GtViewContentItemStatusBar,
	GtViewContentItemNavigationBarAndStatusBar		= GtViewContentItemNavigationBar + GtViewContentItemStatusBar
} GtViewContentItem;

#define GtViewContentsDescriptorPadding 1

typedef struct GtViewContentsDescriptor{
	GtViewContentItem top:8;
	GtViewContentItem bottom:8;
#if GtViewContentsDescriptorPadding
	UIEdgeInsets padding;
#endif
} GtViewContentsDescriptor;

extern
const GtViewContentsDescriptor GtViewContentsDescriptorInvalid;

extern
const struct GtViewContentsDescriptor GtViewContentsDescriptorNone;

NS_INLINE
BOOL GtViewContentsDescriptorEqualToViewContentsDescriptor(GtViewContentsDescriptor lhs, GtViewContentsDescriptor rhs)
{
	return lhs.top == rhs.top && lhs.bottom == rhs.bottom;
}

NS_INLINE
GtViewContentsDescriptor GtViewContentsDescriptorMake(	GtViewContentItem top, 
								GtViewContentItem bottom)
{
#if GtViewContentsDescriptorPadding
	 GtViewContentsDescriptor contents = { top, bottom, { 0, 0, 0, 0 } };
#else
	 GtViewContentsDescriptor contents = { top, bottom };
#endif
	return contents;
} 

#if GtViewContentsDescriptorPadding
NS_INLINE
GtViewContentsDescriptor GtViewContentsDescriptorMakeWithItemsAndPadding( GtViewContentItem top, 
											GtViewContentItem bottom,
											UIEdgeInsets padding)
{
	GtViewContentsDescriptor contents;
	contents.top = top;
	contents.bottom = bottom;
	contents.padding = padding;
	return contents;
} 
					   

NS_INLINE
GtViewContentsDescriptor GtViewContentsDescriptorMakeWithPadding( UIEdgeInsets padding)
{
	GtViewContentsDescriptor contents;
	contents.top = GtViewContentItemNone;
	contents.bottom = GtViewContentItemNone;
	contents.padding = padding;
	return contents;
}
#endif	
NS_INLINE
BOOL GtViewContentsDescriptorIsEmpty( GtViewContentsDescriptor contents)
{
#if GtViewContentsDescriptorPadding
	return	contents.top == GtViewContentItemNone && contents.padding.top == 0 && 
			contents.bottom == GtViewContentItemNone && contents.padding.bottom == 0;
#else
	return	contents.top == GtViewContentItemNone && 
			contents.bottom == GtViewContentItemNone;
#endif
}

//NS_INLINE
//BOOL GtViewContentsDescriptorTopIsValid(GtViewContentsDescriptor contents)
//{
//	  return contents.top != GtViewContentItemInvalid;
//}
//
//NS_INLINE
//BOOL GtViewContentsDescriptorBottomIsValid(GtViewContentsDescriptor contents)
//{
//	  return contents.bottom != GtViewContentItemInvalid;
//}

NS_INLINE
BOOL GtViewContentsDescriptorIsValid( GtViewContentsDescriptor contents)
{
	return !GtViewContentsDescriptorEqualToViewContentsDescriptor(contents, GtViewContentsDescriptorInvalid);
}

//NS_INLINE
//BOOL GtViewContentsDescriptorHasLayout( GtViewContentsDescriptor contents)
//{
//	  return GtViewContentsDescriptorIsEmpty(contents);
//}


#if GtViewContentsDescriptorPadding
NS_INLINE
CGFloat GtViewContentsDescriptorMinWidth(CGFloat width, GtViewContentsDescriptor contents)
{
	return width + contents.padding.left + contents.padding.right;
}

NS_INLINE
CGFloat GtViewContentsDescriptorMinHeight(CGFloat height, GtViewContentsDescriptor contents)
{
	return height + contents.padding.top + contents.padding.bottom;
}
#endif	

extern CGFloat GtViewContentsDescriptorCalculateTop( GtViewContentsDescriptor contents);
extern CGFloat GtViewContentsDescriptorCalculateBottom( GtViewContentsDescriptor contents);
extern CGRect GtViewContentsDescriptorCalculateContainerRect(CGRect bounds, GtViewContentsDescriptor contents);

#if GtViewContentsDescriptorPadding
extern UIEdgeInsets GtViewContentsDescriptorPaddingForRectLayout(GtViewContentsDescriptor contents);
#else
NS_INLINE
UIEdgeInsets GtViewContentsDescriptorPaddingForRectLayout(GtViewContentsDescriptor contents)
{
	return UIEdgeInsetsMake(GtViewContentsDescriptorCalculateTop(contents), 0, GtViewContentsDescriptorCalculateBottom(contents), 0);
}
#endif


NS_INLINE
CGRect GtViewContentsDescriptorCalculateRectVertically(CGRect containeeRect, 
	CGRect containerRect,	  
	GtViewContentsDescriptor contents,
	GtRectLayout rectLayout)
{
	return GtRectLayoutRectInRectVerticallyWithPadding(rectLayout, containerRect, containeeRect, GtViewContentsDescriptorPaddingForRectLayout(contents));
}

NS_INLINE
CGRect GtViewContentsDescriptorCalculateRectHorizonally(CGRect containeeRect, 
	CGRect containerRect,	  
	GtViewContentsDescriptor contents,
	GtRectLayout rectLayout)
{
	return GtRectLayoutRectInRectHorizontallyWithPadding(rectLayout, containerRect, containeeRect, GtViewContentsDescriptorPaddingForRectLayout(contents));
}
	
NS_INLINE
CGRect GtViewContentsDescriptorCalculateRect(
	CGRect containeeRect, 
	CGRect containerRect,	  
	GtViewContentsDescriptor contents,
	GtRectLayout rectLayout)
{
	return GtViewContentsDescriptorCalculateRectVertically(
		GtViewContentsDescriptorCalculateRectHorizonally(containeeRect, containerRect, contents, rectLayout), 
		containerRect, 
		contents, 
		rectLayout);
}

