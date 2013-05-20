//
//	GtViewContentsDescriptor.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewContentsDescriptor.h"

#if GtViewContentsDescriptorPadding
const struct GtViewContentsDescriptor GtViewContentsDescriptorInvalid = { GtViewContentItemInvalid, GtViewContentItemInvalid, {0, 0, 0, 0}};
const struct GtViewContentsDescriptor GtViewContentsDescriptorNone = { GtViewContentItemNone, GtViewContentItemNone, {0, 0, 0, 0}};
#else
const struct GtViewContentsDescriptor GtViewContentsDescriptorInvalid = { GtViewContentItemInvalid, GtViewContentItemInvalid};
const struct GtViewContentsDescriptor GtViewContentsDescriptorNone = { GtViewContentItemNone, GtViewContentItemNone};
#endif
 
CGFloat GtViewContentsDescriptorCalculateTop( GtViewContentsDescriptor contents)
{
#if GtViewContentsDescriptorPadding
	CGFloat top = contents.padding.top;
#else
	CGFloat top = 0;
#endif	  
	switch(contents.top)
	{
		case GtViewContentItemNavigationBarAndStatusBar:
			top += [UIDevice currentDevice].navigationBarHeight + [UIDevice currentDevice].statusBarHeight;
			break;
			
		case GtViewContentItemToolbarAndStatusBar:
			top += [UIDevice currentDevice].toolbarHeight + [UIDevice currentDevice].statusBarHeight;
			break;
	
		case GtViewContentItemToolbar:
			top += [UIDevice currentDevice].toolbarHeight;
			break;
			
		case GtViewContentItemNavigationBar:
			top += [UIDevice currentDevice].navigationBarHeight;
			break;
			
		case GtViewContentItemStatusBar:
			top += [UIDevice currentDevice].statusBarHeight;
			break;
			
		default:
			break;
	}
	
	return top;
}

CGFloat GtViewContentsDescriptorCalculateBottom( GtViewContentsDescriptor contents)
{
#if GtViewContentsDescriptorPadding
   CGFloat bottom = contents.padding.bottom;
#else
   CGFloat bottom = 0;
#endif
						
   switch(contents.bottom)
	{
		case GtViewContentItemNavigationBarAndStatusBar:
		case GtViewContentItemToolbarAndStatusBar:
			GtAssertFailed(@"can't have status bar on bottom");
			break;
		
		case GtViewContentItemToolbar:
			bottom += [UIDevice currentDevice].toolbarHeight;
			break;
			
		case GtViewContentItemTabBar:
			bottom += [UIDevice currentDevice].tabBarHeight;
			break;
			
		default:
		break;
		
	}
	
	return bottom;
}

CGRect GtViewContentsDescriptorCalculateContainerRect(CGRect bounds, GtViewContentsDescriptor contents)
{
	CGFloat top = GtViewContentsDescriptorCalculateTop(contents);
	bounds.origin.y = top;
	bounds.size.height -= (top + GtViewContentsDescriptorCalculateBottom(contents));
	return bounds;
} 

#if GtViewContentsDescriptorPadding
UIEdgeInsets GtViewContentsDescriptorPaddingForRectLayout(GtViewContentsDescriptor contents)
{
	UIEdgeInsets padding = contents.padding;
	padding.top += GtViewContentsDescriptorCalculateTop(contents);
	padding.bottom += GtViewContentsDescriptorCalculateBottom(contents);
	return padding;
	return UIEdgeInsetsMake(GtViewContentsDescriptorCalculateTop(contents), 0, GtViewContentsDescriptorCalculateBottom(contents), 0);
}
#endif	  

