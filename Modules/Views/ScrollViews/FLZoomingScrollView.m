//
//	FLZoomingScrollView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLZoomingScrollView.h"
#import "FLTouch.h"
#import "FLCallbackObject.h"

#define kDoubleTapInterval 0.3f

@implementation FLZoomingScrollView

@synthesize zoomedView = _zoomedView;
@synthesize zoomingScrollViewDelegate = _zoomingScrollViewDelegate;
@synthesize zoomingScrollViewZoomScale = _zoomScale;
@synthesize zoomingScrollViewMaximumZoomScale = _maxZoomScale;
@synthesize zoomingScrollViewDoubleTapZoomScale = _doubleTapZoomScale;
@synthesize touchableScrollViewDelegate = _touchableScrollViewDelegate;
FLSynthesizeStructProperty(animating, setAnimating, BOOL, _zoomingScrollViewFlags);

// these are here because setting them breaks everything.


- (float) maximumZoomScale
{
	return 1.0f;
}

- (float) minimumZoomScale
{
	return 1.0f;
}

- (void) setMinimumZoomScale:(float) scale
{
	// no-op
}

- (void) setMaximumZoomScale:(CGFloat) scale
{
	// no-op
}

- (id)initWithFrame:(CGRect) frame
{
	if ((self = [super initWithFrame:frame])) 
	{
		self.pagingEnabled = NO;
		self.directionalLockEnabled = NO;
		self.bounces = NO;
		self.showsHorizontalScrollIndicator = YES;
		self.showsVerticalScrollIndicator = YES;
		self.scrollEnabled = NO;
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = YES;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		self.backgroundColor = [UIColor blackColor];
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.delegate = self;

// not sure about these
		self.delaysContentTouches = YES; // true because we don't want to start acting on touch too soon
		self.canCancelContentTouches = NO; // don't cancel pinches to start scrolling 
		self.exclusiveTouch = YES; // don't let anything else eff with our pinching, tapping, or zooming.

		_zoomScale = 1.0f; 
		_inZoomRelativeScale = 1.0f;
		self.zoomingScrollViewDoubleTapZoomScale = FLZoomingScrollViewDefaultDoubleTapZoomScale;
		self.zoomingScrollViewMaximumZoomScale = FLZoomingScrollViewDefaultMaxZoomScale;
	}
	
	return self;
}

- (void) dealloc
{
	self.zoomingScrollViewDelegate = nil;
	FLReleaseWithNil(_zoomedView);
	FLReleaseWithNil(_lastTouch);
	FLSuperDealloc();
}

- (BOOL) isZoomingScrollViewZooming
{
	return _zoomScale * _inZoomRelativeScale > 1.0f;
}	

- (void) setZoomedView:(UIView*) zoomedView
{
	if(_zoomedView != zoomedView)
	{
		if(_zoomedView)
		{
			[_zoomedView removeFromSuperview];
			FLReleaseWithNil(_zoomedView);
		}
		
		if(zoomedView)
		{
			_zoomedView.multipleTouchEnabled = YES;
			_zoomedView.userInteractionEnabled = YES;
			
			_zoomedView = FLReturnRetained(zoomedView);
			[self addSubview:_zoomedView];
			_zoomedView.transform = CGAffineTransformIdentity;
			
			[_zoomedView setViewSizeToFitInSuperview:YES];
			
			self.contentSize = _zoomedView.frame.size;
			self.contentOffset = CGPointZero;
		}
	}
}

- (void) _notifyZoomingDidStop
{
	if([_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:zoomingDidStopForView:)])
	{
		[_zoomingScrollViewDelegate zoomingScrollView:self zoomingDidStopForView:self.zoomedView];
	}
}

- (void) _notifyZoomingWillStart
{
	if([_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:zoomingDidStartForView:)])
	{
		[_zoomingScrollViewDelegate zoomingScrollView:self zoomingDidStartForView:self.zoomedView];
	}
}

