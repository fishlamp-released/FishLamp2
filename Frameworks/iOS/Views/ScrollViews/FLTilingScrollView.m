//
//	FLTilingScrollView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTilingScrollView.h"
#
#import "FLLowMemoryHandler.h"
#import "FLTouch.h"

#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

@interface FLScrollSnapshot : NSObject {
@private
	FLTouch* _firstTouch;
	FLTouch* _lastTouch;
	CGFloat _scrollAmount;
}

@property (readwrite, retain, nonatomic) FLTouch* firstTouch;
@property (readwrite, retain, nonatomic) FLTouch* lastTouch;
@property (readwrite, assign, nonatomic) CGFloat scrollAmount;

- (id) initWithFirstTouch:(FLTouch*) touch;

@end

@implementation FLScrollSnapshot

@synthesize firstTouch = _firstTouch;
@synthesize lastTouch = _lastTouch;
@synthesize scrollAmount = _scrollAmount;

- (id) initWithFirstTouch:(FLTouch*) touch
{
	if((self = [super init]))
	{
		self.firstTouch = touch;
	}
	return self;
}

- (void) dealloc
{
	release_(_firstTouch);
	release_(_lastTouch);
	super_dealloc_();
}

@end

@implementation FLTilingScrollView

@synthesize tilingScrollViewDelegate = _tilingScrollViewDelegate;

FLSynthesizeStructProperty(autoRotate, setAutoRotate, BOOL, _tilingScrollViewFlags);
FLSynthesizeStructProperty(lastScrollDirection, setLastScrollDirection, FLTilingScrollViewSlideDirection, _tilingScrollViewFlags);
FLSynthesizeStructProperty(canScrollTiles, setCanScrollTiles, BOOL, _tilingScrollViewFlags);

@synthesize tiledViewCount = _tileCount;
@synthesize centerViewIndex = _centerViewIndex;


- (void) handleLowMemory:(id) notification
{
	for(NSUInteger i = 0; i < _tileCount; i++)
	{
		if(i != self.centerViewIndex)
		{
			[_tilingScrollViewDelegate tilingScrollView:self releaseMemoryForView:[_tiledViews objectAtIndex:i] atIndex:i];
		}
	}
}

- (void) initScrollView
{
	FLAssert_v(self != nil, @"scroll view is nil");
	
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
	
	_tileCount = 0;
	
	[[FLLowMemoryHandler defaultHandler] addObserver:self action:@selector(handleLowMemory:)];
	
	_scrollQueue = [[NSMutableArray alloc] init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) 
	{
		[self initScrollView];
	}
	
	return self;
}

- (id)initWithFrame:(FLRect)frame 
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
	[_tilingScrollViewDelegate tilingScrollView:self createTiledView:&view];
	view.frame = FLRectSetOrigin(self.frame, 0,0);
	[self addSubview:view];
	if(outView)
	{
		*outView = retain_(view);
	}
	release_(view);
}

- (void) _removeTiledViewAtIndex:(NSUInteger) which
{
	FLAssert_v(which >= 0 && which < _tiledViews.count, @"bad idx");
	FLAssertIsNotNil_(_tilingScrollViewDelegate);
	
	UIView* view = [_tiledViews objectAtIndex:which];
	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willRemoveView:)])
	{
		[_tilingScrollViewDelegate tilingScrollView:self willRemoveView:view];
	}
	
	[view removeFromSuperview];
	[_tiledViews removeObjectAtIndex:which];
}

- (void) removeTiledViewAtIndex:(NSUInteger) which
{
	[self _removeTiledViewAtIndex:which];
	UIView* newView = nil;
	[self createTiledView:&newView];
	[_tiledViews addObject:newView];
	release_(newView);
	[self updateTiledArrangement];
}

- (void) removeAllTiledViews
{
	for(NSUInteger i = 0; i < _tiledViews.count; i++)
	{	
		[self _removeTiledViewAtIndex:i];
	}
}

- (void) tearDown
{
	//int i = 0;
	for(UIView* view in _tiledViews)
	{
		if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willRemoveView:)])
		{
			[_tilingScrollViewDelegate tilingScrollView:self willRemoveView:view];
		}
		[view removeFromSuperview];
	}
	
	FLReleaseWithNil_(_tiledViews);
}

- (void) dealloc
{	
	_tilingScrollViewDelegate = nil;
	
	[[FLLowMemoryHandler defaultHandler] removeObserver:self];
	[self tearDown];
	release_(_scrollQueue);
	release_(_currentScroll);
	super_dealloc_();
}

- (NSUInteger) firstNextViewIndex
{
	return _centerViewIndex + 1;
}

- (NSUInteger) lastNextViewIndex
{
	return _tileCount - 1;
}

- (NSUInteger) nextTiledViewCount
{
	return _tileCount - _centerViewIndex - 1;
}

- (NSUInteger) firstPreviousViewIndex
{
	return 0;
}

- (NSUInteger) lastPreviousViewIndex
{
	return _centerViewIndex - 1;
}

- (NSUInteger) previousTiledViewCount
{
	return _centerViewIndex;
}

