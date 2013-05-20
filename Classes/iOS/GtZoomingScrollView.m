//
//	GtZoomingScrollView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtZoomingScrollView.h"
#import "GtTouch.h"
#import "GtCallbackObject.h"

#define kDoubleTapInterval 0.3f

@implementation GtZoomingScrollView

@synthesize zoomedView = m_zoomedView;
@synthesize zoomingScrollViewDelegate = m_zoomingScrollViewDelegate;
@synthesize zoomingScrollViewZoomScale = m_zoomScale;
@synthesize zoomingScrollViewMaximumZoomScale = m_maxZoomScale;
@synthesize zoomingScrollViewDoubleTapZoomScale = m_doubleTapZoomScale;
@synthesize touchableScrollViewDelegate = m_touchableScrollViewDelegate;
GtSynthesizeStructProperty(animating, setAnimating, BOOL, m_zoomingScrollViewFlags);

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

		m_zoomScale = 1.0f; 
		m_inZoomRelativeScale = 1.0f;
		self.zoomingScrollViewDoubleTapZoomScale = GtZoomingScrollViewDefaultDoubleTapZoomScale;
		self.zoomingScrollViewMaximumZoomScale = GtZoomingScrollViewDefaultMaxZoomScale;
	}
	
	return self;
}

- (void) dealloc
{
	self.zoomingScrollViewDelegate = nil;
	GtReleaseWithNil(m_zoomedView);
	GtReleaseWithNil(m_lastTouch);
	GtSuperDealloc();
}

- (BOOL) isZoomingScrollViewZooming
{
	return m_zoomScale * m_inZoomRelativeScale > 1.0f;
}	

- (void) setZoomedView:(UIView*) zoomedView
{
	if(m_zoomedView != zoomedView)
	{
		if(m_zoomedView)
		{
			[m_zoomedView removeFromSuperview];
			GtReleaseWithNil(m_zoomedView);
		}
		
		if(zoomedView)
		{
			m_zoomedView.multipleTouchEnabled = YES;
			m_zoomedView.userInteractionEnabled = YES;
			
			m_zoomedView = GtRetain(zoomedView);
			[self addSubview:m_zoomedView];
			m_zoomedView.transform = CGAffineTransformIdentity;
			
			[m_zoomedView setViewSizeToFitInSuperview:YES];
			
			self.contentSize = m_zoomedView.frame.size;
			self.contentOffset = CGPointZero;
		}
	}
}

- (void) _notifyZoomingDidStop
{
	if([m_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:zoomingDidStopForView:)])
	{
		[m_zoomingScrollViewDelegate zoomingScrollView:self zoomingDidStopForView:self.zoomedView];
	}
}

- (void) _notifyZoomingWillStart
{
	if([m_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:zoomingDidStartForView:)])
	{
		[m_zoomingScrollViewDelegate zoomingScrollView:self zoomingDidStartForView:self.zoomedView];
	}
}

- (void) _notifyZoomingFactorDidChange
{
	if([m_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:zoomScaleForViewChanged:zoomScale:)])
	{
		[m_zoomingScrollViewDelegate zoomingScrollView:self zoomScaleForViewChanged:self.zoomedView zoomScale:m_zoomScale];
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
		newFrame = GtRectCenterRectInRectHorizontally(visibleRect, newFrame);
	}

	if(newFrame.size.height < visibleRect.size.height)
	{
		newFrame = GtRectCenterRectInRectVertically(visibleRect, newFrame);
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
	CGRect frame = m_zoomedView.layer.frame;
	m_zoomedView.transform = CGAffineTransformIdentity;
	self.contentOffset = CGPointZero;
	self.contentSize = frame.size;
	m_zoomedView.frameOptimizedForSize = [m_zoomedView frameSizedToFitInSuperview:YES];
	
	m_zoomScale = 1.0f;
	m_inZoomRelativeScale = 1.0f;

//	  GtLog(@"zoom out frame: %@", NSStringFromCGRect(m_zoomedView.frame));
			
	[self _notifyZoomingDidStop];
}

