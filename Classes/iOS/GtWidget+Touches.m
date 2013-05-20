//
//  GtWidget+Touches.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/28/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import "GtWidget+Touches.h"
#define kTouchHighlightDelay 0.15f

@implementation GtWidget (Touches)

GtSynthesizeStructProperty(highlightOnTouch, setHighlightOnTouch, BOOL, m_state);
GtSynthesizeStructProperty(touchDidEnter, setTouchDidEnter, BOOL, m_state);
GtSynthesizeStructProperty(didChangeStateOnTouch, setDidChangeStateOnTouch, BOOL, m_state);
GtSynthesizeStructProperty(exclusiveTouchMode, setExclusiveTouchMode, BOOL, m_state);

static GtWidget* s_touchedWidget = nil;
static GtWidget* s_lastEnteredWidget = nil;

+ (id) touchedWidget
{
	return s_touchedWidget;
}

+ (id) lastEnteredWidget
{
	return s_lastEnteredWidget;
}

- (BOOL) isUserInteractionEnabled
{
	return m_state.isUserInteractionEnabled;
}

- (void) setUserInteractionEnabled:(BOOL) enabled
{
	if(enabled != m_state.isUserInteractionEnabled)
	{
		m_state.isUserInteractionEnabled = enabled;
	
		if(m_state.isUserInteractionEnabled)
		{
			[[GtWindow topWindow] addEventInterceptor:self];
		}
		else
		{
			[[GtWindow topWindow] removeEventInterceptor:self];
		}
	}
}

- (void) _touchesDidEndWithMiss
{
#if DELAYED_TOUCHES
	[self _cancelDelayedTouch];
#endif    
	if(!self.disabled)
	{
		self.highlighted = NO;
		if([m_widgetDelegate respondsToSelector:@selector(widgetTouchesEnded:)])
		{
			[m_widgetDelegate widgetTouchesEnded:self];
		}
	}

	[self resetTouchState];
	s_touchedWidget = nil;
	s_lastEnteredWidget = nil;
}

- (void) _touchesDidEndWithHit
{
#if DELAYED_TOUCHES
	[self _cancelDelayedTouch];
#endif
	if(!self.disabled)
	{
		if(	!m_state.cancelCurrentTouch)
		{
			if([m_widgetDelegate respondsToSelector:@selector(widgetTouchUpInside:)])
			{
				[m_widgetDelegate widgetTouchUpInside:self];
			}
			if([m_widgetDelegate respondsToSelector:@selector(widgetTouchesEnded:)])
			{
				[m_widgetDelegate widgetTouchesEnded:self];
			}
		}
	
		self.highlighted = NO;
	}
	[self resetTouchState];
	s_touchedWidget = nil;
	s_lastEnteredWidget = nil;
}



- (void) touchEventReceiverResetTouchState
{
	m_state.gotFirstTouch = NO;
	m_startTap = 0;
	m_state.isTouching = NO;
	m_state.lastTouchWasInside = NO;
}

- (void) cancelCurrentTouch
{
	m_state.cancelCurrentTouch = YES;
}

- (void) resetTouchState
{
	m_state.cancelCurrentTouch = NO;
	m_state.isTouching = NO;
	m_state.didChangeStateOnTouch = NO;
	m_state.touchDidEnter = NO;
	m_state.gotFirstTouch = NO;
	m_startTap = 0;
	m_state.lastTouchWasInside = NO;
}

- (BOOL) isTouching
{
	return m_state.isTouching;
}

#if DELAYED_TOUCHES
- (void) _delayedTouch
{
	if([m_widgetDelegate respondsToSelector:@selector(widgetTouchDownDelayed:)])
	{
		m_state.cancelCurrentTouch = [m_widgetDelegate widgetTouchDownDelayed:self];
		if(m_state.cancelCurrentTouch)
		{
			self.highlighted = NO;
		}
	}
}

- (void) _cancelDelayedTouch
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_delayedTouch) object:nil];
}
#endif