- (UIView*) centerView
{
	return [self tiledViewAtIndex:self.centerViewIndex];
}

- (NSUInteger) tiledViewCount
{
	return _tileCount;
}

- (void) setCenterView:(UIView*) view
{
	[self setTiledView:view atIndex:self.centerViewIndex];
}

- (void) updateTiledArrangement
{
	if(!_tilingScrollViewFlags.isAutoRotating)
	{
		FLRect pageFrame = FLRectSetOrigin(self.frame, 0,0); 
		
		for(NSUInteger i = 0; i < self.tiledViewCount; i++)
		{
			UIView* view = [_tiledViews objectAtIndex:i];
			pageFrame.origin.x += FLTilingScrollViewPageMargin;
			view.newFrame = pageFrame;
			
			pageFrame.origin.x += ((pageFrame.size.width) + FLTilingScrollViewPageMargin);
		}
	   
		FLSize size = FLSizeMake(	pageFrame.origin.x, 
									pageFrame.size.height);
		
		if(!CGSizeEqualToSize(size, self.contentSize))
		{
			[self setContentSize:size];
		}
		
		FLRect visibleRect = [self scrollViewPageRectForViewAtIndex:self.centerViewIndex];
		
		[self scrollRectToVisible:visibleRect animated:NO];
	}
}


#define BACK_THRESHOLD 40.0
- (void) noOp
{
}

- (void) _handleScroll:(FLScrollSnapshot*) scrollSnapshot
{
	CGFloat delta = scrollSnapshot.scrollAmount;
	if(delta && self.canScrollTiles)
	{
		FLRect newBounds = CGRectZero;
		if(fabsf(delta) < BACK_THRESHOLD && ((scrollSnapshot.lastTouch.timestamp - scrollSnapshot.firstTouch.timestamp) >= 0.3f))
		{
			newBounds = [self scrollViewPageRectForViewAtIndex:self.centerViewIndex];
			_animationDoneSelector = @selector(noOp);
		}
		else 
		if(delta < 0)
		{
			newBounds = [self scrollViewPageRectForViewAtIndex:self.firstNextViewIndex];
			_animationDoneSelector = @selector(shiftArrangementToLeft);
		}
		else
		{
			newBounds = [self scrollViewPageRectForViewAtIndex:self.lastPreviousViewIndex];
			_animationDoneSelector = @selector(shiftArrangementToRight);
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
	if(_animationDoneSelector)
	{
		[self performSelector:_animationDoneSelector];
		_animationDoneSelector = nil;
	}

	if(_scrollQueue.count)
	{
		[self _handleScroll:[_scrollQueue popFirstObject]];
	}
	else
	{
		_tilingScrollViewFlags.scrollInProgress = NO;
		
		if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollViewDidFinishDragAnimation:)])
		{
			[_tilingScrollViewDelegate tilingScrollViewDidFinishDragAnimation:self];
		}
	}
}

- (void) updateScroll:(FLScrollSnapshot*) scrollSnapshot
{
	if(_tilingScrollViewFlags.scrollInProgress)
	{
		if(_animationDoneSelector)
		{
			[_scrollQueue addObject:scrollSnapshot];
		}
		else
		{
			[self _handleScroll:scrollSnapshot];
		}
	}
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(_touchCount <= 0)
	{
		_touchCount = 0;
		release_(_currentScroll);
		_currentScroll = [[FLScrollSnapshot alloc] initWithFirstTouch:[FLTouch touchWithUITouch:[touches anyObject]]];
		_tilingScrollViewFlags.scrollInProgress = NO;
		_tilingScrollViewFlags.disableScroll = NO;
	}
	_touchCount += [touches count];
	if(_touchCount > 1)
	{
		_tilingScrollViewFlags.disableScroll = YES;
	}
	return YES;
}

- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([touches count] == 1 && !_tilingScrollViewFlags.disableScroll)
	{
		UITouch* touch = [touches anyObject];
		if(touch.phase == UITouchPhaseMoved)
		{
			_tilingScrollViewFlags.scrollInProgress = YES;
			CGFloat delta = [touch locationInView:self].x - [touch previousLocationInView:self].x; 
			_currentScroll.scrollAmount += delta;
			if(self.canScrollTiles)
			{
				FLPoint newOffset = CGPointMake(self.contentOffset.x - delta, self.contentOffset.y);
				[self setContentOffset:newOffset animated:NO];
			}
			
//			  FLLog(@"scrolling: %f newContent offset: %@", delta, NSStringFromCGPoint(_parentScrollView.contentOffset));
		}
	}
	return YES;
}

