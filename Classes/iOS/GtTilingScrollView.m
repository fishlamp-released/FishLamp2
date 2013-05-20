//
//	GtTilingScrollView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTilingScrollView.h"
#
#import "GtLowMemoryHandler.h"
#import "GtTouch.h"

@interface GtScrollSnapshot : NSObject {
@private
	GtTouch* m_firstTouch;
	GtTouch* m_lastTouch;
	CGFloat m_scrollAmount;
}

@property (readwrite, retain, nonatomic) GtTouch* firstTouch;
@property (readwrite, retain, nonatomic) GtTouch* lastTouch;
@property (readwrite, assign, nonatomic) CGFloat scrollAmount;

- (id) initWithFirstTouch:(GtTouch*) touch;

@end

@implementation GtScrollSnapshot

@synthesize firstTouch = m_firstTouch;
@synthesize lastTouch = m_lastTouch;
@synthesize scrollAmount = m_scrollAmount;

- (id) initWithFirstTouch:(GtTouch*) touch
{
	if((self = [super init]))
	{
		self.firstTouch = touch;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_firstTouch);
	GtRelease(m_lastTouch);
	GtSuperDealloc();
}

@end

@implementation GtTilingScrollView

@synthesize tilingScrollViewDelegate = m_tilingScrollViewDelegate;

GtSynthesizeStructProperty(autoRotate, setAutoRotate, BOOL, m_tilingScrollViewFlags);
GtSynthesizeStructProperty(lastScrollDirection, setLastScrollDirection, GtTilingScrollViewSlideDirection, m_tilingScrollViewFlags);
GtSynthesizeStructProperty(canScrollTiles, setCanScrollTiles, BOOL, m_tilingScrollViewFlags);

@synthesize tiledViewCount = m_tileCount;
@synthesize centerViewIndex = m_centerViewIndex;


- (void) handleLowMemory:(id) notification
{
	for(NSUInteger i = 0; i < m_tileCount; i++)
	{
		if(i != self.centerViewIndex)
		{
			[m_tilingScrollViewDelegate tilingScrollView:self releaseMemoryForView:[m_tiledViews objectAtIndex:i] atIndex:i];
		}
	}
}

- (void) initScrollView
{
	GtAssert(self != nil, @"scroll view is nil");
	
	self.pagingEnabled = NO;
	self.directionalLockEnabled = YES;
	self.multipleTouchEnabled = NO;
	self.userInteractionEnabled = YES;
	self.delaysContentTouches = NO;
	self.canCancelContentTouches = NO;
//	  self.scrollEnabled = YES;
	
	self.decelerationRate = UIScrollViewDecelerationRateNormal;
	
	self.bounces = NO;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	
	
	self.autoresizesSubviews = NO;
	
	self.delegate = self;
	
	m_tileCount = 0;
	
	[[GtLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemory:)];
	
	m_scrollQueue = [[NSMutableArray alloc] init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) 
	{
		[self initScrollView];
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)frame 
{
	if ((self = [super initWithFrame:frame])) 
	{
		[self initScrollView];
	}
	
	return self;
}

- (void) createTiledView:(UIView**) outView
{
	UIView* view = nil;
	[m_tilingScrollViewDelegate tilingScrollView:self createTiledView:&view];
	view.frame = GtRectSetOrigin(self.frame, 0,0);
	[self addSubview:view];
	if(outView)
	{
		*outView = GtRetain(view);
	}
	GtRelease(view);
}

- (void) _removeTiledViewAtIndex:(NSUInteger) which
{
	GtAssert(which >= 0 && which < m_tiledViews.count, @"bad idx");
	GtAssertNotNil(m_tilingScrollViewDelegate);
	
	UIView* view = [m_tiledViews objectAtIndex:which];
	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willRemoveView:)])
	{
		[m_tilingScrollViewDelegate tilingScrollView:self willRemoveView:view];
	}
	
	[view removeFromSuperview];
	[m_tiledViews removeObjectAtIndex:which];
}

- (void) removeTiledViewAtIndex:(NSUInteger) which
{
	[self _removeTiledViewAtIndex:which];
	UIView* newView = nil;
	[self createTiledView:&newView];
	[m_tiledViews addObject:newView];
	GtRelease(newView);
	[self updateTiledViewLayout];
}