//- (void)touchEventReceiverTouchesBegan:(CGPoint) point inView:(UIView*) view
//{
//	if(!self.isDisabled && !self.isHidden)
//	{
//GtLog(@"got touch");    
//    
//		[self resetTouchState];
//		
//		s_touchedWidget = self;
//		m_state.gotFirstTouch = YES;
//		m_startTap = [NSDate timeIntervalSinceReferenceDate];
//		m_state.isTouching = YES;
//		m_state.lastTouchWasInside = YES;			
//		m_state.touchDidEnter = YES;
//
//		if(!self.disabled)
//		{
//			if([m_widgetDelegate respondsToSelector:@selector(widgetTouchDown:)])
//			{
//				[m_widgetDelegate widgetTouchDown:self];
//			}
//			
//			if(m_state.highlightOnTouch)
//			{
//				self.highlighted = YES;
//			}
//			
//#if DELAYED_TOUCHES
//			[self performSelector:@selector(_delayedTouch) withObject:nil afterDelay:1.0];
//#endif            
//		}
//	}
//}

- (void)touchEventReceiverTouchesMoved:(CGPoint) point inView:(UIView*) view
{
	if(	!self.isDisabled && 
		!self.isHidden)
	{
		GtAssertNotNil(self.superview);
		
		if(view != self.superview)
		{
			point = [self.superview convertPoint:point fromView:view];
		}

		BOOL touchIsInside = CGRectContainsPoint(self.frame,point);

		if(touchIsInside && !m_state.isTouching)
		{
			m_state.isTouching = YES;
		}
		
		if(m_state.isTouching && m_state.lastTouchWasInside != touchIsInside)
		{
			if(touchIsInside)
			{
				if(	!m_state.cancelCurrentTouch && 
					[m_widgetDelegate respondsToSelector:@selector(widgetTouchEntered:)])
				{
					[m_widgetDelegate widgetTouchEntered:self];
				}
				s_lastEnteredWidget = self;
				m_state.touchDidEnter = YES;
			}
			else
			{
#if DELAYED_TOUCHES
				[self _cancelDelayedTouch];
#endif
				if(	!m_state.cancelCurrentTouch && 
					[m_widgetDelegate respondsToSelector:@selector(widgetTouchExited:)])
				{
					[m_widgetDelegate widgetTouchExited:self];
				}
			
			}

			if(m_state.highlightOnTouch)
			{
				self.highlighted = touchIsInside;
			}

			m_state.lastTouchWasInside = touchIsInside;
		}
	}
}


#define kStartDelay 0.15

/*
	BOOL m_canStartTouches;
	BOOL m_didBegin;
	GtDeferredTouch* m_firstTouch;
	id<GtTouchEventReciever> m_firstTouchReceiver;
*/

//- (void) _sendStartTouch
//{
////GtLog(@"_sendStartTouch");
//
//	m_didBegin = YES;
//	m_canStartTouches = YES;					
//
//	[m_firstTouchReceiver touchEventReceiverTouchesBegan:m_firstTouch.touch inView:m_firstTouch.view];
//}

- (BOOL) _isOurView:(UIView*) aView
{
    if(self.superview == aView)
    {
        return YES;
    }

//    if([self.superview containsSubviewRecursive:aView])
//    {
//        return YES;
//    }
    
    return NO;
}


- (void) _touchesMoved:(NSSet*) touches withEvent:(UIEvent*) event
{
    GtAssertNotNil(self.superview);
    UITouch* touch = [touches anyObject];
		
    BOOL touchIsInside = CGRectContainsPoint(self.frame, [touch locationInView:self.superview]);

    if(touchIsInside && !m_state.isTouching)
    {
        m_state.isTouching = YES;
    }
    
    if(m_state.isTouching && m_state.lastTouchWasInside != touchIsInside)
    {
        if(touchIsInside)
        {
            if(	!m_state.cancelCurrentTouch && 
                [m_widgetDelegate respondsToSelector:@selector(widgetTouchEntered:)])
            {
                [m_widgetDelegate widgetTouchEntered:self];
            }
            s_lastEnteredWidget = self;
            m_state.touchDidEnter = YES;
        }
        else
        {
#if DELAYED_TOUCHES
            [self _cancelDelayedTouch];
#endif
            if(	!m_state.cancelCurrentTouch && 
                [m_widgetDelegate respondsToSelector:@selector(widgetTouchExited:)])
            {
                [m_widgetDelegate widgetTouchExited:self];
            }
        
        }

        if(m_state.highlightOnTouch)
        {
            self.highlighted = touchIsInside;
        }

        m_state.lastTouchWasInside = touchIsInside;
    }
}