- (void) _touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	_touchCount -= [touches count];
	if(_touchCount <= 0)
	{
		_currentScroll.lastTouch = [FLTouch touchWithUITouch:[touches anyObject]];
		[self updateScroll:_currentScroll];
		FLReleaseWithNil_(_currentScroll);
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

- (FLRect) scrollViewPageRectForViewAtIndex:(NSInteger) idx
{
	FLAssert_v(idx >= 0, @"view not found in arrangement");
	
	FLRect bounds = FLRectSetOrigin(self.frame, 0, 0);
	if(idx > 0)
	{
		bounds.origin.x = (bounds.size.width * idx) + (idx * (FLTilingScrollViewPageMargin*2));
	}
	
	bounds.origin.x += FLTilingScrollViewPageMargin;
	
	return bounds;
}

- (void) resetAllViews
{
	for(NSUInteger i = 0; i < self.tiledViewCount; i++)
	{
		[self _removeTiledViewAtIndex:i];
	
		UIView* newView = nil;
		[self createTiledView:&newView];
		[_tiledViews addObject:newView];
		release_(newView);
	}
	
	[self updateTiledArrangement];
}


- (void) createTiles:(NSUInteger) tileCount
{
	FLAssert_v(tileCount >= 3, @"expecting at least 3 tiles");
	FLAssert_v(tileCount % 2 == 1, @"expecting odd number of tiles");
	FLAssertIsNotNil_(_tilingScrollViewDelegate);
		
	[self tearDown];

	_tileCount = tileCount;
	_centerViewIndex = (_tileCount / 2);
	_tiledViews = [[NSMutableArray alloc] initWithCapacity:self.tiledViewCount];
	for(NSUInteger i = 0; i < self.tiledViewCount; i++)
	{
		UIView* view = nil;
		[self createTiledView:&view];
		[_tiledViews addObject:view];
		release_(view);
	}
	
	[self updateTiledArrangement];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if( !_tilingScrollViewFlags.scrollInProgress && 
		_touchCount <= 0 && 
		!_tilingScrollViewFlags.isAutoRotating)
	{
//		  FLLog(@"Updated layout in tilingView layoutSubviews");
		
		[self updateTiledArrangement];
	}
}

- (void) setTiledView:(UIView*) view atIndex:(NSUInteger) which 
{
	FLAssert_v(which >= 0 && which < _tiledViews.count, @"bad idx");
	FLAssertIsNotNil_(view);
	
	if([_tiledViews objectAtIndex:which] != view)
	{
		if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willRemoveView:)])
		{
			[_tilingScrollViewDelegate tilingScrollView:self willRemoveView:[_tiledViews objectAtIndex:which]];
		}
		
		[_tiledViews replaceObjectAtIndex:which withObject:view];
	}
}

- (UIView*) tiledViewAtIndex:(NSUInteger) which
{
	FLAssert_v(which >= 0 && which < _tiledViews.count, @"bad idx");
	return [_tiledViews objectAtIndex:which];
}

- (BOOL) removeTiledView:(id) view
{
	FLAssertIsNotNil_(view);
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
	FLAssertIsNotNil_(viewToFind);
	FLAssertIsNotNil_(_tilingScrollViewDelegate);

	NSInteger i = 0;
	for(UIView* view in _tiledViews)
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
//	  FLAssertIsNotNil_(_tilingScrollViewDelegate);
//
//	  for(NSUInteger i = 0; i < _tileCount; i++)
//	  {
//		  if(i != idx)
//		  {
//			  [_tilingScrollViewDelegate tilingScrollView:self cancelLoadingForView:[_tiledViews objectAtIndex:i] atIndex:i];
//		  }
//	  }
//}

- (void) shiftArrangementToLeft
{
	self.lastScrollDirection = FLTilingScrollViewSlideDirectionLeft;
	
	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willTileViews:)])
	{
		[_tilingScrollViewDelegate tilingScrollView:self willTileViews: FLTilingScrollViewSlideDirectionLeft];
	}

	[self _removeTiledViewAtIndex:0];
	
	UIView* newView = nil;
	[self createTiledView:&newView];
	[_tiledViews addObject:newView];
	release_(newView);
	
	[self updateTiledArrangement];
	
	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:didTileViews:)])
	{
		[_tilingScrollViewDelegate tilingScrollView:self didTileViews: FLTilingScrollViewSlideDirectionLeft];
	}
}

- (void) shiftArrangementToRight
{
	self.lastScrollDirection = FLTilingScrollViewSlideDirectionRight;

	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:willTileViews:)])
	{
		[_tilingScrollViewDelegate tilingScrollView:self willTileViews: FLTilingScrollViewSlideDirectionRight];
	}

	[self _removeTiledViewAtIndex:_tiledViews.indexOfLastObject];

	UIView* newView = nil;
	[self createTiledView:&newView];
	[_tiledViews insertObject:newView atIndex:0];
	release_(newView);

	[self updateTiledArrangement];

	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollView:didTileViews:)])
	{
		[_tilingScrollViewDelegate tilingScrollView:self didTileViews: FLTilingScrollViewSlideDirectionRight];
	}
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollViewWillRotate:)])
	{
		[_tilingScrollViewDelegate tilingScrollViewWillRotate:self];
	}
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self updateTiledArrangement];

	if([_tilingScrollViewDelegate respondsToSelector:@selector(tilingScrollViewDidRotate:)])
	{
		[_tilingScrollViewDelegate tilingScrollViewDidRotate:self];
	}
}

@end


