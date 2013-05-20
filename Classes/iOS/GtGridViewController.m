//
//  GtGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewController.h"
#import "UIScrollView+GtExtras.h"
#import "GtGridViewCellTouchHandler.h"
#import "GtCallback.h"
#import <objc/runtime.h>

#if DEBUG
#define TRACE 0
#endif

@implementation NSObject (GtGridViewObject)

- (BOOL) implementsGridViewObjectProtocol
{
    return  [self respondsToSelector:@selector(gridViewObjectID)] &&
            [self respondsToSelector:@selector(gridViewDisplayName)] &&
            [self respondsToSelector:@selector(createGridViewCell)] &&
            [self respondsToSelector:@selector(createGridViewSelectionHandler)] &&
            [self respondsToSelector:@selector(createGridViewTouchHandler)];
}

@end

@interface GtGridViewController ()
- (UIView*) gridViewSuperview; // self.scrollView is default
@end

@implementation UIView (GtGridViewCell)

static void * const kAssociatedObjectKey = (void*)&kAssociatedObjectKey;

- (GtGridViewCellController*) gridViewCellController
{
    return objc_getAssociatedObject(self, &kAssociatedObjectKey);
}

- (void) setGridViewCellController:(GtGridViewCellController*) cell
{
    objc_setAssociatedObject(self, &kAssociatedObjectKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didMoveToGridViewCellController];
}

- (void) didMoveToGridViewCellController
{
}

- (void) objectCacheWillCacheObject:(GtObjectCache*) cache
{
    self.hidden = YES;
    self.gridViewCellController = nil;
}

- (void) objectCacheWillUncacheObject:(GtObjectCache*) cache
{
    [self setNeedsDisplay];
}

- (void) objectCacheWillPurgeObject:(GtObjectCache*) cache
{
    [self removeFromSuperview];
}


@end

@implementation GtGridViewController

@synthesize dataProvider = m_dataProvider;
@synthesize objectCache = m_objectCache;
@synthesize viewLayout = m_viewLayout;
@synthesize cellCollection = m_cellCollection;
@synthesize visibleCellCollection = m_visibleCellCollection;
@dynamic actionContext;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        m_objectCache = [[GtObjectCache alloc] init];
        m_cellCollection = [[GtOrderedCollection alloc] init];

        m_visibleCellCollection = [[GtContiguousVisibleGridViewCellCollection alloc] init];
        m_visibleCellCollection.delegate = self;
    }
    
    return self;
}

- (UIView*) gridViewSuperview
{
    return self.scrollView;
}

- (void) dealloc
{
    GtRelease(m_visibleCellCollection);
    GtRelease(m_cellCollection);
    GtRelease(m_viewLayout);
    GtRelease(m_objectCache);
    GtRelease(m_dataProvider);
    GtRelease(m_scrollIndicatorView);
    GtSuperDealloc();
}

- (void) viewDidUnload
{
#if TRACE
    GtLog(@"%@ did unload", NSStringFromClass([self class])); 
#endif    

    [super viewDidUnload];
    
    GtReleaseWithNil(m_scrollIndicatorView);
}

- (void) createScrollIndicatorView
{
    m_scrollIndicatorView = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 12)];
    
    m_scrollIndicatorView.textColor = [UIColor whiteColor];
    m_scrollIndicatorView.shadowColor = [UIColor blackColor];
    m_scrollIndicatorView.backgroundColor = [UIColor clearColor];
    m_scrollIndicatorView.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    m_scrollIndicatorView.hidden = YES;
    m_scrollIndicatorView.textAlignment = UITextAlignmentRight;
    [self.view addSubview:m_scrollIndicatorView];
}