- (void) _zoomOutFinished
{
	CGRect frame = m_zoomedView.layer.frame;
	m_zoomedView.transform = CGAffineTransformIdentity;
	m_zoomScale = m_zoomOutScale;
	m_zoomOutScale = 1.0f;
	self.contentSize = frame.size;
	self.contentOffset = GtPointAddPointToPoint(self.contentOffset, m_zoomOutDelta);
	frame = GtRectMoveWithPoint(frame, m_zoomOutDelta);
	m_zoomedView.frame = frame;
	
	[self _notifyZoomingFactorDidChange];
	
//	  GtLog(@"zoom out frame: %@", NSStringFromCGRect(m_zoomedView.frame));

}

- (void) _zoomByScale:(CGFloat) scaleDelta animated:(BOOL) animated
{
	self.animating = animated;

	m_zoomOutScale = m_zoomScale * scaleDelta;
			
	CGRect newFrame = GtRectScale(m_zoomedView.frame, scaleDelta);

	newFrame = [self _setCorrectLocation:newFrame];
			
	CGAffineTransform scale = CGAffineTransformMakeScale(
		scaleDelta,
		scaleDelta);

	m_zoomOutDelta = GtPointSubtractPointFromPoint(GtRectGetCenter(newFrame), 
		GtRectGetCenter(m_zoomedView.frame));
	
//	  CGAffineTransform move = 
//		  CGAffineTransformMakeTranslation(m_zoomOutDelta.x, m_zoomOutDelta.y);
	
	if(self.animating)
	{
		[UIView beginAnimations:@"viewin" context:@selector(_zoomOutFinished)];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_zoomStoppedAnimationFinished:finished:context:)];
	}
	
	m_zoomedView.transform = scale; // CGAffineTransformConcat(scale, move);						 
	
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
		GtCallbackObject* cb = (GtCallbackObject*) context;
		[cb invoke:self];
		GtRelease(cb);
	}

	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) stopZooming:(BOOL) animated
	target:(id) target
	action:(SEL) action
{
	CGRect frame = [m_zoomedView frameSizedToFitInSuperview:YES];
		
	self.animating = animated;

	// this gets the proper scale, even if one is rotated.
//	  CGFloat zoom = MAX(frame.size.width, frame.size.height) / MAX(m_zoomedView.frame.size.width, m_zoomedView.frame.size.height);
//
//	  CGAffineTransform scale = CGAffineTransformMakeScale(zoom, zoom); 
//							  
////	CGAffineTransform scale = CGAffineTransformMakeScale(
////		frame.size.width/m_zoomedView.frame.size.width,
////		frame.size.height/m_zoomedView.frame.size.height);
//
//	  CGPoint delta = GtPointSubtractPointFromPoint(GtRectGetCenter(frame), GtRectGetCenter(m_zoomedView.frame));
//	  
//	  CGAffineTransform move = CGAffineTransformMakeTranslation(delta.x, delta.y);
//	  
	if(self.animating)
	{
		[UIView beginAnimations:@"viewin" context:(target && action) ? 
			[[GtCallbackObject callbackWithContainedTarget:[GtRetainedObject retainedObject:target] action:action] retain]: 
			nil];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_stopZoomingAnimationFinished:finished:context:)];
	}
 
	m_zoomedView.frame = frame;
		  
 //	  m_zoomedView.transform = CGAffineTransformConcat(scale, move);						 
	
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
	m_zoomScale *= m_inZoomRelativeScale;
	m_inZoomRelativeScale = 1.0f;
	 
	if(m_zoomScale <= 1.0f)
	{
		[self stopZooming:YES target:nil action:nil];
	}
	else
	{
		if(m_zoomScale > m_maxZoomScale)
		{
			[self _zoomByScale:m_maxZoomScale/m_zoomScale animated:YES];
		}
		else
		{
			[self _notifyZoomingFactorDidChange];
		}
	}
}