- (void) removeAllTiledViews
{
	for(NSUInteger i = 0; i < m_tiledViews.count; i++)
	{	
		[self _removeTiledViewAtIndex:i];
	}
}

- (void) tearDown
{
	//int i = 0;
	for(UIView* view in m_tiledViews)
	{
		if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willRemoveView:)])
		{
			[m_tilingScrollViewDelegate tilingScrollView:self willRemoveView:view];
		}
		[view removeFromSuperview];
	}
	
	GtReleaseWithNil(m_tiledViews);
}

- (void) dealloc
{	
	m_tilingScrollViewDelegate = nil;
	
	[[GtLowMemoryHandler defaultHandler] removeObserver:self];
	[self tearDown];
	GtRelease(m_scrollQueue);
	GtRelease(m_currentScroll);
	GtSuperDealloc();
}

- (NSUInteger) firstNextViewIndex
{
	return m_centerViewIndex + 1;
}

- (NSUInteger) lastNextViewIndex
{
	return m_tileCount - 1;
}

- (NSUInteger) nextTiledViewCount
{
	return m_tileCount - m_centerViewIndex - 1;
}

- (NSUInteger) firstPreviousViewIndex
{
	return 0;
}

- (NSUInteger) lastPreviousViewIndex
{
	return m_centerViewIndex - 1;
}

- (NSUInteger) previousTiledViewCount
{
	return m_centerViewIndex;
}

- (UIView*) centerView
{
	return [self tiledViewAtIndex:self.centerViewIndex];
}

- (NSUInteger) tiledViewCount
{
	return m_tileCount;
}

- (void) setCenterView:(UIView*) view
{
	[self setTiledView:view atIndex:self.centerViewIndex];
}

- (void) updateTiledViewLayout
{
	if(!m_tilingScrollViewFlags.isAutoRotating)
	{
		CGRect pageFrame = GtRectSetOrigin(self.frame, 0,0); 
		
		for(NSUInteger i = 0; i < self.tiledViewCount; i++)
		{
			UIView* view = [m_tiledViews objectAtIndex:i];
			pageFrame.origin.x += GtTilingScrollViewPageMargin;
			view.newFrame = pageFrame;
			
			pageFrame.origin.x += ((pageFrame.size.width) + GtTilingScrollViewPageMargin);
		}
	   
		CGSize size = CGSizeMake(	pageFrame.origin.x, 
									pageFrame.size.height);
		
		if(!CGSizeEqualToSize(size, self.contentSize))
		{
			[self setContentSize:size];
		}
		
		CGRect visibleRect = [self scrollViewPageRectForViewAtIndex:self.centerViewIndex];
		
		[self scrollRectToVisible:visibleRect animated:NO];
	}
}


#define BACK_THRESHOLD 40.0
- (void) noOp
{
}

- (void) _handleScroll:(GtScrollSnapshot*) scrollSnapshot
{
	CGFloat delta = scrollSnapshot.scrollAmount;
	if(delta && self.canScrollTiles)
	{
		CGRect newBounds = CGRectZero;
		if(fabsf(delta) < BACK_THRESHOLD && ((scrollSnapshot.lastTouch.timestamp - scrollSnapshot.firstTouch.timestamp) >= 0.3f))
		{
			newBounds = [self scrollViewPageRectForViewAtIndex:self.centerViewIndex];
			m_animationDoneSelector = @selector(noOp);
		}
		else 
		if(delta < 0)
		{
			newBounds = [self scrollViewPageRectForViewAtIndex:self.firstNextViewIndex];
			m_animationDoneSelector = @selector(shiftArrangementToLeft);
		}
		else
		{
			newBounds = [self scrollViewPageRectForViewAtIndex:self.lastPreviousViewIndex];
			m_animationDoneSelector = @selector(shiftArrangementToRight);
		}

		CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
		animation.delegate = self;
		animation.duration = 0.3;
		animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
		animation.fromValue = [NSValue valueWithCGRect:self.layer.bounds];
		animation.toValue = [NSValue valueWithCGRect:newBounds];
		[self.layer addAnimation:animation forKey:@"bounds"];
		self.layer.bounds = newBounds;
	}
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	if(m_animationDoneSelector)
	{
		[self performSelector:m_animationDoneSelector];
		m_animationDoneSelector = nil;
	}

	if(m_scrollQueue.count)
	{
		[self _handleScroll:[m_scrollQueue popFirstObject]];
	}
	else
	{
		m_tilingScrollViewFlags.scrollInProgress = NO;
		
		if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollViewDidFinishDragAnimation:)])
		{
			[m_tilingScrollViewDelegate tilingScrollViewDidFinishDragAnimation:self];
		}
	}
}

