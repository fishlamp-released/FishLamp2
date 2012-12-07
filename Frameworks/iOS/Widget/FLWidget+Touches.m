//
//  FLWidget+Touches.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/28/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//
#if 0
#import "FLWidget+Touches.h"
#define kTouchHighlightDelay 0.15f

@implementation FLWidget (Touches)

FLSynthesizeStructProperty(highlightOnTouch, setHighlightOnTouch, BOOL, _state);
FLSynthesizeStructProperty(touchDidEnter, setTouchDidEnter, BOOL, _state);
FLSynthesizeStructProperty(didChangeStateOnTouch, setDidChangeStateOnTouch, BOOL, _state);
FLSynthesizeStructProperty(exclusiveTouchMode, setExclusiveTouchMode, BOOL, _state);

static FLWidget* s_touchedWidget = nil;
static FLWidget* s_lastEnteredWidget = nil;

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
	return _state.isUserInteractionEnabled;
}

- (void) setUserInteractionEnabled:(BOOL) enabled
{
	if(enabled != _state.isUserInteractionEnabled)
	{
		_state.isUserInteractionEnabled = enabled;
	
		if(_state.isUserInteractionEnabled)
		{
			[[FLWindow topWindow] addEventInterceptor:self];
		}
		else
		{
			[[FLWindow topWindow] removeEventInterceptor:self];
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
		if([_widgetDelegate respondsToSelector:@selector(widgetTouchesEnded:)])
		{
			[_widgetDelegate widgetTouchesEnded:self];
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
		if(	!_state.cancelCurrentTouch)
		{
			if([_widgetDelegate respondsToSelector:@selector(widgetTouchUpInside:)])
			{
				[_widgetDelegate widgetTouchUpInside:self];
			}
			if([_widgetDelegate respondsToSelector:@selector(widgetTouchesEnded:)])
			{
				[_widgetDelegate widgetTouchesEnded:self];
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
	_state.gotFirstTouch = NO;
	_startTap = 0;
	_state.isTouching = NO;
	_state.lastTouchWasInside = NO;
}

- (void) cancelCurrentTouch
{
	_state.cancelCurrentTouch = YES;
}

- (void) resetTouchState
{
	_state.cancelCurrentTouch = NO;
	_state.isTouching = NO;
	_state.didChangeStateOnTouch = NO;
	_state.touchDidEnter = NO;
	_state.gotFirstTouch = NO;
	_startTap = 0;
	_state.lastTouchWasInside = NO;
}

- (BOOL) isTouching
{
	return _state.isTouching;
}

#if DELAYED_TOUCHES
- (void) _delayedTouch
{
	if([_widgetDelegate respondsToSelector:@selector(widgetTouchDownDelayed:)])
	{
		_state.cancelCurrentTouch = [_widgetDelegate widgetTouchDownDelayed:self];
		if(_state.cancelCurrentTouch)
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
//FLLog(@"got touch");    
//    
//		[self resetTouchState];
//		
//		s_touchedWidget = self;
//		_state.gotFirstTouch = YES;
//		_startTap = [NSDate timeIntervalSinceReferenceDate];
//		_state.isTouching = YES;
//		_state.lastTouchWasInside = YES;			
//		_state.touchDidEnter = YES;
//
//		if(!self.disabled)
//		{
//			if([_widgetDelegate respondsToSelector:@selector(widgetTouchDown:)])
//			{
//				[_widgetDelegate widgetTouchDown:self];
//			}
//			
//			if(_state.highlightOnTouch)
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
		FLAssertIsNotNil_(self.superview);
		
		if(view != self.superview)
		{
			point = [self.superview convertPoint:point fromView:view];
		}

		BOOL touchIsInside = CGRectContainsPoint(self.frame,point);

		if(touchIsInside && !_state.isTouching)
		{
			_state.isTouching = YES;
		}
		
		if(_state.isTouching && _state.lastTouchWasInside != touchIsInside)
		{
			if(touchIsInside)
			{
				if(	!_state.cancelCurrentTouch && 
					[_widgetDelegate respondsToSelector:@selector(widgetTouchEntered:)])
				{
					[_widgetDelegate widgetTouchEntered:self];
				}
				s_lastEnteredWidget = self;
				_state.touchDidEnter = YES;
			}
			else
			{
#if DELAYED_TOUCHES
				[self _cancelDelayedTouch];
#endif
				if(	!_state.cancelCurrentTouch && 
					[_widgetDelegate respondsToSelector:@selector(widgetTouchExited:)])
				{
					[_widgetDelegate widgetTouchExited:self];
				}
			
			}

			if(_state.highlightOnTouch)
			{
				self.highlighted = touchIsInside;
			}

			_state.lastTouchWasInside = touchIsInside;
		}
	}
}


#define kStartDelay 0.15

/*
	BOOL _canStartTouches;
	BOOL _didBegin;
	FLDeferredTouch* _firstTouch;
	id<FLTouchEventReciever> _firstTouchReceiver;
*/

//- (void) _sendStartTouch
//{
////FLLog(@"_sendStartTouch");
//
//	_didBegin = YES;
//	_canStartTouches = YES;					
//
//	[_firstTouchReceiver touchEventReceiverTouchesBegan:_firstTouch.touch inView:_firstTouch.view];
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
    FLAssertIsNotNil_(self.superview);
    UITouch* touch = [touches anyObject];
		
    BOOL touchIsInside = CGRectContainsPoint(self.frame, [touch locationInView:self.superview]);

    if(touchIsInside && !_state.isTouching)
    {
        _state.isTouching = YES;
    }
    
    if(_state.isTouching && _state.lastTouchWasInside != touchIsInside)
    {
        if(touchIsInside)
        {
            if(	!_state.cancelCurrentTouch && 
                [_widgetDelegate respondsToSelector:@selector(widgetTouchEntered:)])
            {
                [_widgetDelegate widgetTouchEntered:self];
            }
            s_lastEnteredWidget = self;
            _state.touchDidEnter = YES;
        }
        else
        {
#if DELAYED_TOUCHES
            [self _cancelDelayedTouch];
#endif
            if(	!_state.cancelCurrentTouch && 
                [_widgetDelegate respondsToSelector:@selector(widgetTouchExited:)])
            {
                [_widgetDelegate widgetTouchExited:self];
            }
        
        }

        if(_state.highlightOnTouch)
        {
            self.highlighted = touchIsInside;
        }

        _state.lastTouchWasInside = touchIsInside;
    }
}

- (void) _touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event
{
    FLAssertIsNotNil_(self.superview);
    UITouch* touch = [touches anyObject];
	
	if(_state.gotFirstTouch || _state.isTouching)
	{
		CGPoint pt = [touch locationInView:self.superview];
			
		NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - _startTap;
		
        if(_state.highlightOnTouch && delay < kTouchHighlightDelay)
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
	if(_state.gotFirstTouch || _state.isTouching)
	{
		NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - _startTap;
		if(_state.highlightOnTouch && delay < kTouchHighlightDelay)
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
        FLAssertIsNotNil_(self.superview);
        FLAssertIsNotNil_(self.superwidget);

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
                _state.gotFirstTouch = YES;
                _startTap = [NSDate timeIntervalSinceReferenceDate];
                _state.isTouching = YES;
                _state.lastTouchWasInside = YES;			
                _state.touchDidEnter = YES;

                if([_widgetDelegate respondsToSelector:@selector(widgetTouchDown:)])
                {
                    [_widgetDelegate widgetTouchDown:self];
                }
                
                if(_state.highlightOnTouch)
                {
                    self.highlighted = YES;
                }
                
    #if DELAYED_TOUCHES
                [self performSelector:@selector(_delayedTouch) withObject:nil afterDelay:1.0];
    #endif            
            }
        }
     

		
//        else if(/*_firstTouchReceiver &&*/ touch.phase != UITouchPhaseStationary)
//		{
//			if(!_didBegin)
//			{
//				CGFloat distance = FLDistanceBetweenTwoPoints([touch.view convertPoint:_firstTouch.touch fromView:_firstTouch.view], [touch locationInView:touch.view]);
//				
////					  FLLog(@"distance: %f", distance);
//				
//				if(distance > 10.f)
//				{
////					FLLog(@"cancelled, distance is too high");
//
//					// this means we're starting scrolling?
//
//					_didBegin = YES;
//					_canStartTouches = NO;
//					[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendStartTouch) object:nil];
////					[self _sendStartTouch];
//				}
//				else if(touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded)
//				{
////					FLLog(@"quick tap");
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