- (void) _touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event
{
    GtAssertNotNil(self.superview);
    UITouch* touch = [touches anyObject];
	
	if(m_state.gotFirstTouch || m_state.isTouching)
	{
		CGPoint pt = [touch locationInView:self.superview];
			
		NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - m_startTap;
		
        if(m_state.highlightOnTouch && delay < kTouchHighlightDelay)
		{
			if([self pointInside:pt])
			{
				[self performSelector:@selector(_touchesDidEndWithHit) 
						   withObject:nil afterDelay:kTouchHighlightDelay - delay];
			}
			else
			{
				[self performSelector:@selector(_touchesDidEndWithMiss) 
						   withObject:nil afterDelay:kTouchHighlightDelay - delay];
			}
		}
		else
		{
			if([self pointInside:pt])
			{
				[self _touchesDidEndWithHit];
			}
			else
			{
				[self _touchesDidEndWithMiss];
			}
		}
	}

}

- (void) _touchesCancelled:(NSSet*) touches withEvent:(UIEvent*) event
{
	if(m_state.gotFirstTouch || m_state.isTouching)
	{
		NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - m_startTap;
		if(m_state.highlightOnTouch && delay < kTouchHighlightDelay)
		{
			[self performSelector:@selector(_touchesDidEndWithMiss) 
						   withObject:nil afterDelay:delay];
		}
		else
		{
			[self _touchesDidEndWithMiss];
		}
	}
	[self resetTouchState];
	s_touchedWidget = nil;
	s_lastEnteredWidget = nil;
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if( event.type == UIEventTypeTouches)
	{
        GtAssertNotNil(self.superview);
        GtAssertNotNil(self.superwidget);

        if(self.isDisabled || self.isHidden || CGRectEqualToRect(self.frame, CGRectZero))
        {
            return NO;
        }
    
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];
		
		UIView* hitView = touch.view;

		if(touch.phase == UITouchPhaseBegan)
        {
            if( [self _isOurView:hitView] && 
                CGRectContainsPoint(self.frame, [touch locationInView:hitView]))
            {
                [self resetTouchState];
                
                s_touchedWidget = self;
                m_state.gotFirstTouch = YES;
                m_startTap = [NSDate timeIntervalSinceReferenceDate];
                m_state.isTouching = YES;
                m_state.lastTouchWasInside = YES;			
                m_state.touchDidEnter = YES;

                if([m_widgetDelegate respondsToSelector:@selector(widgetTouchDown:)])
                {
                    [m_widgetDelegate widgetTouchDown:self];
                }
                
                if(m_state.highlightOnTouch)
                {
                    self.highlighted = YES;
                }
                
    #if DELAYED_TOUCHES
                [self performSelector:@selector(_delayedTouch) withObject:nil afterDelay:1.0];
    #endif            
            }
        }
     

		
//        else if(/*m_firstTouchReceiver &&*/ touch.phase != UITouchPhaseStationary)
//		{
//			if(!m_didBegin)
//			{
//				CGFloat distance = GtDistanceBetweenTwoPoints([touch.view convertPoint:m_firstTouch.touch fromView:m_firstTouch.view], [touch locationInView:touch.view]);
//				
////					  GtLog(@"distance: %f", distance);
//				
//				if(distance > 10.f)
//				{
////					GtLog(@"cancelled, distance is too high");
//
//					// this means we're starting scrolling?
//
//					m_didBegin = YES;
//					m_canStartTouches = NO;
//					[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendStartTouch) object:nil];
////					[self _sendStartTouch];
//				}
//				else if(touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded)
//				{
////					GtLog(@"quick tap");
//
//					[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendStartTouch) object:nil];
//					[self _sendStartTouch];
//				}
//			}
    
        if(s_touchedWidget == self)
        {
//				BOOL returnNO = NO;
            switch(touch.phase)
            {
                case UITouchPhaseBegan:
                    break;
                
                case UITouchPhaseMoved:
                    [self _touchesMoved:touches withEvent:event];
//                        returnNO = YES; // this eats scrolling events in a table.
                    break;
                    
                case UITouchPhaseEnded:
                    [self _touchesEnded:touches withEvent:event];
                break;
                    
                case UITouchPhaseCancelled:
                     [self _touchesCancelled:touches withEvent:event];
                break;
                
                case UITouchPhaseStationary: 
                break;
            }
            
//				if(returnNO)
//				{
//					return NO;
//				}
        }
	}

	return NO;
}




@end
#endif