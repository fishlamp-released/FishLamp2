//
//  GtViewLayout.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewLayout.h"
#import <objc/runtime.h>

//@implementation GtArrangebleObject
//
//@synthesize frame = m_frame;
//@synthesize hidden = m_hidden;
//@synthesize viewLayoutMargins = m_layoutMargins;
//@synthesize viewLayoutBehavior = m_layoutBehavior;
//
//- (CGRect) calculateLayoutFrameInBounds:(CGRect) bounds
//{
//    return bounds;
//}
//
//- (BOOL) isHidden
//{
//    return NO;
//}
//
//- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint
//{
//    return hint.size;
//}
//
//- (NSString*) description
//{
//    return [NSString stringWithFormat:@"%@ %@", [super description], NSStringFromCGRect(m_frame)];
//}
//
//- (NSArray*) subviews
//{
//    return nil;
//}
//
//- (void) setBounds:(CGRect) bounds
//{
//    self.frame = bounds;
//}
//
//- (CGRect) bounds
//{
//    return self.bounds;
//}   
//
//@end

@implementation GtViewLayoutBehavior 

+ (GtViewLayoutBehavior*) viewLayoutBehavior
{
    return GtReturnAutoreleased([[GtViewLayoutBehavior alloc] init]);
}

@synthesize margins = m_margins;
@synthesize resizeMask = m_resizeMask;

@end

static void * const kViewLayoutKey = (void*)&kViewLayoutKey;
static void * const kViewLayoutBehaviorKey = (void*)&kViewLayoutBehaviorKey;

@implementation NSObject (GtViewLayout)

- (GtViewLayout*) viewLayout
{
    return objc_getAssociatedObject(self, &kViewLayoutKey);
}