- (void) _notifyZoomingFactorDidChange
{
	if([_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:zoomScaleForViewChanged:zoomScale:)])
	{
		[_zoomingScrollViewDelegate zoomingScrollView:self zoomScaleForViewChanged:self.zoomedView zoomScale:_zoomScale];
	}
}
- (CGRect) _setCorrectLocation:(CGRect) newFrame
{
// we might be rotated, so use the unrotated bounds from the layer if we need to.
	CGRect visibleRect = 
			CGAffineTransformEqualToTransform(CGAffineTransformIdentity, self.transform) ?
			CGRectMake(0,0,self.frame.size.width, self.frame.size.height) :
			CGRectMake(0,0,self.layer.bounds.size.width, self.layer.bounds.size.height);
			
	if( (newFrame.size.width >= visibleRect.size.width) && 
		(newFrame.origin.x < 0 || newFrame.origin.x > 0))
	{
		newFrame.origin.x = 0;
	}
	
	if( (newFrame.size.height >= visibleRect.size.height) &&
		(newFrame.origin.y < 0 || newFrame.origin.y > 0))
	{
		newFrame.origin.y = 0;
	}
	
	if(newFrame.size.width < visibleRect.size.width)
	{
		newFrame = FLRectCenterRectInRectHorizontally(visibleRect, newFrame);
	}

	if(newFrame.size.height < visibleRect.size.height)
	{
		newFrame = FLRectCenterRectInRectVertically(visibleRect, newFrame);
	}

	return newFrame;
}

-(void) _zoomStoppedAnimationFinished:(NSString *)animationID 
	finished:(NSNumber *)finished 
	context:(void *)context
{
	self.animating = NO;
	[self performSelector:(SEL) context];
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) _zoomingDidStop
{
	CGRect frame = _zoomedView.layer.frame;
	_zoomedView.transform = CGAffineTransformIdentity;
	self.contentOffset = CGPointZero;
	self.contentSize = frame.size;
	_zoomedView.frameOptimizedForSize = [_zoomedView frameSizedToFitInSuperview:YES];
	
	_zoomScale = 1.0f;
	_inZoomRelativeScale = 1.0f;

//	  FLLog(@"zoom out frame: %@", NSStringFromCGRect(_zoomedView.frame));
			
	[self _notifyZoomingDidStop];
}

- (void) _zoomOutFinished
{
	CGRect frame = _zoomedView.layer.frame;
	_zoomedView.transform = CGAffineTransformIdentity;
	_zoomScale = _zoomOutScale;
	_zoomOutScale = 1.0f;
	self.contentSize = frame.size;
	self.contentOffset = FLPointAddPointToPoint(self.contentOffset, _zoomOutDelta);
	frame = FLRectMoveWithPoint(frame, _zoomOutDelta);
	_zoomedView.frame = frame;
	
	[self _notifyZoomingFactorDidChange];
	
//	  FLLog(@"zoom out frame: %@", NSStringFromCGRect(_zoomedView.frame));

}

- (void) _zoomByScale:(CGFloat) scaleDelta animated:(BOOL) animated
{
	self.animating = animated;

	_zoomOutScale = _zoomScale * scaleDelta;
			
	CGRect newFrame = FLRectScale(_zoomedView.frame, scaleDelta);

	newFrame = [self _setCorrectLocation:newFrame];
			
	CGAffineTransform scale = CGAffineTransformMakeScale(
		scaleDelta,
		scaleDelta);

	_zoomOutDelta = FLPointSubtractPointFromPoint(FLRectGetCenter(newFrame), 
		FLRectGetCenter(_zoomedView.frame));
	
//	  CGAffineTransform move = 
//		  CGAffineTransformMakeTranslation(_zoomOutDelta.x, _zoomOutDelta.y);
	
	if(self.animating)
	{
		[UIView beginAnimations:@"viewin" context:@selector(_zoomOutFinished)];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_zoomStoppedAnimationFinished:finished:context:)];
	}
	
	_zoomedView.transform = scale; // CGAffineTransformConcat(scale, move);						 
	
	if(self.animating)
	{
		[UIView commitAnimations];
	}
	else
	{
		[self performSelector:@selector(_zoomOutFinished)];
	}
}

