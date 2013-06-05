//
//	UIScrollView+FLExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIScrollView+FLExtras.h"
#import "FLViewContentsDescriptor.h"

@implementation UIScrollView (FLExtras)

- (CGRect) visibleRect
{
	CGRect visibleRect;
	visibleRect.origin = self.contentOffset;
	visibleRect.size = self.bounds.size;
	visibleRect.origin.y += self.contentInset.top;
	visibleRect.origin.x += self.contentInset.left;
	visibleRect.size.height -= (self.contentInset.top + self.contentInset.bottom);
	visibleRect.size.width -= (self.contentInset.left + self.contentInset.right);
	return visibleRect;
} 

- (void) scrollToTop:(BOOL) animated
{
	[self setContentOffset:CGPointMake(0, -self.contentInset.top) animated: animated];
}

- (void) scrollToBottom:(BOOL) animated
{
	CGRect bounds = self.bounds;
	CGSize mySize = self.contentSize;
	if(mySize.height > bounds.size.height)
	{
		[self setContentOffset:CGPointMake(0, mySize.height-bounds.size.height+self.contentInset.bottom) animated: animated];
	}
}

//- (void) adjustInsets:(FLViewContentsDescriptor*) contents
//{
////	UIEdgeInsets insets = self.contentInset;
////	insets.top = FLViewContentsDescriptorCalculateTop(contents);
////	insets.bottom = FLViewContentsDescriptorCalculateBottom(contents);
//	self.contentInset = [self contentViewInsets];
//}
@end
