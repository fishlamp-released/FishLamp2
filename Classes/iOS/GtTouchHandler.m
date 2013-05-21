//
//  GtTouchHandler.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/29/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTouchHandler.h"
#import "GtApplication.h"
#define kTouchHighlightDelay 0.15f

@implementation GtTouchHandler
@synthesize touchableObject = m_touchableObject;
@synthesize changedStateCallback = m_changedStateCallback;

//@synthesize touchHighlighter = m_touchHighlighter;

- (id) init
{
    if((self = [super init]))
    {
        [[GtApplication sharedApplication].keyWindow addEventInterceptor:self];
    }
    
    return self;
}

- (void) dealloc
{
	[[GtApplication sharedApplication].keyWindow removeEventInterceptor:self];
	GtSuperDealloc();
}

- (BOOL) _isOurView:(UIView*) aView
{
    if([self.touchableObject view] == aView)
    {
        return YES;
    }
    return NO;
}

- (BOOL) isOurTouch:(UITouch*) touch
{
    UIView* hitView = touch.view;

    return [self _isOurView:hitView] && 
                CGRectContainsPoint([self.touchableObject frame], [touch locationInView:hitView]);

}

- (void) handleTouches:(NSSet*) touches forEvent:(UIEvent*) event
{
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if( event.type == UIEventTypeTouches)
	{
        GtAssertNotNil([self.touchableObject view]);
        
        if( [self.touchableObject isDisabled] || 
            [self.touchableObject isHidden] || 
            CGRectEqualToRect([self.touchableObject frame], CGRectZero))
        {
            return NO;
        }
    
		[self handleTouches:[event allTouches] forEvent:event];
	}

	return NO;
}

@end

@implementation GtSelectOnTouchDownHandler

+ (GtSelectOnTouchDownHandler*) selectOnTouchDownHandler
{
    return GtReturnAutoreleased([[GtSelectOnTouchDownHandler alloc] init]);
}

- (void) handleTouches:(NSSet*) touches forEvent:(UIEvent*) event
{
    UITouch* touch = [touches anyObject];
    
    if(touch.phase == UITouchPhaseBegan)
    {
        if( [self isOurTouch:touch])
        {
        //    [self.touchableObject setHighlighted:YES];
            [self.touchableObject setSelected:YES];
            GtInvokeCallback(self.changedStateCallback, self.touchableObject);
        }
    }
}



@end



@interface GtSelectOnTouchUpHandler ()

@end


@implementation GtSelectOnTouchUpHandler

@synthesize touchDownCallback = m_touchDown;
@synthesize touchUpInsideCallback = m_touchInside;
@synthesize touchEnteredCallback = m_touchEntered;
@synthesize touchExitedCallback = m_touchExited;
@synthesize touchesEndedCallback = m_touchesEnded;

GtSynthesizeStructProperty(highlightOnTouch, setHighlightOnTouch, BOOL, m_state);
GtSynthesizeStructProperty(touchDidEnter, setTouchDidEnter, BOOL, m_state);
GtSynthesizeStructProperty(didChangeStateOnTouch, setDidChangeStateOnTouch, BOOL, m_state);
GtSynthesizeStructProperty(exclusiveTouchMode, setExclusiveTouchMode, BOOL, m_state);

static id s_touchedObject = nil;
static id s_lastEnteredObject = nil;

+ (id) touchedObject
{
    return s_touchedObject;
}

+ (id) lastEnteredObject
{
    return s_lastEnteredObject;
}

- (id) init
{
    if((self = [super init]))
    {
        self.exclusiveTouchMode = YES;
		self.highlightOnTouch = YES;
    }
    
    return self;
}

+ (GtSelectOnTouchUpHandler*) selectOnTouchUpHandler
{
    return GtReturnAutoreleased([[GtSelectOnTouchUpHandler alloc] init]);
}


//- (BOOL) isUserInteractionEnabled
//{
//	return m_state.isUserInteractionEnabled;
//}
//
//- (void) setUserInteractionEnabled:(BOOL) enabled
//{
//	if(enabled != m_state.isUserInteractionEnabled)
//	{
//		m_state.isUserInteractionEnabled = enabled;
//	
//		if(m_state.isUserInteractionEnabled)
//		{
//		}
//		else
//		{
//			[[GtApplication sharedApplication].keyWindow removeEventInterceptor:self];
//		}
//	}
//}