-(void) _stopZoomingAnimationFinished:(NSString *)animationID 
	finished:(NSNumber *)finished 
	context:(void *)context
{
	self.animating = NO;
	[self _zoomingDidStop];
	
	if(context)
	{
		FLCallbackObject* cb = (FLCallbackObject*) context;
		[cb invoke:self];
		FLRelease(cb);
	}

	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) stopZooming:(BOOL) animated
	target:(id) target
	action:(SEL) action
{
	CGRect frame = [_zoomedView frameSizedToFitInSuperview:YES];
		
	self.animating = animated;

	// this gets the proper scale, even if one is rotated.
//	  CGFloat zoom = MAX(frame.size.width, frame.size.height) / MAX(_zoomedView.frame.size.width, _zoomedView.frame.size.height);
//
//	  CGAffineTransform scale = CGAffineTransformMakeScale(zoom, zoom); 
//							  
////	CGAffineTransform scale = CGAffineTransformMakeScale(
////		frame.size.width/_zoomedView.frame.size.width,
////		frame.size.height/_zoomedView.frame.size.height);
//
//	  CGPoint delta = FLPointSubtractPointFromPoint(FLRectGetCenter(frame), FLRectGetCenter(_zoomedView.frame));
//	  
//	  CGAffineTransform move = CGAffineTransformMakeTranslation(delta.x, delta.y);
//	  
	if(self.animating)
	{
		[UIView beginAnimations:@"viewin" context:(target && action) ? 
			[[FLCallbackObject callbackWithContainedTarget:[FLRetainedObject retainedObject:target] action:action] retain]: 
			nil];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_stopZoomingAnimationFinished:finished:context:)];
	}
 
	_zoomedView.frame = frame;
		  
 //	  _zoomedView.transform = CGAffineTransformConcat(scale, move);						 
	
	if(self.animating)
	{
		[UIView commitAnimations];
	}
	else
	{
		[self _zoomingDidStop];
		[target performSelector:action withObject:self];
	}		 
		
}

-(void) _adjustLocationAnimationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	self.animating = NO;
	[self _notifyZoomingFactorDidChange];
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}


- (void) _zoomingDidFinish
{
	_zoomScale *= _inZoomRelativeScale;
	_inZoomRelativeScale = 1.0f;
	 
	if(_zoomScale <= 1.0f)
	{
		[self stopZooming:YES target:nil action:nil];
	}
	else
	{
		if(_zoomScale > _maxZoomScale)
		{
			[self _zoomByScale:_maxZoomScale/_zoomScale animated:YES];
		}
		else
		{
			[self _notifyZoomingFactorDidChange];
		}
	}
}

- (void) _zoomingDidFinishWithTransform
{
	CGRect newFrame = _zoomedView.layer.frame;
	_zoomedView.transform = CGAffineTransformIdentity;
   
	CGPoint offset = self.contentOffset; 

	if(newFrame.size.width >= self.frame.size.width)
	{	
		offset.x -= newFrame.origin.x;
		newFrame.origin.x -= newFrame.origin.x;
	}
	
	if(newFrame.size.height >= self.frame.size.height)
	{
		offset.y -= newFrame.origin.y;
		newFrame.origin.y -= newFrame.origin.y;
	}
	self.contentSize = newFrame.size;
	self.contentOffset = offset;
	_zoomedView.frame = newFrame;	  
	
//	  self.scrollEnabled = YES;
//	  FLLog(@"scroll enabled");
	[self _notifyZoomingFactorDidChange];
}

-(void) _zoomStartedAnimationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	self.animating = NO;
	[self _zoomingDidFinishWithTransform];

	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void)setZoomScale:(float)scale animated:(BOOL)animated
{
	FLAssertFailed(@"Call setZoomingScrollViewZoomScale instead of setZoomScale");
}