- (void) updateScroll:(GtScrollSnapshot*) scrollSnapshot
{
	if(m_tilingScrollViewFlags.scrollInProgress)
	{
		if(m_animationDoneSelector)
		{
			[m_scrollQueue addObject:scrollSnapshot];
		}
		else
		{
			[self _handleScroll:scrollSnapshot];
		}
	}
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(m_touchCount <= 0)
	{
		m_touchCount = 0;
		GtRelease(m_currentScroll);
		m_currentScroll = [[GtScrollSnapshot alloc] initWithFirstTouch:[GtTouch touchWithUITouch:[touches anyObject]]];
		m_tilingScrollViewFlags.scrollInProgress = NO;
		m_tilingScrollViewFlags.disableScroll = NO;
	}
	m_touchCount += [touches count];
	if(m_touchCount > 1)
	{
		m_tilingScrollViewFlags.disableScroll = YES;
	}
	return YES;
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([touches count] == 1 && !m_tilingScrollViewFlags.disableScroll)
	{
		UITouch* touch = [touches anyObject];
		if(touch.phase == UITouchPhaseMoved)
		{
			m_tilingScrollViewFlags.scrollInProgress = YES;
			CGFloat delta = [touch locationInView:self].x - [touch previousLocationInView:self].x; 
			m_currentScroll.scrollAmount += delta;
			if(self.canScrollTiles)
			{
				CGPoint newOffset = CGPointMake(self.contentOffset.x - delta, self.contentOffset.y);
				[self setContentOffset:newOffset animated:NO];
			}
			
//			  GtLog(@"scrolling: %f newContent offset: %@", delta, NSStringFromCGPoint(m_parentScrollView.contentOffset));
		}
	}
	return YES;
}

- (void) _touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	m_touchCount -= [touches count];
	if(m_touchCount <= 0)
	{
		m_currentScroll.lastTouch = [GtTouch touchWithUITouch:[touches anyObject]];
		[self updateScroll:m_currentScroll];
		GtReleaseWithNil(m_currentScroll);
	}
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self _touchesEnded:touches withEvent:event];
	return YES;
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self _touchesEnded:touches withEvent:event];
	return YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	[super touchesMoved:touches withEvent:event];
	[self touchableScrollView:self touchesMoved:touches withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	[self touchableScrollView:self touchesBegan:touches withEvent:event];
}

-(void) touchesCancelled: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[super touchesCancelled:touches withEvent:event];
	[self touchableScrollView:self touchesCancelled:touches withEvent:event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[super touchesEnded:touches withEvent:event];
	[self touchableScrollView:self touchesEnded:touches withEvent:event];
}

- (CGRect) scrollViewPageRectForViewAtIndex:(NSInteger) idx
{
	GtAssert(idx >= 0, @"view not found in arrangement");
	
	CGRect bounds = GtRectSetOrigin(self.frame, 0, 0);
	if(idx > 0)
	{
		bounds.origin.x = (bounds.size.width * idx) + (idx * (GtTilingScrollViewPageMargin*2));
	}
	
	bounds.origin.x += GtTilingScrollViewPageMargin;
	
	return bounds;
}

- (void) resetAllViews
{
	for(NSUInteger i = 0; i < self.tiledViewCount; i++)
	{
		[self _removeTiledViewAtIndex:i];
	
		UIView* newView = nil;
		[self createTiledView:&newView];
		[m_tiledViews addObject:newView];
		GtRelease(newView);
	}
	
	[self updateTiledViewLayout];
}