- (BOOL) isTouching
{
	return m_state.isTouching;
}

- (void) _touchesDidEndWithMiss
{
	if(![self.touchableObject isDisabled])
	{
        if(m_state.highlightOnTouch)
        {
            [self.touchableObject setHighlighted:NO];
        }
        
        GtInvokeCallback(self.touchesEndedCallback, self);
        [self.touchableObject setSelected:NO];
        GtInvokeCallback(self.changedStateCallback, self.touchableObject);
	}

	[self resetTouchState];
	s_touchedObject = nil;
	s_lastEnteredObject = nil;
}

- (void) _touchesDidEndWithHit
{
	if(![self.touchableObject isDisabled])
	{
        GtInvokeCallback(self.touchUpInsideCallback, self);
        GtInvokeCallback(self.touchesEndedCallback, self);
        
        if(m_state.highlightOnTouch)
        {
            [self.touchableObject setHighlighted:NO];
        }
        
        [self.touchableObject setSelected:YES];
        GtInvokeCallback(self.changedStateCallback, self.touchableObject);
	}
	[self resetTouchState];
	s_touchedObject = nil;
	s_lastEnteredObject = nil;
}

- (void) touchEventReceiverResetTouchState
{
	m_state.gotFirstTouch = NO;
	m_startTap = 0;
	m_state.isTouching = NO;
	m_state.lastTouchWasInside = NO;
}

- (void) resetTouchState
{
	m_state.isTouching = NO;
	m_state.didChangeStateOnTouch = NO;
	m_state.touchDidEnter = NO;
	m_state.gotFirstTouch = NO;
	m_startTap = 0;
	m_state.lastTouchWasInside = NO;
}


#define kStartDelay 0.15
- (void) _touchesMoved:(NSSet*) touches withEvent:(UIEvent*) event
{
    GtAssertNotNil([self.touchableObject view]);
    UITouch* touch = [touches anyObject];
		
    BOOL touchIsInside = CGRectContainsPoint([self.touchableObject frame], [touch locationInView:[self.touchableObject view]]);

    if(touchIsInside && !m_state.isTouching)
    {
        m_state.isTouching = YES;
    }
    
    if(m_state.isTouching && m_state.lastTouchWasInside != touchIsInside)
    {
        if(touchIsInside)
        {
            GtInvokeCallback(self.touchEnteredCallback, self);
            s_lastEnteredObject = self;
            m_state.touchDidEnter = YES;
        }
        else
        {
            GtInvokeCallback(self.touchExitedCallback, self);
        }

        if(m_state.highlightOnTouch)
        {
            [self.touchableObject setHighlighted:touchIsInside];
        }
        
        GtInvokeCallback(self.changedStateCallback, self.touchableObject);

        m_state.lastTouchWasInside = touchIsInside;
    }
}

- (void) _touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event
{
    GtAssertNotNil([self.touchableObject view]);
    UITouch* touch = [touches anyObject];
	
	if(m_state.gotFirstTouch || m_state.isTouching)
	{
		CGPoint point = [touch locationInView:[self.touchableObject view]];
			
		NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - m_startTap;
		
        if(m_state.highlightOnTouch && delay < kTouchHighlightDelay)
		{
			if(CGRectContainsPoint([self.touchableObject frame], point))
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
			if(CGRectContainsPoint([self.touchableObject frame], point))
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
	s_touchedObject = nil;
	s_lastEnteredObject = nil;
}

- (void) handleTouches:(NSSet*) touches forEvent:(UIEvent*) event
{
    UITouch* touch = [touches anyObject];
    
    if(touch.phase == UITouchPhaseBegan)
    {
        if( [self isOurTouch:touch])
        {
            [self resetTouchState];
            
            s_touchedObject = self;
            m_state.gotFirstTouch = YES;
            m_startTap = [NSDate timeIntervalSinceReferenceDate];
            m_state.isTouching = YES;
            m_state.lastTouchWasInside = YES;			
            m_state.touchDidEnter = YES;

            GtInvokeCallback(self.touchDownCallback, self);

            if(m_state.highlightOnTouch)
            {
                [self.touchableObject setHighlighted:YES];
                GtInvokeCallback(self.changedStateCallback, self.touchableObject);
            }
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
    
    if(s_touchedObject == self)
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







@end