- (void) setZoomingScrollViewZoomScale:(float) scale translateToPoint:(CGPoint) point animated:(BOOL) animated
{
	if(scale != _zoomScale)
	{
		if(scale <= 1.01f) // a little bit more than 1.0, just too handle rounding errors
		{
			[self stopZooming:YES target:nil action:nil];
		}
		else
		{
			_zoomScale = scale;
			_inZoomRelativeScale = 1.0f;
			
//			  FLLog(@"zoom in frame: %@", NSStringFromCGRect(_zoomedView.frame));
			
			self.animating = animated;
			if(self.animating)
			{
				[UIView beginAnimations:@"viewin" context:nil];
				[UIView setAnimationDuration:0.3];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(_zoomStartedAnimationFinished:finished:context:)];
			}
			
			_zoomedView.transform = CGAffineTransformMakeScale(_zoomScale,_zoomScale);						  
			
			if(self.animating)
			{
				[UIView commitAnimations];
			}
			else
			{
				[self _zoomingDidFinishWithTransform];
			}
		}
	}
}

- (void) setZoomingScrollViewZoomScale:(float) scale animated:(BOOL) animated
{
	[self setZoomingScrollViewZoomScale:scale 
		translateToPoint:FLRectGetCenter(self.bounds)
		animated:animated];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(!self.isZoomingScrollViewZooming && !self.animating && _touchCount <= 0)
	{
		if([_zoomedView setViewSizeToFitInSuperview:YES])
		{
//			  FLLog(@"Updated zoomedViewFrame in layoutSubviews");
		}
	}
}

- (void) _singleTap:(UITouch*) touch
{
	if([_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:userTappedView:withTouch:)])
	{
		[_zoomingScrollViewDelegate zoomingScrollView:self userTappedView:_zoomedView withTouch:_lastTouch];
	}
	
	FLReleaseWithNil(_lastTouch);
}

#define BorderBuffer 0.0f

- (CGPoint) _makeValidScrollOffsetFromDelta:(CGPoint) delta
{
	CGPoint newOffset = self.contentOffset;
	
	if(self.contentSize.width > self.frame.size.width)
	{
		newOffset.x -= delta.x;
		
		if(newOffset.x < -BorderBuffer)
		{
			newOffset.x = -BorderBuffer;
		}
		else if(newOffset.x + self.frame.size.width > (self.contentSize.width + BorderBuffer))
		{
			newOffset.x = (self.contentSize.width - self.frame.size.width) + BorderBuffer;
		}
	}
	
	if(self.contentSize.height > self.frame.size.height)
	{
		newOffset.y -= delta.y;
		
		if(newOffset.y < 0)
		{
			newOffset.y = 0;
		}
		else if(newOffset.y + self.frame.size.height > self.contentSize.height)
		{
			newOffset.y = self.contentSize.height - self.frame.size.height;
		}
	}

	return newOffset;
}

- (BOOL) atLeftEdge
{
	return self.contentOffset.x <= 2.0f;
}

- (BOOL) atRightEdge
{
	return self.contentOffset.x >= (self.contentSize.width - self.frame.size.width - 2.0f);
}