- (void) _zoomingDidFinishWithTransform
{
	CGRect newFrame = m_zoomedView.layer.frame;
	m_zoomedView.transform = CGAffineTransformIdentity;
   
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
	m_zoomedView.frame = newFrame;	  
	
//	  self.scrollEnabled = YES;
//	  GtLog(@"scroll enabled");
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
	GtAssertFailed(@"Call setZoomingScrollViewZoomScale instead of setZoomScale");
}

- (void) setZoomingScrollViewZoomScale:(float) scale translateToPoint:(CGPoint) point animated:(BOOL) animated
{
	if(scale != m_zoomScale)
	{
		if(scale <= 1.01f) // a little bit more than 1.0, just too handle rounding errors
		{
			[self stopZooming:YES target:nil action:nil];
		}
		else
		{
			m_zoomScale = scale;
			m_inZoomRelativeScale = 1.0f;
			
//			  GtLog(@"zoom in frame: %@", NSStringFromCGRect(m_zoomedView.frame));
			
			self.animating = animated;
			if(self.animating)
			{
				[UIView beginAnimations:@"viewin" context:nil];
				[UIView setAnimationDuration:0.3];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(_zoomStartedAnimationFinished:finished:context:)];
			}
			
			m_zoomedView.transform = CGAffineTransformMakeScale(m_zoomScale,m_zoomScale);						  
			
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
		translateToPoint:GtRectGetCenter(self.bounds)
		animated:animated];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(!self.isZoomingScrollViewZooming && !self.animating && m_touchCount <= 0)
	{
		if([m_zoomedView setViewSizeToFitInSuperview:YES])
		{
//			  GtLog(@"Updated zoomedViewFrame in layoutSubviews");
		}
	}
}