- (UIScrollView*) createScrollView
{
    GtTouchableScrollView* scrollView = [[GtTouchableScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizesSubviews = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    scrollView.touchableScrollViewDelegate  = self;
    scrollView.delaysContentTouches = NO;
    scrollView.minimumZoomScale = 0.5f;
    scrollView.maximumZoomScale = 2.5f;
    scrollView.multipleTouchEnabled = YES;
    
    return scrollView;
}

//- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//     CGRect newBounds = self.view.bounds;
//     CGRect oldBounds = newBounds;
//    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
//    {
//        newBounds.size.width = MAX(oldBounds.size.width, oldBounds.size.height);
//        newBounds.size.height = MIN(oldBounds.size.width, oldBounds.size.height);
//    }
//    else
//    {
//        newBounds.size.width = MIN(oldBounds.size.width, oldBounds.size.height);
//        newBounds.size.height = MAX(oldBounds.size.width, oldBounds.size.height);
//    }
//
//    [self reflowCellsInBounds:newBounds];
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self reflowCellsInBounds:self.view.bounds];
}

- (CGRect) visibleGridViewBounds 
{
    CGRect visibleRect;
	visibleRect.origin = self.scrollView.contentOffset;
	visibleRect.size = self.scrollView.bounds.size;
    visibleRect.origin.y += self.scrollView.contentInset.top;
//	visibleRect.origin.x += self.scrollView.contentInset.left;
//	visibleRect.size.height += (self.scrollView.contentInset.top + self.scrollView.contentInset.bottom);
//	visibleRect.size.width += (self.scrollView.contentInset.left + self.scrollView.contentInset.right);
    
#if TRACE
    GtLog(@"visible rect: %@", NSStringFromCGRect(visibleRect));
#endif
    
    return visibleRect;
}

- (void) removeAllCells
{
    [self unloadVisibleCells];   
    [self.cellCollection removeAllObjects];
    [self.visibleCellCollection removeAllCells];
}

- (void) unloadVisibleCells
{
    UIView* superview = self.gridViewSuperview;

    for(GtGridViewCellController* cell in self.visibleCellCollection)
    {
        if(cell.isCellLoaded)
        {
            [cell cellDidDisappearFromSuperview:superview viewController:self];
        }
    }
    
    [self.visibleCellCollection removeAllCells];
}

- (void) updateVisibleCells:(CGRect) visibleBounds
{
    UIView* superview = self.gridViewSuperview;
    
    for(GtGridViewCellController* cell in self.visibleCellCollection)
    {
        if(CGRectIntersectsRect(cell.frame, visibleBounds))
        {
            if(!cell.isCellLoaded)
            {
                [cell cellWillAppearInSuperview:superview viewController:self];
            }
        }
        else
        {
            if(cell.isCellLoaded)
            {
                [cell cellDidDisappearFromSuperview:superview viewController:self];
            }
        }    
    }
}

- (void) visibleGridViewCellCollectionVisibleCellsDidChange:(id<GtVisibleGridViewCellCollection>) collection
{
    [self visibleCellsChanged];
}

- (void) visibleGridViewCellCollection:(id<GtVisibleGridViewCellCollection>) collection updateCellVisiblityInBounds:(CGRect) bounds
{
    [self updateVisibleCells:bounds];
}

- (GtOrderedCollection*) visibleGridViewCellCollectionGetCellCollection:(id<GtVisibleGridViewCellCollection>) collection
{
    return self.cellCollection;
}

- (void) reflowCells
{
    [self reflowCellsInBounds:self.view.bounds];
}

- (void) reflowCellsInBounds:(CGRect) bounds
{
    GtAssertNotNil(self.viewLayout);
    GtAssertNotNil(self.visibleCellCollection);
    GtAssertNotNil(self.scrollView);

    self.scrollView.contentSize = [self.viewLayout layoutArrangeableViews:self.cellCollection.objectArray inBounds:bounds];
    
    [m_visibleCellCollection recalculateVisibleCellsInBounds:self.visibleGridViewBounds];
}