- (void) setViewLayout:(GtViewLayout*) viewLayout
{
    objc_setAssociatedObject(self, &kViewLayoutKey, viewLayout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GtViewLayoutBehavior*) viewLayoutBehavior
{
    return objc_getAssociatedObject(self, &kViewLayoutBehaviorKey);
}

- (void) setViewLayoutBehavior:(GtViewLayoutBehavior*) viewLayoutBehavior
{
    objc_setAssociatedObject(self, &kViewLayoutBehaviorKey, viewLayoutBehavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint
{
    return hint.size;
}

- (void) layoutSubviewsWithViewLayout
{
    id SELF = self;
    GtAssert([SELF respondsToSelector:@selector(subviews)], @"object doesn't respond to self.subviews");

    GtViewLayout* layout = self.viewLayout;
    if(layout)
    {
        GtAssert([SELF respondsToSelector:@selector(bounds)], @"object doesn't respond to self.bounds");
        GtAssert([SELF respondsToSelector:@selector(setBounds:)], @"object doesn't respond to self setBounds:");
    
        CGRect bounds = [SELF bounds];
        bounds.size = [layout layoutArrangeableViews:[SELF subviews] inBounds:bounds];
        [SELF setBounds:bounds];
    }

    for(id subview in [SELF subviews])
    {
        [subview layoutSubviewsWithViewLayout];
    }
}

@end


@implementation GtViewLayout

@synthesize padding = m_padding;
@synthesize viewMargins = m_viewMargins;

+ (id) viewLayout
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

#if DEBUG
- (void) dealloc
{
    GtSuperDealloc();
}
#endif

- (CGSize) layoutArrangeableViews:(NSArray*) views 
                         inBounds:(CGRect) bounds
{
    return bounds.size;
}

- (UIEdgeInsets) adjustedMarginsForView:(id) view
{
	UIEdgeInsets adjustedMargins = self.viewMargins;

    GtViewLayoutBehavior* behavior = self.viewLayoutBehavior;
    if(behavior)
    {
        UIEdgeInsets viewMargins = behavior.margins;
        adjustedMargins.top += viewMargins.top;
        adjustedMargins.bottom += viewMargins.bottom;
        adjustedMargins.left += viewMargins.left;
        adjustedMargins.right += viewMargins.right;
    }
    
	return adjustedMargins;
}

//- (void) layoutSubviewsInView:(id) view
//{
//    CGRect bounds = [view bounds];
//    bounds.size = [self layoutArrangeableViews:[view subviews] inBounds:bounds];
//    [view setBounds:bounds];
//        
//    for(GtViewLayout* layout in m_layouts)
//    {
//        [layout layoutViews];
//    }
//    
//    
//    
////    if(GtBitMaskTest(self.arrangeableObject.viewLayoutBehavior, GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout))
////    {
////        [self.viewLayout setViewSize:self];
////    }
//}



@end

@implementation GtRowViewLayout

+ (GtRowViewLayout*) rowViewLayout
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (CGSize) layoutArrangeableViews:(NSArray*) views 
                         inBounds:(CGRect) bounds
{
	CGFloat top = bounds.origin.y + self.padding.top;
	
	id lastView = nil;
	for(id view in views)
	{	
		if([view isHidden]) 
		{
			continue;
		}
        
		UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
		top += adjustedMargins.top;
	
        CGFloat left = bounds.origin.x + adjustedMargins.right + self.padding.left;

        CGFloat width = bounds.size.width - adjustedMargins.left - adjustedMargins.right - self.padding.left - self.padding.right;
        
        GtViewLayoutBehavior* behavior = [view viewLayoutBehavior];
        
        GtArrangeableViewHint hint;
        if(behavior)
        {
            hint.flexibleWidth =    GtBitMaskTest(behavior.resizeMask, GtViewLayoutResizeMaskFlexibleWidth);
            hint.flexibleHeight =   GtBitMaskTest(behavior.resizeMask, GtViewLayoutResizeMaskFlexibleHeight); 
        }
        hint.size.width = width;
        hint.size.height = [view frame].size.height;
        
        CGSize size = [view calculateSizeForLayout:hint];
        
		[view setFrame:CGRectMake(left, top, size.width, size.height)];
					
		top = GtRectGetBottom([view frame]) + adjustedMargins.bottom;
        lastView = view;
	}
    
    if(lastView)
	{
        GtViewLayoutBehavior* behavior = [lastView viewLayoutBehavior];
        
		CGFloat height = GtRectGetBottom([lastView frame]) + self.padding.bottom + (self.viewMargins.bottom + [behavior margins].bottom);
	
        bounds = GtRectSetHeight(bounds, height);
	}
    
    return bounds.size;
}

//- (void) setViewSize:(id) parentView
//{
//	id lastView = nil;
//	NSArray* subviews = [parentView subviews];
//	for(id view in subviews)
//	{
//		if([view isHidden]) 
//		{
//			continue;
//		}
//		lastView = view;
//	}
//	
//	if(lastView)
//	{
//		CGFloat height = GtRectGetBottom([lastView frame]) + self.padding.bottom + (self.viewMargins.bottom + [lastView viewLayoutMargins].bottom);
//	
//		[parentView setFrame: GtRectSetHeight([parentView frame], height)];
//	}
//}


@end

@implementation GtFillInSuperviewViewLayout

- (CGSize) layoutArrangeableViews:(NSArray*) views 
                       inBounds:(CGRect) bounds
{
	for(id view in views)
	{	
		if([view isHidden]) 
		{
			continue;
		}
		
		CGRect frame = GtRectInsetWithEdgeInsets(bounds, [self adjustedMarginsForView:view]);
		
		[view setFrame:frame];
	}
    
    return bounds.size;
}

@end

@implementation GtColumnViewLayout

+ (GtColumnViewLayout*) columnViewLayout
{
    return GtReturnAutoreleased([[GtColumnViewLayout alloc] init]);
}

- (CGSize) layoutArrangeableViews:(NSArray*) views 
                         inBounds:(CGRect) bounds
{
	CGFloat colWidth = bounds.size.width - self.padding.left - self.padding.right;

	id adjustableView = nil;
	for(id view in views)
	{
		if([view isHidden]) 
		{
			continue;
		}
		
		UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
		colWidth -= (adjustedMargins.left + adjustedMargins.right);
		
        GtViewLayoutBehavior* behavior = [view viewLayoutBehavior];
        
		if(behavior && GtBitMaskTest(behavior.resizeMask, GtViewLayoutResizeMaskFlexibleWidth))
		{
			GtAssert(adjustableView == nil, @"only one flexible view supported");
		
			adjustableView = view;
			continue;
		}
	
		colWidth -= [view frame].size.width; 
	}
		
	if(adjustableView)
	{
		[adjustableView setFrame:GtRectSetWidth([adjustableView frame], colWidth)];
	}

	CGPoint origin = bounds.origin;
    origin.x += self.padding.left;
    origin.y += self.padding.top;
    
	CGFloat bottom = origin.y + self.padding.bottom;

	for(id view in views)
	{
		if([view isHidden]) 
		{
			continue;
		}
		
		UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:view];
		bottom = MAX(bottom, GtRectGetBottom([view frame]) + adjustedMargins.bottom);
	
		origin.x += adjustedMargins.left;
	
		CGRect frame = GtRectSetOrigin([view frame], origin.x, origin.y + adjustedMargins.top);
	
		[view setFrame:frame];

		origin.x += ([view frame].size.width + adjustedMargins.right);
	}
    
    CGFloat height = bottom - bounds.origin.y + self.padding.bottom;
        
    if(height)
    {
        bounds.size.height = height;
    }
    
    bounds.size.width = origin.x + self.padding.right;
    
    return bounds.size;
}

//- (void) setViewSize:(id) view
//{
//	NSArray* subviews = [view subviews];
//	if(subviews.count)
//	{
//	//	id lastView = nil;
//		CGFloat bottom = 0;
//		for(id subview in subviews)
//		{
//			if([subview isHidden]) 
//			{
//				continue;
//			}
//			
//	//		lastView = subview;
//			
//			UIEdgeInsets adjustedMargins = [self adjustedMarginsForView:subview];
//			bottom = MAX(bottom, GtRectGetBottom([subview frame]) + adjustedMargins.bottom);
//		}
//		
//		CGRect frame = [view frame];
//		CGFloat height = bottom - frame.origin.y + self.padding.bottom;
//			
//		if(height)
//		{
//		//	CGFloat width = GtRectGetRight([lastView frame]) + self.padding.right + [self adjustedMarginsForView:lastView].right;
//			
//			frame.size.height = height;
//			[view setFrame:frame];
//		}
//	}
//}

@end