- (void) _singleTap:(UITouch*) touch
{
	if([m_zoomingScrollViewDelegate respondsToSelector:@selector(zoomingScrollView:userTappedView:withTouch:)])
	{
		[m_zoomingScrollViewDelegate zoomingScrollView:self userTappedView:m_zoomedView withTouch:m_lastTouch];
	}
	
	GtReleaseWithNil(m_lastTouch);
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
	
	if([touches count] == 1 && !m_zoomingScrollViewFlags.isZooming)
	{
		if(m_zoomScale > 1.0f)
		{
			UITouch* touch = [touches anyObject];
			CGPoint delta;
			delta.x = [touch locationInView:self].x - [touch previousLocationInView:self].x; 
			delta.y = [touch locationInView:self].y - [touch previousLocationInView:self].y; 

			[m_touches addObject:[GtTouch touchWithUITouch:touch]];
			if(m_touches.count > 5)
			{
				[m_touches popFirstObject];
			}

			// the m_totalDelta is used to turn off edge mode when the user stop scrolling in
			// parent view, e.g., this view is fully in view again and the contents of this view
			// should be scrolled.
				
			if( m_zoomingScrollViewFlags.inEdgedScrollingMode)
			{
				if( (m_zoomingScrollViewFlags.atLeftEdge && m_totalDelta.x <= -EdgeBuffer) ||
					(m_zoomingScrollViewFlags.atRightEdge && m_totalDelta.x >= EdgeBuffer))
				{
				// this means we're fully visible again, so stop passing touches to delegate.
					m_zoomingScrollViewFlags.inEdgedScrollingMode = NO;
					m_totalDelta.x = 0;
				}
			}
			
			if( //([NSDate timeIntervalSinceReferenceDate] - m_firstTapTimeStamp > 0.15f) && 
				(m_zoomingScrollViewFlags.inEdgedScrollingMode ||
				(m_zoomingScrollViewFlags.atLeftEdge && delta.x > -EdgeBuffer && self.atLeftEdge) ||
				(m_zoomingScrollViewFlags.atRightEdge && delta.x < EdgeBuffer && self.atRightEdge)))
			{
				m_totalDelta.x += delta.x;
//			  GtLog(@"forwarding event");
			
				m_zoomingScrollViewFlags.doCoast = NO;
				m_zoomingScrollViewFlags.inEdgedScrollingMode = YES;
				[m_touchableScrollViewDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
			}
			else //if([NSDate timeIntervalSinceReferenceDate] - m_firstTapTimeStamp > 0.1f)
			{
				m_zoomingScrollViewFlags.doCoast = YES;
				[self setContentOffset:[self _makeValidScrollOffsetFromDelta:delta] animated:NO];
			}
		}
		else
		{		 
			[m_touchableScrollViewDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
		}
		m_zoomingScrollViewFlags.cancelSingleTap = YES;
	}
	else if([touches count] == 2) 
	{
		m_zoomingScrollViewFlags.doCoast = NO;
				
		NSArray *twoTouches = [touches allObjects];
		UITouch *first = [twoTouches objectAtIndex:0];
		UITouch *second = [twoTouches objectAtIndex:1];
		CGFloat currentDistance = GtDistanceBetweenTwoPoints(
														[first locationInView:self],
														[second locationInView:self]);

		if(m_initialDistance == 0.0)
		{
			m_startFrame = m_zoomedView.frame;
			m_initialDistance = currentDistance;
		}
		
		CGFloat newZoomScale = currentDistance / m_initialDistance;
		if((m_zoomScale * newZoomScale) >= kSmallestPinch && ((m_zoomScale * newZoomScale) <= (self.zoomingScrollViewMaximumZoomScale + kSmallestPinch)))
		{
			m_inZoomRelativeScale = newZoomScale;
		
			CGRect prevFrame = m_zoomedView.frame;
			
			CGRect newFrame = GtRectScale(m_startFrame, m_inZoomRelativeScale);
			
			if((m_zoomScale * newZoomScale) <= 1.0f)
			{
				newFrame = GtRectCenterRectInRect([m_zoomedView frameSizedToFitInSuperview:YES] /*GtRectMakeWithSize(self.frame.size)*/, newFrame);
                
                [m_zoomingScrollViewDelegate zoomingScrollView:self isClosePinching:m_zoomScale * newZoomScale];
            }
			else
			{
				newFrame = [self _setCorrectLocation:newFrame];
			}
			
			CGPoint delta = GtPointSubtractPointFromPoint(GtRectGetCenter(newFrame), GtRectGetCenter(prevFrame));
			
			m_zoomedView.frameOptimizedForSize = newFrame;
			
			self.contentSize = newFrame.size;
			self.contentOffset = GtPointAddPointToPoint(self.contentOffset, delta);
		}
	}
   [super touchesMoved:touches withEvent:event];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// reset to known state, even if m_touchCount is foobared (which I haven't seen happen)
	if(m_touchCount <= 0)
	{
		m_inZoomRelativeScale = 1.0f;
		m_initialDistance = 0.0;
		m_firstTapTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		m_zoomingScrollViewFlags.isZooming = NO;
		m_zoomingScrollViewFlags.didEndZooming = NO;
		m_zoomingScrollViewFlags.cancelSingleTap = NO;
		m_zoomingScrollViewFlags.doCoast = NO;
		m_touchCount = 0;
		m_zoomingScrollViewFlags.atRightEdge = self.atRightEdge;
		m_zoomingScrollViewFlags.atLeftEdge = self.atLeftEdge;
		m_zoomingScrollViewFlags.inEdgedScrollingMode = NO;
		GtReleaseWithNil(m_touches);
		m_touches = [[NSMutableArray alloc] init];
	}
	
	m_touchCount += [touches count];

	if(m_touchCount == 2)
	{
		m_initialDistance = 0.0;
		m_inZoomRelativeScale = 1.0f;
		m_zoomingScrollViewFlags.isZooming = YES;
		m_zoomingScrollViewFlags.cancelSingleTap = YES;
		m_zoomingScrollViewFlags.doCoast = NO;
		m_zoomingScrollViewFlags.didEndZooming = NO;
	}
//	  GtLog(@"touches began: touch count: %d, inTouches count: %d", m_touchCount, touches.count);
   
	[m_touchableScrollViewDelegate touchableScrollView:self touchesBegan:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
	
}

- (void) _touchesDoneOrCancelled: (NSSet *) touches
{
	m_touchCount -= [touches count];
	
	if(m_touchCount <= 1 && m_zoomingScrollViewFlags.isZooming)
	{
		m_zoomingScrollViewFlags.cancelSingleTap = YES;
		m_zoomingScrollViewFlags.doCoast = NO;
		
		if(!m_zoomingScrollViewFlags.didEndZooming)
		{
			m_zoomingScrollViewFlags.didEndZooming = YES;
			[self _zoomingDidFinish];
		}
	}
	
	if(m_touchCount <= 0)
	{	 
		m_touchCount = 0;
		
		if(m_zoomingScrollViewFlags.doCoast)
		{
			[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
			m_zoomingScrollViewFlags.cancelSingleTap = YES;
			
			UITouch* touch = [touches anyObject];
			CGPoint delta;
			delta.x = [touch locationInView:self].x - [touch previousLocationInView:self].x; 
			delta.y = [touch locationInView:self].y - [touch previousLocationInView:self].y; 
			
			for(GtTouch* savedTouch in m_touches)
			{
				delta.x += savedTouch.locationInView.x - savedTouch.previousLocationInView.x; 
				delta.y += savedTouch.locationInView.y - savedTouch.previousLocationInView.y; 
			}
			
			delta.x /= (m_touches.count + 1);
			delta.y /= (m_touches.count + 1);
						
			delta.x *= 10;
			delta.y *= 10;
			
			CGRect newBounds = GtRectSetOriginWithPoint(self.layer.bounds, [self _makeValidScrollOffsetFromDelta:delta]);
						
			// using animation so we have control over duration and timing function. 

			CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
			animation.duration = 0.4;
			animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
			animation.fromValue = [NSValue valueWithCGRect:self.layer.bounds];
			animation.toValue = [NSValue valueWithCGRect:newBounds];
			[self.layer addAnimation:animation forKey:@"bounds"];
			self.layer.bounds = newBounds;
		}
		
		
		if(m_zoomingScrollViewFlags.cancelSingleTap)
		{
			m_lastSingleTap = 0; // disable double tap for next tap
		}
		
		GtReleaseWithNil(m_touches);
	}
	
//	  GtLog(@"touches ended: touchCount: %d, inTouches count: %d", m_touchCount, touches.count);
	
}

-(void) touchesCancelled: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
	[super touchesCancelled:touches withEvent:event];
	[self _touchesDoneOrCancelled:touches];
	[m_touchableScrollViewDelegate touchableScrollView:self touchesCancelled:touches withEvent:event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
	[super touchesEnded:touches withEvent:event];
	[self _touchesDoneOrCancelled:touches];
	if(m_touchCount <= 0 && !m_zoomingScrollViewFlags.cancelSingleTap)
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_singleTap:) object:nil];
		if(self.animating)
		{
			m_lastSingleTap = 0;
		}	 
		else
		{
			UITouch* touch = [touches anyObject];
			if([NSDate timeIntervalSinceReferenceDate] - m_lastSingleTap < kDoubleTapInterval)
			{
				if(self.isZoomingScrollViewZooming)
				{
					[self stopZooming:YES target:nil action:nil];
				}
				else
				{
					[m_zoomedView setViewSizeToFitInSuperview:YES]; 
					self.contentSize = m_zoomedView.frame.size;
					self.contentOffset = CGPointZero;

					[self setZoomingScrollViewZoomScale:self.zoomingScrollViewDoubleTapZoomScale 
						translateToPoint:[touch locationInView:self] 
						animated:YES];
				}
			}
			else
			{
				GtAssignObject(m_lastTouch, touch);
				[self performSelector:@selector(_singleTap:) withObject:nil afterDelay:kDoubleTapInterval];
			}
			
			m_lastSingleTap = [NSDate timeIntervalSinceReferenceDate];
		}
	}
	[m_touchableScrollViewDelegate touchableScrollView:self touchesEnded:touches withEvent:event];
}

@end