#define EdgeBuffer 0.0f
#define kSmallestPinch 0.5f

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
	
	if([touches count] == 1 && !_zoomingScrollViewFlags.isZooming)
	{
		if(_zoomScale > 1.0f)
		{
			UITouch* touch = [touches anyObject];
			CGPoint delta;
			delta.x = [touch locationInView:self].x - [touch previousLocationInView:self].x; 
			delta.y = [touch locationInView:self].y - [touch previousLocationInView:self].y; 

			[_touches addObject:[FLTouch touchWithUITouch:touch]];
			if(_touches.count > 5)
			{
				[_touches popFirstObject];
			}

			// the _totalDelta is used to turn off edge mode when the user stop scrolling in
			// parent view, e.g., this view is fully in view again and the contents of this view
			// should be scrolled.
				
			if( _zoomingScrollViewFlags.inEdgedScrollingMode)
			{
				if( (_zoomingScrollViewFlags.atLeftEdge && _totalDelta.x <= -EdgeBuffer) ||
					(_zoomingScrollViewFlags.atRightEdge && _totalDelta.x >= EdgeBuffer))
				{
				// this means we're fully visible again, so stop passing touches to delegate.
					_zoomingScrollViewFlags.inEdgedScrollingMode = NO;
					_totalDelta.x = 0;
				}
			}
			
			if( //([NSDate timeIntervalSinceReferenceDate] - _firstTapTimeStamp > 0.15f) && 
				(_zoomingScrollViewFlags.inEdgedScrollingMode ||
				(_zoomingScrollViewFlags.atLeftEdge && delta.x > -EdgeBuffer && self.atLeftEdge) ||
				(_zoomingScrollViewFlags.atRightEdge && delta.x < EdgeBuffer && self.atRightEdge)))
			{
				_totalDelta.x += delta.x;
//			  FLLog(@"forwarding event");
			
				_zoomingScrollViewFlags.doCoast = NO;
				_zoomingScrollViewFlags.inEdgedScrollingMode = YES;
				[_touchableScrollViewDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
			}
			else //if([NSDate timeIntervalSinceReferenceDate] - _firstTapTimeStamp > 0.1f)
			{
				_zoomingScrollViewFlags.doCoast = YES;
				[self setContentOffset:[self _makeValidScrollOffsetFromDelta:delta] animated:NO];
			}
		}
		else
		{		 
			[_touchableScrollViewDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
		}
		_zoomingScrollViewFlags.cancelSingleTap = YES;
	}
	else if([touches count] == 2) 
	{
		_zoomingScrollViewFlags.doCoast = NO;
				
		NSArray *twoTouches = [touches allObjects];
		UITouch *first = [twoTouches objectAtIndex:0];
		UITouch *second = [twoTouches objectAtIndex:1];
		CGFloat currentDistance = FLDistanceBetweenTwoPoints(
														[first locationInView:self],
														[second locationInView:self]);

		if(_initialDistance == 0.0)
		{
			_startFrame = _zoomedView.frame;
			_initialDistance = currentDistance;
		}
		
		CGFloat newZoomScale = currentDistance / _initialDistance;
		if((_zoomScale * newZoomScale) >= kSmallestPinch && ((_zoomScale * newZoomScale) <= (self.zoomingScrollViewMaximumZoomScale + kSmallestPinch)))
		{
			_inZoomRelativeScale = newZoomScale;
		
			CGRect prevFrame = _zoomedView.frame;
			
			CGRect newFrame = FLRectScale(_startFrame, _inZoomRelativeScale);
			
			if((_zoomScale * newZoomScale) <= 1.0f)
			{
				newFrame = FLRectCenterRectInRect([_zoomedView frameSizedToFitInSuperview:YES] /*FLRectMakeWithSize(self.frame.size)*/, newFrame);
                
                [_zoomingScrollViewDelegate zoomingScrollView:self isClosePinching:_zoomScale * newZoomScale];
            }
			else
			{
				newFrame = [self _setCorrectLocation:newFrame];
			}
			
			CGPoint delta = FLPointSubtractPointFromPoint(FLRectGetCenter(newFrame), FLRectGetCenter(prevFrame));
			
			_zoomedView.frameOptimizedForSize = newFrame;
			
			self.contentSize = newFrame.size;
			self.contentOffset = FLPointAddPointToPoint(self.contentOffset, delta);
		}
	}
   [super touchesMoved:touches withEvent:event];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// reset to known state, even if _touchCount is foobared (which I haven't seen happen)
	if(_touchCount <= 0)
	{
		_inZoomRelativeScale = 1.0f;
		_initialDistance = 0.0;
		_firstTapTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		_zoomingScrollViewFlags.isZooming = NO;
		_zoomingScrollViewFlags.didEndZooming = NO;
		_zoomingScrollViewFlags.cancelSingleTap = NO;
		_zoomingScrollViewFlags.doCoast = NO;
		_touchCount = 0;
		_zoomingScrollViewFlags.atRightEdge = self.atRightEdge;
		_zoomingScrollViewFlags.atLeftEdge = self.atLeftEdge;
		_zoomingScrollViewFlags.inEdgedScrollingMode = NO;
		FLReleaseWithNil(_touches);
		_touches = [[NSMutableArray alloc] init];
	}
	
	_touchCount += [touches count];

	if(_touchCount == 2)
	{
		_initialDistance = 0.0;
		_inZoomRelativeScale = 1.0f;
		_zoomingScrollViewFlags.isZooming = YES;
		_zoomingScrollViewFlags.cancelSingleTap = YES;
		_zoomingScrollViewFlags.doCoast = NO;
		_zoomingScrollViewFlags.didEndZooming = NO;
	}
//	  FLLog(@"touches began: touch count: %d, inTouches count: %d", _touchCount, touches.count);
   
	[_touchableScrollViewDelegate touchableScrollView:self touchesBegan:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
	
}

- (void) _touchesDoneOrCancelled: (NSSet *) touches
{
	_touchCount -= [touches count];
	
	if(_touchCount <= 1 && _zoomingScrollViewFlags.isZooming)
	{
		_zoomingScrollViewFlags.cancelSingleTap = YES;
		_zoomingScrollViewFlags.doCoast = NO;
		
		if(!_zoomingScrollViewFlags.didEndZooming)
		{
			_zoomingScrollViewFlags.didEndZooming = YES;
			[self _zoomingDidFinish];
		}
	}
	
	if(_touchCount <= 0)
	{	 
		_touchCount = 0;
		
		if(_zoomingScrollViewFlags.doCoast)
		{
			[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
			_zoomingScrollViewFlags.cancelSingleTap = YES;
			
			UITouch* touch = [touches anyObject];
			CGPoint delta;
			delta.x = [touch locationInView:self].x - [touch previousLocationInView:self].x; 
			delta.y = [touch locationInView:self].y - [touch previousLocationInView:self].y; 
			
			for(FLTouch* savedTouch in _touches)
			{
				delta.x += savedTouch.locationInView.x - savedTouch.previousLocationInView.x; 
				delta.y += savedTouch.locationInView.y - savedTouch.previousLocationInView.y; 
			}
			
			delta.x /= (_touches.count + 1);
			delta.y /= (_touches.count + 1);
						
			delta.x *= 10;
			delta.y *= 10;
			
			CGRect newBounds = FLRectSetOriginWithPoint(self.layer.bounds, [self _makeValidScrollOffsetFromDelta:delta]);
						
			// using animation so we have control over duration and timing function. 

			CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
			animation.duration = 0.4;
			animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
			animation.fromValue = [NSValue valueWithCGRect:self.layer.bounds];
			animation.toValue = [NSValue valueWithCGRect:newBounds];
			[self.layer addAnimation:animation forKey:@"bounds"];
			self.layer.bounds = newBounds;
		}
		
		
		if(_zoomingScrollViewFlags.cancelSingleTap)
		{
			_lastSingleTap = 0; // disable double tap for next tap
		}
		
		FLReleaseWithNil(_touches);
	}
	
//	  FLLog(@"touches ended: touchCount: %d, inTouches count: %d", _touchCount, touches.count);
	
}

-(void) touchesCancelled: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
	[super touchesCancelled:touches withEvent:event];
	[self _touchesDoneOrCancelled:touches];
	[_touchableScrollViewDelegate touchableScrollView:self touchesCancelled:touches withEvent:event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[super touchesEnded:touches withEvent:event];
	[self _touchesDoneOrCancelled:touches];
	if(_touchCount <= 0 && !_zoomingScrollViewFlags.cancelSingleTap)
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
		if(self.animating)
		{
			_lastSingleTap = 0;
		}	 
		else
		{
			UITouch* touch = [touches anyObject];
			if([NSDate timeIntervalSinceReferenceDate] - _lastSingleTap < kDoubleTapInterval)
			{
				if(self.isZoomingScrollViewZooming)
				{
					[self stopZooming:YES target:nil action:nil];
				}
				else
				{
					[_zoomedView setViewSizeToFitInSuperview:YES]; 
					self.contentSize = _zoomedView.frame.size;
					self.contentOffset = CGPointZero;

					[self setZoomingScrollViewZoomScale:self.zoomingScrollViewDoubleTapZoomScale 
						translateToPoint:[touch locationInView:self] 
						animated:YES];
				}
			}
			else
			{
				FLAssignObject(_lastTouch, touch);
				[self performSelector:@selector(_singleTap:) withObject:nil afterDelay:kDoubleTapInterval];
			}
			
			_lastSingleTap = [NSDate timeIntervalSinceReferenceDate];
		}
	}
	[_touchableScrollViewDelegate touchableScrollView:self touchesEnded:touches withEvent:event];
}

@end

