//
//	GtWidgetView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWidgetView.h"


@implementation UIView (GtWidgetView)

#if VIEW_AUTOLAYOUT
- (void) clearViewDelegate
{

}
#endif

- (void) themeDidChange
{
	if(self.themeAction)
	{
		[GtThemeManager applyThemeToObject:self themeAction:self.themeAction];
	}
	
	for(UIView* subview in self.subviews)
	{
		[subview themeDidChange];
	}
	
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

@end

@implementation UIView (GtArrangableView)

-(void) visitSubviews:(GtViewVisitor) visitor
{
	for(UIView* view in self.subviews)
	{
		if(!view.isHidden)
		{
			[view visitSubviews:visitor];
			visitor(view);
		}
	}
}

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint
{
    return hint.size;
}

@end


@implementation GtWidgetView

GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);

@synthesize widget = _widget;


//#if VIEW_AUTOLAYOUT

#if 0
@synthesize superviewContentsDescriptor = m_superviewContentsDescriptor;
@synthesize autoLayoutMode = m_autoLayoutMode;
@synthesize viewDelegate = m_viewDelegate;
@synthesize lastSuperviewSize = m_lastSuperviewSize;

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_superviewContentsDescriptor = GtViewContentsDescriptorInvalid;
		m_autoLayoutMode = GtRectLayoutNone; 
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		m_superviewContentsDescriptor = GtViewContentsDescriptorInvalid;
		m_autoLayoutMode = GtRectLayoutNone; 
	}
	return self;
}
- (void) clearViewDelegate
{
	m_viewDelegate = nil;
	for(UIView* view in self.subviews)
	{
		[self clearViewDelegate];
	}
}
- (void) setPositionInSuperview
{
	GtViewSetPositionInSuperview(self);
}
#endif

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyTheme];
#if VIEW_AUTOLAYOUT
		GtViewDidMoveToSuperview(self);
#endif        
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(self.superview)
	{
#if VIEW_AUTOLAYOUT
		GtViewDidLayoutSubviews(self);
#endif

// TODO: not sure if this should be here.
//		if(m_subviewLayout)
//		{
//			GtLogAssert(self.autoresizesSubviews, @"warning autoresize subviews in on and you have an arranger");
//		
//			[m_subviewLayout layoutView:self];
//		}

        for(GtWidget* widget in self.widgets)
        {
            [widget setNeedsLayout];
        }
    }
}

- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	
    for(GtWidget* widget in self.widgets)
    {
        if(CGRectIntersectsRect(rect, widget.frame))
        {
            [widget drawInRect:rect];
        }
    }
}


#if GT_CHECK_RECT_SANITY

- (CGRect) bounds
{
	GtAssertIsSaneRect([super bounds]);
	return [super bounds];
}

- (CGRect) frame
{
	GtAssertIsSaneRect([super frame]);
	return [super frame];
}

- (void) setBounds:(CGRect) rect
{
	GtAssertIsSaneRect(rect);
	[super setBounds:rect];
	
	GtAssertIsSaneRect([super bounds]);
	GtAssertIsSaneRect([super frame]);
	
}

- (void) setFrame:(CGRect) rect
{
	GtAssertIsSaneRect(rect);
	[super setFrame:rect];
	
	GtAssertIsSaneRect([super bounds]);
	GtAssertIsSaneRect([super frame]);
	
}
#endif

#if FL_MRC
- (void) dealloc {
	[_widget release];
	[super dealloc];
}
#endif
@end

//@implementation UIView (GtViewLayout)
//
//- (BOOL) containsSubviewRecursive:(UIView*) view
//{
//	for(UIView* subview in self.subviews)
//	{
//		if(subview == view || [subview containsSubviewRecursive:view])
//		{
//			return YES;
//		}
//	}
//	
//	return NO;
//}
//
////- (CGSize) layoutSubviewsWithViewLayout
////{
////    [self setNeedsLayout];
////    [self layoutIfNeeded];
////
////    NSArray* subviews = self.subviews;
////
////    CGSize size = self.bounds.size;
////
////    if(self.viewLayout)
////    {
////        size = [self.viewLayout layoutArrangeableViews:subviews inBounds:self.bounds];
////    }
////
////    for(UIView* view in subviews)
////    {
////        [view layoutSubviewsWithViewLayout];
////    }
////    
////    return size;
////}
//
//@end