- (void) createTiles:(NSUInteger) tileCount
{
	GtAssert(tileCount >= 3, @"expecting at least 3 tiles");
	GtAssert(tileCount % 2 == 1, @"expecting odd number of tiles");
	GtAssertNotNil(m_tilingScrollViewDelegate);
		
	[self tearDown];

	m_tileCount = tileCount;
	m_centerViewIndex = (m_tileCount / 2);
	m_tiledViews = [[NSMutableArray alloc] initWithCapacity:self.tiledViewCount];
	for(NSUInteger i = 0; i < self.tiledViewCount; i++)
	{
		UIView* view = nil;
		[self createTiledView:&view];
		[m_tiledViews addObject:view];
		GtRelease(view);
	}
	
	[self updateTiledViewLayout];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if( !m_tilingScrollViewFlags.scrollInProgress && 
		m_touchCount <= 0 && 
		!m_tilingScrollViewFlags.isAutoRotating)
	{
//		  GtLog(@"Updated layout in tilingView layoutSubviews");
		
		[self updateTiledViewLayout];
	}
}

- (void) setTiledView:(UIView*) view atIndex:(NSUInteger) which 
{
	GtAssert(which >= 0 && which < m_tiledViews.count, @"bad idx");
	GtAssertNotNil(view);
	
	if([m_tiledViews objectAtIndex:which] != view)
	{
		if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willRemoveView:)])
		{
			[m_tilingScrollViewDelegate tilingScrollView:self willRemoveView:[m_tiledViews objectAtIndex:which]];
		}
		
		[m_tiledViews replaceObjectAtIndex:which withObject:view];
	}
}

- (UIView*) tiledViewAtIndex:(NSUInteger) which
{
	GtAssert(which >= 0 && which < m_tiledViews.count, @"bad idx");
	return [m_tiledViews objectAtIndex:which];
}

- (BOOL) removeTiledView:(id) view
{
	GtAssertNotNil(view);
	NSInteger idx = [self indexForTiledView:view];
	if(idx != NSNotFound)
	{
		[self removeTiledViewAtIndex:idx];
		return YES;
	}
	
	return NO;
}

- (NSInteger) indexForTiledView:(UIView*) viewToFind
{
	GtAssertNotNil(viewToFind);
	GtAssertNotNil(m_tilingScrollViewDelegate);

	NSInteger i = 0;
	for(UIView* view in m_tiledViews)
	{	
		if(view == viewToFind)
		{
			return i;
		}
	
		++i;
	}

	return NSNotFound;
}

//- (void) cancelLoadingForAllTiledViewsExceptViewAtIndex:(NSUInteger) idx
//{
//	  GtAssertNotNil(m_tilingScrollViewDelegate);
//
//	  for(NSUInteger i = 0; i < m_tileCount; i++)
//	  {
//		  if(i != idx)
//		  {
//			  [m_tilingScrollViewDelegate tilingScrollView:self cancelLoadingForView:[m_tiledViews objectAtIndex:i] atIndex:i];
//		  }
//	  }
//}

- (void) shiftArrangementToLeft
{
	self.lastScrollDirection = GtTilingScrollViewSlideDirectionLeft;
	
	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willTileViews:)])
	{
		[m_tilingScrollViewDelegate tilingScrollView:self willTileViews: GtTilingScrollViewSlideDirectionLeft];
	}

	[self _removeTiledViewAtIndex:0];
	
	UIView* newView = nil;
	[self createTiledView:&newView];
	[m_tiledViews addObject:newView];
	GtRelease(newView);
	
	[self updateTiledViewLayout];
	
	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:didTileViews:)])
	{
		[m_tilingScrollViewDelegate tilingScrollView:self didTileViews: GtTilingScrollViewSlideDirectionLeft];
	}
}

- (void) shiftArrangementToRight
{
	self.lastScrollDirection = GtTilingScrollViewSlideDirectionRight;

	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willTileViews:)])
	{
		[m_tilingScrollViewDelegate tilingScrollView:self willTileViews: GtTilingScrollViewSlideDirectionRight];
	}

	[self _removeTiledViewAtIndex:m_tiledViews.indexOfLastObject];

	UIView* newView = nil;
	[self createTiledView:&newView];
	[m_tiledViews insertObject:newView atIndex:0];
	GtRelease(newView);

	[self updateTiledViewLayout];

	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:didTileViews:)])
	{
		[m_tilingScrollViewDelegate tilingScrollView:self didTileViews: GtTilingScrollViewSlideDirectionRight];
	}
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollViewWillRotate:)])
	{
		[m_tilingScrollViewDelegate tilingScrollViewWillRotate:self];
	}
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self updateTiledViewLayout];

	if([m_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollViewDidRotate:)])
	{
		[m_tilingScrollViewDelegate tilingScrollViewDidRotate:self];
	}
}

@end