- (void) visibleCellsChanged
{
    GtVisibleCellRanges visible = m_visibleCellCollection.visibleRanges;

    GtAssert(visible.count == 1, @"expecting only one range");

    NSRange range = visible.ranges[0];

    if(m_scrollIndicatorView)
    {
        m_scrollIndicatorView.text = [NSString stringWithFormat:@"%d-%d of %d", range.location + 1, range.location + 1 + range.length, m_cellCollection.count];             
    }

    if(range.location + range.length >= m_cellCollection.count)
    {
        if(!m_gridViewControllerFlags.showingLastCell)
        {
            m_gridViewControllerFlags.showingLastCell = YES;
            [self lastCellIsVisible];
        }
    }
    else
    {
        m_gridViewControllerFlags.showingLastCell = NO;
    }
}

- (void) lastCellIsVisible
{
}

- (void) scrollToGalleryItem:(id) item    
                    animated:(BOOL) animated
{
    GtAssertNotNil(item);

    GtGridViewCellController* cell = [m_cellCollection objectForKey:[item gridViewObjectID]];
    if(cell)
    {
        [self.scrollView scrollRectToVisible:cell.frame animated:animated];
    }
}

- (void) updateScrollIndicatorViewPosition
{
    if(m_scrollIndicatorView)
    {
        CGRect r;
        r.origin = self.scrollView.contentOffset;
        r.size = self.scrollView.bounds.size;
        
        if(r.size.height > 0)
        {
            CGFloat mid = CGRectGetMidY(r);
            
            CGFloat percentage = mid / self.scrollView.contentSize.height;
            
            CGFloat proportionalMid = self.view.bounds.size.height * percentage;
            
            m_scrollIndicatorView.frame = CGRectMake(
                GtRectGetRight(self.view.bounds) - m_scrollIndicatorView.frame.size.width - 10, 
                proportionalMid - (m_scrollIndicatorView.frame.size.height / 2.0f), 
                m_scrollIndicatorView.frame.size.width, 
                m_scrollIndicatorView.frame.size.height);
        }
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(m_scrollIndicatorView)
    {
        m_scrollIndicatorView.hidden = YES;
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(m_scrollIndicatorView)
    {
        m_scrollIndicatorView.hidden = NO;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    GtLog(@"Zooming zoom scale: %f", scrollView.zoomScale);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self reflowCells];

    if(self.visibleCellCollection.count == 0)
    {   
        [self beginRefreshing:NO];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self unloadVisibleCells];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];

    [m_visibleCellCollection recalculateVisibleCellsInBounds:self.visibleGridViewBounds];
    
    [self updateScrollIndicatorViewPosition]; 
}

- (void) gridViewCellWasSelected:(GtGridViewCellController*) cell
{
}


- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* superview = self.scrollView;

    for(GtGridViewCellController* cell in m_visibleCellCollection)
    {
        if(cell.touchHandler)
        {
            [cell.touchHandler touchesBeganInGridViewCell:cell
                superview:superview
                touches:touches 
                withEvent:event ];
        }
        
    }
    
    return YES;
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* superview = self.scrollView;

    for(GtGridViewCellController* cell in m_visibleCellCollection)
    {
        if(cell.touchHandler)
        {
            [cell.touchHandler touchesMovedInGridViewCell:cell
                superview:superview
                touches:touches 
                withEvent:event];
        }

    }

    return YES;
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* superview = self.scrollView;

    for(GtGridViewCellController* cell in m_visibleCellCollection)
    {
        if(cell.touchHandler)
        {
            [cell.touchHandler touchesEndedInGridViewCell:cell
                superview:superview
                touches:touches 
                withEvent:event];
        }

    }
    return YES;
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* superview = self.scrollView;
 
    for(GtGridViewCellController* cell in m_visibleCellCollection)
    {
        if(cell.touchHandler)
        {   
            [cell.touchHandler touchesCancelledInGridViewCell:cell 
                superview:superview
                touches:touches 
                withEvent:event ];
        }

    }
    return YES;
}




@end

